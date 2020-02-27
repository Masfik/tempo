import 'package:Tempo/models/task.dart';
import 'package:Tempo/utils/input_exception.dart';

class Project {
  String _name;
  DateTime _startDate;
  DateTime _dueDate;
  List<Task> _tasks = [];

  String get name => _name;

  DateTime get startDate => _startDate;

  DateTime get dueDate => _dueDate;

  List<Task> get tasks => _tasks;

  set name(String value) {
    if (value.isNotEmpty) this._name = value;
    else throw InputException('Cannot create a project without a name!', 'name');
  }

  set startDate(DateTime date) {
    if (date != null) this._startDate = date;
    else throw InputException('Cannot create a project without a start date!', 'startDate');
  }

  set dueDate(DateTime date) {
    if (date != null) this._dueDate = date;
    else throw InputException('Cannot create a project without a due date!', 'dueDate');
  }
}
