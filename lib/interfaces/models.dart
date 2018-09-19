import 'dart:async';
import 'dart:io';

import 'package:flutter_conference_app/interfaces/presenters.dart';
import 'package:flutter_conference_app/models/data.dart';

abstract class IHomeModel {
  List<Speaker> speakers;
  List<Track> tracks;
  List<Schedule> schedule;
  List<TalkType> talkTypes;

  void init(IHomePresenter presenter);
  String cacheFileName(String path);
  Future<String> get cachePath;
  Future<File> get cachedFile;
  Future<bool> get cacheExists;
  Future<bool> get staleCacheCheck;
  void get loadDataFromCache;
  Future get fetchAndSaveData;
  Future saveData(resource);
  void populateData(IHomeModel model);
  void get generateScheduleList;
  void get generateSpeakerList;
  Future get checkAndLoadCache;
}
