import 'package:Tempo/models/team.dart';
import 'package:Tempo/models/user.dart';
import 'package:Tempo/utils/input_exception.dart';

class Meeting {
  String _name;
  DateTime _date;
  DateTime _to;
  User _creator;
  List<Team> _guests;

  Meeting(this._name, this._date, this._to, this._creator, this._guests);

  set name(String value) {
    if(value.isNotEmpty) _name = value;
    else throw InputException("Cannot create a Team without a name!", "name");
  }
}