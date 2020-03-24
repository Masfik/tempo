import 'package:Tempo/models/user.dart';
import 'package:Tempo/ui/widgets/meeting/meeting_list_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Tempo/ui/widgets/misc/none_available.dart';
import '../../../models/meeting.dart';

class MeetingListScreen extends StatefulWidget {
  @override
  _MeetingListScreenState createState() => _MeetingListScreenState();
}

class _MeetingListScreenState extends State<MeetingListScreen> {
  @override
  Widget build(BuildContext context) {
    List<Meeting> meetings = Provider.of<User>(context).meetings;
    return meetings.length == 0
        ? NoneAvailable('No meetings', Icons.schedule)
        : MeetingListView(meetingCounter: meetings.length, meetings: meetings);
  }
}
