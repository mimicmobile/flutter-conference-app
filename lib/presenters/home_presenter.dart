import 'dart:async';
import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_conference_app/app_config.dart';
import 'package:flutter_conference_app/config.dart';
import 'package:flutter_conference_app/interfaces/presenters.dart';
import 'package:flutter_conference_app/interfaces/views.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class HomePresenter implements IHomePresenter {
  final scheduleKey = PageStorageKey('scheduleKey');
  final speakersKey = PageStorageKey('speakersKey');
  final aboutKey = PageStorageKey('aboutKey');

  final PageStorageBucket bucket = PageStorageBucket();

  FirebaseMessaging _firebaseMessaging;
  FlutterLocalNotificationsPlugin localNotif =
      new FlutterLocalNotificationsPlugin();

  int currentIndex = 0;
  List<Widget> pages;

  IHomeView _view;

  HomePresenter(this._view);

  @override
  void configureFirebase(BuildContext context) {
    var config = AppConfig.of(context);

    if (_firebaseMessaging != null) {
      return;
    }

    _firebaseMessaging = FirebaseMessaging();
    _firebaseMessaging.subscribeToTopic(config.flavorName);

    var initializationSettingsAndroid =
        new AndroidInitializationSettings('@drawable/notification');
    var initializationSettingsIOS = new IOSInitializationSettings();

    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    localNotif = new FlutterLocalNotificationsPlugin();

    localNotif.initialize(initializationSettings,
        onSelectNotification: handleNotificationPayload);

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        await handleNotification(config, message);
      },
      onResume: (Map<String, dynamic> message) async {
        // Backgrounded
        await handleNotificationPayload(message["data"]["url"]);
      },
      onLaunch: (Map<String, dynamic> message) async {
        // Terminated
        await handleNotificationPayload(message["data"]["url"]);
      },
    );
  }

  Future<void> handleNotificationPayload(String payload) async {
    if (await canLaunch(payload)) {
      launch(payload);
    }
  }

  Future<void> handleNotification(
      AppConfig config, Map<String, dynamic> message) async {

    String title = message['notification']['title'];
    String body = message['notification']['body'] == ""
        ? 'Important notice'
        : message['notification']['body'];
    int id = message['data']['id'] == ""
        ? Random().nextInt(900)
        : int.parse(message['data']['id']);
    String payload = message['data']['url'];

    if (title == "") {
      localNotif.cancel(id);
    }

    var androidSpecifics = new AndroidNotificationDetails(
        'flutter-conference', Config.title, Config.description,
        enableVibration: true,
        color: Config.primaryColor,
        style: AndroidNotificationStyle.BigText,
        styleInformation: BigTextStyleInformation(body),
        importance: Importance.Default,
        priority: Priority.Default);

    var iosSpecifics = new IOSNotificationDetails(presentSound: false);

    var platformSpecifics =
        new NotificationDetails(androidSpecifics, iosSpecifics);
    await localNotif.show(id, title, body, platformSpecifics, payload: payload);
  }
}
