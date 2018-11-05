import 'package:flutter/material.dart';
import 'package:flutter_conference_app/app_config.dart';
import 'package:flutter_conference_app/config.dart';
import 'package:flutter_conference_app/main_widget.dart';

void main() {
  var configuredApp = new AppConfig(
    appName: Config.title,
    flavorName: 'production',
    child: new MyApp(),
  );

  runApp(configuredApp);
}

