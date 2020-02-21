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
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
              currentAccountPicture: GestureDetector(
                child: Icon(
                  Icons.add_a_photo,
                  size: 50,
                  color: Colors.white,
                ),
                onTap: () {
                  // TODO: set avatar
                  Navigator.pop(context);
                },
              ),
              accountName: Text('Placeholder'),
              accountEmail: Text('name@domain.tld')),
          ListTile(
            leading: Icon(Icons.ac_unit),
            title: Text('Item 1'),
            onTap: () {
              // TODO: open page
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.accessibility),
            title: Text('Item 2'),
            onTap: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}
