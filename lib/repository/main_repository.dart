import '../service/client/travel_client.dart';
import '../service/model/travel_audio.dart' as travelService;
import 'data/travel_audio_list.dart';

/// 抽象類別：定義主要資料倉儲的介面
///
/// 提供取得「旅遊音檔」的方法，需傳入成功與失敗的回呼函式。
abstract class AbsMainRepository {
  /// API 客戶端（必須存在）
  final _travelClient = TravelClient();

  /// 語系代碼
  String get languageCode => _travelClient.languageCode;

  /// 目前快取的旅遊音檔清單
  TravelAudioList _travelAudioList = travelAudioEmptyList;

  bool isValidOfTravelAudioOfMediaApi() {
    return (_travelAudioList.list.length < _travelAudioList.total);
  }

  /// 取得媒體相關的旅遊音檔資料
  ///
  /// [success] 成功時回傳 TravelAudioList
  /// [error]   失敗時回傳錯誤代碼與訊息
  Future<void> getTravelAudioOfMedia({
    int page = 1,
    required void Function(TravelAudioList data) success,
    required void Function(int code, String message) error,
  }) async {

    bool isValid = false;
    // 檢查是否符合條件（至少第 1 頁，或尚有資料未載入）
    isValid = isValid || page >= 1;
    isValid = isValid || isValidOfTravelAudioOfMediaApi();

    if (isValid) {
      await _travelClient.fetchDataByTravelClient(
        api: (url, languageCode, client) {
          return client.travelAudioOfMedia(languageCode, page);
        },
        success: (response) async {
          // 處理成功結果 ----------------------------------

          // 將 API 回傳資料轉換成 TravelAudioList
          final newList = newTravelAudioList(
            response.data ?? [],
            total: response.total,
          );

          // 第一頁：直接取代
          if (page == 1) {
            _travelAudioList = newList;
          }
          // 其他頁：合併舊清單
          else {
            _travelAudioList = _travelAudioList.merge(
              newList,
              page: page,
              newTravelAudio: mapAudio,
            );
          }

          // 回傳成功資料
          success(_travelAudioList);
        },
        error: (code, message) {
          // 處理失敗結果 ----------------------------------
          error(code ?? -1, message ?? '');
        },
      );
    }
  }

  /// 將 API 的 TravelAudio 轉換成 App 內部使用的 TravelAudio
  Future<TravelAudio> mapAudio(travelService.TravelAudio audio);

  TravelAudioList newTravelAudioList(
      List<travelService.TravelAudio> rawList, {
        required int total,
      });

  Future<void> insertOrUpdateAudio(
      TravelAudio audio, {
        required String filePath,
      });

  Future<String> downloadFile(
      TravelAudio audio, {
        required void Function(int received, int total) onReceiveProgress,
      });
}

/// 實作資料倉儲（Singleton 單例模式）
///
/// 負責處理「旅遊音檔」的存取邏輯，
/// 包含 API 請求、快取、資料庫存取與檔案下載。
final class MainRepository extends AbsMainRepository {
  MainRepository._();

  /// 全域唯一實例（Singleton）
  static MainRepository get instance => MainRepository._();

  //=========================================================================

  /// 建立新的旅遊音檔清單
  @override
  TravelAudioList newTravelAudioList(
    List<travelService.TravelAudio> rawList, {
    required int total,
  }) {
    return TravelAudioList(rawList, total: total, newTravelAudio: mapAudio);
  }

  /// 將 API 的 TravelAudio 轉換成 App 內部使用的 TravelAudio
  @override
  Future<TravelAudio> mapAudio(travelService.TravelAudio audio) async {
    final newTravelAudio = TravelAudio(
      audio.id,
      audio.title ?? '',
      audio.summary,
      audio.url ?? '',
      audio.fileExt,
      audio.modified ?? '',
      isModified: false,
      filePath: null,
    );

    return newTravelAudio;
  }

  @override
  Future<String> downloadFile(TravelAudio audio, {required void Function(int received, int total) onReceiveProgress}) {
    throw UnimplementedError();
  }

  @override
  Future<void> insertOrUpdateAudio(TravelAudio audio, {required String filePath}) {
    throw UnimplementedError();
  }
}
