import 'package:Tempo/models/auth_user.dart';
import 'package:Tempo/models/project.dart';
import 'package:Tempo/models/task.dart';
import 'package:Tempo/models/user.dart';
import 'package:Tempo/repositories/repository.dart';
import 'package:Tempo/services/storage/storage.dart';

abstract class LocalRepository {
  LocalRepository(Storage storage);

  Repository<User> getUserRepository();

  Repository<Project> getProjectRepository(AuthUser user);

  Repository<Task> getTaskRepository(Project project);
}