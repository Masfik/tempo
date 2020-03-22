import 'package:Tempo/models/database_model.dart';
import 'package:Tempo/models/location.dart';
import 'package:Tempo/services/stopwatch.dart';
import 'package:Tempo/utils/input_exception.dart';
import 'package:json_annotation/json_annotation.dart';

part 'task.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Task with DatabaseModel, Identity {
  @JsonKey(required: true)
  int id;

  @JsonKey(required: true)
  String _name;

  @JsonKey(required: true, defaultValue: false)
  bool isDone = false;

  @JsonKey(ignore: true)
  final TempoStopwatch stopwatch = TempoStopwatch();

  @JsonKey(includeIfNull: false)
  Location location;

  Task({this.id, String name, this.isDone = false, this.location}) : this._name = name;

  factory Task.fromJson(Map<String, dynamic> json) {
    Task task = _$TaskFromJson(json);
    task.stopwatch.initialDuration = Duration(milliseconds: json['elapsed']);
    return task;
  }

  Map<String, dynamic> toJson() => _$TaskToJson(this);

  /* GETTERS */

  String get name => _name;

  /* SETTERS */

  set name(String value) {
    if (value != null && value.isNotEmpty)
      this._name = value;
    else
      throw InputException('Cannot create a task without a name!', 'name');
  }

  @override
  Map<String, dynamic> toDatabaseMap() => {
    'task_name': _name,
    'is_done': isDone ? 1 : 0,
    'elapsed': stopwatch.elapsedMilliseconds,
    'longitude': location.longitude,
    'latitude': location.latitude
  };
}
