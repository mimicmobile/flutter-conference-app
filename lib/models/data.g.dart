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
      json['image_url'] as String,
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
      'image_url': instance.imageUrl
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
      (json['sponsors'] as List)
          ?.map((e) =>
              e == null ? null : Sponsor.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$AboutToJson(About instance) => <String, dynamic>{
      'venue': instance.venue,
      'description': instance.description,
      'twitter': instance.twitter,
      'website': instance.website,
      'contact_email': instance.contactEmail,
      'sponsors': instance.sponsors
    };

Sponsor _$SponsorFromJson(Map<String, dynamic> json) {
  return Sponsor(json['name'] as String, json['image_url'] as String,
      json['title'] as String, json['website'] as String);
}

Map<String, dynamic> _$SponsorToJson(Sponsor instance) => <String, dynamic>{
      'name': instance.name,
      'image_url': instance.imageUrl,
      'title': instance.title,
      'website': instance.website
    };

Venue _$VenueFromJson(Map<String, dynamic> json) {
  return Venue(json['name'] as String, json['image_url'] as String,
      json['address'] as String);
}

Map<String, dynamic> _$VenueToJson(Venue instance) => <String, dynamic>{
      'name': instance.name,
      'image_url': instance.imageUrl,
      'address': instance.address
    };
