import 'package:Tempo/models/team.dart';
import 'package:Tempo/ui/pages/add_people.dart';
import 'package:Tempo/ui/misc/style.dart';
import 'package:Tempo/ui/widgets/team/member_tile.dart';
import 'package:flutter/material.dart';

class ShowCurrentTeam extends StatefulWidget {
  @override
  _ShowCurrentTeamState createState() => _ShowCurrentTeamState();
}

class _ShowCurrentTeamState extends State<ShowCurrentTeam> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Team Members')
      ),
      body: Column(
        children: <Widget>[
          FlatButton(
            child: Row(
              children: const <Widget>[
                const Icon(Icons.person_add),
                const SizedBox(width: 10),
                const Text('Add people')
              ],
            ),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                shape: kRoundedRectangleShape,
                builder: (context) => AddPeopleScreen()
              );
            },
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                MemberTile(
                  fullName: 'Name Surname',
                  identifier: 'Username',
                  memberType: MemberRank.creator
                ),
                MemberTile(
                  fullName: 'Name Surname',
                  identifier: 'Username',
                  memberType: MemberRank.admin
                ),
                MemberTile(
                  fullName: 'Name Surname',
                  identifier: 'Username',
                ),
                MemberTile(
                  fullName: 'Name Surname',
                  identifier: 'Username',
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
