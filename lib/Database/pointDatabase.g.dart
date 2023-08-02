// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pointDatabase.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorPointDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$PointDatabaseBuilder databaseBuilder(String name) =>
      _$PointDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$PointDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$PointDatabaseBuilder(null);
}

class _$PointDatabaseBuilder {
  _$PointDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$PointDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$PointDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<PointDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$PointDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$PointDatabase extends PointDatabase {
  _$PointDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  PointDAO? _pointDaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `points` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `point` INTEGER, `timeStamp` INTEGER)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  PointDAO get pointDao {
    return _pointDaoInstance ??= _$PointDAO(database, changeListener);
  }
}

class _$PointDAO extends PointDAO {
  _$PointDAO(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _pointDataInsertionAdapter = InsertionAdapter(
            database,
            'points',
            (PointData item) => <String, Object?>{
                  'id': item.id,
                  'point': item.point,
                  'timeStamp': item.timeStamp
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<PointData> _pointDataInsertionAdapter;

  @override
  Stream<List<PointData>> getAllPoints() {
    return _queryAdapter.queryListStream('select * from points',
        mapper: (Map<String, Object?> row) => PointData(
            row['point'] as int?, row['timeStamp'] as int?,
            id: row['id'] as int?),
        queryableName: 'points',
        isView: false);
  }

  @override
  Future<void> addPoint(PointData pointData) async {
    await _pointDataInsertionAdapter.insert(
        pointData, OnConflictStrategy.abort);
  }
}
