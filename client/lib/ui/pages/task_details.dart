import 'dart:async';
import 'package:Tempo/models/location.dart';
import 'package:Tempo/models/task.dart';
import 'package:Tempo/services/location/location_service.dart';
import 'package:Tempo/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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

  // Google Maps variables
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

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
      body: SingleChildScrollView(
        child: Form(
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
                onPressed: () async => print((await LocationService.getLocation(context)))
              ),
              SizedBox(height: 10),
              Card(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 250,
                      child: GoogleMap(
                        mapType: MapType.normal,
                        initialCameraPosition: _kGooglePlex,
                        onMapCreated: (GoogleMapController controller) {
                          _controller.complete(controller);
                        }
                      ),
                    ),
                    Text('Location', )
                  ],
                ),
              )
            ],
          ),
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
