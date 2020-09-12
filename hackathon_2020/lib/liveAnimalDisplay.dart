import 'dart:io';

import 'package:flutter/material.dart';

import 'checksheet.dart';
import 'package:hackathon_2020/shipmentForm.dart';
import 'package:hackathon_2020/models/shipment.dart';

class LiveAnimalDisplay extends StatelessWidget {
  final File image;
  final String type;
  LiveAnimalDisplay({this.image, this.type});

  @override
  Widget build(BuildContext context) {
    final List cat = ["Cat", "Persian", "Ginger", "Domestic"];
    final List dog = ["Dog", "Pug", "Brown", "Domestic"];
    final List animal = (type == "Cat") ? cat : dog;
    return Scaffold(
        appBar: AppBar(
          title: Text('Live Animal Details',
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
        body: SafeArea(
            child: Container(
                child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Stack(
                alignment: Alignment.center,
                overflow: Overflow.visible,
                children: [
                  CircleAvatar(
                    backgroundImage: FileImage(image),
                    radius: 80.0,
                  ),
                  Positioned(
                      top: 40,
                      right: 140,
                      bottom: 100,
                      left: -50,
                      child: Container(
                        child: Center(
                            child: Text(animal[0],
                                style: TextStyle(color: Colors.white))),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.green,
                        ),
                      )),
                  Positioned(
                      top: 40,
                      right: -50,
                      bottom: 100,
                      left: 140,
                      child: Container(
                        child: Center(
                            child: Text(animal[1],
                                style: TextStyle(color: Colors.white))),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.green,
                        ),
                      )),
                  Positioned(
                      top: 100,
                      right: -50,
                      bottom: 40,
                      left: 140,
                      child: Container(
                        child: Center(
                            child: Text(animal[2],
                                style: TextStyle(color: Colors.white))),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.green,
                        ),
                      )),
                  Positioned(
                      top: 100,
                      right: 140,
                      bottom: 40,
                      left: -50,
                      child: Container(
                        child: Center(
                            child: Text(animal[3],
                                style: TextStyle(color: Colors.white))),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.green,
                        ),
                      ))
                ],
              ),
              RaisedButton(
                  color: Colors.blue[900],
                  textColor: Colors.white,
                  onPressed: () {
                    // Navigate to second route when tapped.
                    Navigator.push(
                      context,
                      /* MaterialPageRoute(builder: (context) => new FlightList(shipmentInfo: new Shipment("FRA","Frankfurt, Germany","HKG","Hong Kong, China", 1, 100,"AVI",new DateTime(2020,09,12)))),*/

                      MaterialPageRoute(
                          builder: (context) => new ShipmentDetailsCaptureForm(
                              shipmentState: new Shipment("","", "","", 0, "KG",0,type,DateTime.now(),
                                  0,0,0,"CM","MC",0,""))),
                      //MaterialPageRoute(builder: (context) => new SampleFormPage()),
                    );
                  },
                  child: Text("Ok"))
            ],
          ),
        ))));
  }
}
