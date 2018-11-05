import 'package:flutter_conference_app/models/data.dart';
import 'package:flutter_conference_app/models/data.dart';
import 'package:flutter_conference_app/models/list_items.dart';
import 'package:flutter/widgets.dart';

abstract class IHomePresenter {
  bool loaded;
  List<ListItem> scheduleList;
  List<ListItem> speakerList;
  List<ListItem> aboutList;

  PageStorageBucket get bucket;

  PageStorageKey get scheduleKey;

  PageStorageKey get speakersKey;

  PageStorageKey get aboutKey;

  int currentIndex;
  List<Widget> pages;

  void init();

  void checkCache();

  void refreshState({bool showSnackBar = false});

  void showNetworkError();

  void fetchData();

  void configureFirebase(BuildContext context);
}

abstract class ISchedulePresenter {
  scheduleTap(BuildContext context, TalkBoss boss);
}

abstract class ISpeakersPresenter {
  speakerTap(BuildContext context, TalkBoss boss);
}

abstract class IAboutPresenter {
  aboutTap(BuildContext context, AboutAction action, String target);
}
