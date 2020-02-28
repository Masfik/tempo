import 'package:Tempo/models/meeting.dart';
import 'package:Tempo/models/project.dart';
import 'package:Tempo/models/team.dart';

class User {
  String _id;
  String _firstName;
  String _surname;
  String _email;
  List<Project> _projects;
  Team _team;
  List<Meeting> _meetings;

  User(this._firstName, this._surname, this._email);

  String get id => _id;
  String get firstName => _firstName;
  String get surname => _surname;
  String get email => _email;
  List<Project> get projects => _projects;
  Team get team => _team;
  List<Meeting> get meetings => _meetings;

  addProject(Project project) => _projects.add(project);
  addMeeting(Meeting meeting) => _meetings.add(meeting);
}