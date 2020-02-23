import 'package:flutter/material.dart';

final kTempoThemeData = ThemeData(
  brightness: Brightness.dark,
  accentColor: Color(0xFF29a19c),
  backgroundColor: Color(0xFF435055),
  toggleableActiveColor: Color(0xFF29a19c)
);

const kRoundedRectangleShape = RoundedRectangleBorder(
  borderRadius: BorderRadius.only(
    topRight: Radius.circular(20),
    topLeft: Radius.circular(20)
  )
);