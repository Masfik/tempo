import 'dart:math';

import 'package:Tempo/models/project.dart';
import 'package:Tempo/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    return Consumer<User>(
      builder: (context, user, child) => Drawer(
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
              accountName: Text(user.fullName),
              accountEmail: Text(user.email),
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
                user.activeProject = user.projects.first;
                Navigator.pop(context);
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
              child: ListView.builder(
                padding: const EdgeInsets.all(0),
                itemCount: user.projects.length - 1,
                itemBuilder: (context, index) {
                  Project project = user.projects[index + 1];
                  return ListTile(
                    leading: Icon(Icons.layers),
                    title: Text(project.name),
                    onTap: () {
                      user.activeProject = project;
                      Navigator.pop(context);
                    }
                  );
                }
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
      ),
    );
  }
}