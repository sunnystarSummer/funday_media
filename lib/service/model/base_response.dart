import 'package:json_annotation/json_annotation.dart';

part 'base_response.g.dart';

class AbsBaseResponse<T> {
  @JsonKey(name: 'data')
  T? data;

  AbsBaseResponse();
}

@JsonSerializable(explicitToJson: true)
class BaseResponse extends AbsBaseResponse {
  BaseResponse();

  factory BaseResponse.fromJson(Map<String, dynamic> json) =>
      _$BaseResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BaseResponseToJson(this);
}
