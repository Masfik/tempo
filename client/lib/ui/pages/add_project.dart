import 'package:Tempo/models/project.dart';
import 'package:Tempo/models/team.dart';
import 'package:Tempo/models/user.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddProjectScreen extends StatefulWidget {
  @override
  _AddProjectScreenState createState() => _AddProjectScreenState();
}

class _AddProjectScreenState extends State<AddProjectScreen> {
  Project project = Project();
  String _name;
  DateTime _startDate;
  DateTime _dueDate;
  List<User> _people = [];
  List<Team> _team = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add a project"),
        leading: IconButton(
          icon: Icon(Icons.check),
          onPressed: () {
            project.name = _name;
            project.startDate = _startDate;
            project.dueDate = _dueDate;
            project.people = _people;
            project.team = _team;
          },
        ),
        actions: <Widget>[ IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        )],
      ),
      body: ListView(
        children: <Widget>[
          TextField(
            onChanged: (value) => _name = value,
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
            subtitle: Text(
                _startDate != null ? DateFormat('E d MMM, y').format(_startDate) : 'Select date'
            ),
            onTap: () => showCalendar(start: true),
          ),
          ListTile(
            leading: Icon(
              Icons.calendar_today,
            ),
            title: Text('Due Date'),
            subtitle: Text(
                _dueDate != null ? DateFormat('E d MMM, y').format(_dueDate) : 'Select date'
            ),
            onTap: () => showCalendar(start: false),
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

  Future showCalendar({@required bool start}) async {
    DateTime date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(DateTime.now().year + 20)
    );
    if (start == true) setState(() => _startDate = date);
    else setState(() => _dueDate = date);
  }
}
