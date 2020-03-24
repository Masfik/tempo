import 'package:flutter/material.dart';

class NoneAvailable extends StatelessWidget {
  final String text;
  final IconData icon;

  const NoneAvailable(this.text, this.icon);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(icon, size: 150, color: Theme.of(context).disabledColor),
          Text(text,
            style: TextStyle(
              color: Theme.of(context).disabledColor,
              fontSize: 30
            )
          )
        ],
      ),
    );
  }
}