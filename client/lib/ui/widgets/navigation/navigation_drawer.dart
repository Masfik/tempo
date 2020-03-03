import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class NavigationDrawer extends StatefulWidget {
  const NavigationDrawer({
    Key key,
  }) : super(key: key);

  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          UserAccountsDrawerHeader(
            currentAccountPicture: GestureDetector(
              child: CircleAvatar(
                child: Image.asset('images/user.png'),
              ),
              onTap: () {
                // TODO: set avatar
                Navigator.pop(context);
              },
            ),
            accountName: Text('Placeholder'),
            accountEmail: Text('name@domain.tld'),
            otherAccountsPictures: <Widget>[
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {
                  Navigator.pop(context);
                } ,
              )
            ],
          ),
          ListTile(
            leading: const Icon(Icons.folder),
            title: const Text('General'),
            onTap: () {
              Navigator.pop(context);
              // TODO open general tasks
            },
          ),
          ListTile(
            leading: const Icon(Icons.group),
            title: const Text('Teams'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/team');
            },
          ),
          const Divider(color: Colors.black),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(0),
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.account_balance_wallet),
                  title: Text('Sample project name'),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.account_balance_wallet),
                  title: Text('Sample project name'),
                  onTap: () {},
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.playlist_add),
            title: const Text('ADD PROJECT'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/addproject');
            },
          )
        ],
      ),
    );
  }
}