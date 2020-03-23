import 'package:Tempo/models/meeting.dart';
import 'package:Tempo/models/user.dart';
import 'package:Tempo/ui/misc/style.dart';
import 'package:Tempo/ui/pages/meeting_list.dart';
import 'package:Tempo/ui/widgets/meeting/meeting_list_view.dart';
import 'package:Tempo/ui/widgets/misc/calendar_tile.dart';
import 'package:Tempo/ui/widgets/misc/simple_error_dialog.dart';
import 'package:Tempo/ui/widgets/misc/time_tile.dart';
import 'package:Tempo/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
  List<User> people = [];
  String room;
  // Key for identifying the form itself
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Schedule a meeting'),
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
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(5),
              child: TextFormField(
                autofocus: true,
                onChanged: (value) => name = value,
                decoration: kInputAddDecoration.copyWith(
                  labelText: 'Subject of the Meeting',
                  prefixIcon: Icon(Icons.local_offer)
                ),
                validator: kValidator,
              ),
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
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: TextFormField(
                      onChanged: (value) => room = value,
                      decoration: kInputAddDecoration.copyWith(
                          labelText: 'Meeting Room',
                          prefixIcon: Icon(Icons.room)
                      ),
                      validator: kValidator,
                    ),
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

   void submit() {
     if (_formKey.currentState.validate()) {
       try {
         if (startTime != null && endTime == null) {
           showDialog(
               context: context,
               builder: (context) =>
                   SimpleErrorDialog(
                       title: 'Please, specify end Time',
                       message: 'When a start time is given, an end time must also be specified.'
                   )
           );
           return;
         }

         dateFrom = DateTime(
             dateFrom.year,
             dateFrom.month,
             dateFrom.day,
             startTime.hour,
             startTime.minute
         );
         
         meeting.name = name;
         meeting.dateFrom = dateFrom;
         meeting.endTime = endTime;
         meeting.people = people;
         meeting.room = room;
         meeting.people = people;

         Provider.of<User>(context, listen: false).addMeeting(meeting);
         Navigator.pop(context);
         Navigator.push(
             context,
             MaterialPageRoute(
                 builder: (context) => MeetingListScreen()
             )
         );
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
   }
}

