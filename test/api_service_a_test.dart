import 'package:flutter_test/flutter_test.dart';
import 'package:funday_media/service/client/travel_client.dart';
import 'package:funday_media/util/json_util.dart';
import 'package:logger/logger.dart';

void main() {
  late TravelClient client;
  late Logger logger;

  setUp(() {
    client = TravelClient();
    logger = Logger();
  });

  /// 影音刊物_語音導覽
  test('A_MediaAudio', () async {
    var info = "A_影音刊物_語音導覽";

    await client.fetchDataByTravelClient(
      api: (url, languageCode, client) {
        info += "\n";
        info += "Url= $url\n";
        info += "LanguageCode= $languageCode\n";

        return client.travelAudioOfMedia(languageCode, 1);
      },
      success: (response) {
        // 此區塊可處理「成功」結果
        info += "\n";
        info += "Response:\n";
        info += "${response.toJson().prettyJson()}\n";
      },
      error: (code, message) {
        // 此區塊可處理「失敗」結果
        info += "\n";
        info += "ErrorCode= $code\n";
        info += "ErrorMessage= $message\n";
      },
    );
    //expect(response?.data != null, true);

    logger.d(info);
  });
}
