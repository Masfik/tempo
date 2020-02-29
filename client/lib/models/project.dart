import 'package:Tempo/models/task.dart';
import 'package:Tempo/models/team.dart';
import 'package:Tempo/models/user.dart';
import 'package:Tempo/utils/input_exception.dart';

class Project {
  String _name;
  DateTime _startDate;
  DateTime _dueDate;
  List<Task> _tasks = [];
  List<User> _people = [];
  List<Team> _team = [];

  List<User> get people => _people;

  set people(List<User> value) {
    _people = value;
  }

  set startDate(DateTime value) {
    _startDate = value;
  }

  String get name => _name;

  DateTime get startDate => _startDate;

  DateTime get dueDate => _dueDate;

  List<Task> get tasks => _tasks;

  set name(String value) {
    if (value != null && value.isNotEmpty) this._name = value;
    else throw InputException('Cannot create a project without a name!', 'name');
  }

  List<Team> get team => _team;

  set team(List<Team> value) {
    _team = value;
  }

  set dueDate(DateTime value) {
    _dueDate = value;
  }

  set tasks(List<Task> value) {
    _tasks = value;
  }
}
