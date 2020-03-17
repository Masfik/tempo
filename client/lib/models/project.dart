import 'dart:collection';
import 'package:Tempo/models/task.dart';
import 'package:Tempo/models/team.dart';
import 'package:Tempo/models/user.dart';
import 'package:Tempo/utils/input_exception.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'project.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Project with ChangeNotifier {
  @JsonKey(required: true, disallowNullValue: true)
  int _id;

  @JsonKey(required: true, disallowNullValue: true)
  String _name = 'None';

  DateTime _startDate;
  DateTime _dueDate;
  List<Task> _tasks = [];
  List<User> _people = [];
  List<Team> _team = [];

  Project({
    String name = 'None',
    DateTime startDate,
    DateTime dueDate
  }) {
    this._name = name;
    this._startDate = startDate;
    this._dueDate = dueDate;
  }

  factory Project.fromJson(Map<String, dynamic> json) => _$ProjectFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectToJson(this);

  updateWith(Project project) {
    if (project == null) return;
    _id = project._id;
    _name = project._name;
    _startDate = project._startDate;
    _dueDate = project._dueDate;
    _tasks = project._tasks;
    _people = project._people;
    _team = project._team;
    notifyListeners();
  }

  int get id => _id;

  String get name => _name;

  DateTime get startDate => _startDate;

  DateTime get dueDate => _dueDate;

  UnmodifiableListView<Task> get tasks => UnmodifiableListView(_tasks);

  UnmodifiableListView<User> get people => UnmodifiableListView(_people);

  List<Team> get team => UnmodifiableListView(_team);

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

  void addTask(Task task) {
    // Adds newest Task as first in the list
    _tasks.insert(0, task);
    notifyListeners();
  }

  void addPeople(List<User> people) {
    _people.addAll(people);
    notifyListeners();
  }

  void addTeams(List<Team> teams) {
    _team.addAll(teams);
    notifyListeners();
  }
}
