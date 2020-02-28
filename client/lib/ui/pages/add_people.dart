import 'package:Tempo/ui/widgets/team/member_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddPeopleScreen extends StatefulWidget {
  @override
  _AddPeopleScreenState createState() => _AddPeopleScreenState();
}

class _AddPeopleScreenState extends State<AddPeopleScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: TextField(
              textInputAction: TextInputAction.search,
              enableSuggestions: false,
              decoration: InputDecoration(
                labelText: 'Search people or teams'
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                MemberTile(
                  fullName: 'Name Surname',
                  identifier: 'Username',
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
