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
        children: const <Widget>[
          const Icon(Icons.check, size: 150, color: Colors.grey),
          const Text('No tasks', style: const TextStyle(
              color: Colors.grey,
              fontSize: 30
          ))
        ],
      ),
    );
  }
}