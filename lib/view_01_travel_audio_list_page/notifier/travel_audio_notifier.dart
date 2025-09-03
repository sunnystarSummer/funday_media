import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:synchronized/synchronized.dart';

import '../../main.dart';
import '../../repository/data/travel_audio_list.dart';

/// 提供旅遊音檔資料的全域狀態管理（Riverpod Provider）
///
/// - 狀態型別：TravelAudioList
/// - 使用 AsyncNotifier 實現（支援 Loading/Error 狀態）
final travelAudioProvider =
    AsyncNotifierProvider<TravelAudioNotifier, TravelAudioList>(
      TravelAudioNotifier.new,
    );

/// 狀態管理器：負責操作「旅遊音檔清單」
///
/// 功能包含：
/// - 初始化狀態
/// - 從 Repository 取得清單
/// - 下載單筆音檔
/// - 更新資料庫與狀態
class TravelAudioNotifier extends AsyncNotifier<TravelAudioList> {
  /// 初始狀態（空清單）
  @override
  FutureOr<TravelAudioList> build() async {
    return travelAudioEmptyList;
  }

  /// 是否正在下載檔案（避免重複觸發）
  final _lock = Lock();

  int _page = 1;

  int get page => _page;

  /// 從 Repository 取得旅遊音檔清單
  ///
  /// [page] 指定分頁頁碼
  Future<void> fetchTravelAudioOfMedia({
    int page = 1,
    bool enableLoadMore = false,
    required void Function(int code, String message) error,
  }) async {
    await _lock.synchronized(() async {
      if (enableLoadMore) {
        _page++;
      }

      // 設定狀態為 Loading
      state = const AsyncLoading();

      try {
        final completer = Completer<TravelAudioList>();

        await repository.getTravelAudioOfMedia(
          page: enableLoadMore ? _page : page,
          success: (data) => completer.complete(data),
          error: (code, message) {
            error(code, message);
            completer.completeError(message);
          },
        );

        final result = await completer.future;

        state = AsyncData(result);
      } catch (e, st) {
        state = AsyncError(e, st);
      }
    });
  }

  Completer<void>? _runningTask;

  Future<void> fetchTravelAudioOfMediaWhenScroll({
    required void Function(int code, String message) error,
  }) async {
    if (_runningTask != null) return; // 已經在跑 → 忽略

    final task = Completer<void>();
    _runningTask = task;

    await fetchTravelAudioOfMedia(enableLoadMore: true, error: error).then((_) {
      task.complete();
      _runningTask = null;
    });
  }

  /// 下載指定索引的音檔 MP3，並更新狀態
  ///
  /// [index]             音檔在清單中的索引位置
  /// [onReceiveProgress] 下載進度回呼（已接收 / 總大小）
  ///
  /// 回傳下載完成後的檔案路徑，若已有下載中則回傳 `null`
  Future<String?> downloadedMp3(
    int index, {
    required void Function(int received, int total) onReceiveProgress,
  }) async {
    await _lock.synchronized(() async {
      // 取得舊的音檔資料
      final oldAudio = await state.value!.list[index];

      // 呼叫 Repository 下載檔案
      final filePath = await repository.downloadFile(
        oldAudio,
        onReceiveProgress: onReceiveProgress,
      );

      // 將下載完成的檔案資訊寫入資料庫
      await repository.insertOrUpdateAudio(oldAudio, filePath: filePath);

      // 重新建立清單（確保狀態更新）
      TravelAudioList newTravelAudioList = repository.newTravelAudioList(
        state.value!.rawList,
        total: state.value!.total,
      );

      // 更新狀態
      state = AsyncData(newTravelAudioList);

      return filePath;
    });
    return null;
  }
}
