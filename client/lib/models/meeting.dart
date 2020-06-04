import 'package:Tempo/models/database_model.dart';
import 'package:Tempo/models/user.dart';
import 'package:Tempo/utils/input_exception.dart';

class Meeting with DatabaseModel, Identity {
  int id;
  String _name;
  DateTime dateFrom;
  DateTime endTime;
  User organiser;
  List<User> people;
  String room;
  String qrHash;

  Meeting({
    this.id,
    String name,
    this.dateFrom,
    this.endTime,
    this.organiser,
    List<User> people,
    this.room,
    this.qrHash
  }) {
    this._name = name;
    this.people = people ?? <User>[];
  }

  String get name => _name;

  set name(String value) {
    if (value.isNotEmpty) _name = value;
    else throw InputException("Cannot create a meeting without a name!", "name");
  }

  factory Meeting.fromJson(Map<String, dynamic> json) => Meeting(
    id: json['id'],
    name: json['meetingName'],
    dateFrom: DateTime.parse(json['dateFrom']),
    endTime: DateTime.parse(json['endTime']),
    organiser: User(email: json['organiser']),
    room: json['room'],
    qrHash: json['qrHash']
  );

  Map<String, dynamic> toJson() => {
    "meetingName": this._name,
    "dateFrom": this.dateFrom.toIso8601String(),
    "endTime": this.endTime.toIso8601String(),
    "organiser": organiser.email,
    "room": this.room,
    "qrHash": this.qrHash
  };

  @override
  Map<String, dynamic> toDatabaseMap() {
    // TODO: implement toDatabaseMap
    return null;
  }
}