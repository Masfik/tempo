import 'package:Tempo/models/auth_user.dart';
import 'package:Tempo/models/project.dart';
import 'package:Tempo/models/task.dart';
import 'package:Tempo/models/user.dart';
import 'package:Tempo/repositories/base_repository.dart';
import 'package:Tempo/services/storage/storage.dart';

abstract class LocalRepository {
  LocalRepository(Storage storage);

  BaseRepository<User> getUserRepository();

  BaseRepository<Project> getProjectRepository(AuthUser user);

  BaseRepository<Task> getTaskRepository(Project project);
}