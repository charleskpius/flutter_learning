import 'package:flutter/material.dart';

class BestPractise extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Cs();
  }
}

class Cs extends State<BestPractise> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Stateful widget class'),
        ),
        body: wi(),
      ),
    );
  }

  Widget wi() {
    return const Center(
      child: Text('Structure of Stateful Widget class'),
    );
  }
}
