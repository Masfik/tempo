import 'package:Tempo/models/project.dart';
import 'package:Tempo/models/task.dart';
import 'package:flutter/material.dart';

class TaskDetailsScreen extends StatelessWidget {
  final Project project;
  final Task task;

  TaskDetailsScreen({@required this.project, @required this.task});

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
