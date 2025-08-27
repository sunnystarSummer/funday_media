// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'travel_audio_db.dart';

// ignore_for_file: type=lint
class $TravelAudioTableTable extends TravelAudioTable
    with TableInfo<$TravelAudioTableTable, TravelAudioTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TravelAudioTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _summaryMeta = const VerificationMeta(
    'summary',
  );
  @override
  late final GeneratedColumn<String> summary = GeneratedColumn<String>(
    'summary',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _urlMeta = const VerificationMeta('url');
  @override
  late final GeneratedColumn<String> url = GeneratedColumn<String>(
    'url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fileExtMeta = const VerificationMeta(
    'fileExt',
  );
  @override
  late final GeneratedColumn<String> fileExt = GeneratedColumn<String>(
    'file_ext',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _modifiedMeta = const VerificationMeta(
    'modified',
  );
  @override
  late final GeneratedColumn<String> modified = GeneratedColumn<String>(
    'modified',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _filePathMeta = const VerificationMeta(
    'filePath',
  );
  @override
  late final GeneratedColumn<String> filePath = GeneratedColumn<String>(
    'file_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    summary,
    url,
    fileExt,
    modified,
    filePath,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'travel_audio_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<TravelAudioTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    }
    if (data.containsKey('summary')) {
      context.handle(
        _summaryMeta,
        summary.isAcceptableOrUnknown(data['summary']!, _summaryMeta),
      );
    }
    if (data.containsKey('url')) {
      context.handle(
        _urlMeta,
        url.isAcceptableOrUnknown(data['url']!, _urlMeta),
      );
    }
    if (data.containsKey('file_ext')) {
      context.handle(
        _fileExtMeta,
        fileExt.isAcceptableOrUnknown(data['file_ext']!, _fileExtMeta),
      );
    }
    if (data.containsKey('modified')) {
      context.handle(
        _modifiedMeta,
        modified.isAcceptableOrUnknown(data['modified']!, _modifiedMeta),
      );
    }
    if (data.containsKey('file_path')) {
      context.handle(
        _filePathMeta,
        filePath.isAcceptableOrUnknown(data['file_path']!, _filePathMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TravelAudioTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TravelAudioTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      ),
      summary: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}summary'],
      ),
      url: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}url'],
      ),
      fileExt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}file_ext'],
      ),
      modified: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}modified'],
      ),
      filePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}file_path'],
      ),
    );
  }

  @override
  $TravelAudioTableTable createAlias(String alias) {
    return $TravelAudioTableTable(attachedDatabase, alias);
  }
}

class TravelAudioTableData extends DataClass
    implements Insertable<TravelAudioTableData> {
  final int id;
  final String? title;
  final String? summary;
  final String? url;
  final String? fileExt;
  final String? modified;
  final String? filePath;
  const TravelAudioTableData({
    required this.id,
    this.title,
    this.summary,
    this.url,
    this.fileExt,
    this.modified,
    this.filePath,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    if (!nullToAbsent || summary != null) {
      map['summary'] = Variable<String>(summary);
    }
    if (!nullToAbsent || url != null) {
      map['url'] = Variable<String>(url);
    }
    if (!nullToAbsent || fileExt != null) {
      map['file_ext'] = Variable<String>(fileExt);
    }
    if (!nullToAbsent || modified != null) {
      map['modified'] = Variable<String>(modified);
    }
    if (!nullToAbsent || filePath != null) {
      map['file_path'] = Variable<String>(filePath);
    }
    return map;
  }

  TravelAudioTableCompanion toCompanion(bool nullToAbsent) {
    return TravelAudioTableCompanion(
      id: Value(id),
      title: title == null && nullToAbsent
          ? const Value.absent()
          : Value(title),
      summary: summary == null && nullToAbsent
          ? const Value.absent()
          : Value(summary),
      url: url == null && nullToAbsent ? const Value.absent() : Value(url),
      fileExt: fileExt == null && nullToAbsent
          ? const Value.absent()
          : Value(fileExt),
      modified: modified == null && nullToAbsent
          ? const Value.absent()
          : Value(modified),
      filePath: filePath == null && nullToAbsent
          ? const Value.absent()
          : Value(filePath),
    );
  }

  factory TravelAudioTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TravelAudioTableData(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String?>(json['title']),
      summary: serializer.fromJson<String?>(json['summary']),
      url: serializer.fromJson<String?>(json['url']),
      fileExt: serializer.fromJson<String?>(json['fileExt']),
      modified: serializer.fromJson<String?>(json['modified']),
      filePath: serializer.fromJson<String?>(json['filePath']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String?>(title),
      'summary': serializer.toJson<String?>(summary),
      'url': serializer.toJson<String?>(url),
      'fileExt': serializer.toJson<String?>(fileExt),
      'modified': serializer.toJson<String?>(modified),
      'filePath': serializer.toJson<String?>(filePath),
    };
  }

  TravelAudioTableData copyWith({
    int? id,
    Value<String?> title = const Value.absent(),
    Value<String?> summary = const Value.absent(),
    Value<String?> url = const Value.absent(),
    Value<String?> fileExt = const Value.absent(),
    Value<String?> modified = const Value.absent(),
    Value<String?> filePath = const Value.absent(),
  }) => TravelAudioTableData(
    id: id ?? this.id,
    title: title.present ? title.value : this.title,
    summary: summary.present ? summary.value : this.summary,
    url: url.present ? url.value : this.url,
    fileExt: fileExt.present ? fileExt.value : this.fileExt,
    modified: modified.present ? modified.value : this.modified,
    filePath: filePath.present ? filePath.value : this.filePath,
  );
  TravelAudioTableData copyWithCompanion(TravelAudioTableCompanion data) {
    return TravelAudioTableData(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      summary: data.summary.present ? data.summary.value : this.summary,
      url: data.url.present ? data.url.value : this.url,
      fileExt: data.fileExt.present ? data.fileExt.value : this.fileExt,
      modified: data.modified.present ? data.modified.value : this.modified,
      filePath: data.filePath.present ? data.filePath.value : this.filePath,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TravelAudioTableData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('summary: $summary, ')
          ..write('url: $url, ')
          ..write('fileExt: $fileExt, ')
          ..write('modified: $modified, ')
          ..write('filePath: $filePath')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, title, summary, url, fileExt, modified, filePath);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TravelAudioTableData &&
          other.id == this.id &&
          other.title == this.title &&
          other.summary == this.summary &&
          other.url == this.url &&
          other.fileExt == this.fileExt &&
          other.modified == this.modified &&
          other.filePath == this.filePath);
}

class TravelAudioTableCompanion extends UpdateCompanion<TravelAudioTableData> {
  final Value<int> id;
  final Value<String?> title;
  final Value<String?> summary;
  final Value<String?> url;
  final Value<String?> fileExt;
  final Value<String?> modified;
  final Value<String?> filePath;
  const TravelAudioTableCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.summary = const Value.absent(),
    this.url = const Value.absent(),
    this.fileExt = const Value.absent(),
    this.modified = const Value.absent(),
    this.filePath = const Value.absent(),
  });
  TravelAudioTableCompanion.insert({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.summary = const Value.absent(),
    this.url = const Value.absent(),
    this.fileExt = const Value.absent(),
    this.modified = const Value.absent(),
    this.filePath = const Value.absent(),
  });
  static Insertable<TravelAudioTableData> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? summary,
    Expression<String>? url,
    Expression<String>? fileExt,
    Expression<String>? modified,
    Expression<String>? filePath,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (summary != null) 'summary': summary,
      if (url != null) 'url': url,
      if (fileExt != null) 'file_ext': fileExt,
      if (modified != null) 'modified': modified,
      if (filePath != null) 'file_path': filePath,
    });
  }

  TravelAudioTableCompanion copyWith({
    Value<int>? id,
    Value<String?>? title,
    Value<String?>? summary,
    Value<String?>? url,
    Value<String?>? fileExt,
    Value<String?>? modified,
    Value<String?>? filePath,
  }) {
    return TravelAudioTableCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      summary: summary ?? this.summary,
      url: url ?? this.url,
      fileExt: fileExt ?? this.fileExt,
      modified: modified ?? this.modified,
      filePath: filePath ?? this.filePath,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (summary.present) {
      map['summary'] = Variable<String>(summary.value);
    }
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    if (fileExt.present) {
      map['file_ext'] = Variable<String>(fileExt.value);
    }
    if (modified.present) {
      map['modified'] = Variable<String>(modified.value);
    }
    if (filePath.present) {
      map['file_path'] = Variable<String>(filePath.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TravelAudioTableCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('summary: $summary, ')
          ..write('url: $url, ')
          ..write('fileExt: $fileExt, ')
          ..write('modified: $modified, ')
          ..write('filePath: $filePath')
          ..write(')'))
        .toString();
  }
}

abstract class _$TravelAudioDatabase extends GeneratedDatabase {
  _$TravelAudioDatabase(QueryExecutor e) : super(e);
  $TravelAudioDatabaseManager get managers => $TravelAudioDatabaseManager(this);
  late final $TravelAudioTableTable travelAudioTable = $TravelAudioTableTable(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [travelAudioTable];
}

typedef $$TravelAudioTableTableCreateCompanionBuilder =
    TravelAudioTableCompanion Function({
      Value<int> id,
      Value<String?> title,
      Value<String?> summary,
      Value<String?> url,
      Value<String?> fileExt,
      Value<String?> modified,
      Value<String?> filePath,
    });
typedef $$TravelAudioTableTableUpdateCompanionBuilder =
    TravelAudioTableCompanion Function({
      Value<int> id,
      Value<String?> title,
      Value<String?> summary,
      Value<String?> url,
      Value<String?> fileExt,
      Value<String?> modified,
      Value<String?> filePath,
    });

class $$TravelAudioTableTableFilterComposer
    extends Composer<_$TravelAudioDatabase, $TravelAudioTableTable> {
  $$TravelAudioTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get summary => $composableBuilder(
    column: $table.summary,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get url => $composableBuilder(
    column: $table.url,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fileExt => $composableBuilder(
    column: $table.fileExt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get modified => $composableBuilder(
    column: $table.modified,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get filePath => $composableBuilder(
    column: $table.filePath,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TravelAudioTableTableOrderingComposer
    extends Composer<_$TravelAudioDatabase, $TravelAudioTableTable> {
  $$TravelAudioTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get summary => $composableBuilder(
    column: $table.summary,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get url => $composableBuilder(
    column: $table.url,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fileExt => $composableBuilder(
    column: $table.fileExt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get modified => $composableBuilder(
    column: $table.modified,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get filePath => $composableBuilder(
    column: $table.filePath,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TravelAudioTableTableAnnotationComposer
    extends Composer<_$TravelAudioDatabase, $TravelAudioTableTable> {
  $$TravelAudioTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get summary =>
      $composableBuilder(column: $table.summary, builder: (column) => column);

  GeneratedColumn<String> get url =>
      $composableBuilder(column: $table.url, builder: (column) => column);

  GeneratedColumn<String> get fileExt =>
      $composableBuilder(column: $table.fileExt, builder: (column) => column);

  GeneratedColumn<String> get modified =>
      $composableBuilder(column: $table.modified, builder: (column) => column);

  GeneratedColumn<String> get filePath =>
      $composableBuilder(column: $table.filePath, builder: (column) => column);
}

class $$TravelAudioTableTableTableManager
    extends
        RootTableManager<
          _$TravelAudioDatabase,
          $TravelAudioTableTable,
          TravelAudioTableData,
          $$TravelAudioTableTableFilterComposer,
          $$TravelAudioTableTableOrderingComposer,
          $$TravelAudioTableTableAnnotationComposer,
          $$TravelAudioTableTableCreateCompanionBuilder,
          $$TravelAudioTableTableUpdateCompanionBuilder,
          (
            TravelAudioTableData,
            BaseReferences<
              _$TravelAudioDatabase,
              $TravelAudioTableTable,
              TravelAudioTableData
            >,
          ),
          TravelAudioTableData,
          PrefetchHooks Function()
        > {
  $$TravelAudioTableTableTableManager(
    _$TravelAudioDatabase db,
    $TravelAudioTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TravelAudioTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TravelAudioTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TravelAudioTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> title = const Value.absent(),
                Value<String?> summary = const Value.absent(),
                Value<String?> url = const Value.absent(),
                Value<String?> fileExt = const Value.absent(),
                Value<String?> modified = const Value.absent(),
                Value<String?> filePath = const Value.absent(),
              }) => TravelAudioTableCompanion(
                id: id,
                title: title,
                summary: summary,
                url: url,
                fileExt: fileExt,
                modified: modified,
                filePath: filePath,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> title = const Value.absent(),
                Value<String?> summary = const Value.absent(),
                Value<String?> url = const Value.absent(),
                Value<String?> fileExt = const Value.absent(),
                Value<String?> modified = const Value.absent(),
                Value<String?> filePath = const Value.absent(),
              }) => TravelAudioTableCompanion.insert(
                id: id,
                title: title,
                summary: summary,
                url: url,
                fileExt: fileExt,
                modified: modified,
                filePath: filePath,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TravelAudioTableTableProcessedTableManager =
    ProcessedTableManager<
      _$TravelAudioDatabase,
      $TravelAudioTableTable,
      TravelAudioTableData,
      $$TravelAudioTableTableFilterComposer,
      $$TravelAudioTableTableOrderingComposer,
      $$TravelAudioTableTableAnnotationComposer,
      $$TravelAudioTableTableCreateCompanionBuilder,
      $$TravelAudioTableTableUpdateCompanionBuilder,
      (
        TravelAudioTableData,
        BaseReferences<
          _$TravelAudioDatabase,
          $TravelAudioTableTable,
          TravelAudioTableData
        >,
      ),
      TravelAudioTableData,
      PrefetchHooks Function()
    >;

class $TravelAudioDatabaseManager {
  final _$TravelAudioDatabase _db;
  $TravelAudioDatabaseManager(this._db);
  $$TravelAudioTableTableTableManager get travelAudioTable =>
      $$TravelAudioTableTableTableManager(_db, _db.travelAudioTable);
}
