import 'package:flutter/material.dart';

import 'package:hackathon_2020/models/shipment.dart';
import 'package:hackathon_2020/SampleForm.dart';
import 'package:hackathon_2020/shipmentForm.dart';
class FirstRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Route'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Check Availability'),
          onPressed: () {
            // Navigate to second route when tapped.
            Navigator.push(
              context,
             /* MaterialPageRoute(builder: (context) => new FlightList(shipmentInfo: new Shipment("FRA","Frankfurt, Germany","HKG","Hong Kong, China", 1, 100,"AVI",new DateTime(2020,09,12)))),*/

              MaterialPageRoute(builder: (context) => new ShipmentDetailsCaptureForm(shipmentState: new Shipment("","", "","", 0, "KG",0,"",DateTime.now(),
                  0,0,0,"CM","MC",0,""))),
              //MaterialPageRoute(builder: (context) => new SampleFormPage()),
            );
          },
        ),
      ),
    );
  }
}
