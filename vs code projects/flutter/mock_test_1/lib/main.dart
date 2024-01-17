import 'package:flutter/material.dart';
import 'package:mock_test_1/custom_container.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: CustomContainer(child: const Text('Custom Container')),
    );
  }
}