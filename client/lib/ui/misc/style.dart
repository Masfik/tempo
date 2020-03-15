import 'package:flutter/material.dart';

final kTempoThemeData = ThemeData(
  brightness: Brightness.dark,

  primaryColor: Color(0xFF3b4252),
  canvasColor: Color(0xFF434c5e),
  backgroundColor: Color(0xFF434c5e),
  dialogBackgroundColor: Color(0xFF3b4252),
  accentColor: Color(0xFF5E81AC),
  toggleableActiveColor: Color(0xFF5E81AC),
  buttonColor: Color(0xFF5E81AC),

  cardColor: Color(0xFF434c5e),
  cardTheme: CardTheme(
    elevation: 6,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(20))
    )
  ),

  errorColor: Color(0xFFBF616A),
  disabledColor: Color(0xFF767b86),
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