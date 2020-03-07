import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'dart:collection';
import 'package:Tempo/models/project.dart';
import 'package:Tempo/models/team.dart';
import 'package:Tempo/models/meeting.dart';

class User with ChangeNotifier {
  FirebaseUser _firebaseUser;
  String _id;
  String token;
  String _firstName;
  String _surname;
  String _email;
  List<Project> _projects = [];
  Project _activeProject;
  Team _team;
  List<Meeting> _meetings;

  User({@required String id, @required String email}) {
    this._id = id;
    this._email = email;
  }

  User.fromFirebase(FirebaseUser firebaseUser) {
    this._firebaseUser = firebaseUser;
    this._id = firebaseUser.uid;
    this._email = firebaseUser.email;
  }

  loadFromJSON(Map<String, dynamic> json) {
    _firstName = json['first_name'];
    _surname = json['surname'];
    for (dynamic project in json['projects']) _projects.add(Project.fromJSON(project));
    // Sets the first project as default active (General)
    _activeProject = _projects.first;
    _team = json['team'];
    notifyListeners();
  }

  FirebaseUser get firebaseUser => _firebaseUser;

  String get id => _id;

  String get firstName => _firstName;

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

  // Might be unnecessary (will cause issues if sorting is ever implemented)
  set activeProjectByIndex(int index) => activeProject = _projects[index];

  addMeeting(Meeting meeting) => _meetings.add(meeting);
}
