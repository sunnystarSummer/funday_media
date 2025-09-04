import '../service/model/travel_audio.dart' as travel_service;
import 'data/travel_audio_list.dart';
import 'main_repository.dart';

/// 實作資料倉儲（Singleton 單例模式）
///
/// 負責處理「旅遊音檔」的存取邏輯，
/// 包含 API 請求、快取、資料庫存取與檔案下載。
final class _MainRepository extends AbsMainRepository {
  _MainRepository._();

  /// 全域唯一實例（Singleton）
  static final _MainRepository _instance = _MainRepository._();

  //=========================================================================

  /// 建立新的旅遊音檔清單
  @override
  TravelAudioList newTravelAudioList(
    List<travel_service.TravelAudio> rawList, {
    required int total,
  }) {
    return TravelAudioList(rawList, total: total, newTravelAudio: mapAudio);
  }

  /// 將 API 的 TravelAudio 轉換成 App 內部使用的 TravelAudio
  @override
  Future<TravelAudio> mapAudio(travel_service.TravelAudio audio) async {
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
  Future<String> downloadFile(
    TravelAudio audio, {
    required void Function(int received, int total) onReceiveProgress,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<void> insertOrUpdateAudio(
    TravelAudio audio, {
    required String filePath,
  }) {
    throw UnimplementedError();
  }
}

AbsMainRepository mainRepositoryForWeb() => _MainRepository._instance;
