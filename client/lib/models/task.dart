import 'package:Tempo/utils/input_exception.dart';

class Task {
  int _id;
  String _name;
  bool _isDone = false;
  final Stopwatch stopwatch = new Stopwatch();

  int get id => _id;
  String get name => _name;
  bool get isDone => _isDone;

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

  set name(String value) {
    if (value != null && value.isNotEmpty) this._name = value;
    else throw InputException('Cannot create a task without a name!', 'name');
  }

  set isDone(bool value) {
    _isDone = value;
  }
}