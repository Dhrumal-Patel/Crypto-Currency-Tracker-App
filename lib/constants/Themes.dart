import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
 scaffoldBackgroundColor: Colors.white,
 textTheme: TextTheme(
  bodyText1: TextStyle()
 ).apply(
  displayColor: Colors.black,
 ),
  appBarTheme: AppBarTheme(
    elevation: 0,
    backgroundColor: Colors.white,
    iconTheme: IconThemeData(color: Colors.white)
  )
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Color(0xff15161a),
  appBarTheme: AppBarTheme(
    elevation: 0,    
    backgroundColor:  Color(0xff15161a),
  )
);