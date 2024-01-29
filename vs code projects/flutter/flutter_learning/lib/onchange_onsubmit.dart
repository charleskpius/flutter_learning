import 'package:flutter/material.dart';

class OnchangeOnsubmit extends StatefulWidget{
  const OnchangeOnsubmit({Key? key}) : super(key:key);
  @override

  State<StatefulWidget> createState() => OnchangeOnsubmitState();
}

class OnchangeOnsubmitState extends State<OnchangeOnsubmit>{
  String str = 'null';
  String str1 = 'null';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('OnChange and OnSubmit'),
        ),
        body: text_1(),
      ),
    );
  }
  Widget text_1() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: ListView(
        children: [
          TextField(
            onSubmitted: (value) => {setState(() => str = value)},
            onChanged: (value) => {setState(() => str1 = value)},
          ),
          Container(
            alignment: Alignment.topCenter,
            margin: const EdgeInsets.only(top:10),
            child: Text('Onsubmitted $str', style: const TextStyle(color: Colors.black, fontSize: 15,),),
          ),
          Container(
            alignment: Alignment.topCenter,
            margin: const EdgeInsets.only(top:10),
            child: Text('OnChanged $str1', style: const TextStyle(color: Colors.black, fontSize: 15,),),
          ),
        ],
      )
    );
  }
}