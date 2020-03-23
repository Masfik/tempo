import 'dart:collection';
import 'package:Tempo/models/database_model.dart';
import 'package:Tempo/models/task.dart';
import 'package:Tempo/models/team.dart';
import 'package:Tempo/models/user.dart';
import 'package:Tempo/utils/input_exception.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'project.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Project extends ChangeNotifier with DatabaseModel, Identity {
  @JsonKey(required: true, disallowNullValue: true, name: 'project_id')
  int id;

  String _name;

  DateTime _startDate;
  DateTime _dueDate;
  List<Task> _tasks = [];
  List<User> _people = [];
  List<Team> _teams = [];

  Project({
    this.id,
    String name = 'None',
    DateTime startDate,
    DateTime dueDate,
    List<Task> tasks
  }) {
    this._name = name;
    this._startDate = startDate;
    this._dueDate = dueDate;
    this._tasks = tasks ?? [];
  }

  factory Project.fromJson(Map<String, dynamic> json) => _$ProjectFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectToJson(this);

  updateWith(Project project) {
    if (project == null) return;
    id = project.id;
    _name = project._name;
    _startDate = project._startDate;
    _dueDate = project._dueDate;
    _tasks = project._tasks;
    _people = project._people;
    _teams = project._teams;
    notifyListeners();
  }

  @JsonKey(required: true, disallowNullValue: true, name: 'project_name')
  String get name => _name;

  DateTime get startDate => _startDate;

  DateTime get dueDate => _dueDate;

  UnmodifiableListView<Task> get tasks => UnmodifiableListView(_tasks);

  UnmodifiableListView<User> get people => UnmodifiableListView(_people);

  List<Team> get teams => UnmodifiableListView(_teams);

  set name(String value) {
    if (value != null && value.isNotEmpty)  {
      if (_name == 'General')
        throw InputException('Cannot rename default "General" project.', 'name');

      this._name = value;
      notifyListeners();
    } else throw InputException('Cannot create a project without a name!', 'name');
  }

  set startDate(DateTime value) {
    _startDate = value;
    notifyListeners();
  }

  set dueDate(DateTime value) {
    _dueDate = value;
    notifyListeners();
  }

  set tasks(List<Task> tasks) {
    _tasks = tasks;
    notifyListeners();
  }

  void addTask(Task task) {
    // Adds newest Task as first in the list
    _tasks.insert(0, task);
    notifyListeners();
  }

  void removeTask(Task task) {
    _tasks.remove(task);
    notifyListeners();
  }

  void addPeople(List<User> people) {
    _people.addAll(people);
    notifyListeners();
  }

  void addTeam(List<Team> teams) {
    _teams.addAll(teams);
    notifyListeners();
  }

  @override
  Map<String, dynamic> toDatabaseMap() => {
    'project_name': _name,
    'start_date': _startDate?.toIso8601String(),
    'due_date': _dueDate?.toIso8601String()
  };
}
