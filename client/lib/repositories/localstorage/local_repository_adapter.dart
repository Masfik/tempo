import 'package:Tempo/models/auth_user.dart';
import 'package:Tempo/models/project.dart';
import 'package:Tempo/models/task.dart';
import 'package:Tempo/models/user.dart';
import 'package:Tempo/repositories/localstorage/repository.dart';
import 'package:Tempo/repositories/localstorage/local_repository.dart';

class LocalRepositoryAdapter implements LocalRepository {
  LocalRepository _localRepository;

  LocalRepositoryAdapter(LocalRepository repository) : this._localRepository = repository;

  @override
  Repository<User> getUserRepository() => _localRepository.getUserRepository();

  @override
  Repository<Project> getProjectRepository(AuthUser user) => _localRepository.getProjectRepository(user);

  @override
  Repository<Task> getTaskRepository(Project project) => _localRepository.getTaskRepository(project);
}