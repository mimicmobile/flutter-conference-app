import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_conference_app/config.dart';
import 'package:flutter_conference_app/models/list_items.dart';
import 'package:flutter_conference_app/models/data.dart';
import 'package:flutter_conference_app/interfaces/models.dart';
import 'package:flutter_conference_app/interfaces/presenters.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:json_annotation/json_annotation.dart';
part 'conference_data.g.dart';

@JsonSerializable()
class ConferenceData implements IHomeModel {
  final String jsonUrl = Config.jsonUrl;

  List<Speaker> speakers;
  List<Track> tracks;
  List<Schedule> schedule;

  @JsonKey(name: 'talk_types')
  List<TalkType> talkTypes;

  @JsonKey(ignore: true)
  IHomePresenter _presenter;

  ConferenceData();

  factory ConferenceData.fromJson(Map<String, dynamic> content) => _$ConferenceDataFromJson(content);
  Map<String, dynamic> toJson() => _$ConferenceDataToJson(this);

  @override
  Future init(IHomePresenter presenter) async {
    _presenter = presenter;
    bool exists = await _cacheExists;

    if (exists) {
      print("Cache exists, loading from disk");
      await _loadDataFromCache;
      _staleCacheCheck.then((isStale) async {
        if (isStale) {
          print("Cache outdated, fetching new data..");
          await _fetchAndSaveData;
        }
      });
    } else {
      print("Cache unavailable, fetching new data..");
      await _fetchAndSaveData;
    }
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
    return await http.head(this.jsonUrl).then((response) async {
      SharedPreferences sharedPrefs = await SharedPreferences.getInstance();

      String etag = sharedPrefs.getString('etag') ?? null;
      String serverEtag = response.headers.containsKey('etag') ?
      response.headers['etag'] : null;

      if (etag == serverEtag) {
        print("Cache file not changed, keeping cache");
        return false;
      } else {
        sharedPrefs.setString('etag', serverEtag);
        print("Cache file changed!");
        return true;
      }

    }).catchError((e) {
      print("staleCacheCheck failed: $e");
      return false;
    });
  }

  get _loadDataFromCache async {
    return await _cachedFile.then((file) {
      try {
        _populateData(
            ConferenceData.fromJson(json.decode(file.readAsStringSync())));
      } catch (e) {
        print("Cache file has invalid JSON!\n" + e.toString());
      }
    });
  }

  Future get _fetchAndSaveData async {
    return http.get(this.jsonUrl).then((response) async {
      await _saveData(response);
      await _loadDataFromCache;
    }).catchError((e) => print("fetchAndSaveData failed $e"));
  }

  _saveData(resource) async {
    await _cachedFile.then((file) {
      try {
        json.decode(resource.body);
        file.writeAsString(resource.body);
      } catch (e) {
        print("File was not valid JSON!");
      }
    });
  }

  _populateData(ConferenceData conferenceData) {
    this.speakers = conferenceData.speakers;
    this.tracks = conferenceData.tracks;
    this.schedule  = conferenceData.schedule;
    this.talkTypes = conferenceData.talkTypes;

    _generateScheduleList;
    _generateSpeakerList;

    var wasLoaded = _presenter.loaded;

    _presenter.loaded = true;
    _presenter.refreshState(showSnackBar: wasLoaded);
  }

  get _generateScheduleList {
    var _scheduleList = <ListItem>[];

    this.schedule.forEach((f) {
      _scheduleList.add(new TimeItem(f.time));  // Add time item
      f.talks.forEach((talk) {                  // Add talk items
        var _augmentedTalk = talk.createAugmented(speakers, tracks, talkTypes);
        _scheduleList.add(new TalkItem(_augmentedTalk));
      });
    });

    _presenter.scheduleList = _scheduleList;
    print("Schedule parsed and flattened | ${_scheduleList.length} items");
  }

  get _generateSpeakerList {
    var _speakerList = <ListItem>[];

    this.speakers.forEach((f) {
      _speakerList.add(new SpeakerItem(f));
    });

    _presenter.speakerList = _speakerList;
    print("Speakers parsed | ${_speakerList.length} items");
  }
}
