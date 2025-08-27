// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'travel_audio_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TravelAudio _$TravelAudioFromJson(Map<String, dynamic> json) => TravelAudio(
  (json['id'] as num).toInt(),
  json['title'] as String,
  json['summary'],
  json['url'] as String,
  json['file_ext'],
  json['modified'] as String,
  isModified: json['isModified'] as bool,
  filePath: json['filePath'] as String?,
)..isDownloaded = json['isDownloaded'] as bool;

Map<String, dynamic> _$TravelAudioToJson(TravelAudio instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'summary': instance.summary,
      'url': instance.url,
      'file_ext': instance.fileExt,
      'modified': instance.modified,
      'isModified': instance.isModified,
      'filePath': instance.filePath,
      'isDownloaded': instance.isDownloaded,
    };
