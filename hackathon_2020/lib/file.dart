

import 'package:flutter/material.dart';

import 'package:hackathon_2020/route1.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'eCommerce app',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        canvasColor: Colors.white,
        primarySwatch: Colors.blue,
        fontFamily: "Montserrat",
      ),
      home: FirstRoute(),
    );
  }
}
