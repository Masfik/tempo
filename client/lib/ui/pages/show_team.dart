import 'package:flutter/cupertino.dart';
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
      body: ListView(
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
              // TODO
            },
          ),
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
    );
  }
}
