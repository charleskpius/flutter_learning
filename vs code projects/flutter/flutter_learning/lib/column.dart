import 'package:flutter/material.dart';

class columns3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 40),
      color: Colors.amber,
      child: const Column(
        children: [
          Text('Column 1'),
          Text('Column 2'),
          Text('Column 3'),
          Text('Column 4'),
          Text('Column 5'),
          Text('Column 6'),
          Text('Column 7'),
          Text('Column 8'),
          Text('Column 9'),
        ],
      ),
    );
  }
}
