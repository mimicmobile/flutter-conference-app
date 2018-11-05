import 'package:flutter/services.dart';
import 'package:flutter_conference_app/app_config.dart';
import 'package:flutter_conference_app/config.dart';
import 'package:flutter_conference_app/widgets/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_villains/villains/villains.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    var config = AppConfig.of(context);

    return MaterialApp(
        title: config.appName,
        theme: ThemeData(
            primaryColor: Config.primaryColor,
            accentColor: Config.accentColor,
            dividerColor: Config.dividerColor,
            backgroundColor: Config.backgroundColor,
            dialogBackgroundColor: Config.bottomNavBarColor
        ),
        home: Home(),
        navigatorObservers: [new VillainTransitionObserver()]
    );
  }
}
