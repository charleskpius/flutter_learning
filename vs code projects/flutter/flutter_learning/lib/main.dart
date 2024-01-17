import 'package:flutter/material.dart';
import 'package:flutter_learning/container.dart';
import 'package:flutter_learning/row.dart';
import 'package:flutter_learning/column.dart';
import 'package:flutter_learning/image.dart';
import 'package:flutter_learning/button_and_onpressed_property.dart';
import 'package:flutter_learning/listview.dart';
import 'package:flutter_learning/add_values_to_listview.dart';
import 'package:flutter_learning/elevated_button_and_snackbar.dart';

void main() {
  runApp(
     MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: container1(),
      // home: rows2(),
      // home: columns3(),
      // home: image4(),
      // home: MyStatefulWidget(),
      // home: ListView6(),
      // home: ListView7(),
      home: SnackBar8(),
    ),
  );
}
