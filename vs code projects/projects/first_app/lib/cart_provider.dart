import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CartProduct {
  String? id;
  String? name;
  double price; // Use double for price

  CartProduct({required this.id, required this.name, this.price = 0.0}); // Initialize price

  // Constructor for Firestore data
  CartProduct.fromMap(Map<String, dynamic> map)
      : id = map['key'] as String?,
        name = map['name'] as String?,
        price = map['price'] as double;

  static CartProduct fromFirestore(QueryDocumentSnapshot<Object?> doc) {
    final data = doc.data() as Map<String, dynamic>;
    return CartProduct.fromMap(data);
  }
}

class CartProvider with ChangeNotifier {
  late Map<String, CartProduct> _cart = {};

  void setCart(List<CartProduct> cartProducts) {
    _cart = {for (var product in cartProducts) product.id!: product};
    notifyListeners();
  }

  Map<String, CartProduct> get cart => _cart;

  double get totalAmount =>
      _cart.values.fold(0.0, (sum, product) => sum + product.price);

  void addToCart(CartProduct product) {
    if (_cart.containsKey(product.id)) {
      // Update price if the product is already in the cart
      _cart[product.id!] = product;
    } else {
      _cart[product.id!] = product;
    }

    notifyListeners();
  }

  void removeFromCart(String productKey) {
    _cart.remove(productKey);
    notifyListeners();
  }

  void increasePrice(String productKey) {
    if (_cart.containsKey(productKey)) {
      _cart[productKey]?.price++; // Access price directly
      notifyListeners();
    } else {
      print('Product not found in cart: $productKey');
    }
  }

  void decreasePrice(String productKey) {
    if (_cart.containsKey(productKey)) {
      if (_cart[productKey]!.price > 0) {
        _cart[productKey]?.price--; // Access price directly
        notifyListeners();
      } else {
        // Remove the product from the cart if the price reaches 0
        _cart.remove(productKey);
        notifyListeners();
      }
    } else {
      print('Product not found in cart: $productKey');
    }
  }
}
