import 'package:json_annotation/json_annotation.dart';

part 'data.g.dart';

@JsonSerializable()
class Speaker {
  final String id;
  final String name;
  final String bio;
  final String company;
  final String twitter;
  final String github;

  final String linkedIn;

  final String imagePath;

  Speaker(this.id, this.name, this.bio, this.imagePath, this.company,
      this.twitter, this.linkedIn, this.github);

  factory Speaker.fromJson(Map content) =>
      _$SpeakerFromJson(content);

  Map<String, dynamic> toJson() => _$SpeakerToJson(this);
}

@JsonSerializable()
class Track {
  final String id;
  final String name;
  final String color;

  Track(this.id, this.name, this.color);

  factory Track.fromJson(Map content) =>
      _$TrackFromJson(content);

  Map<String, dynamic> toJson() => _$TrackToJson(this);
}

@JsonSerializable()
class TalkType {
  final String id;
  final String name;

  @JsonKey(name: 'material_icon')
  final String materialIcon;

  final String description;

  TalkType(this.id, this.name, this.materialIcon, this.description);

  factory TalkType.fromJson(Map content) =>
      _$TalkTypeFromJson(content);

  Map<String, dynamic> toJson() => _$TalkTypeToJson(this);
}

@JsonSerializable()
class Talk {
 final List<String> speakerIds;

  final String trackId;

  @JsonKey(name: 'typeId')
  final String talkTypeId;

  final String time;
  final String datetime;
  final String title;
  final String description;

  Talk(this.speakerIds, this.trackId, this.talkTypeId, this.title,
      this.description, this.time, this.datetime);

  factory Talk.fromJson(Map content) =>
      _$TalkFromJson(content);

  Map<String, dynamic> toJson() => _$TalkToJson(this);

  @override
  String toString() {
    return title;
  }
}

@JsonSerializable()
class Schedule {
  final String speakerRef;
  final List<Track> talkTracks;
  final List<TalkType> talkTypes;
  final Map<String, Map<String, Talk>> talks;

  Schedule(this.speakerRef, this.talks, this.talkTracks, this.talkTypes);

  factory Schedule.fromJson(Map content) =>
      _$ScheduleFromJson(content);

  Map<String, dynamic> toJson() => _$ScheduleToJson(this);

  @override
  String toString() {
    return "";
  }
}

enum AboutAction { Twitter, Website, Email, Map }

@JsonSerializable()
class About {
  final Venue venue;
  final String description;
  final String twitter;
  final String website;
  final String contactEmail;
  final String headerImage;
  final List<AboutLink> links;
  final List<AboutLinkTypes> linkTypes;

  About(this.venue, this.description, this.twitter, this.website,
      this.contactEmail, this.headerImage, this.links, this.linkTypes);

  factory About.fromJson(Map content) =>
      _$AboutFromJson(content);

  Map<String, dynamic> toJson() => _$AboutToJson(this);
}

@JsonSerializable()
class AboutLinkTypes {
  final String id;
  final String name;

  AboutLinkTypes(this.id, this.name);

  factory AboutLinkTypes.fromJson(Map content) =>
      _$AboutLinkTypesFromJson(content);

  Map<String, dynamic> toJson() => _$AboutLinkTypesToJson(this);
}

@JsonSerializable()
class AboutLink {
  final String name;
  final String imagePath;
  final String website;
  @JsonKey(name: 'typeId')
  final String linkTypeId;

  AboutLink(this.name, this.imagePath, this.website, this.linkTypeId);

  factory AboutLink.fromJson(Map content) =>
      _$AboutLinkFromJson(content);

  Map<String, dynamic> toJson() => _$AboutLinkToJson(this);
}

@JsonSerializable()
class Venue {
  final String name;
  final String imagePath;
  final String address;

  Venue(this.name, this.imagePath, this.address);

  factory Venue.fromJson(Map content) =>
      _$VenueFromJson(content);

  Map<String, dynamic> toJson() => _$VenueToJson(this);
}

class AugmentedTalk {
  final Talk talk;
  final Track track;
  final TalkType talkType;
  final List<Speaker> speakers;

  AugmentedTalk(this.talk, this.speakers, this.track, this.talkType);

  String get title => talk.title;
  String get description => talk.description;
  String get time => talk.time;
  String get datetime => talk.datetime;
  List<String> get speakerIds => talk.speakerIds;

  bool hasSpeakers() {
    return speakers.length > 0;
  }
}
