import 'package:flutter_conference_app/config.dart';
import 'package:flutter_conference_app/widgets/home.dart';
import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: Config.title,
      theme: new ThemeData(
        primaryColor: Colors.orange,
        accentColor: Colors.orangeAccent,
      ),
      home: Home(),
    );
  }
}
