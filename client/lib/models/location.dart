import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:location/location.dart';

part 'location.g.dart';

@JsonSerializable()
class Location extends LatLng {
  @JsonKey(required: true)
  double latitude;

  @JsonKey(required: true)
  double longitude;

  Location(this.latitude, this.longitude) : super(latitude, longitude);

  Location.fromLocationData(LocationData data) : this(data.latitude, data.longitude);

  factory Location.fromJson(Map<String, dynamic> json) => _$LocationFromJson(json);

  Map<String, dynamic> toJson() => _$LocationToJson(this);
}