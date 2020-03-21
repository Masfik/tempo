import 'package:Tempo/models/location.dart';
import 'package:Tempo/utils/input_exception.dart';
import 'package:json_annotation/json_annotation.dart';

part 'task.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Task {
  @JsonKey(required: true)
  int _id;

  @JsonKey(required: true)
  String _name;

  @JsonKey(required: true, defaultValue: false)
  bool isDone = false;

  @JsonKey(ignore: true)
  final Stopwatch stopwatch = new Stopwatch();

  @JsonKey(includeIfNull: false)
  Location location;

  Task({int id, String name}) : this._id = id, this._name = name;

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  Map<String, dynamic> toJson() => _$TaskToJson(this);

  /* GETTERS */

  int get id => _id;

  String get name => _name;

  String get formattedDuration {
    final Duration duration = this.stopwatch.elapsed;
    if (duration == null) throw "The stopwatch hasn't been initialised! Make sure to start it at least once.";

    String twoDigits(int number) {
      if (number >= 10) return '$number';
      return '0$number';
    }

    return  '${twoDigits(duration.inHours)}:'
            '${twoDigits(duration.inMinutes.remainder(60))}:'
            '${twoDigits(duration.inSeconds.remainder(60))}';
  }

  /* SETTERS */

  set name(String value) {
    if (value != null && value.isNotEmpty)
      this._name = value;
    else
      throw InputException('Cannot create a task without a name!', 'name');
  }
}
