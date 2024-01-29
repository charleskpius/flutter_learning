import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductPage extends StatefulWidget {
  final String productKey;

  const ProductPage({Key? key, required this.productKey}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late Future<Map<String, dynamic>> futureProductData;

  @override
  void initState() {
    super.initState();
    futureProductData = fetchProductData(widget.productKey);
  }

  Future<Map<String, dynamic>> fetchProductData(String productId) async {
    try {
      final response = await http.get(Uri.parse('https://dummyjson.com/products/$productId'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return data;
      } else {
        throw Exception('Failed to load product data');
      }
    } catch (error) {
      print('Error loading product data: $error');
      rethrow; // Rethrow the error so that FutureBuilder can catch it
    }
  }

  Widget _buildProductImage(Map<String, dynamic> product) {
    return product['images'] != null && product['images'].isNotEmpty
        ? AspectRatio(
            aspectRatio: 16 / 9,
            child: Image.network(
              product['images'][0],
              fit: BoxFit.cover,
            ),
          )
        : const SizedBox.shrink();
  }

  Widget buildProductDetails(Map<String, dynamic> productData) {
    int price = int.tryParse(productData['price'] ?? '') ?? 0;

    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(productData['title'] ?? 'No title available', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Text('Price: \$${price.toString()}', style: TextStyle(fontSize: 18)),
          SizedBox(height: 10),
          Text('Rating: ${productData['rating'] ?? 'No rating available'}', style: TextStyle(fontSize: 18)),
          SizedBox(height: 10),
          Text('Brand: ${productData['brand'] ?? 'No brand available'}', style: TextStyle(fontSize: 18)),
          SizedBox(height: 10),
          Text('Category: ${productData['category'] ?? 'No category available'}', style: TextStyle(fontSize: 18)),
          SizedBox(height: 10),
          Text('Description: ${productData['description'] ?? 'No description available'}', style: TextStyle(fontSize: 18)),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<Map<String, dynamic>>(
          future: futureProductData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text('Loading...'); // Placeholder text while loading
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return Text(snapshot.data?['title'] ?? 'Product Page');
            }
          },
        ),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: futureProductData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildProductImage(snapshot.data!),
                buildProductDetails(snapshot.data!),
              ],
            );
          }
        },
      ),
      bottomNavigationBar: FutureBuilder<Map<String, dynamic>>(
        future: futureProductData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox.shrink(); // Hide the bottom navigation bar while loading
          } else if (snapshot.hasError) {
            return SizedBox.shrink(); // Hide the bottom navigation bar on error
          } else {
            return SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: () => addToCart(snapshot.data!),
                child: const Text('Add to Cart'),
              ),
            );
          }
        },
      ),
    );
  }

  Future<void> addToCart(Map<String, dynamic> productData) async {
    // ... Your existing addToCart method remains unchanged
  }
}
