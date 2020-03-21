import 'package:Tempo/services/storage/sqlite/sqlite_storage.dart';
import 'package:Tempo/services/storage/storage.dart';

class LocalStorageServiceAdapter implements Storage {
  final Storage _localStorage;

  // Sets SQLite as the Local Storage service (can be changed at a later stage)
  LocalStorageServiceAdapter() : this._localStorage = SQLiteStorageService('userdata.db');

  @override
  get database => _localStorage.database;

  @override
  String get name => _localStorage.name;

  @override
  Future<Storage> init() => _localStorage.init();

  @override
  Future<void> deleteStorage() => _localStorage.deleteStorage();

  @override
  Future<void> close() => _localStorage.close();
}