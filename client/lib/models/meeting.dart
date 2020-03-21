import 'package:Tempo/models/user.dart';
import 'package:Tempo/utils/input_exception.dart';
import 'package:flutter/src/material/time.dart';

import 'location.dart';

class Meeting {
  String _name;
  DateTime _date;
  TimeOfDay _endTime;
  User _creator;
  List<User> _people;
  String _room;

  Meeting({
    String name,
    DateTime date,
    TimeOfDay endTime,
    User creator,
    List<User> people,
    String room
  }) {
    this._name = name;
    this._date = date;
    this._endTime = endTime;
    this._creator = creator;
    this._people = people;
    this._room = room;
  }

  set room(String value) {
    _room = value;
  }

  set people(List<User> value) {
    _people = value;
  }

  set endTime(TimeOfDay value) {
    _endTime = value;
  }

  set date(DateTime value) {
    _date = value;
  }

  set name(String value) {
    if(value.isNotEmpty) _name = value;
    else throw InputException("Cannot create a meeting without a name!", "name");
  }
}