class User {
  String _firstName;
  String _surname;
  String _email;
  List<Project> _project;
  Team _team;
  List<Meeting> _meetings;

  User(this._firstName, this._surname, this._email);
  addProject(Project project) => _project.add(project);
  addMeeting(Meeting meeting) => _Meeting.add(meeting);
}