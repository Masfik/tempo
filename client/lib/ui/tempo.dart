import 'package:Tempo/ui/pages/add_project.dart';
import 'package:Tempo/ui/pages/login.dart';
import 'package:Tempo/ui/pages/main_content.dart';
import 'package:Tempo/ui/pages/scan_qr.dart';
import 'package:Tempo/ui/pages/teams.dart';
import 'package:Tempo/ui/style.dart';
import 'package:flutter/material.dart';

class Tempo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tempo',
      theme: kTempoThemeData,
      initialRoute: '/',
      routes: {
        '/': (context) => MainContentScreen(),
        '/addproject': (context) => AddProjectScreen(),
        '/team': (context) => TeamsScreen(),
        '/scan': (context) => ScanQrScreen(),
        '/login': (context) => Login()
      },
    );
  }
}