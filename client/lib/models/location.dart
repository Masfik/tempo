import 'package:location/location.dart';

class Location {
  double latitude;
  double longitude;

  Location({this.latitude, this.longitude});

  Location.fromLocationData(LocationData locationData) {
    this.latitude = locationData.latitude;
    this.longitude = locationData.longitude;
  }
}
