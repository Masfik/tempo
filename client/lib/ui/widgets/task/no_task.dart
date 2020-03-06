import 'package:flutter/material.dart';

class NoTasks extends StatelessWidget {
  const NoTasks({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.check, size: 150, color: Theme.of(context).disabledColor),
          Text('No tasks', style: TextStyle(
            color: Theme.of(context).disabledColor,
            fontSize: 30
          ))
        ],
      ),
    );
  }
}