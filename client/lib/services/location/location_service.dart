import 'package:Tempo/ui/widgets/simple_error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as geo;

class LocationService {
  static Future<LatLng> getLocation(BuildContext context) async {
    geo.Location location = geo.Location();

    if (!await location.serviceEnabled()) /* Checks if location service is enabled */ {
      if (!await location.requestService()) /* Requests user to enable location service */{
        showDialog(
          context: context,
          builder: (context) => SimpleErrorDialog(
            title: 'Location disabled',
            message: 'Please, enable location in order to use this functionality.'
          )
        );
        return null;
      }
    }

    if (await location.hasPermission() == geo.PermissionStatus.DENIED) /* Checks if permission is denied */ {
      if (await location.requestPermission() != geo.PermissionStatus.GRANTED) /* Requests permission */ {
        showDialog(
          context: context,
          builder: (context) => SimpleErrorDialog(
            title: 'Location permission',
            message: 'Please, give your location access permission if you want to use this functionality.'
          )
        );
        return null;
      }
    }

    geo.LocationData locationData = await location.getLocation();
    return LatLng(locationData.latitude, locationData.longitude);
  }
}