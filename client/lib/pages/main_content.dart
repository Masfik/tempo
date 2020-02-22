import 'package:Tempo/widgets/navigation_drawer.dart';
import 'package:Tempo/widgets/task/add_task.dart';
import 'package:flutter/material.dart';

class MainContentScreen extends StatefulWidget {
  @override
  _MainContentScreenState createState() => _MainContentScreenState();
}

class _MainContentScreenState extends State<MainContentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Tempo')
      ),
      drawer: NavigationDrawer(),
      body: Container(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text('1st column'),
                Text('2nd column'),
                Text('3rd column'),
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add Task',
        child: Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => AddTask()
          );
        },
      ),
    );
  }
}