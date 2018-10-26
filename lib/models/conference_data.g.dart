// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conference_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConferenceData _$ConferenceDataFromJson(Map<String, dynamic> json) {
  return ConferenceData()
    ..speakers = (json['speakers'] as List)
        ?.map((e) =>
            e == null ? null : Speaker.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..tracks = (json['tracks'] as List)
        ?.map(
            (e) => e == null ? null : Track.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..schedule = (json['schedule'] as List)
        ?.map((e) =>
            e == null ? null : Schedule.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..about = json['about'] == null
        ? null
        : About.fromJson(json['about'] as Map<String, dynamic>)
    ..talkTypes = (json['talk_types'] as List)
        ?.map((e) =>
            e == null ? null : TalkType.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$ConferenceDataToJson(ConferenceData instance) =>
    <String, dynamic>{
      'speakers': instance.speakers,
      'tracks': instance.tracks,
      'schedule': instance.schedule,
      'about': instance.about,
      'talk_types': instance.talkTypes
    };
