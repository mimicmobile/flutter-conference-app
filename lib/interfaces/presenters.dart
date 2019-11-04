import 'package:flutter_conference_app/models/data.dart';
import 'package:flutter/widgets.dart';

abstract class IHomePresenter {
  PageStorageBucket get bucket;

  PageStorageKey get scheduleKey;

  PageStorageKey get speakersKey;

  PageStorageKey get aboutKey;

  int currentIndex;
  List<Widget> pages;

  void configureFirebase(BuildContext context);
}

abstract class ISchedulePresenter {
  scheduleTap(BuildContext context, AugmentedTalk talk);
}

abstract class ISpeakersPresenter {
  speakerTap(BuildContext context, Speaker speaker);
}

abstract class IAboutPresenter {
  aboutTap(BuildContext context, AboutAction action, String target);
}
