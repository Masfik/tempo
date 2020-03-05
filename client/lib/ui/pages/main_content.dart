import 'package:Tempo/models/project.dart';
import 'package:Tempo/ui/style.dart';
import 'package:Tempo/ui/widgets/navigation/actions_menu.dart';
import 'package:Tempo/ui/widgets/navigation/navigation_drawer.dart';
import 'package:Tempo/ui/pages/add_task.dart';
import 'package:Tempo/ui/widgets/task/no_task.dart';
import 'package:Tempo/ui/widgets/task/task_list_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainContentScreen extends StatefulWidget {
  @override
  _MainContentScreenState createState() => _MainContentScreenState();
}

class _MainContentScreenState extends State<MainContentScreen> {
  int taskCounter = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Project>(
      builder: (context, project, child) => Scaffold(
        appBar: AppBar(
          title: Text(project.name),
          actions: [ ActionsMenu() ],
        ),
        drawer: const NavigationDrawer(),
        body: project.tasks.length == 0 ? NoTasks() : TaskListView(taskCounter: project.tasks.length, tasks: project.tasks),
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
      ),
    );
  }

  void _updateTasks() {
    setState(() => taskCounter++);
  }
}