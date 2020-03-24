import 'package:Tempo/models/task.dart';
import 'package:Tempo/ui/widgets/task/task_tile.dart';
import 'package:flutter/material.dart';

class TaskListView extends StatelessWidget {
  final int taskCounter;
  final List<Task> tasks;

  const TaskListView({
    Key key,
    @required this.taskCounter,
    @required this.tasks,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: taskCounter,
      itemBuilder: (context, index) =>
        TaskTile(
          task: tasks[index],
          key: Key(tasks[index].id.toString())
        ),
    );
  }
}
