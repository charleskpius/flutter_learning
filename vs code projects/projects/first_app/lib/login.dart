import 'package:first_app/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/home.dart';
import 'package:first_app/signup.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LoginForm(),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key});

  @override
  LoginFormState createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? validatePassword(String password) {
    if (password.isEmpty) {
      return 'Password is required';
    }

    // Use regex to enforce password rules (e.g., at least one uppercase, one lowercase, and one digit)
    if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).+$').hasMatch(password)) {
      return 'Password must contain at least one uppercase letter, one lowercase letter, and one digit';
    }

    return null;
  }

  String? validateEmail(String email) {
    if (email.isEmpty) {
      return 'Email is required';
    }

    // Use regex to validate email format
    if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$').hasMatch(email)) {
      return 'Enter a valid email address';
    }

    return null;
  }

  Future<void> loginUser() async {
    final String email = emailController.text;
    final String password = passwordController.text;
    await SharedPreferencesService().saveUserLoginStatus(true);

    // Validate email and password
    String? emailError = validateEmail(email);
    String? passwordError = validatePassword(password);

    if (emailError != null || passwordError != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(emailError ?? passwordError!),
          duration: const Duration(seconds: 2),
        ),
      );
      return;
    }

    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Get the user document from Firestore using the UID
      DocumentSnapshot<Map<String, dynamic>> userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();

      if (userDoc.exists) {
        // User found, navigate to the home page
        Navigator.pushReplacement(
          context,
          CustomPageRoute(page: const HomeScreen()),
        );

        emailController.clear();
        passwordController.clear();
      } else {
        // User not found, display an error message using SnackBar
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invalid email or password'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } on FirebaseAuthException {
      // If login fails, display an error message using SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid email or password'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> resetPassword() async {
    String email = emailController.text;

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your email'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password reset email sent'),
          duration: Duration(seconds: 2),
        ),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.message}'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextField(
          controller: emailController,
          decoration: const InputDecoration(
            labelText: 'Email',
          ),
        ),
        const SizedBox(height: 16.0),
        TextField(
          controller: passwordController,
          obscureText: true,
          decoration: const InputDecoration(
            labelText: 'Password',
          ),
        ),
        const SizedBox(height: 8.0),
        TextButton(
          onPressed: resetPassword,
          child: const Text(
            'Forgot Password',
            style: TextStyle(color: Colors.blue),
          ),
        ),
        const SizedBox(height: 24.0),
        ElevatedButton(
          onPressed: loginUser,
          child: const Text('Login'),
        ),
        const SizedBox(height: 16.0),
        TextButton(
          onPressed: () {
            // Navigate to the login page when the "Login" button is pressed
            Navigator.pushReplacement(
              context,
              CustomPageRoute(page: const SignUpPage()),
            );
          },
          child: const Text(
            "If you have an account, try Signing up!!",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }
}

class CustomPageRoute<T> extends PageRouteBuilder<T> {
  final Widget page;

  CustomPageRoute({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;
            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);
            var slidingAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(animation);

            return SlideTransition(
              position: offsetAnimation,
              child: FadeTransition(
                opacity: slidingAnimation,
                child: child,
              ),
            );
          },
        );
}
