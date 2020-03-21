import 'package:Tempo/services/storage/storage.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class SQLiteStorageService implements Storage<Database> {
  static final SQLiteStorageService _instance = SQLiteStorageService._();
  static String _databaseName;

  Database _database;

  SQLiteStorageService._();

  factory SQLiteStorageService(String databaseName) {
    if (_databaseName == null) _databaseName = databaseName;
    else print('Warning! It is not possible to change the name of the database once assigned!');

    return _instance;
  }

  /* GETTERS */

  @override
  Database get database => database;

  @override
  String get name => _databaseName;

  /* OTHER METHODS */

  @override
  Future<SQLiteStorageService> init() async {
    if (_database != null) return this;

    _database = await openDatabase(
      path.join(await getDatabasesPath(), _databaseName),
      onCreate: _createTables,
      version: 1,
    );

    return this;
  }

  @override
  Future<void> deleteStorage() async => await deleteDatabase(path.join(await getDatabasesPath(), _databaseName));

  Future<void> _createTables(Database db, int version) async {
    // TODO: Update queries
    await db.execute(
      '''
      CREATE TABLE IF NOT EXISTS APP_USER (
        email          VARCHAR(64) PRIMARY KEY,
        first_name     VARCHAR(64) NOT NULL,
        surname        VARCHAR(64) NOT NULL,
      );
    
      CREATE TABLE IF NOT EXISTS MEETING (
        meeting_id     INTEGER PRIMARY KEY,
        meeting_name   VARCHAR(64) NOT NULL
        date_from      INTEGER NOT NULL,
        end_time       INTEGER NOT NULL,
        organiser      VARCHAR(64) NOT NULL,
        user_fid       INTEGER,
        FOREIGN KEY(user_fid) REFERENCES APP_USER(user_id)
      );
      
      CREATE TABLE IF NOT EXISTS PROJECT (
        project_id     INTEGER PRIMARY KEY,
        project_name   VARCHAR(64) NOT NULL
        start_date     INTEGER NOT NULL,
        due_date       INTEGER NOT NULL,
        user_fid       INTEGER,
        FOREIGN KEY(user_fid) REFERENCES APP_USER(user_id)
      );

      CREATE TABLE IF NOT EXISTS LOCATION (
        location_id    INTEGER PRIMARY KEY,
        longitude      DOUBLE NOT NULL,
        latitude       DOUBLE NOT NULL
      );

      CREATE TABLE IF NOT EXISTS TASK (
        task_id        INTEGER PRIMARY KEY,
        task_name      VARCHAR(64) NOT NULL
        task_time      INTEGER NOT NULL,
        is_done        BOOLEAN NOT NULL,
        project_fid    INTEGER,
        location_fid   INTEGER,
        FOREIGN KEY(project_fid) REFERENCES PROJECT(project_id),
        FOREIGN KEY(location_fid) REFERENCES LOCATION(location_id)
      );
      '''
    );
  }

  @override
  Future<void> close() => _database.close();
}