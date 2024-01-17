import 'package:flutter/material.dart';

class container1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: Alignment.bottomRight,
        color: Colors.lightGreen,
        margin: const EdgeInsets.only(top: 100.0),
        child: const Text('container'),
      ),
    );
  }
}
