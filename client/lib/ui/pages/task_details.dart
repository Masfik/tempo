import 'package:Tempo/models/project.dart';
import 'package:Tempo/models/task.dart';
import 'package:flutter/material.dart';

class TaskDetailsScreen extends StatefulWidget {
  /* final Project project;
  final Task task;
  final Function onStart;
  final Function onStop;

  TaskDetailsScreen({
    this.project,
    this.task,
    this.onStart,
    this.onStop
  }); */

  @override
  _TaskDetailsScreen createState() => _TaskDetailsScreen();
}

class _TaskDetailsScreen extends State<TaskDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Apollo 13'),
      ),
      body: Text('Dickbutt'),
    );
  }
}
