import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'bottom_navigation.dart';
import 'category.dart';

class CategoriesPage extends StatefulWidget {
  @override
  CategoriesPageState createState() => CategoriesPageState();
}

class CategoriesPageState extends State<CategoriesPage> {
  late Future<List<String>> futureCategories;
  int _selectedIndex = 1; // Define _selectedIndex

  @override
  void initState() {
    super.initState();
    futureCategories = fetchCategories();
  }

  void onTabChange(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<List<String>> fetchCategories() async {
    try {
      final response =
          await http.get(Uri.parse('https://dummyjson.com/products/categories'));

      if (response.statusCode == 200) {
        return List<String>.from(json.decode(response.body));
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
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
        future: futureCategories,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                String capitalizedCategory =
                    snapshot.data![index].substring(0, 1).toUpperCase() +
                        snapshot.data![index].substring(1);

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
                          builder: (context) => FutureCategoryPage(
                            categoryName: capitalizedCategory,
                          ),
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

class FutureCategoryPage extends StatefulWidget {
  final String categoryName;

  const FutureCategoryPage({Key? key, required this.categoryName})
      : super(key: key);

  @override
  _FutureCategoryPageState createState() => _FutureCategoryPageState();
}

class _FutureCategoryPageState extends State<FutureCategoryPage> {
  late Future<Map<String, dynamic>> futureCategoryData;

  @override
  void initState() {
    super.initState();
    futureCategoryData = fetchCategoryDetails(widget.categoryName);
  }

  Future<Map<String, dynamic>> fetchCategoryDetails(String categoryName) async {
    try {
      // Replace this with the actual API endpoint for category details
      final response = await http.get(
          Uri.parse('https://dummyjson.com/category/details/$categoryName'));

      if (response.statusCode == 200) {
        return Map<String, dynamic>.from(json.decode(response.body));
      } else {
        throw Exception('Failed to load category details');
      }
    } catch (e) {
      throw Exception('Error fetching category details: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: futureCategoryData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return CategoryPage(
            categoryData: snapshot.data!,
            categoryName: widget.categoryName,
          );
        }
      },
    );
  }
}
