import 'package:Tempo/services/api/api.dart';
import 'package:Tempo/services/api/user_data_adapter.dart';
import 'package:Tempo/services/authentication/auth_adapter.dart';
import 'package:Tempo/services/authentication/authentication.dart';
import 'package:Tempo/ui/misc/auth_stream_builder.dart';
import 'package:Tempo/ui/pages/add_project.dart';
import 'package:Tempo/ui/pages/authentication.dart';
import 'package:Tempo/ui/pages/login.dart';
import 'package:Tempo/ui/pages/main_content.dart';
import 'package:Tempo/ui/pages/scan_qr.dart';
import 'package:Tempo/ui/pages/settings.dart';
import 'package:Tempo/ui/pages/teams.dart';
import 'package:Tempo/ui/misc/style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Tempo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(create: (context) => AuthServiceAdapter()),
        Provider<ApiService>(create:  (context) => UserDataServiceAdapter())
      ],
      child: AuthStreamBuilder(
        builder: (context, snapshot) {
          return MaterialApp(
            title: 'Tempo',
            theme: kTempoThemeData,
            home: AuthenticationScreen(authUserSnapshot: snapshot),
            routes: {
              '/tasks':       (context) => HomeScreen(),
              '/addproject':  (context) => AddProjectScreen(),
              '/team':        (context) => TeamsScreen(),
              '/scan':        (context) => ScanQrScreen(),
              '/login':       (context) => LoginScreen(),
              '/settings':    (context) => SettingsScreen()
            },
          );
        },
      )
    );
  }
}