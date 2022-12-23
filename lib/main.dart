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
        50:Color.fromRGBO(242,94,94, .1),
        100:Color.fromRGBO(242,94,94, .2),
        200:Color.fromRGBO(242,94,94, .3),
        300:Color.fromRGBO(242,94,94, .4),
        400:Color.fromRGBO(242,94,94, .5),
        500:Color.fromRGBO(242,94,94, .6),
        600:Color.fromRGBO(242,94,94, .7),
        700:Color.fromRGBO(242,94,94, .8),
        800:Color.fromRGBO(242,94,94, .9),
        900:Color.fromRGBO(242,94,94, 1),
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

