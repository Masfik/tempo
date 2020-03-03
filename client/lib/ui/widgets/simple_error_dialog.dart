import 'package:flutter/material.dart';

class SimpleErrorDialog extends StatelessWidget {
  final String title;
  final String message;

  SimpleErrorDialog({@required this.title, @required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: <Widget>[
        FlatButton(
          child: const Text('CLOSE'),
          onPressed: () => Navigator.pop(context),
        )
      ],
    );
  }
}
