import 'package:flutter/material.dart';

class ListView6 extends StatelessWidget{
  const ListView6({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: li(),
    );
  }
  Widget li() {
    var list = ListView(
      children: const [
        ListTile(
          leading: Icon(Icons.landscape),
          title: Text('1st item'),
          subtitle: Text('1st items description'),
          trailing: Icon(Icons.wb_sunny),
        ),
        ListTile(
          leading: Icon(Icons.account_circle),
          title: Text('2nd item'),
          subtitle: Text('2nd items description'),
          trailing: Icon(Icons.account_box),
        ),
        ListTile(
          leading: Icon(Icons.laptop),
          title: Text('3rd item'),
          subtitle: Text('3rd items description'),
          trailing: Icon(Icons.mobile_screen_share),
        ),
      ],
    );
    return list;
  }
}