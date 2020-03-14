import 'package:Tempo/models/location.dart';
import 'package:Tempo/models/task.dart';
import 'package:Tempo/services/location/location_service.dart';
import 'package:Tempo/utils/constants.dart';
import 'package:flutter/material.dart';

class TaskDetailsScreen extends StatefulWidget {
  final Task task;

  TaskDetailsScreen({@required this.task});

  @override
  _TaskDetailsScreenState createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  BuildContext context;
  Location location;
  String taskName;

  // Key for identifying the form itself
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    this.context = context;
    this.location = widget.task.location;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task.name),
        leading: IconButton(
          icon: Icon(Icons.check),
          onPressed: submitChanges,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            SizedBox(height: 10),
            TextFormField(
              initialValue: widget.task.name,
              onChanged: (value) => taskName = value,
              onFieldSubmitted: (value) => taskName = value,
              decoration: InputDecoration(
                labelText: 'Task Name',
                contentPadding: EdgeInsets.only(left: 20, right: 20),
                counterText: '', // Disables characters counter label
              ),
              maxLines: 1,
              maxLength: 30,
              validator: kValidator,
            ),
            SizedBox(height: 10),
            RaisedButton(
              child: Text('Update location'),
              onPressed: () async => print((await LocationService.getLocation(context)).longitude)
            ),
          ],
        ),
      )
    );
  }

  submitChanges() {
    if (_formKey.currentState.validate()) {
      try {
        widget.task.name = taskName;
        Navigator.pop(context);
      } catch(e) {
        Navigator.pop(context);
      }
    }
  }
}
