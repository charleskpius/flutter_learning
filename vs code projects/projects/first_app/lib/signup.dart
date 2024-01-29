import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'login.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up Page'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SignupForm(),
      ),
    );
  }
}

class SignupForm extends StatefulWidget {
  const SignupForm({Key? key}) : super(key: key);

  @override
  State<SignupForm> createState() => SignupFormState();
}

class SignupFormState extends State<SignupForm> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  String validateName(String name) {
    if (name.isEmpty) {
      return 'Enter your name';
    }
    return '';
  }

  String validatePassword(String password) {
    if (password.isEmpty) {
      return 'Password is required';
    }

    // Use regex to enforce password rules
    if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).+$').hasMatch(password)) {
      return 'Password must contain at least one uppercase letter, one lowercase letter, and one digit';
    }

    return '';
  }

  String validateConfirmPassword(String confirmPassword) {
    if (confirmPassword != passwordController.text) {
      return 'Passwords do not match';
    }
    return '';
  }

  String validateEmail(String email) {
    if (email.isEmpty) {
      return 'Email is required';
    }

    // Use regex to validate email format
    if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
        .hasMatch(email)) {
      return 'Enter a valid email address';
    }

    return '';
  }

  String validatePhoneNumber(String phoneNumber) {
    if (phoneNumber.isEmpty) {
      return 'Phone number is required';
    }

    // Use regex to validate phone number format
    if (!RegExp(r'^\d{10}$').hasMatch(phoneNumber)) {
      return 'Enter a valid 10-digit phone number';
    }

    return '';
  }

  Future<void> signUpWithEmailAndPassword() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // Get the current user count to generate a numeric ID
      QuerySnapshot userCountSnapshot =
          await FirebaseFirestore.instance.collection('users').get();
      int userCount = userCountSnapshot.docs.length + 1;

      // User successfully signed up, now store additional data in Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'id': userCount, // Numeric ID starting from 1
        'name': usernameController.text,
        'email': emailController.text,
        'phone': phoneController.text,
        'password': passwordController.text,
      });

      // Clear text controllers after successful sign-up
      usernameController.clear();
      emailController.clear();
      phoneController.clear();
      passwordController.clear();
      confirmPasswordController.clear();

      // Navigate to the login page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    } catch (e) {
      // Show error message using Snackbar
      showErrorMessage("Error: $e");
    }
  }

  void showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                errorText: validateName(usernameController.text),
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                errorText: validateEmail(emailController.text),
              ),
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                setState(() {});
              },
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: phoneController,
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      errorText: validatePhoneNumber(phoneController.text),
                    ),
                    keyboardType: TextInputType.phone,
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                errorText: validatePassword(passwordController.text),
              ),
              obscureText: true,
              onChanged: (value) {
                setState(() {});
              },
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: confirmPasswordController,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                errorText:
                    validateConfirmPassword(confirmPasswordController.text),
              ),
              obscureText: true,
              onChanged: (value) {
                setState(() {});
              },
            ),
            const SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () {
                // Check if all text fields are filled and pass validation
                if (validateName(usernameController.text).isEmpty &&
                    validateEmail(emailController.text).isEmpty &&
                    validatePhoneNumber(phoneController.text).isEmpty &&
                    validatePassword(passwordController.text).isEmpty &&
                    validateConfirmPassword(confirmPasswordController.text)
                        .isEmpty) {
                  // If all fields are filled and pass validation, proceed to sign up
                  signUpWithEmailAndPassword();
                } else {
                  // If any field is not filled or validation fails, show an error message using Snackbar
                  showErrorMessage("Please fill in all the fields correctly.");
                }
              },
              child: const Text('Sign Up'),
            ),
            const SizedBox(height: 16.0),
            TextButton(
              onPressed: () {
                //Navigate to the login page when the "Login" button is pressed
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              child: const Text(
                "If you have an account, try Login!!",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
