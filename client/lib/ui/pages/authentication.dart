import 'package:Tempo/models/auth_user.dart';
import 'package:Tempo/ui/pages/login.dart';
import 'package:Tempo/ui/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'main_content.dart';

class AuthenticationScreen extends StatelessWidget {
  final AsyncSnapshot<AuthUser> authUserSnapshot;

  AuthenticationScreen({@required this.authUserSnapshot});

  @override
  Widget build(BuildContext context) {
    if (authUserSnapshot.connectionState == ConnectionState.active)
      return authUserSnapshot.hasData ? HomeScreen() : LoginScreen();

    return Scaffold(
      body: Center(
        child: LoadingIndicator(type: LoadingType.loading, message: 'Loading...')
      ),
    );

    /*User user = Provider.of<User>(context);
    if (user == null) return LoginScreen();

    LoadingIndicator child;
    // If the token is null, the data has not been loaded yet from the User model
    if (user.token != null) return TasksScreen();
    else child = LoadingIndicator(type: LoadingType.loading, message: 'Loading user data...');

    return Scaffold(
      body: Center(child: child),
    );*/

    /*return FutureBuilder<Map<String, dynamic>>(
      future: userData,
      builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        LoadingIndicator child;
        if (snapshot.hasData && user.token == null) {
          firebaseUser.getIdToken().then((result) {
            user.loadFromFirebase(firebaseUser);
            user.loadFromJSON(snapshot.data);
          });
          return TasksScreen();
        } else if (snapshot.hasError || (snapshot.connectionState == ConnectionState.done && snapshot.data == null)) {
          child = LoadingIndicator(
            type: LoadingType.error,
            message: 'Failed to fetch user data.',
            onRetry: () => setState(() {
              userData = ApiService().fetchUserData();
            }),
          );
        } else child = LoadingIndicator(type: LoadingType.loading, message: 'Loading user data...');

        return Scaffold(
          body: Center(
              child: child
          ),
        );
      },
    );*/
  }
}
