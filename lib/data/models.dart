import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class ConferenceData {
  static final ConferenceData _conferenceData = new ConferenceData._internal();
  final String jsonUrl = "http://jeff.mimic.ca/p/androidto/data.json";

  List<Speaker> speakers;
  List<Track> tracks;
  List<TalkType> talkTypes;
  List<Schedule> schedule;

  bool loaded = false;

  ConferenceData();

  static ConferenceData get() {
    return _conferenceData;
  }

  ConferenceData._internal();

  init() async {
    bool exists = await _cacheExists;
    if (exists) {
      _loadDataFromCache;
    } else {
      _fetchData;
    }
    _staleCacheCheck;
  }

  String _cacheFileName(String path) {
    return join(path, 'data.json');
  }

  Future<String> get _cachePath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _cachedFile async {
    final path = await _cachePath;
    return File(_cacheFileName(path));
  }

  Future<bool> get _cacheExists async {
    final file = await _cachedFile;
    return await file.exists();
  }

  Future<bool> get _staleCacheCheck async {
    return http.head(this.jsonUrl).then((response) {
      print("etag: $response.headers['Etag']");
    }).catchError((e) => print(e));
  }

  get _loadDataFromCache async {
    _cachedFile.then((file) {
      print(file);
      file.readAsString().then((contents) => _loadFromJson(contents));
    });
  }

  Future get _fetchData async {
    return http.get(this.jsonUrl).then((response) {
      print(response);
      saveData(response);
    }).catchError((e) => print(e));
  }

  saveData(resource) async {
    return _cachedFile.then((file) => file.writeAsString(resource));
  }

  _loadFromJson(String contents) {
    print(contents);
  }
}

class Speaker {
  String name;
  String bio;
  String imageUrl;
}

class Track {
  String name;
}

class TalkType {
  String name;
  String materialIcon;
}

class Talk {
  int speaker;
  int track;
  int talk_type;
  String title;
  String description;
}

class Schedule {
  String time;
  List<Talk> talks;
}