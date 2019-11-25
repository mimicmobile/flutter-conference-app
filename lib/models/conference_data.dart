import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conference_app/models/list_items.dart';
import 'package:flutter_conference_app/models/data.dart';
import 'package:flutter_conference_app/interfaces/models.dart';
import 'package:flutter_conference_app/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'conference_data.g.dart';

@JsonSerializable()
class ConferenceData extends ChangeNotifier implements IHomeModel {
  List<Speaker> speakers;
  Schedule schedule;
  About about;

  @JsonKey(ignore: true)
  bool wasLoaded = false;
  @JsonKey(ignore: true)
  bool loaded = false;
  @JsonKey(ignore: true)
  bool aboutLoaded = false;

  @JsonKey(ignore: true)
  List<ListItem> scheduleList;
  @JsonKey(ignore: true)
  List<ListItem> speakerList;
  @JsonKey(ignore: true)
  List<ListItem> aboutList;

  ConferenceData._(bool fetch) {
    getDataFromFireStore();
  }

  ConferenceData();

  factory ConferenceData.start() => ConferenceData._(true);

  factory ConferenceData.fromJson(Map content) =>
      _$ConferenceDataFromJson(content);

  Map<String, dynamic> toJson() => _$ConferenceDataToJson(this);

  @override
  Future getDataFromFireStore() async {
    Firestore.instance
        .collection("about")
        .orderBy("created", descending: true)
        .limit(1)
        .snapshots()
        .listen((querySnapshot) {
      querySnapshot.documents.forEach((doc) async {
        var data = doc.data;
        print("About updated!");

        populateAbout(ConferenceData.fromJson({"about": data}));
      });
    });

    Firestore.instance
        .collection("schedule")
        .orderBy("created", descending: true)
        .limit(1)
        .snapshots()
        .listen((querySnapshot) {
      querySnapshot.documents.forEach((doc) async {
        var data = doc.data;
        print("Schedule/Speakers updated!");

        DocumentSnapshot speakerSnapshot = await Firestore.instance
            .collection("speakers")
            .document(data["speakerRef"])
            .get();

        populateScheduleAndSpeakers(ConferenceData.fromJson(
            {"schedule": data, "speakers": speakerSnapshot.data["speakers"]}));
      });
    });
  }

  @override
  Future<SharedPreferences> getSharedPrefs() async {
    return await SharedPreferences.getInstance();
  }

  @override
  void populateScheduleAndSpeakers(IHomeModel model) {
    this.speakers = model.speakers;
    this.schedule = model.schedule;

    generateScheduleList();
    generateSpeakerList();

    wasLoaded = loaded;

    loaded = true;
    notifyListeners();
  }

  @override
  void populateAbout(IHomeModel model) {
    this.about = model.about;

    generateAboutList();

    aboutLoaded = true;
    notifyListeners();
  }

  @override
  AugmentedTalk createAugmentedTalk(List<String> speakerIds, Talk talk) {
    return AugmentedTalk(
        talk,
        speakerIds.map((s) => getSpeaker(s)).toList(),
        Utils.findItemById(schedule.talkTracks, talk.trackId),
        Utils.findItemById(schedule.talkTypes, talk.talkTypeId));
  }

  @override
  void generateAboutList() {
    var _aboutList = <ListItem>[HeaderItem()];
    _aboutList.add(TitleItem('About'));
    _aboutList.add(ConferenceItem(this.about.description, this.about.twitter,
        this.about.website, this.about.contactEmail));
    _aboutList.add(TitleItem('Venue'));
    _aboutList.add(VenueItem(this.about.venue.name, this.about.venue.address,
        this.about.venue.imagePath));

    if (this.about.links != null) {
      this.about.linkTypes.forEach((f) {
        _aboutList.add(TitleItem(f.name));
        _aboutList.add(AboutListItem(
            this.about.links.where((l) => l.linkTypeId == f.id).toList()));
      });
    }

    aboutList = _aboutList;
  }

  @override
  void generateScheduleList() {
    var _scheduleList = <ListItem>[HeaderItem()];

    List<String> datetimes = this.schedule.talks.keys.toList();
    datetimes.sort((a, b) => a.compareTo(b));

    datetimes.forEach((datetime) {
      List<AugmentedTalk> talkList = [];
      _scheduleList
          .add(TitleItem(getTimeFromDateTime(datetime))); // Add time item
      this.schedule.talks[datetime].forEach((trackName, talk) {
        talkList.add(createAugmentedTalk(talk.speakerIds, talk));
      });
      _scheduleList.add(TalkItem(talkList));
    });

    scheduleList = _scheduleList;
    print("Schedule parsed and flattened | ${_scheduleList.length} items");
  }

  @override
  void generateSpeakerList() {
    var _speakerList = <ListItem>[HeaderItem(), TitleItem('Speakers')];

    this.speakers.shuffle();

    this.speakers.forEach((Speaker f) => _speakerList.add(SpeakerItem(f)));

    speakerList = _speakerList;
    print("Speakers parsed | ${_speakerList.length} items");
  }

  @override
  List<AugmentedTalk> getTalksForSpeaker(String speakerId) {
    List<AugmentedTalk> _speakerTalkList = [];
    this.schedule.talks.forEach((datetime, v) {
      v.forEach((trackName, talk) {
        if (talk.speakerIds.contains(speakerId) || speakerId == null) {
          _speakerTalkList.add(AugmentedTalk(
              talk,
              talk.speakerIds.map((s) => getSpeaker(s)).toList(),
              Utils.findItemById(schedule.talkTracks, talk.trackId),
              Utils.findItemById(schedule.talkTypes, talk.talkTypeId)));
        }
      });
    });
    return _speakerTalkList;
  }

  @override
  Speaker getSpeaker(String speakerId) {
    if (speakerId == null) return null;
    return Utils.findItemById(speakers, speakerId);
  }

  String get headerImageUrl {
    return about.headerImage;
  }

  @override
  String getTimeFromDateTime(String datetime) {
    return DateFormat("hh:mma")
        .format(DateTime.parse(datetime))
        .toLowerCase();
  }
}
