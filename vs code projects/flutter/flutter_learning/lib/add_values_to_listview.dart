import 'package:flutter/material.dart';

class ListView7 extends StatelessWidget {
  const ListView7({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adding Values'),
      ),
      body: view(),
    );
  }

  List getelements() {
    List li = List.generate(100, (index) => 'Item is $index');
    return li;
  }

  Widget view() {
    var items = getelements();

    var li = ListView.builder(itemBuilder: (context, index) {
      return ListTile (
        leading: const Icon(Icons.arrow_right),
        title: Text(items[index] as String),
      );
    },
    itemCount: 100);
    return li;
  }
}