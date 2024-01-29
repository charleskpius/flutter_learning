import 'package:flutter/material.dart';

class CustomGridView extends StatefulWidget {
  const CustomGridView({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => CustomGridViewState();
}

class CustomGridViewState extends State<CustomGridView> {
  List<String> nonVeggies = ['Chicken', 'Beef', 'Fish', 'Egg'];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Grid View'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 8),
              itemBuilder: (context, index) {
                var xIndex = index % 8;
                var yIndex = (index / 8).floor();
                // var titleId = ${titleletter[xIndex]}${yIndex + 1};
                return Container(
                  color: (xIndex + yIndex).isEven ? Colors.black : Colors.white,
                  child: const Stack(children: <Widget>[]),
                );
              }),
        ),
      ),
    );
  }
}
