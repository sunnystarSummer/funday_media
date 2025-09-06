import 'package:flutter/material.dart';
import 'package:funday_media/repository/data_base/travel_audio_db.dart';

import '../service/client/travel_client.dart';
import '../service/model/travel_audio.dart' as travel_service;
import 'data/travel_audio_list.dart';
import 'main_repository_mobile.dart' as mobile;
import 'main_repository_web.dart';

AbsMainRepository mainOfRepository() =>
    isSupportDb ? mobile.mainRepositoryForMobile() : mainRepositoryForWeb();

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

  bool _isValidOfTravelAudioOfMediaApi() {
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
    isValid = isValid || _isValidOfTravelAudioOfMediaApi();

    if (isValid) {
      await _travelClient.fetchDataByTravelClient(
        api: (url, languageCode, client) {
          return client.travelAudioOfMedia(languageCode, page);
        },
        success: (response) async {
          // 處理成功結果 ----------------------------------

          // 將 API 回傳資料轉換成 TravelAudioList
          final newList = newTravelAudioList(
            {page: response.data ?? []},
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
  @protected
  Future<TravelAudio> mapAudio(travel_service.TravelAudio audio);

  TravelAudioList newTravelAudioList(
    Map<int, List<travel_service.TravelAudio>> travelAudioMap, {
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
