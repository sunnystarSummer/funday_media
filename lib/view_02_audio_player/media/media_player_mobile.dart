import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';

import '../../repository/data/travel_audio_list.dart';

Future<void> setSourceDeviceFile(
  AudioPlayer audioPlayer,
  TravelAudio travelAudio,
) async {
  final filePath = travelAudio.filePath ?? '';
  final file = File(filePath);

  if (file.existsSync()) {
    // 設定音源為本地檔案
    await audioPlayer.setSourceDeviceFile(filePath);
  }
}
