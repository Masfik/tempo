import 'package:Tempo/models/database_model.dart';
import 'package:Tempo/models/location.dart';
import 'package:Tempo/services/stopwatch.dart';
import 'package:Tempo/utils/input_exception.dart';

class Task with DatabaseModel, Identity {
  int id;
  String _name;
  bool isDone;
  final TempoStopwatch stopwatch = TempoStopwatch();
  Location location;

  Task({this.id, String name, this.isDone = false, Duration initialDuration, this.location}) {
    this._name = name;
    this.stopwatch.initialDuration = initialDuration ?? Duration();
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['task_id'],
      name: json['task_name'],
      initialDuration: Duration(milliseconds: json['elapsed']),
      isDone: json['is_done'],
      location: json['latitude'] != null ? Location(json['latitude'], json['longitude']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'task_name': _name,
    'is_done': isDone,
    'elapsed': stopwatch.elapsedMilliseconds,
    'longitude': location.longitude,
    'latitude': location.latitude
  };

  /* GETTERS */

  String get name => _name;

  /* SETTERS */

  set name(String value) {
    if (value != null && value.isNotEmpty)
      this._name = value;
    else
      throw InputException('Cannot leave the name of the task empty!', 'name');
  }

  @override
  Map<String, dynamic> toDatabaseMap() => toJson();
}
