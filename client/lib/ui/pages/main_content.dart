import 'package:Tempo/models/project.dart';
import 'package:Tempo/models/user.dart';
import 'package:Tempo/ui/misc/style.dart';
import 'package:Tempo/ui/widgets/navigation/actions_menu.dart';
import 'package:Tempo/ui/widgets/navigation/navigation_drawer.dart';
import 'package:Tempo/ui/pages/add_task.dart';
import 'package:Tempo/ui/widgets/task/no_task.dart';
import 'package:Tempo/ui/widgets/task/task_list_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TasksScreen extends StatefulWidget {
  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  @override
  Widget build(BuildContext context) {
    Project project = Provider.of<Project>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(project.name),
        actions: [ ActionsMenu() ],
      ),
      drawer: const NavigationDrawer(),
      body: project.tasks.length == 0
          ? NoTasks()
          : TaskListView(taskCounter: project.tasks.length, tasks: project.tasks),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add Task',
        isExtended: true,
        child: const Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
              context: context,
              shape: kRoundedRectangleShape,
              builder: (context) => AddTask()
          );
        },
      ),
    );
  }
}