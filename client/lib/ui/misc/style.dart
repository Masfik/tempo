import 'package:flutter/material.dart';

final kTempoThemeData = ThemeData(
  brightness: Brightness.dark,

  primaryColor: Color(0xFF3b4252),
  canvasColor: Color(0xFF434c5e),
  backgroundColor: Color(0xFF434c5e),
  accentColor: Color(0xFF5E81AC),
  toggleableActiveColor: Color(0xFF5E81AC),
  buttonColor: Color(0xFF5E81AC),

  cardColor: Color(0xFF434c5e),
  cardTheme: const CardTheme(
    elevation: 6,
    shape: kRoundedAllRectangleShape
  ),

  dialogBackgroundColor: Color(0xFF3b4252),
  dialogTheme: const DialogTheme(
    shape: kRoundedAllRectangleShape
  ),

  errorColor: Color(0xFFBF616A),
  disabledColor: Color(0xFF767b86),
);

const kCurvedEdgedRadius = Radius.circular(20);

const kRoundedAllRectangleShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(kCurvedEdgedRadius)
);

const kRoundedTopRectangleShape = RoundedRectangleBorder(
  borderRadius: BorderRadius.only(
    topRight: kCurvedEdgedRadius,
    topLeft: kCurvedEdgedRadius
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

const kInputLoginDecoration = InputDecoration(
  border: OutlineInputBorder(
    borderSide: BorderSide(width: 0, style: BorderStyle.none),
      borderRadius: BorderRadius.all(
        Radius.circular(30)
      )
  ),
  fillColor: Color(0xFF4c566a),
  filled: true,
);

const kInputAddDecoration = InputDecoration(
  border: OutlineInputBorder(),

  contentPadding: EdgeInsets.only(
    left: 20,
    right: 20
  ),
  counterText: '', // Disables characters counter label
);