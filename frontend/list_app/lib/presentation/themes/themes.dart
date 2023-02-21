import 'package:flutter/material.dart';

const Color primaryColor = Color(0xffFA8787);
const Color accentColor = Color(0xffFFE1E1);
const Color customGray1 = Color(0xffd9d9d9);




ThemeData getThemeData() => ThemeData(
  useMaterial3: true,
    textSelectionTheme: TextSelectionThemeData(
        cursorColor: primaryColor,
        selectionHandleColor: primaryColor,
        selectionColor: primaryColor,
    )
);

