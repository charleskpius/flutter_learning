import 'package:flutter/material.dart';

class CustomMenuBar extends StatefulWidget {
  CustomMenuBar({super.key});
  @override
  State<CustomMenuBar> createState() => CustomMenuBarState();
}

class CustomMenuBarState extends State<CustomMenuBar> {
  String str = 'Nothing selected';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu Item'),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: Icon(Icons.computer),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => computer(),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.mobile_screen_share_rounded),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => mobile(),
                ),
              );
            },
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'Computer') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => computer(),
                  ),
                );
              } else if (value == 'Mobile') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => mobile(),
                  ),
                );
              } else {
                setState(() {
                  str = value;
                });
              }
            },
            itemBuilder: (context) {
              return {'Computer', 'Mobile'}.map((String e) {
                return PopupMenuItem(
                  value: e,
                  child: Text(e),
                );
              }).toList();
            },
          ),
        ],
      ),
    );
  }

  Widget computer() {
    return Scaffold(
      appBar: AppBar(),
      body: Text('Computer'),
    );
  }

  Widget mobile() {
    return Scaffold(
      appBar: AppBar(),
      body: Text('Mobile'),
    );
  }
}
