import 'package:Tempo/models/auth_user.dart';
import 'package:Tempo/models/database_model.dart';
import 'package:flutter/foundation.dart';
import 'dart:collection';
import 'package:Tempo/models/project.dart';
import 'package:Tempo/models/team.dart';
import 'package:Tempo/models/meeting.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class User with ChangeNotifier implements DatabaseModel {
  @JsonKey(ignore: true)
  AuthUser _authUser;

  @JsonKey(required: true, disallowNullValue: true)
  String _id;

  @JsonKey(required: true, disallowNullValue: true)
  String _firstName = 'Anonymous';

  @JsonKey(required: true, disallowNullValue: true)
  String _surname = 'User';

  @JsonKey(required: true, disallowNullValue: true)
  String _email = 'Not logged in';

  @JsonKey(required: true)
  List<Project> _projects = [];

  @JsonKey(ignore: true)
  Project _activeProject = Project(name: 'None');

  @JsonKey(includeIfNull: false)
  Team _team;

  List<Meeting> _meetings = [];

  User({
    String id = '0',
    String email = 'Not logged in',
  }) {
    this._id = id;
    this._email = email;
  }

  User.fromAuthUser({@required AuthUser authUser}) {
    this._authUser = authUser;
    this._id = authUser.id;
    this._email = authUser.email;
  }

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  loadFromJSON(Map<String, dynamic> json, {bool forceUpdate = false}) {
    if (!forceUpdate && _projects.isNotEmpty) return;

    _firstName = json['first_name'];
    _surname = json['surname'];

    List<Project> projects = [];
    for (dynamic project in json['projects']) projects.add(Project.fromJson(project));
    _projects = projects;
    // Sets the first project as default active (General)
    _activeProject = _projects.first;
    _team = json['team'];
    if (forceUpdate) notifyListeners();
  }

  /* GETTERS */

  AuthUser get authUser => _authUser;

  String get id => _id;

  String get firstName => _firstName;

  String get name => firstName;

  String get surname => _surname;

  String get fullName => '$_firstName $_surname';

  String get email => _email;

  UnmodifiableListView<Project> get projects => UnmodifiableListView(_projects);

  Project get activeProject => _activeProject;

  Team get team => _team;

  List<Meeting> get meetings => _meetings;

  /* SETTERS */

  /// Set first name
  set firstName(String name) {
    _firstName = name;
    notifyListeners();
  }

  /// Alias of the #firstName setter
  set name(String name) => firstName = name;

  /// Set surname
  set surname(String surname) {
    _surname = surname;
    notifyListeners();
  }

  /// Alias of the #surname setter
  set lastName(String lastName) => surname = lastName;

  addProject(Project project) {
    _projects.add(project);
    notifyListeners();
  }

  set activeProject(Project project) {
    _activeProject = project;
    notifyListeners();
  }

  addMeeting(Meeting meeting) => _meetings.add(meeting);

  @override
  User fromDatabaseMap() {
    // TODO: implement fromDatabaseMap
    return null;
  }

  @override
  Map<String, dynamic> toDatabaseMap() {
    // TODO: implement toDatabaseMap
    return null;
  }
}
