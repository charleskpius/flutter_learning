import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:first_app/product.dart';

class CategoryPage extends StatefulWidget {
  final String categoryName;

  const CategoryPage({Key? key, required this.categoryName, required Map<String, dynamic> categoryData}) : super(key: key);

  @override
  CategoryPageState createState() => CategoryPageState();
}

class CategoryPageState extends State<CategoryPage> {
  late Future<List<Map<String, dynamic>>> futureProducts;

  @override
  void initState() {
    super.initState();
    futureProducts = fetchProducts();
  }

  Future<List<Map<String, dynamic>>> fetchProducts() async {
    try {
      final response = await http.get(
        Uri.parse('https://dummyjson.com/products/category/${widget.categoryName}'),
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to fetch products');
      }
      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        return List<Map<String, dynamic>>.from(responseData);
      } else {
        throw Exception('Failed to fetch products');
      }
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }

  void navigateToProductDetails(Map<String, dynamic> product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductPage(
          productKey: product['key'].toString(),
        ),
      ),
    );
  }

  void navigateToCategoryProductsPage(String categoryName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductsDetails(
          categoryName: categoryName,
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
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: futureProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final Map<String, dynamic> product = snapshot.data![index];
                return GestureDetector(
                  onTap: () => navigateToProductDetails(product),
                  child: Card(
                    elevation: 5.0,
                    margin: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        _buildProductImage(product),
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
            );
          }
        },
      ),
    );
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
}

class ProductsDetails extends StatefulWidget {
  final String categoryName;

  const ProductsDetails({Key? key, required this.categoryName}) : super(key: key);

  @override
  ProductsDetailsState createState() => ProductsDetailsState();
}

class ProductsDetailsState extends State<ProductsDetails> {
  late Future<List<Map<String, dynamic>>> futureProducts;

  @override
  void initState() {
    super.initState();
    futureProducts = fetchProducts(widget.categoryName);
  }

  Future<List<Map<String, dynamic>>> fetchProducts(String categoryName) async {
    try {
      final response = await http.get(
        Uri.parse('https://dummyjson.com/products/category/$categoryName'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        return List<Map<String, dynamic>>.from(responseData);
      } else {
        throw Exception('Failed to fetch products');
      }
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }

  void navigateToProductDetails(Map<String, dynamic> product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductPage(
          productKey: product['key'].toString(),
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
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: futureProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final Map<String, dynamic> product = snapshot.data![index];
                return GestureDetector(
                  onTap: () => navigateToProductDetails(product),
                  child: Card(
                    elevation: 5.0,
                    margin: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        _buildProductImage(product),
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
            );
          }
        },
      ),
    );
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
}
