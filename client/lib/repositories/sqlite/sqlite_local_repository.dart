import 'package:Tempo/models/auth_user.dart';
import 'package:Tempo/models/project.dart';
import 'package:Tempo/models/task.dart';
import 'package:Tempo/models/user.dart';
import 'package:Tempo/repositories/base_repository.dart';
import 'package:Tempo/repositories/local_repository.dart';
import 'package:Tempo/repositories/sqlite/project_repository.dart';
import 'package:Tempo/repositories/sqlite/task_repository.dart';
import 'package:Tempo/repositories/sqlite/user_repository.dart';
import 'package:Tempo/services/storage/sqlite_storage.dart';

class SQLiteLocalRepository implements LocalRepository {
  SQLiteStorageService _storage;

  SQLiteLocalRepository(SQLiteStorageService storage) : this._storage = storage;

  @override
  BaseRepository<User> getUserRepository() => SQLiteUserRepository(_storage.database);

  @override
  BaseRepository<Project> getProjectRepository(AuthUser user) => SQLiteProjectRepository(_storage.database, user);

  @override
  BaseRepository<Task> getTaskRepository(Project project) => SQLiteTaskRepository(_storage.database, project);
}