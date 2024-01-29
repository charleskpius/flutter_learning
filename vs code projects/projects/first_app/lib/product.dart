import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
      throw error; // Rethrow the error so that FutureBuilder can catch it
    }
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
            return buildProductDetails(snapshot.data!);
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

  Widget buildProductDetails(Map<String, dynamic> productData) {
    // Implement the UI for displaying product details here
    return Center(
      child: Text(productData['description'] ?? 'No description available'),
    );
  }

  Future<void> addToCart(Map<String, dynamic> productData) async {
    // ... Your existing addToCart method remains unchanged
  }
}
