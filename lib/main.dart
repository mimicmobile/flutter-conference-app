import 'package:flutter/services.dart';
import 'package:flutter_conference_app/config.dart';
import 'package:flutter_conference_app/widgets/home.dart';
import 'package:flutter/material.dart';

void main() {
  MaterialPageRoute.debugEnableFadingRoutes = true;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    return MaterialApp(
      title: Config.title,
      theme: ThemeData(
        primaryColor: Colors.orange,
        accentColor: Color(0xFFFFA544),
        dividerColor: Colors.black54,
        backgroundColor: Color(0xFF330F3C),
        dialogBackgroundColor: Color(0xFF5B1B6B)
      ),
      home: Home(),
    );
  }
}
