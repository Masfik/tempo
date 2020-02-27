import 'package:Tempo/models/project.dart';
import 'package:Tempo/models/task.dart';
import 'package:flutter/material.dart';

class TaskDetailsScreen extends StatelessWidget {
  final Project project;
  final Task task;
  final Function onStart;
  final Function onStop;

  TaskDetailsScreen({
    @required this.project,
    @required this.task,
    @required this.onStart,
    @required this.onStop
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(project.name),
      ),
      body: Container(
        child: Text('Task Details'),
      ),
    );
  }
}
