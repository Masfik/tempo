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
  String name;
  DateTime startDate;
  DateTime dueDate;
  List<User> people = [];
  List<Team> team = [];
  // Key for identifying the form itself
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add a project"),
        leading: IconButton(
          icon: Icon(Icons.check),
          onPressed: () {
            if (_formKey.currentState.validate()) {
              try {
                project.name = name;
                project.startDate = startDate;
                project.dueDate = dueDate;
                project.people = people;
                project.team = team;
              } catch(e) {

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
            TextFormField(
                onChanged: (value) => name = value,
                decoration: InputDecoration(
                    labelText: 'Project Name',
                    contentPadding: EdgeInsets.only(
                        left: 20,
                        right: 20
                    )
                ),
                validator: (value) {
                  if (value.isEmpty) return 'Please enter some text';
                  return null;
                }
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: Icon(
                      Icons.calendar_today,
                    ),
                    title: Text('Start Date'),
                    subtitle: Text(
                        startDate != null ? DateFormat('E d MMM, y').format(startDate) : 'Select date'
                    ),
                    onTap: () => showCalendar(start: true),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.calendar_today,
                    ),
                    title: Text('Due Date'),
                    subtitle: Text(
                        dueDate != null ? DateFormat('E d MMM, y').format(dueDate) : 'Select date'
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
              ),
            ),
          ],
        ),
      )
    );
  }

  Future showCalendar({@required bool start}) async {
    DateTime date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(DateTime.now().year + 20),
      selectableDayPredicate: (DateTime dateTime) {
        String tmpNow = DateTime.now().toString().substring(0, 10);
        String tmpDate = dateTime.toString().substring(0, 10);

        if (DateTime.parse(tmpDate).compareTo(DateTime.parse(tmpNow)) >= 0)
          return true;
        return false;
      }
    );
    if (start == true) setState(() => startDate = date);
    else setState(() => dueDate = date);
  }
}
