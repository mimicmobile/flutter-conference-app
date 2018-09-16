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

  @JsonKey(name: "linked_in")
  final String linkedIn;

  @JsonKey(name: 'image_url')
  final String imageUrl;

  Speaker(this.id, this.name, this.bio, this.imageUrl, this.company, this.twitter, this.linkedIn, this.github);

  factory Speaker.fromJson(Map<String, dynamic> content) => _$SpeakerFromJson(content);
  Map<String, dynamic> toJson() => _$SpeakerToJson(this);
}

@JsonSerializable()
class Track {
  final String id;
  final String name;
  final String color;

  Track(this.id, this.name, this.color);

  factory Track.fromJson(Map<String, dynamic> content) => _$TrackFromJson(content);
  Map<String, dynamic> toJson() => _$TrackToJson(this);
}

@JsonSerializable()
class TalkType {
  final String id;
  final String name;

  @JsonKey(name: 'material_icon')
  final String materialIcon;

  TalkType(this.id, this.name, this.materialIcon);

  factory TalkType.fromJson(Map<String, dynamic> content) => _$TalkTypeFromJson(content);
  Map<String, dynamic> toJson() => _$TalkTypeToJson(this);
}

@JsonSerializable()
class Talk {
  @JsonKey(name: 'speaker_id')
  final String speakerId;

  @JsonKey(name: 'track_id')
  final String trackId;

  @JsonKey(name: 'talk_type_id')
  final String talkTypeId;

  final String title;
  final String description;

  Talk(this.speakerId, this.trackId, this.talkTypeId, this.title, this.description);

  createAugmented(speakers, tracks, talkTypes, time) {
    return new AugmentedTalk(title, description, findItemById(speakers, this.speakerId),
        findItemById(tracks, this.trackId), findItemById(talkTypes, this.talkTypeId),
        time);
  }

  findItemById(List l, id) {
    for (final i in l) {
      if (i.id == id) return i;
    }
  }

  factory Talk.fromJson(Map<String, dynamic> content) => _$TalkFromJson(content);
  Map<String, dynamic> toJson() => _$TalkToJson(this);

  @override
  String toString() {
    return title;
  }
}

@JsonSerializable()
class Schedule {
  final String time;
  final List<Talk> talks;

  Schedule(this.time, this.talks);

  factory Schedule.fromJson(Map<String, dynamic> content) => _$ScheduleFromJson(content);
  Map<String, dynamic> toJson() => _$ScheduleToJson(this);

  @override
  String toString() {
    String str = "$time";
    talks.forEach(((f) => str += "\n" + f.toString()));
    return str;
  }
}

class AugmentedTalk {
  final String title;
  final String description;
  final Speaker speaker;
  final Track track;
  final TalkType talkType;
  final String time;

  AugmentedTalk(this.title, this.description, this.speaker, this.track,
      this.talkType, this.time);
}

