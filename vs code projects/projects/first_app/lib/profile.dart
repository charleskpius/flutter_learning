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

    fetchUserDetails();
  }

  Future<void> fetchUserDetails() async {
    try {
      DocumentSnapshot userSnapshot =
          await _firestore.collection('users').doc(_user?.uid).get();

      if (userSnapshot.exists) {
        setState(() {
          _displayNameController.text = userSnapshot['name'];
          _emailController.text = userSnapshot['email'];
          _phoneController.text = userSnapshot['phone'];
        });
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error fetching user details: $error'),
          duration: const Duration(seconds: 5),
        ),
      );
    }
  }

  Future<void> saveChanges() async {
    try {
      await _firestore.collection('users').doc(_user?.uid).update({
        'name': _displayNameController.text,
        'phone': _phoneController.text,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Changes saved successfully'),
          duration: const Duration(seconds: 3),
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
        child: SingleChildScrollView(
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
                      decoration: InputDecoration(labelText: 'Display Name'),
                    )
                  : Text(
                      'Display Name: ${_displayNameController.text}',
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    ),
              const SizedBox(height: 20),
              Text(
                'Email: ${_emailController.text}',
                style: const TextStyle(fontSize: 16, color: Colors.black),
              ),
              const SizedBox(height: 20),
              _isEditing
                  ? TextFormField(
                      controller: _phoneController,
                      decoration: InputDecoration(labelText: 'Phone Number'),
                    )
                  : Text(
                      'Phone Number: ${_phoneController.text}',
                      style: const TextStyle(fontSize: 16, color: Colors.black),
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
        ),
      ),
    );
  }
}
