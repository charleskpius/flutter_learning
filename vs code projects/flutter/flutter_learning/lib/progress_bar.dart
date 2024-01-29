import 'package:flutter/material.dart';

class ProgressBar extends StatefulWidget {
  ProgressBar({super.key});
  @override
  State<ProgressBar> createState() => ProgressBarState();
}

class ProgressBarState extends State<ProgressBar> {
  double x = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Progress'),
      ),
      body: ListView(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  child: Text(
                    'Circular Progress',
                    style: TextStyle(fontSize: 25),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  child: Text(
                    'Linear Progress',
                    style: TextStyle(fontSize: 25),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: LinearProgressIndicator(),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Circular Progress Bar with background color red',
                  style: TextStyle(fontSize: 25),
                ),
              ),
              Expanded(
                child: Center(
                  child: CircularProgressIndicator(backgroundColor: Colors.red),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Linear Progress Bar with background color red',
                  style: TextStyle(fontSize: 25),
                ),
              ),
              Expanded(
                child: Center(
                  child: LinearProgressIndicator(backgroundColor: Colors.red),
                ),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {increment();},
            child: Text('Start with custom value'),
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Circular Progress Bar with custom value',
                  style: TextStyle(fontSize: 15),
                ),
              ),
              Expanded(
                child: Center(
                  child: CircularProgressIndicator(
                    value: x,
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Text('$x'),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Linear Progress Bar with custom value',
                  style: TextStyle(fontSize: 15),
                ),
              ),
              Expanded(
                child: Center(
                  child: LinearProgressIndicator(
                    value: x,
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Text('$x'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void increment() async {
    for (double i = 1; i <= 10; i++) {
      setState(() {
        x = x + 0.1;
      });
      await Future.delayed(
        Duration(seconds: 1),
      );
    }
  }
}
