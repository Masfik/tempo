import 'package:Tempo/ui/pages/add_people.dart';
import 'package:Tempo/ui/style.dart';
import 'package:flutter/material.dart';

class ShowTeamScreen extends StatefulWidget {
  @override
  _ShowTeamScreenState createState() => _ShowTeamScreenState();
}

class _ShowTeamScreenState extends State<ShowTeamScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Team Members')
      ),
      body: Column(
        children: <Widget>[
          FlatButton(
            child: Row(
              children: <Widget>[
                Icon(Icons.person_add),
                SizedBox(width: 10),
                Text('Add people')
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
                ListTile(
                  title: Text('Name Surname'),
                  subtitle: Text('@Username'),
                  leading: Image.asset('images/user.png', width: 40),
                  trailing: Text('Creator'),
                ),
                ListTile(
                  title: Text('Name Surname'),
                  subtitle: Text('@Username'),
                  leading: Image.asset('images/user.png', width: 40),
                  trailing: Text('Admin'),
                ),
                ListTile(
                  title: Text('Name Surname'),
                  subtitle: Text('@Username'),
                  leading: Image.asset('images/user.png', width: 40)
                ),
                ListTile(
                  title: Text('Name Surname'),
                  subtitle: Text('@Username'),
                  leading: Image.asset('images/user.png', width: 40)
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
