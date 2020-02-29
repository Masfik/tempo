import 'package:Tempo/models/user.dart';
import 'package:Tempo/utils/input_exception.dart';

enum MemberRank {
  creator,
  admin,
  none
}

class Team {
  String _name;
  List<User> _members;
  User _creator;

  Team(this._name);

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

  addMember(User member) {
    if (member != null && _members.contains(member)) _members.add(member);
  }

  set name(String value) {
    if (value != null && value.isNotEmpty) _name = value;
    else throw InputException("Cannot create a team without a name!", "name");
  }
}
