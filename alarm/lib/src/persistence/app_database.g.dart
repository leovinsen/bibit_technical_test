// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: library_private_types_in_public_api

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  AlarmDao? _alarmDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `alarms` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `scheduled_for` INTEGER NOT NULL, `seconds_elapsed` INTEGER)');
        await database.execute(
            'CREATE INDEX `index_alarms_scheduled_for` ON `alarms` (`scheduled_for`)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  AlarmDao get alarmDao {
    return _alarmDaoInstance ??= _$AlarmDao(database, changeListener);
  }
}

class _$AlarmDao extends AlarmDao {
  _$AlarmDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _alarmModelInsertionAdapter = InsertionAdapter(
            database,
            'alarms',
            (AlarmModel item) => <String, Object?>{
                  'id': item.id,
                  'scheduled_for': _dateTimeConverter.encode(item.scheduledFor),
                  'seconds_elapsed': item.secondElapsed
                }),
        _alarmModelUpdateAdapter = UpdateAdapter(
            database,
            'alarms',
            ['id'],
            (AlarmModel item) => <String, Object?>{
                  'id': item.id,
                  'scheduled_for': _dateTimeConverter.encode(item.scheduledFor),
                  'seconds_elapsed': item.secondElapsed
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<AlarmModel> _alarmModelInsertionAdapter;

  final UpdateAdapter<AlarmModel> _alarmModelUpdateAdapter;

  @override
  Future<List<AlarmModel>> getAlarms() async {
    return _queryAdapter.queryList(
        'SELECT * FROM `alarms` ORDER BY `scheduled_for` DESC',
        mapper: (Map<String, Object?> row) => AlarmModel(
            id: row['id'] as int?,
            scheduledFor:
                _dateTimeConverter.decode(row['scheduled_for'] as int),
            secondElapsed: row['seconds_elapsed'] as int?));
  }

  @override
  Future<int> insertAlarm(AlarmModel alarm) {
    return _alarmModelInsertionAdapter.insertAndReturnId(
        alarm, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateAlarm(AlarmModel alarm) {
    return _alarmModelUpdateAdapter.updateAndReturnChangedRows(
        alarm, OnConflictStrategy.abort);
  }
}

// ignore_for_file: unused_element
final _dateTimeConverter = DateTimeConverter();
