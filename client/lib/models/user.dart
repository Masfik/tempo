import 'package:Tempo/models/auth_user.dart';
import 'package:Tempo/services/api/api.dart';
import 'package:flutter/foundation.dart';
import 'dart:collection';
import 'package:Tempo/models/project.dart';
import 'package:Tempo/models/team.dart';
import 'package:Tempo/models/meeting.dart';

class User {
  AuthUser _authUser;
  ApiService _service;
  String _token;

  String _id;
  String _firstName = 'Anonymous';
  String _surname = 'User';
  String _email = 'Not logged in';
  List<Project> _projects = [ Project(name: 'None') ];
  Project _activeProject = Project(name: 'None');
  Team _team;
  List<Meeting> _meetings = [];

  User({
    String id = '0',
    String email = 'Not logged in',
  }) {
    this._id = id;
    this._email = email;
    _loadUserData();
  }

  User.fromAuthService({@required AuthUser authUser, @required ApiService userDataService}) {
    this._authUser = authUser;
    this._id = authUser.id;
    this._email = authUser.email;
    this._service = userDataService;

    _loadUserData();
  }

  User fromApiService(ApiService service) {
    _service = service;
    return this;
  }

  _loadUserData() async {
    if (_authUser == null || _service == null) return;

    // Obtains the authentication token and assigns it to the token variable of both the User and Service
    _token = _service.token = await authUser.token;

    Map<String, dynamic> json = await _service.fetchData();

    _firstName = json['first_name'];
    _surname = json['surname'];

    List<Project> projects = [];
    for (dynamic project in json['projects']) projects.add(Project.fromJSON(project));
    _projects = projects;

    // Sets the first project as default active (General)
    _activeProject = _projects.first;
    _team = json['team'];
  }

  AuthUser get authUser => _authUser;

  String get token => _token;

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

  /// Set first name
  set firstName(String name) {
    _firstName = name;
  }

  /// Alias of the #firstName setter
  set name(String name) => firstName = name;

  /// Set surname
  set surname(String surname) {
    _surname = surname;
  }

  /// Alias of the #surname setter
  set lastName(String lastName) => surname = lastName;

  addProject(Project project) => _projects.add(project);

  set activeProject(Project project) {
    _activeProject = project;
  }

  // Might be unnecessary (will cause issues if sorting is ever implemented)
  set activeProjectByIndex(int index) => activeProject = _projects[index];

  addMeeting(Meeting meeting) => _meetings.add(meeting);
}
