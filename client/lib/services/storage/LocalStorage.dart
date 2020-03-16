import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class LocalStorage {
  static Future<Database> _database;
  
  init() async {
    if (_database != null) throw 'The database has been initialised already!';

     _database = openDatabase(
      path.join(await getDatabasesPath(), 'doggie_database.db'),
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        return db.execute(
          'CREATE TABLE IF NOT EXISTS APP_USER ('
            'user_id        INTEGER PRIMARY KEY,'
            'first_name     VARCHAR(64) NOT NULL,'
            'surname        VARCHAR(64) NOT NULL,'
            'email          VARCHAR(64) NOT NULL'
          ');'
          'CREATE TABLE IF NOT EXISTS MEETING ('
            'meeting_id     INTEGER PRIMARY KEY,'
            'meeting_name   VARCHAR(64) NOT NULL'
            'date_from      INTEGER NOT NULL,'
            'end_time       INTEGER NOT NULL,'
            'organiser      VARCHAR(64) NOT NULL,'
            'user_fid       INTEGER,'
            'FOREIGN KEY(user_fid) REFERENCES APP_USER(user_id)'
          ');'
          'CREATE TABLE IF NOT EXISTS PROJECT ('
            'project_id     INTEGER PRIMARY KEY,'
            'project_name   VARCHAR(64) NOT NULL'
            'start_date     INTEGER NOT NULL,'
            'due_date       INTEGER NOT NULL,'
            'user_fid       INTEGER,'
            'FOREIGN KEY(user_fid) REFERENCES APP_USER(user_id)'
          ');'
          'CREATE TABLE IF NOT EXISTS LOCATION ('
            'location_id    INTEGER PRIMARY KEY,'
            'longitude      DOUBLE NOT NULL,'
            'latitude       DOUBLE NOT NULL'
          ');'
          'CREATE TABLE IF NOT EXISTS TASK ('
            'task_id        INTEGER PRIMARY KEY,'
            'task_name      VARCHAR(64) NOT NULL'
            'task_time      INTEGER NOT NULL,'
            'is_done        BOOLEAN NOT NULL,'
            'project_fid    INTEGER,'
            'location_fid   INTEGER,'
            'FOREIGN KEY(project_fid) REFERENCES PROJECT(project_id),'
            'FOREIGN KEY(location_fid) REFERENCES LOCATION(location_id)'
          ');',
        );
      },
      version: 1,
    );
  }
  
  get database => _database;
}