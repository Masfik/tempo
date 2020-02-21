import 'package:Tempo/views/main_content.dart';
import 'package:Tempo/widgets/navigation_drawer.dart';
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
      home: Scaffold(
        appBar: AppBar(
          title: Text('Tempo')
        ),
        drawer: NavigationDrawer(),
        body: MainContent(),
        floatingActionButton: FloatingActionButton(
          tooltip: 'Add',
          child: Icon(Icons.add),
          onPressed: null,
        ),
      ),
    );
  }
}
