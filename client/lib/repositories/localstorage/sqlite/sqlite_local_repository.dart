import 'package:Tempo/models/auth_user.dart';
import 'package:Tempo/models/project.dart';
import 'package:Tempo/models/task.dart';
import 'package:Tempo/models/user.dart';
import 'package:Tempo/repositories/localstorage/repository.dart';
import 'package:Tempo/repositories/localstorage/local_repository.dart';
import 'package:Tempo/repositories/localstorage/sqlite/project_repository.dart';
import 'package:Tempo/repositories/localstorage/sqlite/task_repository.dart';
import 'package:Tempo/repositories/localstorage/sqlite/user_repository.dart';
import 'package:Tempo/services/storage/sqlite_storage.dart';
import 'package:sqflite/sqflite.dart';

class SQLiteLocalRepository implements LocalRepository {
  Database _db;

  SQLiteLocalRepository(SQLiteStorageService storage) : this._db = storage.database;

  @override
  Repository<User> getUserRepository() => SQLiteUserRepository(_db);

  @override
  Repository<Project> getProjectRepository(AuthUser user) => SQLiteProjectRepository(_db, user);

  @override
  Repository<Task> getTaskRepository(Project project) => SQLiteTaskRepository(_db, project);
}