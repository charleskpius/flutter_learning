import 'package:flutter/material.dart';

class CustomAlert extends StatefulWidget {
  CustomAlert({super.key});
  @override
  State<CustomAlert> createState() => CustomAlertState();
}

class CustomAlertState extends State<CustomAlert> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alert Box'),
      ),
      body: ElevatedButton(
        onPressed: () {
          setState(
            () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("Yay!...you clicked me"),
                  );
                },
              );
            },
          );
        },
        child: Text('click me'),
      ),
    );
  }
}
