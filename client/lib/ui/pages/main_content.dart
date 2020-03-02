import 'package:Tempo/models/project.dart';
import 'package:Tempo/ui/style.dart';
import 'package:Tempo/ui/widgets/navigation/actions_menu.dart';
import 'package:Tempo/ui/widgets/navigation/navigation_drawer.dart';
import 'package:Tempo/ui/pages/add_task.dart';
import 'package:Tempo/ui/widgets/task/no_task.dart';
import 'package:Tempo/ui/widgets/task/task_list_view.dart';
import 'package:flutter/material.dart';

class MainContentScreen extends StatefulWidget {
  @override
  _MainContentScreenState createState() => _MainContentScreenState();
}

class _MainContentScreenState extends State<MainContentScreen> {
  int taskCounter = 0;
  Project project = Project();

  @override
  void initState() {
    super.initState();

    // TODO: Remove this sample project
    project.name = 'General';
    project.startDate = DateTime(2020);
    project.dueDate = DateTime(2020);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(project.name),
        actions: [ ActionsMenu() ],
      ),
      drawer: const NavigationDrawer(),
      body: taskCounter == 0 ? NoTasks() : TaskListView(taskCounter: taskCounter, tasks: project.tasks),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add Task',
        isExtended: true,
        child: const Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            shape: kRoundedRectangleShape,
            builder: (context) => AddTask(
              project: project,
              onSubmit: _updateTasks,
            )
          );
        },
      ),
    );
  }

  void _updateTasks() {
    setState(() => taskCounter++);
  }
}