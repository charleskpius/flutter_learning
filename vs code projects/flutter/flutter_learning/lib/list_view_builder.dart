import 'package:flutter/material.dart';

class CustomListView extends StatefulWidget {
  const CustomListView({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => CustomListViewState();
}

class CustomListViewState extends State<CustomListView> {
  List<String> veggies = ['Broccoli', 'Carrot', 'Cucumber'];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('List View'),
        ),
        body: ListView.builder(
          itemCount: veggies.length,
          itemBuilder: (context, int index) => Text(
            veggies[index],
          ),
        ),
      ),
    );
  }
}
