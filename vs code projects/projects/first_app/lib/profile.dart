import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? _user;
  late TextEditingController _displayNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  bool _isEditing = false;

  @override
  void dispose() {
    _displayNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser;
    _displayNameController =
        TextEditingController(text: _user?.displayName ?? '');
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
  }

  Future<UserDetails> fetchUserDetails() async {
    try {
      DocumentSnapshot userSnapshot =
          await _firestore.collection('users').doc(_user?.uid).get();

      if (userSnapshot.exists) {
        return UserDetails(
          name: userSnapshot['name'],
          email: userSnapshot['email'],
          phone: userSnapshot['phone'],
        );
      }
      // Handle the case when user details are not available
      return UserDetails(); // You may want to have default values or throw an error here
    } catch (error) {
      rethrow;
    }
  }

  Future<void> saveChanges() async {
    try {
      await _firestore.collection('users').doc(_user?.uid).update({
        'name': _displayNameController.text,
        'phone': _phoneController.text,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Changes saved successfully'),
          duration: Duration(seconds: 3),
        ),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error saving changes: $error'),
          duration: const Duration(seconds: 5),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<UserDetails>(
          future: fetchUserDetails(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              UserDetails userDetails = snapshot.data ?? UserDetails();

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Profile Information',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _isEditing
                        ? TextFormField(
                            controller: _displayNameController,
                            decoration:
                                const InputDecoration(labelText: 'Display Name'),
                          )
                        : Text(
                            'Display Name: ${userDetails.name}',
                            style:
                                const TextStyle(fontSize: 16, color: Colors.black),
                          ),
                    const SizedBox(height: 20),
                    Text(
                      'Email: ${userDetails.email}',
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    const SizedBox(height: 20),
                    _isEditing
                        ? TextFormField(
                            controller: _phoneController,
                            decoration:
                                const InputDecoration(labelText: 'Phone Number'),
                          )
                        : Text(
                            'Phone Number: ${userDetails.phone}',
                            style:
                                const TextStyle(fontSize: 16, color: Colors.black),
                          ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _isEditing = !_isEditing;
                        });

                        if (!_isEditing) {
                          saveChanges();
                        }
                      },
                      child: Text(_isEditing ? 'Save Changes' : 'Edit Profile'),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class UserDetails {
  final String name;
  final String email;
  final String phone;

  UserDetails({this.name = '', this.email = '', this.phone = ''});
}
