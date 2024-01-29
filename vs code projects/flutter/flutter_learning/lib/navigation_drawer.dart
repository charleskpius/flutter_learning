import 'package:flutter/material.dart';

class CustomNavigationDrawer extends StatefulWidget {
  CustomNavigationDrawer({super.key});
  @override
  State<CustomNavigationDrawer> createState() => CustomNavigationDrawerState();
}

class CustomNavigationDrawerState extends State<CustomNavigationDrawer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Naviagtion Drawer'),
      ),
      body: Container(
        child: Text('Main Page'),
      ),
      drawer: Drawer(elevation: 20, child: customDrawer())
    );
  }

  Widget customDrawer() {
    return ListView(children: [
      Icon(Icons.person_2_outlined),
      TextButton(
        onPressed: () {},
        child: Text('Button 1'),
      ),
      TextButton(
        onPressed: () {},
        child: Text('Button 2'),
      ),
      TextButton(
        onPressed: () {},
        child: Text('Button 3'),
      ),
      Text('We can create as like we create normal pages.'),
    ]);
  }
}
