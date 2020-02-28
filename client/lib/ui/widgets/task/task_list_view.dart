import 'package:Tempo/models/project.dart';
import 'package:Tempo/ui/widgets/task/task_tile.dart';
import 'package:flutter/material.dart';

class TaskListView extends StatelessWidget {
  const TaskListView({
    Key key,
    @required this.taskCounter,
    @required this.project,
  }) : super(key: key);

  final int taskCounter;
  final Project project;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: taskCounter,
      itemBuilder: (context, index) => TaskTile(task: project.tasks[index]),
    );
  }
}