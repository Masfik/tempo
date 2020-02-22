import 'package:Tempo/utils/style.dart';
import 'package:Tempo/widgets/navigation_drawer.dart';
import 'package:Tempo/widgets/task/add_task.dart';
import 'package:Tempo/widgets/task/task_tile.dart';
import 'package:flutter/material.dart';

class MainContentScreen extends StatefulWidget {
  @override
  _MainContentScreenState createState() => _MainContentScreenState();
}

class _MainContentScreenState extends State<MainContentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tempo')),
      drawer: NavigationDrawer(),
      body: ListView(
        children: <Widget>[
          TaskTile(
            title: 'Task 1',
          ),
          TaskTile(
            title: 'Task 2',
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add Task',
        child: Icon(Icons.add),
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