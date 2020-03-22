import 'package:Tempo/models/auth_user.dart';
import 'package:Tempo/models/project.dart';
import 'package:Tempo/models/task.dart';
import 'package:Tempo/models/user.dart';
import 'package:Tempo/repositories/base_repository.dart';
import 'package:Tempo/repositories/local_repository.dart';

class LocalRepositoryAdapter implements LocalRepository {
  LocalRepository _localRepository;

  LocalRepositoryAdapter(LocalRepository repository) : this._localRepository = repository;

  @override
  BaseRepository<User> getUserRepository() => _localRepository.getUserRepository();

  @override
  BaseRepository<Project> getProjectRepository(AuthUser user) => _localRepository.getProjectRepository(user);

  @override
  BaseRepository<Task> getTaskRepository(Project project) => _localRepository.getTaskRepository(project);
}