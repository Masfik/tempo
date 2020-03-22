import 'package:Tempo/models/user.dart';
import 'package:Tempo/utils/input_exception.dart';
import 'package:flutter/src/material/time.dart';

import 'location.dart';

class Meeting {
  String _name;
  DateTime dateFrom;
  TimeOfDay endTime;
  User _creator;
  List<User> _people;
  String _room;

  Meeting({
    String nme,
    this.dateFrom,
    this.endTime,
    User creator,
    List<User> people,
    String room
  }) {
    this._name = name;
    this._creator = creator;
    this._people = people;
    this._room = room;
  }

  String get name => _name;

  set room(String value) {
    _room = value;
  }

  set people(List<User> value) {
    _people = value;
  }

  set name(String value) {
    if(value.isNotEmpty) _name = value;
    else throw InputException("Cannot create a meeting without a name!", "name");
  }
}