import 'package:Tempo/models/auth_user.dart';
import 'package:Tempo/models/project.dart';
import 'package:Tempo/models/user.dart';
import 'package:Tempo/services/authentication/authentication.dart';
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

        return MultiProvider(
          providers: [
            // Instantiates a User model based on the AuthUser obtained from the above StreamBuilder
            ChangeNotifierProvider<User>(
              create: (context) => User.fromAuthUser(
                authUser: authUser,
              ),
            ),
            ChangeNotifierProxyProvider<User, Project>(
              create: (context) => Project(name: 'Active Project'),
              update: (context, user, project) => project..updateWith(user.activeProject)
            )
          ],
          child: builder(context, snapshot),
        );
      },
    );
  }
}
