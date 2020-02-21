import 'package:Tempo/utils/input_exception.dart';

class Task {
  String _name;
  final Stopwatch stopwatch = new Stopwatch();

  Task(this._name);

  String get name => _name;

  set name(String value) {
    if (value.isNotEmpty) this._name = value;
    else throw InputException('Cannot create a task without a name!', 'name');
  }
}