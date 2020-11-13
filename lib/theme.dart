import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

// Theme Data (hex format, precede with 0xff)
// Dark Blue:   0xff3A5067
final darkBlue = const Color(0xff3A5067);
// Light Blue:  0xff4D6275
final lightBlue = const Color(0xff4D6275);

final materialThemeData = ThemeData(
    // This is the theme of your application.
    //
    // Try running your application with "flutter run". You'll see the
    // application has a blue toolbar. Then, without quitting the app, try
    // changing the primarySwatch below to Colors.green and then invoke
    // "hot reload" (press "r" in the console where you ran "flutter run",
    // or simply save your changes to "hot reload" in a Flutter IDE).
    // Notice that the counter didn't reset back to zero; the application
    // is not restarted.
    primarySwatch: Colors.blue,
    // This makes the visual density adapt to the platform that you run
    // the app on. For desktop platforms, the controls will be smaller and
    // closer together (more dense) than on mobile platforms.
    visualDensity: VisualDensity.adaptivePlatformDensity,
    scaffoldBackgroundColor: Colors.white,
    accentColor: Colors.blue,
    appBarTheme: AppBarTheme(color: Colors.blue.shade600),
    primaryColor: Colors.blue,
    secondaryHeaderColor: Colors.blue,
    canvasColor: Colors.blue,
    backgroundColor: Colors.red,
    textTheme: TextTheme().copyWith(bodyText2: TextTheme().bodyText2));

final cupertinoTheme = CupertinoThemeData(
    primaryColor: lightBlue,
    barBackgroundColor: Colors.white,
    scaffoldBackgroundColor: lightBlue);

// Styles
final bottomNavTextStyle = TextStyle(color: Colors.white, fontSize: 14.0);
final toolbarButtonTextStyle = TextStyle(color: Colors.white, fontSize: 14.0);
final toolbarTextStyle = TextStyle(color: Colors.black, fontSize: 16.0);

