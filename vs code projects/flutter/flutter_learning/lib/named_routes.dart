import 'package:flutter/material.dart';

class CustomNamedRoutes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Named Route Navigation',
      theme: ThemeData(
        //this is the theme of your application
        primarySwatch: Colors.green,
      ),
      // it start the app with the "/" named route. In this case, the app starts on the homescreen widget.
      initialRoute: '/',
      routes: {
        // when navigating to the "/" route, build the homescreen widget.
        '/': (context) => Main(),
        // when navigating to the "/second" route, build the secondscreen widget.
        '/second': (context) => ScreenTwo(),
      },
    );
  }
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/second');
          },
          child: Text('Click Here'),
        ),
      ),
    );
  }
}

class ScreenTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context, '/second');
          },
          child: Text('Click Here'),
        ),
      ),
    );
  }
}
