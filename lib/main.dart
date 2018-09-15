import 'package:androidto/widgets/home.dart';
import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'AndroidTO 2018',
      theme: new ThemeData(
        primaryColor: Colors.orange,
        accentColor: Colors.orangeAccent,
        brightness: Brightness.dark
      ),
      home: Home(),
    );
  }
}
