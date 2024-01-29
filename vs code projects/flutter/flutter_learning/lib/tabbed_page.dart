import 'package:flutter/material.dart';

class CustomTabs extends StatefulWidget {
  CustomTabs({super.key});
  @override
  State<CustomTabs> createState() => CustomTabsState();
}

class CustomTabsState extends State<CustomTabs> with TickerProviderStateMixin {
  late TabController cn;
  int tab = 0;
  @override
  void initState() {
    super.initState();
    cn = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Tabbed Page'),
        ),
        body: TabBarView(
          controller: cn,
          children: [
            Container(
              color: Colors.lightGreen,
              child: Center(
                child: Text(
                  'Page 1',
                  style: TextStyle(
                    fontSize: 50,
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.lime,
              child: Center(
                child: Text(
                  'Page 2',
                  style: TextStyle(fontSize: 50),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {
            cn.animateTo(value);
            setState(() {
              tab = value;
            });
          },
          currentIndex: tab,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.pages),
              label: 'One',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.pages),
              label: 'Two',
            ),
          ],
        ),
      ),
    );
  }
}
