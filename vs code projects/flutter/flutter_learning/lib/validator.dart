import 'package:flutter/material.dart';

class CustomValidator extends StatefulWidget {
  const CustomValidator({Key? key}) : super(key: key);
  @override
  State <StatefulWidget> createState() => CustomValidatorState();
}

class CustomValidatorState extends State<CustomValidator> {
  TextEditingController cnt = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Validator'),
        ),
        body: wi(),
      ),
    );
  }

  Widget wi() {
    return Container(
      padding:const  EdgeInsets.all(10),
      alignment: Alignment.center,
      child: TextFormField(
        controller: cnt,
        onChanged: (value) => {setState(() {}),},
        decoration: InputDecoration(errorText: validate(cnt.text)),
      ),
    );
  }

  String? validate(String str) {
    if(str.isEmpty) {
      return 'field is Empty';
    }
    return null;
  }
}