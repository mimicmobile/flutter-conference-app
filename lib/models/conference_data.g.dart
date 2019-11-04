// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conference_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConferenceData _$ConferenceDataFromJson(Map json) {
  return ConferenceData()
    ..speakers = (json['speakers'] as List)
        ?.map((e) => e == null ? null : Speaker.fromJson(e as Map))
        ?.toList()
    ..schedule = json['schedule'] == null
        ? null
        : Schedule.fromJson(json['schedule'] as Map)
    ..about =
        json['about'] == null ? null : About.fromJson(json['about'] as Map);
}

Map<String, dynamic> _$ConferenceDataToJson(ConferenceData instance) =>
    <String, dynamic>{
      'speakers': instance.speakers,
      'schedule': instance.schedule,
      'about': instance.about,
    };
