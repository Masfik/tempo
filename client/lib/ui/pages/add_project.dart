import 'package:Tempo/models/project.dart';
import 'package:Tempo/models/team.dart';
import 'package:Tempo/models/user.dart';
import 'package:Tempo/ui/pages/add_people.dart';
import 'package:Tempo/ui/style.dart';
import 'package:Tempo/ui/widgets/project/calendar_tile.dart';
import 'package:Tempo/utils/constants.dart';
import 'package:flutter/material.dart';

enum CalendarType {
  start,
  due
}

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
        title: Text('Add a project'),
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
              decoration: InputDecoration(
                labelText: 'Project Name',
                contentPadding: EdgeInsets.only(
                  left: 20,
                  right: 20
                )
              ),
              validator: kValidator
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  CalendarTile(
                    title: 'Start Date',
                    date: startDate,
                    onTap: () => showCalendar(calendarType: CalendarType.start)
                  ),
                  CalendarTile(
                    title: 'Due Date',
                    date: dueDate,
                    onTap: () => showCalendar(calendarType: CalendarType.due),
                    enabled: startDate != null ? true : false,
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.group_add,
                    ),
                    title: Text('Add People'),
                    onTap: () => showModalBottomSheet(
                      context: context,
                      shape: kRoundedRectangleShape,
                      builder: (context) => AddPeopleScreen()
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      )
    );
  }

  Future showCalendar({@required CalendarType calendarType}) async {
    bool calendarStartType = calendarType == CalendarType.start;

    DateTime now = DateTime.now();
    now = DateTime(now.year, now.month, now.day);
    DateTime initialDate = calendarStartType ? now : startDate;

    DateTime date = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(initialDate.year),
      lastDate: DateTime(initialDate.year + 20),
      selectableDayPredicate: (DateTime dateTime) {
        DateTime sanitisedNow = calendarStartType ? now : startDate;

        if (dateTime.compareTo(sanitisedNow) >= 0)
          return true;
        return false;
      }
    );
    if (calendarStartType) setState(() {
      if (date != null) {
        startDate = date;

        if (dueDate != null && dueDate.compareTo(startDate) <= 0)
          dueDate = null;
      }
    });
    else setState(() => dueDate = date);
  }
}
