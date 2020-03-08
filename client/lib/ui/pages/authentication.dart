import 'package:Tempo/models/user.dart';
import 'package:Tempo/services/api.dart';
import 'package:Tempo/ui/pages/login.dart';
import 'package:Tempo/ui/pages/main_content.dart';
import 'package:Tempo/ui/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthenticationScreen extends StatefulWidget {
  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  Future<Map<String, dynamic>> userData;

  @override
  void initState() {
    super.initState();
    userData = ApiService().fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    if (user == null) return LoginScreen();

    return FutureBuilder<Map<String, dynamic>>(
      future: userData,
      builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        LoadingIndicator child;
        if (snapshot.hasData) {
          user.loadFromJSON(snapshot.data);
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
    );
  }
}