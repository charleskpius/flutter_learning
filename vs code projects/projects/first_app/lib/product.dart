import 'dart:convert';
import 'package:first_app/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'dart:core';
import 'package:first_app/cart.dart';
import 'package:first_app/pageroute.dart';

class ProductPage extends StatefulWidget {
  final String productKey; // Change the type to String

  const ProductPage({Key? key, required this.productKey}) : super(key: key);

  @override
  ProductPageState createState() => ProductPageState();
}

class ProductPageState extends State<ProductPage> {
  Map<String, dynamic>? productData;

  @override
  void initState() {
    super.initState();
    productData = {};
    fetchProductData(widget.productKey);
  }

  Future<void> fetchProductData(String productId) async {
    try {
      final response = await http
          .get(Uri.parse('https://dummyjson.com/products/$productId'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        setState(() {
          productData = data;
          final productKey = productData!['id'].toString();
        });
      } else {
        throw Exception('Failed to load product data');
      }
    } catch (e) {
      print('Error fetching product data: $e');
      // Show error message as a SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error fetching product data: $e'),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  Future<void> addToCart() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      Navigator.push(
        context,
        CustomPageRoute(page: const CartPage()),
      );

      if (user != null) {
        final String productKey = productData!['id'].toString();
        final double price = productData!['price'] as double;
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('cart')
            .add({
          'productKey': productKey,
          'name': productData!['title'],
          'price': productData!['price'],
        });
        final cartProduct = CartProduct(
          id: productKey,
          name: productData!['title'],
          price: price,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Page'),
      ),
      body: productData == null || productData!.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Product Key: ${productData!['id'] ?? 'N/A'}',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Product Title: ${productData!['title'] ?? 'N/A'}',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 8),
                  productData!['images'] != null
                      ? Card(
                          elevation: 15,
                          child: Image.network(
                            productData!['images'][0] ?? '',
                            height: 150,
                            width: 150,
                            fit: BoxFit.cover,
                          ),
                        )
                      : const SizedBox
                          .shrink(), // Don't show the image if the URL is null
                  const SizedBox(height: 8),
                  Text('Price: \$${productData!['price'] ?? 'N/A'}'),
                  Text('Discount: ${productData!['discount'] ?? 'N/A'}%'),
                  Text('Rating: ${productData!['rating'] ?? 'N/A'}'),
                  Text('Stocks: ${productData!['stocks'] ?? 'N/A'}'),
                  Text('Brand: ${productData!['brand'] ?? 'N/A'}'),
                  Text('Category: ${productData!['category'] ?? 'N/A'}'),
                  Text('Description: ${productData!['description'] ?? 'N/A'}'),
                  // You can add more details as needed

                  const SizedBox(height: 16),

                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: addToCart,
                      child: const Text('Add to Cart'),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
