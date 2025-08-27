import 'package:json_annotation/json_annotation.dart';

import 'base_response.dart';

part 'travel_audio.g.dart';

@JsonSerializable(explicitToJson: true)
class TravelAudio {
  @JsonKey(name: 'id')
  int id = -1;
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'summary')
  Object? summary;
  @JsonKey(name: 'url')
  String? url;
  @JsonKey(name: 'file_ext')
  Object? fileExt;
  @JsonKey(name: 'modified')
  String? modified;

  TravelAudio(
    this.id,
    this.title,
    this.summary,
    this.url,
    this.fileExt,
    this.modified,
  );

  factory TravelAudio.fromJson(Map<String, dynamic> json) =>
      _$TravelAudioFromJson(json);

  Map<String, dynamic> toJson() => _$TravelAudioToJson(this);
}

@JsonSerializable(explicitToJson: true)
class TravelAudioResponse extends AbsBaseResponse<List<TravelAudio>> {
  @JsonKey(name: 'total')
  int total = -1;

  TravelAudioResponse();

  factory TravelAudioResponse.fromJson(Map<String, dynamic> json) =>
      _$TravelAudioResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TravelAudioResponseToJson(this);
}
