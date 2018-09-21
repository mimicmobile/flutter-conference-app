import 'package:flutter/services.dart';
import 'package:flutter_conference_app/config.dart';
import 'package:flutter_conference_app/widgets/home.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    return MaterialApp(
      title: Config.title,
      theme: ThemeData(
        primaryColor: Config.primaryColor,
        accentColor: Config.accentColor,
        dividerColor: Config.dividerColor,
        backgroundColor: Config.backgroundColor,
        dialogBackgroundColor: Config.bottomNavBarColor
      ),
      home: Home(),
    );
  }
}
