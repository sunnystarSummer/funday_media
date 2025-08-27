import '../../repository/data/travel_audio_list.dart';

/// 播放器狀態模型
///
/// 包含：
///
/// - [travelAudio] 當前播放的音檔資料
/// - [isPlaying] 是否正在播放
class MediaPlayerValue {
  TravelAudio? travelAudio;

  bool isPlaying = false;
}
