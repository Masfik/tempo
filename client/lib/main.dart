import 'package:Tempo/ui/pages/add_project.dart';
import 'package:Tempo/ui/pages/main_content.dart';
import 'package:Tempo/ui/pages/scan_qr.dart';
import 'package:Tempo/ui/style.dart';
import 'package:flutter/material.dart';

void main() => runApp(Tempo());

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
        '/scan': (context) => ScanQrScreen()
      },
    );
  }
}
