import 'package:Tempo/models/user.dart';
import 'package:Tempo/services/authentication/authentication.dart';
import 'package:Tempo/ui/misc/style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
            child: Center(
              child: Column(
                children: <Widget>[
                  CircleAvatar(
                    child: Image.asset('images/user.png'),
                    radius: 40,
                  ),
                  Text(
                    user.fullName,
                    style: kTextTitle
                  ),
                  Text(
                    user.email,
                    style: TextStyle(color: Colors.grey)
                  ),
                  SizedBox(height: 10),
                  RaisedButton(
                    child: Text('Sign Out'),
                    color: Theme.of(context).errorColor,
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    onPressed: () => Provider.of<AuthService>(context, listen: false).logout(),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
