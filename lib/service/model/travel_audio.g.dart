// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'travel_audio.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TravelAudio _$TravelAudioFromJson(Map<String, dynamic> json) => TravelAudio(
  (json['id'] as num).toInt(),
  json['title'] as String?,
  json['summary'],
  json['url'] as String?,
  json['file_ext'],
  json['modified'] as String?,
);

Map<String, dynamic> _$TravelAudioToJson(TravelAudio instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'summary': instance.summary,
      'url': instance.url,
      'file_ext': instance.fileExt,
      'modified': instance.modified,
    };

TravelAudioResponse _$TravelAudioResponseFromJson(Map<String, dynamic> json) =>
    TravelAudioResponse()
      ..data = (json['data'] as List<dynamic>?)
          ?.map((e) => TravelAudio.fromJson(e as Map<String, dynamic>))
          .toList()
      ..total = (json['total'] as num).toInt();

Map<String, dynamic> _$TravelAudioResponseToJson(
  TravelAudioResponse instance,
) => <String, dynamic>{
  'data': instance.data?.map((e) => e.toJson()).toList(),
  'total': instance.total,
};
