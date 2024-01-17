import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final Widget child;
  final Color color;
  final double padding;
  final double margin;

  CustomContainer(
      {Key? key,
      required this.child,
      this.color = Colors.white,
      this.padding = 16.0,
      this.margin = 0.0})
      : super(key: key);

@override
Widget build(BuildContext context) {
  return Container(
    margin: EdgeInsets.all(margin),
    padding: EdgeInsets.all(padding),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(10.0)
    ),
    child: child,
  );
}
}
