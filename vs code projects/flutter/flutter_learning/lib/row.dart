import 'package:flutter/material.dart';

class rows2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Container(
      child: const Row(
        children: [
          Text('row 1'),
          Text('row 2'),
        ],
      ),
    );
  }
}