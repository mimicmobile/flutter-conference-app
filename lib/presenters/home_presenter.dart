import 'dart:async';
import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_conference_app/app_config.dart';
import 'package:flutter_conference_app/config.dart';
import 'package:flutter_conference_app/models/conference_data.dart';
import 'package:flutter_conference_app/models/list_items.dart';
import 'package:flutter_conference_app/interfaces/models.dart';
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

  bool loaded = false;
  List<ListItem> scheduleList;
  List<ListItem> speakerList;
  List<ListItem> aboutList;

  IHomeModel _model = ConferenceData();
  IHomeView _view;

  HomePresenter(this._view);

  @override
  void init() {
    _model.init(this);
  }

  @override
  Future checkCache() async {
    if (loaded) {
      await _model.checkAndLoadCache();
    }
  }

  @override
  void refreshState({bool showSnackBar = false}) {
    _view.refreshState(showSnackBar);
  }

  @override
  void showNetworkError() {
    if (!loaded) {
      _view.showNetworkError();
    }
  }

  @override
  void fetchData() {
    _model.checkAndLoadCache();
  }

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
      onMessage: (Map<String, dynamic> message) {
        handleNotification(config, message);
      },
      onResume: (Map<String, dynamic> message) {
        // Backgrounded
        handleNotificationPayload(message['url']);
      },
      onLaunch: (Map<String, dynamic> message) {
        // Terminated
        handleNotificationPayload(message['url']);
      },
    );
  }

  Future handleNotificationPayload(String payload) async {
    if (await canLaunch(payload)) {
      launch(payload);
    }
  }

  void handleNotification(
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
