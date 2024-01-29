import 'package:flutter/material.dart';

class CustomDropDown extends StatefulWidget{
  const CustomDropDown ({Key? key}) : super (key:key);
  @override
  State <StatefulWidget> createState() => CustomDropDownState();
}

class CustomDropDownState extends State<CustomDropDown> {
  List<String> li = ['abcd', 'efgh', 'ijkl', 'mnop'];
  late String str;

  @override
  void initState() {
    super.initState();
    str = li.first;
  }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('DropDownButton'),
        ),
        body: dro(),
      ),
    );
  }

  Widget dro() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(20),
      child: DropdownButton(
        items: li.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
        value: str,
        onChanged: (value) => {setState(() => str = value!)},)
    );
  }
}