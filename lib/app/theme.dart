import 'package:flutter/material.dart';

//Dark theme
final darkTheme = ThemeData(
  scaffoldBackgroundColor: Color(0xff1E1E1E),
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xffFED36A),
    titleTextStyle: TextStyle(
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.w900,
      color: Colors.black,
      fontSize: 20,
    ),
  ),
  dividerColor: Colors.white,
  //floating action button theme
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Color(0xffFED36A),
    foregroundColor: Colors.black,
  ),
  //container theme
  cardColor: Color(0xff455A64),

  //icon theme
  iconTheme: IconThemeData(color: Colors.white),
);

//Light theme
final lightTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    titleTextStyle: TextStyle(
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.w900,
      color: Colors.black,
    ),
  ),
);

//
