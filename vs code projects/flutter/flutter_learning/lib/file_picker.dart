import 'package:flutter/material.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';

class PickerFile extends StatefulWidget {
  PickerFile({super.key});
  @override
  State<PickerFile> createState() => PickerFileState();
}

class PickerFileState extends State<PickerFile> {
  String exception = 'Nothing so far';
  String filename = 'Nothing selected';
  String filepath = 'Nothing selected';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('File Picker'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Center(
                child: Text(
                  'Exception : $exception',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Center(
                child: Text(
                  'Filename : $filename',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Center(
                child: Text(
                  'Filepath : $filepath',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: () {
                  openFile();
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green),
                ),
                child: Text(
                  'Pick file',
                  style: TextStyle(fontSize: 25),
                ),
              ),
            ),
            Container(
                padding: EdgeInsets.only(left: 30, right: 20),
                color: Colors.black,
                height: 280,
                width: 280,
                child: filepath != 'Nothing selected'
                    ? Image.file(
                        File(filepath),
                      )
                    : Center(
                        child: Text('No image selected'),
                      )),
          ],
        ),
      ),
    );
  }

  void openFile() async {
    try {
      var files = await FilePicker.platform.pickFiles();
      if (files != null) {
        filepath = files.paths.single!;
        filename = filepath.split('/').last;
        setState(() {});
      }
    } catch (e) {
      print(e);
      setState(() {});
    }
  }
}
