import 'package:Tempo/models/meeting.dart';
import 'package:Tempo/models/user.dart';
import 'package:Tempo/ui/misc/style.dart';
import 'package:Tempo/ui/widgets/misc/calendar_tile.dart';
import 'package:Tempo/ui/widgets/misc/time_tile.dart';
import 'package:Tempo/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'add_people.dart';

enum TimeType {
  start,
  end
}

class AddMeetingScreen extends StatefulWidget {
  @override
  _AddMeetingState createState() => _AddMeetingState();
}

class _AddMeetingState extends State<AddMeetingScreen> {
  Meeting meeting = Meeting();
  String name;
  DateTime dateFrom;
  TimeOfDay startTime;
  TimeOfDay endTime;
  List<User> guests = [];
  /// TODO: Location or Room object for meeting
  // Key fo/r identifying the form itself
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Schedule a meeting'),
        leading: IconButton(
          icon: const Icon(Icons.check),
          onPressed: () {},
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
            const SizedBox(height: 10),
            TextFormField(
              autofocus: true,
              onChanged: (value) => name = value,
              decoration: kInputAddDecoration,
              validator: kValidator,
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: <Widget>[
                  CalendarTile(
                    title: 'Date of the meeting',
                    date: dateFrom,
                    onTap: () => showCalendar()
                  ),
                  TimeTile(
                    title: 'Start Time',
                    time: startTime,
                    onTap: () => showClock(timeType: TimeType.start),
                  ),
                  TimeTile(
                    title: 'End Time',
                    time: endTime,
                    onTap: () => showClock(timeType: TimeType.end),
                    enabled: startTime != null ? true : false,
                  ),
                  ListTile(
                    leading: const Icon(Icons.group_add),
                    title: const Text('Add Guests'),
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
      ),
    );
  }

  Future showCalendar() async {

    DateTime now = DateTime.now();
    now = DateTime(now.year, now.month, now.day);
    DateTime initialDate = now;

    DateTime date = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(initialDate.year),
        lastDate: DateTime(initialDate.year + 20),
        selectableDayPredicate: (DateTime dateTime) {

          if (dateTime.compareTo(initialDate) >= 0)
            return true;
          return false;
        }
    );
    // When the cancel button is pressed, the DateTime returned is null
    if (date != null) setState(() {
       dateFrom = date;
    });
  }

  Future showClock({@required TimeType timeType}) async {
    bool timeStartType = timeType == TimeType.start;

    TimeOfDay initialTime = timeStartType ? TimeOfDay.now() : startTime;

    TimeOfDay time = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );
    if (timeStartType) setState(() {
      // When the cancel button is pressed, the TimeOfDay returned is null
      if (time != null) startTime = time;
    });
    else setState(() {
      if (time != null) endTime = time;
    });
  }

   /* void submit() {
     if (_formKey.currentState.validate()) {
       try {
         if (startDate != null && dueDate == null) {
           showDialog(
               context: context,
               builder: (context) =>
                   SimpleErrorDialog(
                       title: 'Please, specify due date',
                       message: 'When a start date is given, a due date must also be specified.'
                   )
           );
           return;
         }

         meeting.name = name;
         meeting.dateFrom = dateFrom;
         meeting.endTime = endTime;
         meeting.guests = guests;
         meeting.location = location;
         /*project.people = people;
        project.team = team;*/

         Provider.of<User>(context, listen: false).addProject(project);
         Navigator.pop(context);
       } catch (e) {
         showDialog(
             context: context,
             builder: (context) =>
                 SimpleErrorDialog(
                     title: 'Error!',
                     message: e.message
                 )
         );
       }
     }
   }*/
}

