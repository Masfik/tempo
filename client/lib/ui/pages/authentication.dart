import 'package:Tempo/models/user.dart';
import 'package:Tempo/ui/pages/login.dart';
import 'package:Tempo/ui/pages/main_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthenticationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (Provider.of<User>(context) == null) return Login();
    return TasksScreen();

    /*return FutureBuilder(
      future: FETCH USER DETAILS AND TASKS,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (!snapshot.hasError) {
            var data = snapshot.data;
          }
        }
        return Text('Error!');
      },
    );*/
  }
}
