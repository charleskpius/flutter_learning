import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'bottom_navigation.dart';
import 'cart_provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  CartPageState createState() => CartPageState();
}

class CartPageState extends State<CartPage> {
  int _selectedIndex = 2;
  late CartProvider cartProvider;

  @override
  void initState() {
    super.initState();
    _fetchCartProducts();
  }

  @override
  void didChangeDependencies() {
    super
  }

  Future<void> _fetchCartProducts() async {
    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      final cartSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('cart')
          .get();

      final cartProducts = cartSnapshot.docs
          .map((doc) => CartProduct.fromFirestore(doc))
          .toList();

      cartProvider.setCart(cartProducts.cast<CartProduct>());
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error fetching cart: $error'),
        ),
      );
    }
  }

  Stream<QuerySnapshot> get cartStream {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('cart')
        .snapshots();
  }

  Future<void> addProductsToCart(CartProduct product) async {
    try {
      // Add product to Firestore
      final userId = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('cart')
          .add({
        'key': product.id,
        'name': product.name,
        'price': product.price,
      });

      // Also add product to local cart provider
      cartProvider.addToCart(product);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Product added to cart successfully!'),
        ),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error adding product to cart: $error'),
        ),
      );
    }
  }

  Future<void> removeProductFromCart(String productId) async {
    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('cart')
          .doc(productId)
          .delete();

      cartProvider.removeFromCart(productId);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Product removed from cart successfully!')),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Error removing product from Firestore: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: cartStream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Error lodaing cart: ${snapshot.error}'),
              );
            }
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            final cartProducts = snapshot.data!.docs.map((doc) => CartProduct.fromFirestore(doc)).toList();
            return ListView.builder(
              itemCount: cartProvider.cart.length,
              itemBuilder: (context, index) {
                final product = cartProvider.cart.values
                    .elementAt(index); // Access products from provider
                return ListTile(
                  title: Text(product.name!),
                  subtitle: Text('price: ${product.price}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () async {
                          try {
                            await removeProductFromCart(product.id!);
                          } catch (error) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content:
                                      Text('Error removing product: $error')),
                            );
                          }
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    ],
                  ),
                  // Add other product details and actions as needed
                );
              },
            );
          }),
      bottomNavigationBar: BottomNavigation(
        selectedIndex: _selectedIndex,
        onTabChange: (index) => setState(() => _selectedIndex = index),
      ),
    );
  }
}
