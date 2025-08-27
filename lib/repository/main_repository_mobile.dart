import 'package:flutter/foundation.dart';
import 'package:funday_media/service/client/download_client.dart';
import 'package:path_provider/path_provider.dart';

import '../service/model/travel_audio.dart' as travelService;
import 'data/travel_audio_list.dart';
import 'data_base/travel_audio_db.dart';
import 'main_repository.dart';

/// 實作資料倉儲（Singleton 單例模式）
///
/// 負責處理「旅遊音檔」的存取邏輯，
/// 包含 API 請求、快取、資料庫存取與檔案下載。
final class MainRepository extends AbsMainRepository {
  /// 私有建構子，僅允許內部建立
  MainRepository._();

  /// 全域唯一實例（Singleton）
  static MainRepository get instance => MainRepository._();

  /// 資料庫操作物件
  final TravelAudioDatabase _db = TravelAudioDatabase.instance;

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

    // 查詢資料庫是否已有紀錄
    final tableData = await _db.getAudioById(audio.id);

    // 判斷是否有更新
    final isModified = tableData != null && audio.isUpdated(tableData);

    return TravelAudio(
      newTravelAudio.id,
      newTravelAudio.title ?? '',
      newTravelAudio.summary,
      newTravelAudio.url ?? '',
      newTravelAudio.fileExt,
      newTravelAudio.modified ?? '',
      isModified: isModified,
      filePath: tableData?.filePath,
    );

    return newTravelAudio;
  }

  //=========================================================================

  /// 插入或更新單筆音檔資料
  ///
  /// 僅在 [modified] 更新時才會覆蓋
  @override
  Future<void> insertOrUpdateAudio(
    TravelAudio audio, {
    required String filePath,
  }) async {
    final entry = audio.toCompanion(filePath: filePath);
    await _db.insertOrUpdateAudio(entry);
  }

  //=========================================================================

  /// 下載音檔並儲存至 App Documents 目錄
  ///
  /// [onReceiveProgress] 可監聽下載進度（已接收 / 總大小）
  /// 回傳下載完成後的檔案路徑
  @override
  Future<String> downloadFile(
    TravelAudio audio, {
    required void Function(int received, int total) onReceiveProgress,
  }) async {
    if (kIsWeb) {
      return audio.url ?? '';
    }

    final client = DownloadClient();

    final dir = await getApplicationDocumentsDirectory();
    final savePath =
        "${dir.path}/TravelAudio_$languageCode/${audio.id}_${audio.title}.mp3";

    if (audio.url != null) {
      await client.downloadFile(
        url: audio.url!,
        savePath: savePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            onReceiveProgress(received, total);
          }
        },
      );
    }

    return savePath;
  }
}
