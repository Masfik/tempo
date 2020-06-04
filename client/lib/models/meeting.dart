import 'package:Tempo/models/database_model.dart';
import 'package:Tempo/models/user.dart';
import 'package:Tempo/utils/input_exception.dart';
import 'package:json_annotation/json_annotation.dart';

class Meeting with DatabaseModel, Identity {
  int id;
  String _name;
  DateTime dateFrom;
  DateTime endTime;
  User organiser;
  List<User> people;
  String room;

  Meeting({
    this.id,
    String name,
    this.dateFrom,
    this.endTime,
    this.organiser,
    List<User> people,
    this.room
  }) {
    this._name = name;
    this.people = people ?? <User>[];
  }

  @JsonKey(name: 'meetingName')
  String get name => _name;

  set name(String value) {
    if (value.isNotEmpty) _name = value;
    else throw InputException("Cannot create a meeting without a name!", "name");
  }

  factory Meeting.fromJson(Map<String, dynamic> json) => Meeting(
    id: json['id'],
    name: json['meetingName'],
    dateFrom: json['meetingName'],
    endTime: json['meetingName'],
    organiser: User(email: json['organiser']),
    room: json['room']
  );

  Map<String, dynamic> toJson() => {
    'meetingName': this._name,
    'dateFrom': this.dateFrom.toIso8601String(),
    'endTime': this.endTime.toIso8601String(),
    'organiser': organiser.email,
    'room': this.room
  };

  @override
  Map<String, dynamic> toDatabaseMap() {
    // TODO: implement toDatabaseMap
    return null;
  }
}