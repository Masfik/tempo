import 'package:flutter/material.dart';

final kTempoThemeData = ThemeData(
  brightness: Brightness.dark,

  primaryColor: Colors.blueGrey[900],
  canvasColor: Colors.blueGrey[800],
  cardColor: Colors.blueGrey[800],
  accentColor: Color(0xFF29a19c),
  toggleableActiveColor: Color(0xFF29a19c)
);

const kRoundedRectangleShape = RoundedRectangleBorder(
  borderRadius: BorderRadius.only(
    topRight: Radius.circular(20),
    topLeft: Radius.circular(20)
  )
);

const kTextTitle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
  height: 2
);

const kTextNormal = TextStyle(
  height: 1.5
);