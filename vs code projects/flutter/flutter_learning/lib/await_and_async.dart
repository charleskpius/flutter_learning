import 'package:flutter/material.dart';

class Syncs extends StatefulWidget {
  Syncs({super.key});
  @override
  State<Syncs> createState() => SyncsState();
}

class SyncsState extends State<Syncs> {
  String x = 'Has\'nt Started';
  String y = 'Has\'nt Started';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Await and Async'),
      ),
      body: Container(
        margin: EdgeInsets.all(30),
        child: ListView(
          children: [
            ElevatedButton(
              onPressed: () {
                return_x();
              },
              child: Text('First Function'),
            ),
            Text(
              x,
              style: TextStyle(fontSize: 25),
            ),
            Container(
              margin: EdgeInsets.all(30),
              child: ElevatedButton(
                onPressed: () {
                  return_y();
                },
                child: Text('Second Function'),
              ),
            ),
            Text(
              y,
              style: TextStyle(fontSize: 25),
            ),
          ],
        ),
      ),
    );
  }

  void return_x() async {
    for (int i = 0; i <= 100; i++) {
      setState(() {
        x = 'First Thread, ' + i.toString() + 'times';
      });
      await Future.delayed(Duration(seconds: 1));
    }
  }

  void return_y() async {
    for (int i = 0; i <= 100; i++) {
      setState(() {
        y = 'Second Thread, ' + i.toString() + 'times';
      });
      await Future.delayed(Duration(seconds: 1));
    }
  }
}
