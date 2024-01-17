import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:first_app/cart_provider.dart';
import 'package:first_app/cart.dart';
import 'package:first_app/pageroute.dart';

class CategoryPage extends StatefulWidget {
  final String categoryName;

  const CategoryPage({Key? key, required this.categoryName}) : super(key: key);

  @override
  CategoryPageState createState() => CategoryPageState();
}

class CategoryPageState extends State<CategoryPage> {
  List<Map<String, dynamic>> products = [];

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://dummyjson.com/products/category/${widget.categoryName}'),
      );
      if (response.statusCode == 200) {
        setState(() {
          final Map<String, dynamic> responseData = json.decode(response.body);
          products = List<Map<String, dynamic>>.from(responseData['products']);
        });
      } else {
        // Handle error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Failed to load products'),
          ),
        );
      }
    } catch (e) {
      // Handle exception
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error fetching products: $e'),
        ),
      );
    }
  }

  void navigateToProductDetails(Map<String, dynamic> product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailsPage(
          productKey: product['key'].toString(), // Pass productId,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final Map<String, dynamic> product = products[index];
          return GestureDetector(
            onTap: () => navigateToProductDetails(product),
            child: Card(
              elevation: 5.0,
              margin: const EdgeInsets.all(10.0),
              child: Column(
                // Modified to use a Column for better layout
                children: [
                  _buildProductImage(product), // Added for image display
                  ListTile(
                    title: Text(
                      product['title'] ?? '',
                      maxLines: 1,
                      style: const TextStyle(
                        color: Colors.teal,
                        decoration: TextDecoration.none,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    subtitle: Text(
                      '\$${product['price']}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductImage(Map<String, dynamic> product) {
    return product['images'] != null && product['images'].isNotEmpty
        ? AspectRatio(
            aspectRatio: 16 / 9, // Adjust aspect ratio as needed
            child: Image.network(
              product['images'][0],
              fit: BoxFit.cover,
            ),
          )
        : const SizedBox.shrink();
  }
}

class ProductDetailsPage extends StatefulWidget {
  final String productKey;

  const ProductDetailsPage({Key? key, required this.productKey})
      : super(key: key);

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  Map<String, dynamic> productData = {};

  @override
  void initState() {
    super.initState();
    fetchProductData();
  }

  Future<void> addToCart() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final String productKey = productData['id'].toString();
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('cart')
            .add({
          'productKey': productData['key'],
          'name': productData['title'],
          'price': '',
        });
        final cartProduct = CartProduct(
          id: productKey,
          name: productData['title'],
          price: productData!['price'],
        );
        Provider.of<CartProvider>(context, listen: false)
            .addToCart(cartProduct);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Product added to cart successfully'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please sign in to add products to cart'),
          ),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error adding product to cart: $error'),
        ),
      );
    }
  }

  Future<void> fetchProductData() async {
    try {
      final response = await http.get(
          Uri.parse('https://dummyjson.com/products/${widget.productKey}'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        setState(() {
          productData = data;
        });
      } else {
        throw Exception('Failed to load product data');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error fetching product data: $e'),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: productData.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Product ID: ${productData['id'] ?? ''}',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Product Title: ${productData['title'] ?? ''}',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  productData['images'] != null &&
                          productData['images'].isNotEmpty
                      ? Card(
                          elevation: 15,
                          child: Image.network(
                            productData['images'][0] ?? '',
                            height: 150,
                            width: 150,
                            fit: BoxFit.cover,
                          ),
                        )
                      : const SizedBox.shrink(),
                  const SizedBox(height: 8),
                  Text('Price: \$${productData['price'] ?? ''}'),
                  Text('Discount: ${productData['discount'] ?? 'N/A'}%'),
                  Text('Rating: ${productData['rating'] ?? 'N/A'}'),
                  Text('Stocks: ${productData['stocks'] ?? 'N/A'}'),
                  Text('Brand: ${productData['brand'] ?? 'N/A'}'),
                  Text('Category: ${productData['category'] ?? 'N/A'}'),
                  Text('Description: ${productData['description'] ?? 'N/A'}'),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () async {
                        try {
                          await addToCart();
                          Navigator.push(
                            context,
                            CustomPageRoute(
                              page: const CartPage(),
                            ),
                          );
                        } catch (error) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text('Error adding product to cart: $error'),
                            ),
                          );
                        }
                      },
                      child: const Text('Add to Cart'),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
