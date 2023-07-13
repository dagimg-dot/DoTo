import 'package:doto/pages/home_page.dart';
import 'package:doto/pages/splash_page.dart';
import 'package:flutter/material.dart';

import 'utils/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const ColorScheme colorScheme = ColorScheme(
      primary: primaryColor,
      secondary: secondaryColor,
      surface: Color(0xffffffff),
      background: Color(0xffe0e0e0),
      error: Color(0xffd32f2f),
      onPrimary: Color(0xffffffff),
      onSecondary: Color(0xffffffff),
      onSurface: Color(0xff000000),
      onBackground: Color(0xff000000),
      onError: Color(0xffffffff),
      brightness: Brightness.light,
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DoTo',
      theme: ThemeData(
          colorScheme: colorScheme,
          textTheme: TextTheme(
            titleMedium: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: colorScheme.onPrimary,
            ),
            titleSmall: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: colorScheme.onPrimary,
            ),
          )),
      home: const MyHomePage(),
    );
  }
}
