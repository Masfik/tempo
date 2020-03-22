import 'package:Tempo/models/auth_user.dart';
import 'package:Tempo/models/database_model.dart';
import 'package:flutter/foundation.dart';
import 'dart:collection';
import 'package:Tempo/models/project.dart';
import 'package:Tempo/models/team.dart';
import 'package:Tempo/models/meeting.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends ChangeNotifier with DatabaseModel {
  @JsonKey(ignore: true)
  AuthUser _authUser;

  @JsonKey(required: true, disallowNullValue: true)
  String _email;

  @JsonKey(required: true, disallowNullValue: true)
  String _firstName;

  @JsonKey(required: true, disallowNullValue: true)
  String _surname;

  List<Project> _projects = [];

  @JsonKey(ignore: true)
  Project _activeProject = Project(name: 'None');

  @JsonKey(includeIfNull: false)
  Team _team;

  List<Meeting> _meetings = [];

  User({
    String firstName = 'Anonymous',
    String surname = 'User',
    String email = 'Not logged in',
  }) {
    this._firstName = firstName;
    this._surname = surname;
    this._email = email;
  }

  User.fromAuthUser({@required AuthUser authUser}) {
    this._authUser = authUser;
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

  String get firstName => _firstName;

  String get name => firstName;

  String get surname => _surname;

  String get fullName => '$_firstName $_surname';

  String get email => _email.toLowerCase();

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

  /// Alias of the [firstName] setter
  set name(String name) => firstName = name;

  /// Set surname
  set surname(String surname) {
    _surname = surname;
    notifyListeners();
  }

  /// Alias of the [surname] setter
  set lastName(String lastName) => surname = lastName;

  /// Add a project to the [_projects] list
  addProject(Project project) {
    _projects.add(project);
    notifyListeners();
  }

  /// Set the active [project] (the current one being viewed by the user)
  set activeProject(Project project) {
    _activeProject = project;
    notifyListeners();
  }

  /// Add a new [Meeting] to the [meetings] list
  addMeeting(Meeting meeting) => _meetings.add(meeting);

  /// Remove an existing [Meeting] from the [meetings] list
  removeMeeting(Meeting meeting) => _meetings.remove(meeting);

  /// Converts [User] object to a [Map] for Database usage
  @override
  Map<String, dynamic> toDatabaseMap() => {
    'email': _email,
    'first_name': _firstName,
    'surname': _surname
  };
}
