import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'bottom_navigation.dart';
import 'category.dart'; // Import your CategoryPage here

class CategoriesPage extends StatefulWidget {
  @override
  CategoriesPageState createState() => CategoriesPageState();
}

class CategoriesPageState extends State<CategoriesPage> {
  late Future<List<String>> categoriesFuture;
  int _selectedIndex = 1; // Define _selectedIndex

  @override
  void initState() {
    super.initState();
    categoriesFuture = fetchCategories();
  }

  void onTabChange(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<List<String>> fetchCategories() async {
    try {
      final response = await http
          .get(Uri.parse('https://dummyjson.com/products/categories'));

      if (response.statusCode == 200) {
        final List<String> categories =
            List<String>.from(json.decode(response.body));
        return categories;
      } else {
        // Handle error
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      // Handle exception
      throw Exception('Error fetching categories: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder<List<String>>(
        future: categoriesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<String> categories = snapshot.data ?? [];
            return ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                // Capitalize the first letter of the category
                String capitalizedCategory =
                    categories[index].substring(0, 1).toUpperCase() +
                        categories[index].substring(1);

                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 5.0,
                  margin: const EdgeInsets.all(10.0),
                  child: ListTile(
                    title: Text(
                      capitalizedCategory,
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CategoryPage(categoryName: capitalizedCategory),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
      bottomNavigationBar: BottomNavigation(
        selectedIndex: _selectedIndex,
        onTabChange: onTabChange,
      ),
    );
  }
}

class CategoryData {
  final String name;
  final String imageUrl;

  CategoryData({required this.name, required this.imageUrl});
}