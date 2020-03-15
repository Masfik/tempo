import 'package:Tempo/models/user.dart';
import 'package:Tempo/utils/input_exception.dart';

class Meeting {
  String _name;
  DateTime _date;
  DateTime _to;
  User _creator;
  List<User> _guests;

  Meeting({
    String name,
    DateTime date,
    DateTime to,
    User creator,
    List<User> guests
  }) {
    _name = name;
    _date = date;
    _to = to;
    _creator = creator;
    _guests = guests;
  }

  set name(String value) {
    if(value.isNotEmpty) _name = value;
    else throw InputException("Cannot create a meeting without a name!", "name");
  }
}