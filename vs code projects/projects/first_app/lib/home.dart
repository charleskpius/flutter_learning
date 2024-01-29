import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'product.dart';
import 'home_page_model_class.dart';
import 'bottom_navigation.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key,}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  late CarouselController _carouselController;
  late Future<List<Products>> _productsFuture;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  User? _user;

  void onTabChange(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _carouselController = CarouselController();
    _initUser();
    _productsFuture = _fetchProducts();
  }

  Future<void> _initUser() async {
    _user = _auth.currentUser;
    if (_user != null) {
      await _user!.reload();
      _user = _auth.currentUser;
    }
  }

  Future<List<Products>> _fetchProducts() async {
    try {
      final response =
          await http.get(Uri.parse('https://dummyjson.com/products'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final autogenerated = Autogenerated.fromJson(data);
        return autogenerated.products ?? [];
      } else {
        throw Exception('Failed to load products');
      }
    } catch (error) {
      print('Error fetching products: $error');
      throw error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16),
            _buildCarousel(),
            const SizedBox(height: 16),
            _buildProductGrid(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigation(
        selectedIndex: _selectedIndex,
        onTabChange: onTabChange,
      ),
    );
  }

  Widget _buildCarousel() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: ClipPath(
        clipper: ShapeBorderClipper(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: CarouselSlider(
          items: _buildCarouselItems(),
          options: CarouselOptions(
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 2),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            pauseAutoPlayOnTouch: true,
            pauseAutoPlayOnManualNavigate: true,
            scrollDirection: Axis.vertical,
            height: 200,
            viewportFraction:
                1, // Adjust this value to add space between images
          ),
          carouselController: _carouselController,
        ),
      ),
    );
  }

  List<Widget> _buildCarouselItems() {
    return [
      _buildCarouselContainer(
          'https://images-eu.ssl-images-amazon.com/images/G/31/OHL_HSS/3000x1200-heroUnrec._CB570990004_.jpg'),
      _buildCarouselContainer(
          'https://images-eu.ssl-images-amazon.com/images/G/31/img22/Wireless/devjyoti/GW/Uber/Nov/D103625178_DesktopTallHero_3000x1200._CB574597993_.jpg'),
      _buildCarouselContainer(
          'https://images-eu.ssl-images-amazon.com/images/G/31/img22/Toys/HTL2023/GW/Homepage_DesktopHeroTemplate_3000x1200-Toy-Fiesta-APAY_2x_unrec._CB570529351_.jpg'),
      _buildCarouselContainer(
          'https://images-eu.ssl-images-amazon.com/images/G/31/img22/wearables/BAU_GW/New_launchGW_tallhero_3000x1200._CB597027259_.jpg'),
    ];
  }

  Widget _buildCarouselContainer(String imageUrl) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: const Center(),
    );
  }

  Widget _buildProductGrid() {
    return Expanded(
      child: FutureBuilder<List<Products>>(
        future: _productsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<Products> products = snapshot.data ?? [];
            return Container(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return Card(
                    elevation: 10,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ProductPage(productKey: product.key.toString()),
                          ),
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Card(
                              elevation: 10,
                              child: _buildProductImage(product)),
                          _buildProductTitle(product),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildProductImage(Products product) {
    return product.image != null && product.image!.isNotEmpty
        ? AspectRatio(
            aspectRatio: 16 / 9, // Adjust the aspect ratio as needed
            child: Image.network(
              product.image![0],
              fit: BoxFit.cover,
            ),
          )
        : const SizedBox.shrink();
  }

  Widget _buildProductTitle(Products product) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.title ?? '',
            maxLines: 1,
            style: const TextStyle(
              color: Colors.teal,
              // Change the text color to your preferred color
              decoration: TextDecoration.none,
            ),
            textAlign: TextAlign.left,
          ),
          const SizedBox(height: 4), // Add some space between title and price
          Text(
            '\$${product.price}', // Assuming there's a 'price' property in the Products class
            style: const TextStyle(
              color:
                  Colors.black, // Change the text color to your preferred color
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
