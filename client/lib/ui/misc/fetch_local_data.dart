import 'package:Tempo/models/project.dart';
import 'package:Tempo/models/task.dart';
import 'package:Tempo/models/user.dart';
import 'package:Tempo/repositories/base_repository.dart';
import 'package:Tempo/services/api/api.dart';
import 'package:Tempo/ui/widgets/misc/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FetchLocalDataBuilder extends StatefulWidget {
  final Widget renderChild;

  FetchLocalDataBuilder({@required this.renderChild});

  @override
  _FetchLocalDataBuilder createState() => _FetchLocalDataBuilder();
}

class _FetchLocalDataBuilder extends State<FetchLocalDataBuilder> {
  Future<Map<String, dynamic>> loadUserData;

  @override
  void initState() {
    // TODO: temporary spaghetti code. This part will be heavily changed at some point.
    // (the Database setup will be moved elsewhere and an appropriate widget will be created)
    loadUserData = Provider.of<ApiService>(context, listen: false).fetchData().then((value) async {
      User user = Provider.of<User>(context, listen: false);
      user.firstName = value['firstName'];
      user.surname = value['surname'];

      /* USER REPO */

      BaseRepository<User> userRepo = Provider.of<BaseRepository<User>>(context, listen: false);

      if ((await userRepo.getOne(user.email)) == null)
        userRepo.add(user);
      else print('User already exists in the local DB.');

      /* PROJECT REPO */

      BaseRepository<Project> projectRepo = Provider.of<BaseRepository<Project>>(context, listen: false);

      if ((await projectRepo.getAll()).isEmpty) {
        // Adds general as the first Project
        Project general = await projectRepo.add(Project(name: 'General'));
        user.addProject(general);
      } else user.projects = await projectRepo.getAll();

      /* TASK REPO */

      BaseRepository<Task> taskRepo = Provider.of<BaseRepository<Task>>(context, listen: false);

      List<Task> tasks = await taskRepo.getAll();
      if (tasks.isNotEmpty)
        for (Project project in user.projects)
          project.tasks = (await taskRepo.getAll(id: project.id)).reversed.toList();

      print((await userRepo.getAll()).first.toDatabaseMap());
      print((await projectRepo.getAll()).first.toDatabaseMap());

      // Must be placed at the bottom due to the ProxyChangeNotifier<Project>
      user.activeProject = user.projects.first;

      return value;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: loadUserData,
      builder: (context, snapshot) {
        LoadingIndicator child = LoadingIndicator(type: LoadingType.loading, message: 'Loading user data...');

        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return widget.renderChild;
          } else if (snapshot.hasError || snapshot.data == null) {
            child = LoadingIndicator(
              type: LoadingType.error,
              message: 'Failed to fetch user data.\n${snapshot.error.toString()}',
              onRetry: () => setState(() {
                loadUserData = Provider.of<ApiService>(context, listen: false).fetchData();
              }),
            );
          }
        }

        return Scaffold(
          body: Center(child: child),
        );
      },
    );
  }
}
