import 'dart:async';

import 'package:flutter_conference_app/models/data.dart';

abstract class IHomeModel {
  List<Speaker> speakers;
  Schedule schedule;
  About about;

  Future getDataFromFireStore();

  void populateScheduleAndSpeakers(IHomeModel model);

  void populateAbout(IHomeModel model);

  AugmentedTalk createAugmentedTalk(List<String> speakerIds, Talk talk);

  void generateScheduleList();

  void generateSpeakerList();

  void generateAboutList();

  Future getSharedPrefs();

  List<AugmentedTalk> getTalksForSpeaker(String speakerId);

  Speaker getSpeaker(String speakerId);

  String getTimeFromDateTime(String datetime);
}
