import 'package:Tempo/models/user.dart';
import 'package:Tempo/ui/widgets/meeting/meeting_list_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MeetingScreen extends StatefulWidget {
  @override
  _MeetingScreenState createState() => _MeetingScreenState();
}

class _MeetingScreenState extends State<MeetingScreen> {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Scheduled Meetings'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: MeetingListView(
              meetingCounter: user.meetings.length,
              meetings: user.meetings,
            ),
          )
        ],
      ),
    );
  }
}
