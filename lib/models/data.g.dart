// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Speaker _$SpeakerFromJson(Map<String, dynamic> json) {
  return Speaker(
      json['id'] as String,
      json['name'] as String,
      json['bio'] as String,
      json['image_path'] as String,
      json['company'] as String,
      json['twitter'] as String,
      json['linked_in'] as String,
      json['github'] as String);
}

Map<String, dynamic> _$SpeakerToJson(Speaker instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'bio': instance.bio,
      'company': instance.company,
      'twitter': instance.twitter,
      'github': instance.github,
      'linked_in': instance.linkedIn,
      'image_path': instance.imagePath
    };

Track _$TrackFromJson(Map<String, dynamic> json) {
  return Track(
      json['id'] as String, json['name'] as String, json['color'] as String);
}

Map<String, dynamic> _$TrackToJson(Track instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'color': instance.color
    };

TalkType _$TalkTypeFromJson(Map<String, dynamic> json) {
  return TalkType(json['id'] as String, json['name'] as String,
      json['material_icon'] as String, json['description'] as String);
}

Map<String, dynamic> _$TalkTypeToJson(TalkType instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'material_icon': instance.materialIcon,
      'description': instance.description
    };

Talk _$TalkFromJson(Map<String, dynamic> json) {
  return Talk(
      json['speaker_id'] as String,
      json['track_id'] as String,
      json['talk_type_id'] as String,
      json['title'] as String,
      json['description'] as String);
}

Map<String, dynamic> _$TalkToJson(Talk instance) => <String, dynamic>{
      'speaker_id': instance.speakerId,
      'track_id': instance.trackId,
      'talk_type_id': instance.talkTypeId,
      'title': instance.title,
      'description': instance.description
    };

Schedule _$ScheduleFromJson(Map<String, dynamic> json) {
  return Schedule(
      json['time'] as String,
      (json['talks'] as List)
          ?.map((e) =>
              e == null ? null : Talk.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$ScheduleToJson(Schedule instance) =>
    <String, dynamic>{'time': instance.time, 'talks': instance.talks};

About _$AboutFromJson(Map<String, dynamic> json) {
  return About(
      json['venue'] == null
          ? null
          : Venue.fromJson(json['venue'] as Map<String, dynamic>),
      json['description'] as String,
      json['twitter'] as String,
      json['website'] as String,
      json['contact_email'] as String,
      (json['links'] as List)
          ?.map((e) =>
              e == null ? null : AboutLink.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      (json['link_types'] as List)
          ?.map((e) => e == null
              ? null
              : AboutLinkTypes.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$AboutToJson(About instance) => <String, dynamic>{
      'venue': instance.venue,
      'description': instance.description,
      'twitter': instance.twitter,
      'website': instance.website,
      'contact_email': instance.contactEmail,
      'links': instance.links,
      'link_types': instance.linkTypes
    };

AboutLinkTypes _$AboutLinkTypesFromJson(Map<String, dynamic> json) {
  return AboutLinkTypes(json['id'] as String, json['name'] as String);
}

Map<String, dynamic> _$AboutLinkTypesToJson(AboutLinkTypes instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};

AboutLink _$AboutLinkFromJson(Map<String, dynamic> json) {
  return AboutLink(json['name'] as String, json['image_path'] as String,
      json['website'] as String, json['link_type_id'] as String);
}

Map<String, dynamic> _$AboutLinkToJson(AboutLink instance) => <String, dynamic>{
      'name': instance.name,
      'image_path': instance.imagePath,
      'website': instance.website,
      'link_type_id': instance.linkTypeId
    };

Venue _$VenueFromJson(Map<String, dynamic> json) {
  return Venue(json['name'] as String, json['image_path'] as String,
      json['address'] as String);
}

Map<String, dynamic> _$VenueToJson(Venue instance) => <String, dynamic>{
      'name': instance.name,
      'image_path': instance.imagePath,
      'address': instance.address
    };
