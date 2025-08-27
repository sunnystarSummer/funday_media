import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter/foundation.dart';
import '../../service/model/travel_audio.dart';
import 'travel_audio_table.dart';

part 'travel_audio_db.g.dart';

const dbName = 'travel_audio.db';

bool get isSupportDb =>
    defaultTargetPlatform == TargetPlatform.android ||
    defaultTargetPlatform == TargetPlatform.iOS;

@DriftDatabase(tables: [TravelAudioTable])
class TravelAudioDatabase extends _$TravelAudioDatabase {
  //建立一個 記憶體內的 SQLite 資料庫，App 關掉後資料就消失。
  //TravelAudioDatabase() : super(NativeDatabase.memory());
  TravelAudioDatabase._() : super(driftDatabase(name: dbName));

  static TravelAudioDatabase get instance => TravelAudioDatabase._();

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) => m.createAll(),
    onUpgrade: (m, from, to) async {
      if (from == 1) {
        await m.addColumn(travelAudioTable, travelAudioTable.filePath); // 新增欄位
      }
    },
  );

  // 新增或更新
  Future<void> insertOrUpdateAudio(TravelAudioTableCompanion entry) async {
    // 查 DB 是否已有相同 id
    final existing = await (select(
      travelAudioTable,
    )..where((tbl) => tbl.id.equals(entry.id.value))).getSingleOrNull();

    if (existing == null) {
      // 沒有舊資料 → 直接插入
      await into(travelAudioTable).insert(entry);
    } else {
      // 已有舊資料 → 比較 modified
      final newModified = DateTime.tryParse(entry.modified.value ?? '');
      final oldModified = DateTime.tryParse(existing.modified ?? '');

      if (newModified != null && oldModified != null) {
        if (newModified.isAfter(oldModified)) {
          // 新的比較晚 → 更新
          await update(travelAudioTable).replace(entry);
        }
      } else {
        // 如果 modified 格式有問題，就保險一點直接更新
        await update(travelAudioTable).replace(entry);
      }
    }
  }

  // 查詢全部
  Future<List<TravelAudioTableData>> getAllAudioList() async {
    return await select(travelAudioTable).get();
  }

  // 查單筆
  Future<TravelAudioTableData?> getAudioById(int id) async {
    return await (select(
      travelAudioTable,
    )..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }
}

extension TravelAudioModelMapper on TravelAudio {
  TravelAudioTableCompanion toCompanion({required String? filePath}) {
    return TravelAudioTableCompanion.insert(
      id: Value(id),
      title: Value(title),
      summary: Value(summary?.toString()),
      url: Value(url),
      fileExt: Value(fileExt?.toString()),
      modified: Value(modified),
      filePath: Value(filePath),
    );
  }
}
