import 'dart:async';
import 'package:Tempo/models/task.dart';
import 'package:Tempo/services/location/location_service.dart';
import 'package:Tempo/ui/misc/style.dart';
import 'package:Tempo/ui/widgets/task/no_location.dart';
import 'package:Tempo/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TaskDetailsScreen extends StatefulWidget {
  final Task task;

  TaskDetailsScreen({@required this.task});

  @override
  _TaskDetailsScreenState createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  BuildContext context;
  String taskName;
  LatLng location;
  // Key for identifying the form itself
  final _formKey = GlobalKey<FormState>();
  // Google Maps variables
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> markers = Set<Marker>();

  @override
  void initState() {
    super.initState();
    taskName = widget.task.name;

    if (widget.task.location != null) {
      location = widget.task.location;
      markers.add(
        Marker(
          markerId: MarkerId(widget.task.name),
          icon: BitmapDescriptor.defaultMarker,
          position: location
        )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget> [
            Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
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
                  )
                ],
              ),
            ),
            SizedBox(height: 10),
            Card(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 250,
                    child: location == null
                        ? NoLocation()
                        : GoogleMap(
                            mapType: MapType.normal,
                            markers: markers,
                            indoorViewEnabled: true,
                            initialCameraPosition: CameraPosition(
                              target: location,
                              zoom: 18,
                              tilt: 50
                            ),
                            onMapCreated: (GoogleMapController controller) {
                              _controller.complete(controller);
                            }
                          ),
                  ),
                  Text(
                    'Location',
                    style: kTextTitle.copyWith(
                      fontSize: 30
                    ),
                  ),
                  RaisedButton(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(Icons.map),
                        SizedBox(width: 10),
                        Text('Update location')
                      ],
                    ),
                    onPressed: updateLocation
                  ),
                ],
              ),
            )
          ]
        ),
      )
    );
  }

  submitChanges() {
    if (_formKey.currentState.validate())
      widget.task.name = taskName;

    widget.task.location = location;
    Navigator.pop(context);
  }

  updateLocation() async {
    LatLng newLocation = await LocationService.getLocation(context);

    if (this.location != null) {
      final GoogleMapController controller = await _controller.future;

      controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target: this.location = newLocation,
          zoom: 18,
          tilt: 50
        )
      ));
    } else this.location = newLocation;

    markers.clear();
    setState(() {
      markers.add(
        Marker(
          markerId: MarkerId(widget.task.name),
          icon: BitmapDescriptor.defaultMarker,
          position: newLocation
        )
      );
    });
  }
}
