import 'dart:async';
import 'package:Tempo/models/location.dart';
import 'package:Tempo/models/task.dart';
import 'package:Tempo/repositories/localstorage/repository.dart';
import 'package:Tempo/services/location_service.dart';
import 'package:Tempo/ui/misc/style.dart';
import 'package:Tempo/ui/widgets/misc/loading.dart';
import 'package:Tempo/ui/widgets/task/no_location.dart';
import 'package:Tempo/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class TaskDetailsScreen extends StatefulWidget {
  final Task task;

  TaskDetailsScreen({@required this.task});

  @override
  _TaskDetailsScreenState createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  BuildContext context;
  // Task-related fields
  String taskName;
  Location location;
  // Location service
  bool isLoading = false;
  // Google Maps variables
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> markers = Set<Marker>();

  // Key for identifying the form
  final _formKey = GlobalKey<FormState>();

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
        title: Text(taskName),
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
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(height: 10),
                  TextFormField(
                    initialValue: widget.task.name,
                    onChanged: (value) => setState(() => taskName = value),
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
                      ? isLoading ? LoadingIndicator(type: LoadingType.loading) : NoLocation()
                      : GoogleMap(
                          mapType: MapType.normal,
                          markers: markers,
                          indoorViewEnabled: true,
                          initialCameraPosition: CameraPosition(
                            target: location,
                            zoom: 18,
                            tilt: 50
                          ),
                          onMapCreated: (controller) => _controller.complete(controller)
                        ),
                  ),
                  Text(
                    'Location',
                    style: kTextTitle.copyWith(fontSize: 30),
                  ),
                  RaisedButton(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const <Widget>[
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
    if (!_formKey.currentState.validate()) return;

    widget.task.name = taskName;
    widget.task.location = location;
    Provider.of<Repository<Task>>(context, listen: false).update(widget.task);
    Navigator.pop(context);
  }

  updateLocation() async {
    setState(() => isLoading = true);
    LatLng newLocation = await LocationService.getLocation(context);
    setState(() => isLoading = false);

    if (this.location == null) /* Simply assigns a value if the location hasn't been set */
      this.location = newLocation;
    else /* Updates the position of the camera since a location exists already */ {
      final GoogleMapController controller = await _controller.future;

      controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target: this.location = newLocation,
          zoom: 18,
          tilt: 50
        )
      ));
    }

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
