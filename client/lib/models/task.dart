import 'package:Tempo/utils/input_exception.dart';

class Task {
  String _name;
  bool _done = false;

  final Stopwatch stopwatch = new Stopwatch();

  String get name => _name;

  bool get done => _done;

  set name(String value) {
    if (value.isNotEmpty) this._name = value;
    else throw InputException('Cannot create a task without a name!', 'name');
  }

  set done(bool value) {
    _done = value;
  }

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
}