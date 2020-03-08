import 'package:Tempo/models/project.dart';
import 'package:Tempo/models/user.dart';
import 'package:Tempo/services/firebase_auth.dart';
import 'package:Tempo/ui/pages/add_project.dart';
import 'package:Tempo/ui/pages/authentication.dart';
import 'package:Tempo/ui/pages/login.dart';
import 'package:Tempo/ui/pages/main_content.dart';
import 'package:Tempo/ui/pages/scan_qr.dart';
import 'package:Tempo/ui/pages/teams.dart';
import 'package:Tempo/ui/misc/style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Tempo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<User>.value(
          value: FirebaseAuthService().onAuthStateChanged,
        ),
        ChangeNotifierProxyProvider<User, Project>(
          create: (context) => Project(name: 'Active Project'),
          update: (context, user, project) => project.updateWith = user.activeProject
        )
      ],
      child: MaterialApp(
        title: 'Tempo',
        theme: kTempoThemeData,
        home: AuthenticationScreen(),
        routes: {
          '/tasks': (context) => TasksScreen(),
          '/addproject': (context) => AddProjectScreen(),
          '/team': (context) => TeamsScreen(),
          '/scan': (context) => ScanQrScreen(),
          '/login': (context) => LoginScreen()
        },
      ),
    );
  }
}