import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui';

import 'package:guatah/screens/home/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Map<int, Color> primaryColor =
      {
        50: const Color.fromRGBO(242,94,94, .1),
        100: const Color.fromRGBO(242,94,94, .2),
        200: const Color.fromRGBO(242,94,94, .3),
        300: const Color.fromRGBO(242,94,94, .4),
        400: const Color.fromRGBO(242,94,94, .5),
        500: const Color.fromRGBO(242,94,94, .6),
        600: const Color.fromRGBO(242,94,94, .7),
        700: const Color.fromRGBO(242,94,94, .8),
        800: const Color.fromRGBO(242,94,94, .9),
        900: const Color.fromRGBO(242,94,94, 1),
      };
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Guatá',
      theme: ThemeData(
        primarySwatch: MaterialColor(0xFFF25E5E, primaryColor),
        fontFamily: 'SourceSans3',
      ),
      home: HomePage(),
    );
  }
}

