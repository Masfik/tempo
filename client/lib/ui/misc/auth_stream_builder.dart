import 'package:Tempo/models/auth_user.dart';
import 'package:Tempo/models/project.dart';
import 'package:Tempo/models/task.dart';
import 'package:Tempo/models/user.dart';
import 'package:Tempo/repositories/repository.dart';
import 'package:Tempo/repositories/local_repository.dart';
import 'package:Tempo/repositories/sqlite/sqlite_local_repository.dart';
import 'package:Tempo/services/authentication/authentication.dart';
import 'package:Tempo/services/storage/sqlite_storage.dart';
import 'package:Tempo/services/storage/storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthStreamBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, AsyncSnapshot<AuthUser> snapshot) builder;

  AuthStreamBuilder({@required this.builder});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthUser>(
      stream: Provider.of<AuthService>(context).user,
      builder: (context, snapshot) {
        AuthUser authUser = snapshot.data;
        if (authUser == null) return builder(context, snapshot);

        // Storage can be changed at a later stage
        return DatabaseBuilder(
          storage: SQLiteStorageService('userdata.db'),
          builder: (BuildContext context, AsyncSnapshot<Storage> dbSnapshot) {
            Storage storage = dbSnapshot.data;
            if (storage == null) return builder(context, snapshot);

            LocalRepository localRepository = SQLiteLocalRepository(storage);

            return MultiProvider(
              providers: [
                // Instantiates a User model based on the AuthUser obtained from the above StreamBuilder
                ChangeNotifierProvider<User>(
                  create: (context) => User.fromAuthUser(authUser: authUser),
                ),
                ChangeNotifierProxyProvider<User, Project>(
                  create: (context) => Project(name: 'Active Project'),
                  update: (context, user, project) => project..updateWith(user.activeProject)
                ),
                Provider<Repository<User>>.value(
                  value: localRepository.getUserRepository()
                ),
                Provider<Repository<Project>>.value(
                  value: localRepository.getProjectRepository(authUser)
                ),
                ProxyProvider<Project, Repository<Task>>(
                  update: (context, project, _) => localRepository.getTaskRepository(project),
                )
              ],
              child: builder(context, snapshot)
            );
          },
        );
      },
    );
  }
}

class DatabaseBuilder extends StatefulWidget {
  // Storage can be changed at a later stage
  final Storage storage;
  final Widget Function(BuildContext context, AsyncSnapshot<Storage> snapshot) builder;

  DatabaseBuilder({@required this.storage, @required this.builder});

  @override
  _DatabaseBuilderState createState() => _DatabaseBuilderState();
}

class _DatabaseBuilderState extends State<DatabaseBuilder> {
  Future<Storage> initialiseDB;

  @override
  void initState() {
    super.initState();
    initialiseDB = widget.storage.init();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Storage>(
      future: initialiseDB,
      builder: (BuildContext context, AsyncSnapshot<Storage> snapshot) => widget.builder(context, snapshot),
    );
  }
}
