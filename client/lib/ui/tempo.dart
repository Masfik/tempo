import 'package:Tempo/repositories/api/meeting_repository.dart';
import 'package:Tempo/services/api/user_data.dart';
import 'package:Tempo/services/authentication/auth_adapter.dart';
import 'package:Tempo/services/authentication/authentication.dart';
import 'package:Tempo/ui/misc/auth_stream_builder.dart';
import 'package:Tempo/ui/pages/home/add_meeting.dart';
import 'package:Tempo/ui/pages/add_project.dart';
import 'package:Tempo/ui/pages/authentication.dart';
import 'package:Tempo/ui/pages/login.dart';
import 'package:Tempo/ui/pages/home/home.dart';
import 'package:Tempo/ui/pages/scan_qr.dart';
import 'package:Tempo/ui/pages/settings.dart';
import 'package:Tempo/ui/pages/teams.dart';
import 'package:Tempo/ui/misc/style.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Tempo/ui/pages/register.dart';

class Tempo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(create: (context) => AuthServiceAdapter()),
        Provider<UserDataService>(create: (context) => UserDataService()), // <- TODO: create a layer of abstraction
        Provider<MeetingRepository>(create: (context) => MeetingRepository())
      ],
      child: AuthStreamBuilder(
        builder: (context, snapshot) {
          return MaterialApp(
            title: 'Tempo',
            theme: kTempoThemeData,
            home: AuthenticationScreen(authUserSnapshot: snapshot),
            routes: {
              '/home':        (context) => HomeScreen(),
              '/addproject':  (context) => AddProjectScreen(),
              '/addmeeting':  (context) => AddMeetingScreen(),
              '/team':        (context) => TeamsScreen(),
              '/scan':        (context) => ScanQrScreen(),
              '/login':       (context) => LoginScreen(),
              '/register':    (context) => RegisterScreen(),
              '/settings':    (context) => SettingsScreen(),
            },
          );
        },
      )
    );
  }
}