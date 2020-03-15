import 'package:flutter/material.dart';

class NoLocation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Icon(
          Icons.map,
          size: 100,
          color: Theme.of(context).disabledColor
        ),
        Text(
          'No location added',
          style: TextStyle(
            fontSize: 15,
            color: Theme.of(context).disabledColor
          ),
        )
      ],
    );
  }
}
