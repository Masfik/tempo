import 'package:flutter/material.dart';
import '../../../models/task.dart';
import '../../misc/style.dart';
import 'package:Tempo/ui/widgets/misc/none_available.dart';
import '../../widgets/task/task_list_view.dart';
import 'add_task.dart';

class TaskListScreen extends StatelessWidget {
  final List<Task> tasks;

  TaskListScreen(this.tasks);

  @override
  Widget build(BuildContext context) {
    return tasks.length == 0
        ? NoneAvailable('No tasks', Icons.check)
        : TaskListView(taskCounter: tasks.length, tasks: tasks);
  }

  static addTask(BuildContext context) => showModalBottomSheet(
    context: context,
    shape: kRoundedTopRectangleShape,
    builder: (context) => AddTask()
  );
}
