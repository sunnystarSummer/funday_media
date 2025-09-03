import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:funday_media/main_mobile.dart';

import '../../repository/data/travel_audio_list.dart';
import '../media/media_player_mobile.dart';
import '../media/media_player_value.dart';

/// 全域音樂播放器實例
final AudioPlayer _audioPlayer = AudioPlayer();

/// 播放器狀態物件
var _playerState = MediaPlayerValue();

/// 播放器 Async 狀態管理 Provider
///
/// 使用 AsyncNotifierProvider 管理播放狀態
final mediaPlayerProvider =
    AsyncNotifierProvider<MediaPlayerNotifier, MediaPlayerValue>(
      MediaPlayerNotifier.new,
    );

/// 播放器狀態管理器（AsyncNotifier）
class MediaPlayerNotifier extends AsyncNotifier<MediaPlayerValue> {
  /// 初始狀態
  @override
  FutureOr<MediaPlayerValue> build() async {
    return _playerState;
  }

  /// 取得當前播放的音檔
  TravelAudio? get _audio => state.value?.travelAudio;

  /// 設定音樂播放器釋放模式（播放結束後停止）
  void _setReleaseModeOnMediaPlayer() =>
      _audioPlayer.setReleaseMode(ReleaseMode.stop);

  /// 設定播放的音檔
  ///
  /// 1. 停止目前播放
  /// 2. 讀取本地檔案
  /// 3. 更新播放狀態
  Future<void> setTravelAudioMedia(TravelAudio travelAudio) async {
    _setReleaseModeOnMediaPlayer();
    await pause(); // 暫停目前播放

    final url = travelAudio.url;

    if (isMobile) {
      await setSourceDeviceFile(_audioPlayer, travelAudio);
    } else if (url != null) {
      await _audioPlayer.setSourceUrl(url);
    }

    // 設定 Loading 狀態
    state = const AsyncLoading();
    try {
      // 更新播放狀態（未播放）
      _playerState = MediaPlayerValue()
        ..travelAudio = travelAudio
        ..isPlaying = false;

      state = AsyncData(_playerState);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  /// 播放音檔
  Future<void> play() async {
    await _audioPlayer.resume();

    state = const AsyncLoading();
    try {
      _playerState = MediaPlayerValue()
        ..travelAudio = _audio
        ..isPlaying = true;

      state = AsyncData(_playerState);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  /// 暫停播放
  Future<void> pause() async {
    await _audioPlayer.pause();

    state = const AsyncLoading();
    try {
      _playerState = MediaPlayerValue()
        ..travelAudio = _audio
        ..isPlaying = false;

      state = AsyncData(_playerState);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  /// 切換播放 / 暫停指定音檔的操作
  ///
  /// 若目前播放的音檔與 [audio] 相同：
  /// - 若正在播放 → 暫停
  /// - 若暫停中 → 播放
  /// 若不同音檔，則不做任何動作（可擴充成自動切換新音檔）
  Future<void> audioPlayerAction(TravelAudio audio) async {
    final id = _playerState.travelAudio?.id;

    if (id == audio.id) {
      if (_playerState.isPlaying) {
        await pause();
      } else {
        await play();
      }
    }
  }
}

// /// 切換播放 / 暫停指定音檔的操作
// ///
// /// 若目前播放的音檔與 [audio] 相同：
// /// - 若正在播放 → 暫停
// /// - 若暫停中 → 播放
// /// 若不同音檔，則不做任何動作（可擴充成自動切換新音檔）
// Future<void> audioPlayerAction(WidgetRef ref, TravelAudio audio) async {
//   MediaPlayerNotifier notifier = ref.read(mediaPlayerProvider.notifier);
//
//   final id = _playerState.travelAudio?.id;
//
//   if (id == audio.id) {
//     if (_playerState.isPlaying) {
//       await notifier.pause();
//     } else {
//       await notifier.play();
//     }
//   }
// }
