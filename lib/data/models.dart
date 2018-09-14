import 'package:json_annotation/json_annotation.dart';
part 'models.g.dart';

@JsonSerializable()
class Speaker {
  final String name;
  final String bio;

  @JsonKey(name: 'image_url')
  final String imageUrl;

  Speaker(this.name, this.bio, this.imageUrl);

  factory Speaker.fromJson(Map<String, dynamic> content) => _$SpeakerFromJson(content);
  Map<String, dynamic> toJson() => _$SpeakerToJson(this);
}

@JsonSerializable()
class TalkType {
  final String name;

  @JsonKey(name: 'material_icon')
  final String materialIcon;

  TalkType(this.name, this.materialIcon);

  factory TalkType.fromJson(Map<String, dynamic> content) => _$TalkTypeFromJson(content);
  Map<String, dynamic> toJson() => _$TalkTypeToJson(this);
}

@JsonSerializable()
class Talk {
  @JsonKey(name: 'speaker_id')
  final int speakerId;

  @JsonKey(name: 'track_id')
  final int trackId;

  @JsonKey(name: 'talk_type_id')
  final int talkTypeId;

  final String title;
  final String description;

  Talk(this.speakerId, this.trackId, this.talkTypeId, this.title, this.description);

  createAugmented(speakers, tracks, talkTypes) {
    return new AugmentedTalk(title, description, speakers[this.speakerId],
        tracks[this.trackId], talkTypes[this.talkTypeId]);
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
  final String trackName;
  final TalkType talkType;

  AugmentedTalk(this.title, this.description, this.speaker, this.trackName,
      this.talkType);
}

