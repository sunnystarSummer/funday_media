import 'package:json_annotation/json_annotation.dart';
import 'dart:collection';

import '../../service/model/travel_audio.dart' as travel_service;
import '../data_base/travel_audio_db.dart';

part 'travel_audio_list.g.dart';

class TravelAudioList {
  final Map<int, List<travel_service.TravelAudio>> travelAudioMap;

  final List<Future<TravelAudio>> _newList = [];

  // 只允許內部改動，而外部只能讀取
  UnmodifiableListView<Future<TravelAudio>> get list =>
      UnmodifiableListView(_newList);

  final int total;

  TravelAudioList.empty() : total = 0, travelAudioMap = {};

  TravelAudioList(
    this.travelAudioMap, {
    required this.total,
    required Future<TravelAudio> Function(travel_service.TravelAudio)
    newTravelAudio,
  }) {
    // 依 key 排序
    final sortedKeys = travelAudioMap.keys.toList()..sort();

    for (final key in sortedKeys) {
      final audios = travelAudioMap[key];
      if (audios != null) {
        for (final audio in audios) {
          _newList.add(newTravelAudio(audio));
        }
      }
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
    required Future<TravelAudio> Function(travel_service.TravelAudio)
    newTravelAudio,
  }) {
    // 先合併兩個 map
    final mergedMap = <int, List<travel_service.TravelAudio>>{};

    // 複製本身的資料
    for (final entry in travelAudioMap.entries) {
      mergedMap[entry.key] = [...entry.value];
    }

    // 合併另一個 list 的資料
    for (final entry in other.travelAudioMap.entries) {
      mergedMap.update(
        entry.key,
        (existing) => [...existing, ...entry.value],
        ifAbsent: () => [...entry.value],
      );
    }

    return TravelAudioList(
      mergedMap,
      total: total,
      newTravelAudio: newTravelAudio,
    );
  }
}

@JsonSerializable(explicitToJson: true)
class TravelAudio extends travel_service.TravelAudio {
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

extension ExTravelAudio on travel_service.TravelAudio {
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
