import 'package:drift/drift.dart';

class TravelAudioTable extends Table {
  IntColumn get id => integer()();
  TextColumn get title => text().nullable()();
  TextColumn get summary => text().nullable()();
  TextColumn get url => text().nullable()();
  TextColumn get fileExt => text().nullable()();
  TextColumn get modified => text().nullable()();
  TextColumn get filePath => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
