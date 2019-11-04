// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Speaker _$SpeakerFromJson(Map json) {
  return Speaker(
    json['id'] as String,
    json['name'] as String,
    json['bio'] as String,
    json['imagePath'] as String,
    json['company'] as String,
    json['twitter'] as String,
    json['linkedIn'] as String,
    json['github'] as String,
  );
}

Map<String, dynamic> _$SpeakerToJson(Speaker instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'bio': instance.bio,
      'company': instance.company,
      'twitter': instance.twitter,
      'github': instance.github,
      'linkedIn': instance.linkedIn,
      'imagePath': instance.imagePath,
    };

Track _$TrackFromJson(Map json) {
  return Track(
    json['id'] as String,
    json['name'] as String,
    json['color'] as String,
  );
}

Map<String, dynamic> _$TrackToJson(Track instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'color': instance.color,
    };

TalkType _$TalkTypeFromJson(Map json) {
  return TalkType(
    json['id'] as String,
    json['name'] as String,
    json['material_icon'] as String,
    json['description'] as String,
  );
}

Map<String, dynamic> _$TalkTypeToJson(TalkType instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'material_icon': instance.materialIcon,
      'description': instance.description,
    };

Talk _$TalkFromJson(Map json) {
  return Talk(
    (json['speakerIds'] as List)?.map((e) => e as String)?.toList(),
    json['trackId'] as String,
    json['typeId'] as String,
    json['title'] as String,
    json['description'] as String,
    json['time'] as String,
    json['datetime'] as String,
  );
}

Map<String, dynamic> _$TalkToJson(Talk instance) => <String, dynamic>{
      'speakerIds': instance.speakerIds,
      'trackId': instance.trackId,
      'typeId': instance.talkTypeId,
      'time': instance.time,
      'datetime': instance.datetime,
      'title': instance.title,
      'description': instance.description,
    };

Schedule _$ScheduleFromJson(Map json) {
  return Schedule(
    json['speakerRef'] as String,
    (json['talks'] as Map)?.map(
      (k, e) => MapEntry(
          k as String,
          (e as Map)?.map(
            (k, e) => MapEntry(
                k as String, e == null ? null : Talk.fromJson(e as Map)),
          )),
    ),
    (json['talkTracks'] as List)
        ?.map((e) => e == null ? null : Track.fromJson(e as Map))
        ?.toList(),
    (json['talkTypes'] as List)
        ?.map((e) => e == null ? null : TalkType.fromJson(e as Map))
        ?.toList(),
  );
}

Map<String, dynamic> _$ScheduleToJson(Schedule instance) => <String, dynamic>{
      'speakerRef': instance.speakerRef,
      'talkTracks': instance.talkTracks,
      'talkTypes': instance.talkTypes,
      'talks': instance.talks,
    };

About _$AboutFromJson(Map json) {
  return About(
    json['venue'] == null ? null : Venue.fromJson(json['venue'] as Map),
    json['description'] as String,
    json['twitter'] as String,
    json['website'] as String,
    json['contactEmail'] as String,
    json['headerImage'] as String,
    (json['links'] as List)
        ?.map((e) => e == null ? null : AboutLink.fromJson(e as Map))
        ?.toList(),
    (json['linkTypes'] as List)
        ?.map((e) => e == null ? null : AboutLinkTypes.fromJson(e as Map))
        ?.toList(),
  );
}

Map<String, dynamic> _$AboutToJson(About instance) => <String, dynamic>{
      'venue': instance.venue,
      'description': instance.description,
      'twitter': instance.twitter,
      'website': instance.website,
      'contactEmail': instance.contactEmail,
      'headerImage': instance.headerImage,
      'links': instance.links,
      'linkTypes': instance.linkTypes,
    };

AboutLinkTypes _$AboutLinkTypesFromJson(Map json) {
  return AboutLinkTypes(
    json['id'] as String,
    json['name'] as String,
  );
}

Map<String, dynamic> _$AboutLinkTypesToJson(AboutLinkTypes instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

AboutLink _$AboutLinkFromJson(Map json) {
  return AboutLink(
    json['name'] as String,
    json['imagePath'] as String,
    json['website'] as String,
    json['typeId'] as String,
  );
}

Map<String, dynamic> _$AboutLinkToJson(AboutLink instance) => <String, dynamic>{
      'name': instance.name,
      'imagePath': instance.imagePath,
      'website': instance.website,
      'typeId': instance.linkTypeId,
    };

Venue _$VenueFromJson(Map json) {
  return Venue(
    json['name'] as String,
    json['imagePath'] as String,
    json['address'] as String,
  );
}

Map<String, dynamic> _$VenueToJson(Venue instance) => <String, dynamic>{
      'name': instance.name,
      'imagePath': instance.imagePath,
      'address': instance.address,
    };
