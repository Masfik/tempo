import 'package:Tempo/models/meeting.dart';
import 'package:flutter/material.dart';

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

    return Card(
      child: ListTile(
        title: Text(meeting.name),
        trailing: Text(meeting.dateFrom.toString()),
      ),
    );
  }
}
