import 'package:Tempo/models/meeting.dart';
import 'package:Tempo/models/project.dart';
import 'package:Tempo/models/team.dart';

class User {
  String _firstName;
  String _surname;
  String _email;
  List<Project> _project;
  Team _team;
  List<Meeting> _meetings;

  User(this._firstName, this._surname, this._email);
  addProject(Project project) => _project.add(project);
  addMeeting(Meeting meeting) => _meetings.add(meeting);
}