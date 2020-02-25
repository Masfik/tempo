import 'package:Tempo/models/user.dart';
import 'package:Tempo/utils/input_exception.dart';

class Team {
  String _name;
  List<User> _members;
  User _creator;

  Team(String name) {

  }

  // Getter
  List<User> get members => _members;

  User get creator => _creator;

  String get name => _name;

  // Setters
  set creator(User creator) {
    if (creator != null)
      _creator = creator;
    else
      throw ("Cannot set creator more than once!");
  }

  set members(User member) {
    if (member != null && members.contains(member)) _members.add(member);
  }

  set name(String value) {
    if(name.isNotEmpty) _name = value;
    else throw InputException("Cannot create a Team without a name!", "name");
  }
}
