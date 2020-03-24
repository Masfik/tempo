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
    List<Project> projects,
  }) {
    this._firstName = firstName;
    this._surname = surname;
    this._email = email;
    this._projects = projects ?? <Project>[];
  }

  User.fromAuthUser({@required AuthUser authUser}) {
    this._authUser = authUser;
    this._email = authUser.email;
  }

  factory User.fromJson(Map<String, dynamic> json) {
    List<Project> projects = <Project>[];
    if (json['projects'] != null)
      for (var project in json['projects']) projects.add(Project.fromJson(project));

    return User(
      firstName: json['first_name'] ?? json['firstName'],
      surname: json['surname'],
      email: json['email'],
      projects: projects,
    );
  }

  Map<String, dynamic> toJson() => _$UserToJson(this);

  loadFromJSON(Map<String, dynamic> json, {bool forceUpdate = false}) {
    if (!forceUpdate && _projects.isNotEmpty) return;

    _firstName = json['firstName'];
    _surname = json['surname'];

    if (json['projects'] != null) {
      List<Project> projects = [];
      for (var project in json['projects']) projects.add(Project.fromJson(project));
      _projects = projects;
      // Sets the first project as default active (General)
      _activeProject = _projects.first;
    }
    _team = json['team'];
    if (forceUpdate) notifyListeners();
  }

  /* GETTERS */

  AuthUser get authUser => _authUser;

  String get firstName => _firstName;

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

  /// Set surname
  set surname(String surname) {
    _surname = surname;
    notifyListeners();
  }

  set email(String email) => this._email = email.toLowerCase();

  set projects(List<Project> projects) {
    _projects = projects;
    notifyListeners();
  }

  /// Add a project to the [_projects] list
  addProject(Project project) {
    _projects.add(project);
    notifyListeners();
  }

  /// Delete a project from the [_projects] list
  deleteProject(Project project) {
    _projects.remove(project);
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
  deleteMeeting(Meeting meeting) => _meetings.remove(meeting);

  /// Converts [User] object to a [Map] for Database usage
  @override
  Map<String, dynamic> toDatabaseMap() => {
    'email': _email,
    'first_name': _firstName,
    'surname': _surname
  };
}
