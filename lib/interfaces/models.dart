import 'dart:async';
import 'dart:io';

import 'package:flutter_conference_app/interfaces/presenters.dart';
import 'package:flutter_conference_app/models/data.dart';

abstract class IHomeModel {
  List<Speaker> speakers;
  List<Track> tracks;
  List<Schedule> schedule;
  List<TalkType> talkTypes;
  About about;

  void init(IHomePresenter presenter);

  String cacheFileName(String path);

  Future<String> get cachePath;

  Future<File> get cachedFile;

  Future<bool> cacheExists();

  Future<bool> isCacheStale();

  void loadDataFromCache();

  Future fetchAndSaveData();

  Future saveData(resource);

  void populateData(IHomeModel model);

  int getTalkIndex(List<AugmentedTalk> speakerTalks, int hashCode);

  TalkBoss createTalkBoss(String speakerId, [Talk talk]);

  void generateScheduleList();

  void generateSpeakerList();

  void generateAboutList();

  Future checkAndLoadCache();

  Future getSharedPrefs();

  List<AugmentedTalk> getTalksForSpeaker(String speakerId);

  AugmentedSpeaker getSpeaker(String speakerId);
}
