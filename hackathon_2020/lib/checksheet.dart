import 'package:flutter/material.dart';

class Checksheet extends StatelessWidget {
  final String type;
  Checksheet({this.type});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Checksheet',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0,
                // color: Colors.black,
                // fontFamily: 'IndieFlower'
              )),
          centerTitle: true,
          backgroundColor: Colors.blue[900],
        ),
        body: SafeArea(child: Container(child: Center(child: Text(type)))));
  }
}
