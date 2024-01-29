import 'package:flutter/material.dart';

class Gesture extends StatefulWidget {
  Gesture({super.key});
  @override
  State<Gesture> createState() {
    return GestureState();
  }
}

class GestureState extends State<Gesture> {
  int x = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gesture Detector'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            setState(() {
              x++;
            });
          },
          child: Text(
            'Tapped $x times',
            style: TextStyle(fontSize: 25),
          ),
        ),
      ),
    );
  }
}
