import 'dart:typed_data';
import 'package:Tempo/models/meeting.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class MeetingDetailsPage extends StatefulWidget {
  final Meeting meeting;

  MeetingDetailsPage(this.meeting);

  @override
  _MeetingDetailsPageState createState() => _MeetingDetailsPageState();
}

class _MeetingDetailsPageState extends State<MeetingDetailsPage> {
  Uint8List bytes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.meeting.name)
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Center(
              child: bytes == null
                ? RaisedButton(
                  color: Theme.of(context).accentColor,
                  child: Text("Show QR"),
                  onPressed: () async => scanner.generateBarCode(widget.meeting.qrHash)
                      .then((value) => setState(() => bytes = value))
                )
                : Image.memory(bytes, scale: 2,),
            )
          ),
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
