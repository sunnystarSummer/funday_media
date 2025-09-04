import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../model/base_response.dart';
import '../model/travel_audio.dart';
import '../server_type.dart';

part 'travel_api.g.dart';

// https://pub.dev/packages/retrofit

typedef FutureResponse = Future<BaseResponse>;

extension ExtensionServerUrl on ServerType {
  String get travelUrl {
    switch (this) {
      case ServerType.release:
      case ServerType.uat:
      default:
        return 'https://www.travel.taipei/open-api';
    }
  }
}

@RestApi()
abstract class AbsTravelRestClient {
  factory AbsTravelRestClient(Dio dio, {String baseUrl}) = _AbsTravelRestClient;

  /// 影音刊物_語音導覽
  @GET('/{lang}/Media/Audio')
  Future<TravelAudioResponse> travelAudioOfMedia(
    @Path("lang") String language,
    @Query("page") int? page,
  );
}
