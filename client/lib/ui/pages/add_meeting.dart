import 'package:Tempo/models/location.dart';
import 'package:Tempo/models/meeting.dart';
import 'package:Tempo/models/user.dart';
import 'package:Tempo/ui/misc/style.dart';
import 'package:Tempo/ui/widgets/project/calendar_tile.dart';
import 'package:Tempo/utils/constants.dart';
import 'package:flutter/material.dart';
import 'add_people.dart';

class AddMeetingScreen extends StatefulWidget {
  @override
  _AddMeetingState createState() => _AddMeetingState();
}

class _AddMeetingState extends State<AddMeetingScreen> {
  Meeting meeting = Meeting();
  String name;
  DateTime dateFrom;
  DateTime endTime;
  List<User> guests = [];
  Location location;
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
                  /* CalendarTile(
                      title: 'Start Date',
                      date: dateFrom,
                      onTap: () => showCalendar(calendarType: CalendarType.start)
                  ),
                  /// TODO: ClockTile to select the endTime for the meeting
                  ListTile(
                    leading: const Icon(Icons.group_add),
                    title: const Text('Add Guests'),
                    onTap: () => showModalBottomSheet(
                        context: context,
                        shape: kRoundedRectangleShape,
                        builder: (context) => AddPeopleScreen()
                    ),
                  )*/
                ],
              ),
            ),
          ],
        ),
      ),
    );
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

