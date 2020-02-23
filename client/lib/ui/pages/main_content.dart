import 'package:Tempo/models/project.dart';
import 'package:Tempo/ui/style.dart';
import 'package:Tempo/ui/widgets/navigation_drawer.dart';
import 'package:Tempo/ui/pages/add_task.dart';
import 'package:Tempo/ui/widgets/task/task_tile.dart';
import 'package:flutter/material.dart';

class MainContentScreen extends StatefulWidget {
  @override
  _MainContentScreenState createState() => _MainContentScreenState();
}

class _MainContentScreenState extends State<MainContentScreen> {
  int taskCounter = 0;
  // TODO: Remove this sample project
  Project project = Project('General', DateTime(2020), DateTime(2020));

  void updateTasks() {
    setState(() => taskCounter++);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text('Tempo')),
      drawer: NavigationDrawer(),
      body: taskCounter == 0 ? NoTasks() : TastListView(taskCounter: taskCounter, project: project),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add Task',
        isExtended: true,
        child: Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            shape: kRoundedRectangleShape,
            builder: (context) => AddTask(
              project: project,
              callback: updateTasks,
            )
          );
        },
      ),
    );
  }
}

class NoTasks extends StatelessWidget {
  const NoTasks({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.check, size: 150, color: Colors.grey),
          Text('No tasks', style: TextStyle(
            color: Colors.grey,
            fontSize: 30
          ))
        ],
      ),
    );
  }
}

class TastListView extends StatelessWidget {
  const TastListView({
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