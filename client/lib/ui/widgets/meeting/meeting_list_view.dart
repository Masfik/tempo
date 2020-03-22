import 'package:Tempo/models/meeting.dart';
import 'package:flutter/material.dart';
import 'meeting_tile.dart';

class MeetingListView extends StatelessWidget {
  final int meetingCounter;
  final List<Meeting> meetings;

  const MeetingListView({
    @required this.meetingCounter,
    @required this.meetings
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: meetingCounter,
      itemBuilder: (context, index) =>
          MeetingTile(
            meeting: meetings[index],
          )
    );
  }
}
