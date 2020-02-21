import 'package:Tempo/pages/add_project.dart';
import 'package:Tempo/pages/main_content.dart';
import 'package:flutter/material.dart';

void main() => runApp(Tempo());

class Tempo extends StatefulWidget {
  @override
  _TempoState createState() => _TempoState();
}

class _TempoState extends State<Tempo> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tempo',
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MainContentScreen(),
        '/addproject': (context) => AddProjectScreen()
      },
    );
  }
}
