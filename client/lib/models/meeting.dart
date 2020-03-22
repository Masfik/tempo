import 'package:Tempo/models/database_model.dart';
import 'package:Tempo/models/user.dart';
import 'package:Tempo/utils/input_exception.dart';
import 'package:flutter/material.dart';

class Meeting with DatabaseModel, Identity {
  int id;
  String _name;
  DateTime dateFrom;
  TimeOfDay endTime;
  User creator;
  List<User> people;
  String room;

  Meeting({
    this.id,
    String name,
    this.dateFrom,
    this.endTime,
    this.creator,
    List<User> people,
    this.room
  }) {
    this._name = name;
    this.people = people ?? <User>[];
  }

  String get name => _name;

  set name(String value) {
    if (value.isNotEmpty) _name = value;
    else throw InputException("Cannot create a meeting without a name!", "name");
  }



  @override
  Map<String, dynamic> toDatabaseMap() {
    // TODO: implement toDatabaseMap
    return null;
  }
}