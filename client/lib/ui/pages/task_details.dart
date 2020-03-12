import 'package:Tempo/models/task.dart';
import 'package:flutter/material.dart';

class TaskDetailsScreen extends StatefulWidget {
  /* final Project project;
  final Task task;
  final Function onStart;
  final Function onStop;

  TaskDetailsScreen({
    this.project,
    this.task,
    this.onStart,
    this.onStop
  }); */

  @override
  _TaskDetailsScreenState createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  Task task;
  String name;

  // Key for identifying the form itself
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Apollo 13'),
        leading: IconButton(
          icon: Icon(Icons.check),
          onPressed: () {
            if (_formKey.currentState.validate()) {
              try {
                task.name = name;
              } catch(e) {
                print(e);
              }
            }
          },
        ),
        actions: <Widget>[ IconButton(
        icon: Icon(Icons.close),
        onPressed: () => Navigator.pop(context),
      )],
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            TextFormField(
              onChanged: (value) => name = value,
              onFieldSubmitted: (value) => name = value,
              decoration: InputDecoration(
                labelText: 'Task Name',
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      )
    );
  }
}
