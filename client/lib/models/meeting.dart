import 'package:Tempo/models/database_model.dart';
import 'package:Tempo/models/user.dart';
import 'package:Tempo/utils/input_exception.dart';
import 'package:flutter/material.dart';

class Meeting with DatabaseModel, Identity {
  int id;
  String _name;
  DateTime dateFrom;
  TimeOfDay endTime;
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

  factory Meeting.fromJson(Map<String, dynamic> json) {
    List<String> endTime = (json['endTime'] as String).split(':'); // <- TODO: pretty hackish. Change it at some point.

    return Meeting(
        id: json['id'],
        name: json['meetingName'],
        dateFrom: DateTime.parse(json['dateFrom']),
        endTime: TimeOfDay(hour: int.parse(endTime[0]), minute: int.parse(endTime[1])),
        organiser: User(email: json['organiser']),
        room: json['room'],
        qrHash: json['qrHash']
    );
  }

  Map<String, dynamic> toJson() => {
    "meetingName": this._name,
    "dateFrom": this.dateFrom.toIso8601String(),
    "endTime": "${endTime.hour}:${endTime.minute}:00", // <- TODO: use a more generic way
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