import 'package:flutter/material.dart';

class image4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      alignment: Alignment.topLeft,
      child: ReturnImage(),
    );
  }
}

class ReturnImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AssetImage assetImage = const AssetImage('Images/joshua.jpg');
    Image image = Image(image: assetImage);
    return Container(
      height: 160,
      width: 100,
      child: image,
    );
  }
}