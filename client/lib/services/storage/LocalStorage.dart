import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class LocalStorage {
  static Future<Database> _database;
  
  init() async {
    if (database != null) throw 'The database has been initialised already!';

     _database = openDatabase(
      path.join(await getDatabasesPath(), 'doggie_database.db'),
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        return db.execute(
          "",
        );
      },

      version: 1,
    );
  }
  
  get database => _database;
}