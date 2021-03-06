import 'package:Tempo/models/project.dart';
import 'package:Tempo/models/team.dart';
import 'package:Tempo/models/user.dart';
import 'package:Tempo/repositories/localstorage/repository.dart';
import 'package:Tempo/ui/pages/add_people.dart';
import 'package:Tempo/ui/misc/style.dart';
import 'package:Tempo/ui/widgets/misc/calendar_tile.dart';
import 'package:Tempo/ui/widgets/misc/simple_error_dialog.dart';
import 'package:Tempo/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

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
        title: const Text('Add a project'),
        leading: IconButton(
          icon: const Icon(Icons.check),
          onPressed: submit,
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context)
          )
        ],
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: TextFormField(
                autofocus: true,
                onChanged: (value) => name = value,
                decoration: kRoundedInputDecoration.copyWith(
                  hintText: 'Project Name',
                  prefixIcon: Icon(Icons.local_offer, color: Colors.white70)
                ),
                maxLines: 1,
                maxLength: 30,
                validator: kValidator,
              ),
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
                    leading: const Icon(Icons.group_add),
                    title: const Text('Add People'),
                    onTap: () => showModalBottomSheet(
                      context: context,
                      shape: kRoundedTopRectangleShape,
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

  void submit() async {
    if (_formKey.currentState.validate()) {
      try {
        if (startDate != null && dueDate == null) {
          showDialog(
            context: context,
            builder: (context) => SimpleErrorDialog(
              title: 'Please, specify due date',
              message: 'When a start date is given, a due date must also be specified.'
            )
          );
          return;
        }

        project.name = name;
        project.startDate = startDate;
        project.dueDate = dueDate;
        /*project.people = people;
        project.team = team;*/

        project = await Provider.of<Repository<Project>>(context, listen: false).add(project);
        Provider.of<User>(context, listen: false).addProject(project);
        Navigator.pop(context);
      } catch(e) {
        showDialog(
          context: context,
          builder: (context) => SimpleErrorDialog(
            title: 'Error!',
            message: e.message
          )
        );
      }
    }
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
      // When the cancel button is pressed, the DateTime returned is null
      if (date != null) {
        startDate = date;

        if (dueDate != null && dueDate.compareTo(startDate) <= 0)
          dueDate = null;
      }
    });
    else setState(() {
      if (date != null) dueDate = date;
    });
  }
}
