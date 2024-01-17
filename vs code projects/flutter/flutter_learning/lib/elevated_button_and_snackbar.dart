import 'package:flutter/material.dart';

class SnackBar8 extends StatefulWidget {
  const SnackBar8({super.key});
  @override
  State<SnackBar8> createState() => SnackBar8State();}
  class SnackBar8State extends State<SnackBar8> {
    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SnackBar'),
      ),
      body: getview(),
      floatingActionButton: FloatingActionButton(
        onPressed: ()  {showSnackBar(context, 'Floating button clicked');
        },
        backgroundColor: Colors.red,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget getview() {
    return const Center(
      child: Text('This is the body content'),
    );
  }

  void showSnackBar(BuildContext context, String str) {
    var c = SnackBar(
      content: Text(str),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () => {
          debugPrint('Undo clicked'),
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(c);
  }
}
