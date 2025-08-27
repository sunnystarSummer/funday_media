import 'package:json_annotation/json_annotation.dart';
import 'dart:collection';

import '../../service/model/travel_audio.dart' as travelService;
import '../data_base/travel_audio_db.dart';

part 'travel_audio_list.g.dart';

get travelAudioEmptyList {
  return TravelAudioList.empty(0);
}

class TravelAudioList {
  final List<travelService.TravelAudio> rawList;

  final List<Future<TravelAudio>> _newList = [];

  // 只允許內部改動，而外部只能讀取
  UnmodifiableListView<Future<TravelAudio>> get list =>
      UnmodifiableListView(_newList);

  final int total;

  TravelAudioList.empty(this.total) : rawList = [];

  TravelAudioList(
    this.rawList, {
    required this.total,
    required Future<TravelAudio> Function(travelService.TravelAudio)
    newTravelAudio,
  }) {
    for (final audio in rawList) {
      _newList.add(newTravelAudio(audio));
    }
  }
}

extension ExTravelAudioList on TravelAudioList {
  void updateAt(int index, TravelAudio updated) {
    _newList[index] = Future.value(updated);
  }

  /// 合併另一個 TravelAudioList
  TravelAudioList merge(
    TravelAudioList other, {
    required int page,
    required Future<TravelAudio> Function(travelService.TravelAudio)
    newTravelAudio,
  }) {
    return TravelAudioList(total: other.total, [
      ...rawList,
      ...other.rawList,
    ], newTravelAudio: newTravelAudio);
  }
}

@JsonSerializable(explicitToJson: true)
class TravelAudio extends travelService.TravelAudio {
  TravelAudio(
    super.id,
    String super.title,
    super.summary,
    String super.url,
    super.fileExt,
    String super.modified, {
    required this.isModified,
    required this.filePath,
  });

  final bool isModified;
  String? filePath;

  // State
  bool isDownloaded = false;

  factory TravelAudio.fromJson(Map<String, dynamic> json) =>
      _$TravelAudioFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TravelAudioToJson(this);
}

extension ExTravelAudio on travelService.TravelAudio {
  bool isUpdated(TravelAudioTableData tableData) {
    try {
      final a = DateTime.tryParse(tableData.modified ?? '');
      final b = DateTime.tryParse(modified ?? '');

      if (a != null && b != null) {
        return b.isAfter(a);
      }
    } catch (e) {
      return false;
    }

    return false;
  }
}
