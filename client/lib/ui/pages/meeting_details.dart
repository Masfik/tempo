import 'package:Tempo/models/meeting.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MeetingDetailsPage extends StatefulWidget {
  final Meeting meeting;

  MeetingDetailsPage(this.meeting);

  @override
  _MeetingDetailsPageState createState() => _MeetingDetailsPageState();
}

class _MeetingDetailsPageState extends State<MeetingDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.meeting.name)
      ),
      body: Column(
        children: <Widget>[
          Center(),
          Expanded(
            child: ListView(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.info),
                  title: Text('Meeting Name'),
                  subtitle: Text(widget.meeting.name),
                ),
                ListTile(
                  leading: Icon(Icons.date_range),
                  title: Text('Date'),
                  subtitle: Text(DateFormat('E d MMM, y').format(widget.meeting.dateFrom)),
                ),
                ListTile(
                  leading: Icon(Icons.access_time),
                  title: Text('Time'),
                  subtitle: Text(DateFormat('Hm').format(widget.meeting.endTime)),
                ),
                ListTile(
                  leading: Icon(Icons.location_city),
                  title: Text('Room'),
                  subtitle: Text(widget.meeting.room),
                ),
                ListTile(
                  leading: Icon(Icons.email),
                  title: Text('Organiser'),
                  subtitle: Text(widget.meeting.organiser.email),
                ),
              ],
            ),
          )
        ],
      )
    );
  }
}
