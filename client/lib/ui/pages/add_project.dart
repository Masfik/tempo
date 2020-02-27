import 'package:Tempo/models/project.dart';
import 'package:flutter/material.dart';

class AddProjectScreen extends StatefulWidget {
  @override
  _AddProjectScreenState createState() => _AddProjectScreenState();
}

class _AddProjectScreenState extends State<AddProjectScreen> {
  Project project = Project();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add a project"),
        leading: IconButton(
          icon: Icon(Icons.check),
          onPressed: () {

          },
        ),
      ),
      body: ListView(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              labelText: 'Project Name',
              contentPadding: EdgeInsets.only(
                left: 20,
                right: 20
              )
            )
          ),
          ListTile(
            leading: Icon(
              Icons.calendar_today,
            ),
            title: Text('Start Date'),
            onTap: () => showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(DateTime.now().year),
              lastDate: DateTime(DateTime.now().year + 20)
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.calendar_today,
            ),
            title: Text('Due Date'),
            onTap: () => showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(DateTime.now().year),
                lastDate: DateTime(DateTime.now().year + 20)
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.group_add,
            ),
            title: Text('Add People'),
          )
        ],
      )
    );
  }
}
