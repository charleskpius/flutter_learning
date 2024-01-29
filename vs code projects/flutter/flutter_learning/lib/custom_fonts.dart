import 'package:flutter/material.dart';


class CustomFonts extends StatelessWidget {
  CustomFonts({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Custom Fonts'),),
      body: view(),
    );
  }

  Widget view() {
    return Container(
      margin: const EdgeInsets.all(50),
      alignment: Alignment.center,
      child: const Column(
        children: [
          Text('Normal raleway', style: TextStyle(fontSize: 20, fontFamily: 'Raleway'),),
          Text('Bold, weight 700', style: TextStyle(fontSize: 20, fontFamily: 'Raleway', fontWeight: FontWeight.w700),),
          Text('Italic style', style: TextStyle(fontSize: 20, fontFamily: 'Raleway', fontStyle: FontStyle.italic),),
          Text('Regular, weight 300', style: TextStyle(fontSize:20, fontFamily: 'Raleway', fontWeight: FontWeight.w300),),
        ]
      )
    );
  }
}