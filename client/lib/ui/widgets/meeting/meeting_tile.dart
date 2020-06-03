import 'package:Tempo/models/meeting.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MeetingTile extends StatefulWidget {
  final Meeting meeting;

  const MeetingTile({this.meeting});

  @override
  _MeetingTileState createState() => _MeetingTileState();
}

class _MeetingTileState extends State<MeetingTile> {
  Meeting meeting;

  @override
  Widget build(BuildContext context) {
    meeting = widget.meeting;
    String date = DateFormat('E d MMM, y').format(meeting.dateFrom);
    String startTime = DateFormat('Hm').format(meeting.dateFrom);
    String endTime = DateFormat('Hm').format(meeting.endTime);

    return Card(
      child: ListTile(
        title: Text(meeting.name + '\n' + meeting.room),
        trailing: Text('$date \n $startTime - $endTime'),
      ),
    );
  }
}
