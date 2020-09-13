import 'package:flutter/material.dart';
import 'package:hackathon_2020/models/shipment.dart';

enum FeedingHours { hrs2, hrs4, hrs6 }

class CheckListWidget extends StatefulWidget {
  final Shipment shipmentState;

  CheckListWidget({Key key, this.shipmentState}) : super(key: key);

  @override
  CheckList createState() => CheckList(this.shipmentState);
}

class CheckList extends State<CheckListWidget> {
  Shipment shipment;
  String info;
  List<String> restrictions=[];

  bool vaccinated;
  bool certified;
  FeedingHours _character;

  CheckList(Shipment shipmentFromForm) {
    vaccinated = false;
    certified = false;
    _character = FeedingHours.hrs2;
    shipment = shipmentFromForm;
    //info = shipment.commodity + shipment.origin + shipment.destination;
    if(shipment.origin=='FRA') {
      restrictions.add('Vaccination Mandatory');
    }else{
      restrictions.add('No specific restrictions for shipping this cargo');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: SingleChildScrollView(
        child: Card(
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ListTile(
              title: Text('Commodity'),
              subtitle: Text(shipment.commodity),
                      ),
            ListTile(
                title: Text('Pieces, Weight, Volume'),
                subtitle: Text(shipment.pieces.toString() +
                    " " +
                    shipment.weight.toString() +
                    " " +
                    shipment.volume.toString())),
            Row(
              children: [
                Flexible(
                    child: ListTile(
                        title: Text('Origin',style: TextStyle(
                            fontSize: 15,
                            fontStyle: FontStyle.italic,
                            color: Color(0xffb0b5b1))),
                        subtitle: Text(shipment.origin))),
                Flexible(
                    child: ListTile(
                        title: Text('Destination',style: TextStyle(
                            fontSize: 15,
                            fontStyle: FontStyle.italic,
                            color: Color(0xffb0b5b1))),
                        subtitle: Text(shipment.destination))),
                  ],
                ),
            ListTile(
                title: Text('Shipping Date'),
                subtitle: Text(shipment.shippingDate.toString().substring(0,10))),
            ListTile(
                leading: Checkbox(
                    value: vaccinated,
                    onChanged: (bool vaccinatedValue) {
                      setState(() {
                        vaccinated = vaccinatedValue;
                      });
                    }),
                subtitle:
                    Text('Has the pet been vaccinated in the last 3 months?')),
            ListTile(
                leading: Checkbox(
                  value: certified,
                  onChanged: (bool certifiedValue) {
                    setState(() {
                      certified = certifiedValue;
                    });
                  },
                ),
                subtitle: Text(
                    'Have you obtained a veterinary certificate for your pet?')),
            TextField(
                decoration: InputDecoration(
                    hintText:
                        'Does your pet have any active health condition ?',
                hintStyle: TextStyle(
                    fontSize: 10,
                    fontStyle: FontStyle.italic,
                    color: Color(0xffb0b5b1)))),
            Text("How frequently does your pet need to be fed ?"),
            RadioListTile<FeedingHours>(
              title: const Text('2 Hours'),
              value: FeedingHours.hrs2,
              groupValue: _character,
              onChanged: (FeedingHours value) {
                setState(() {
                  _character = value;
                });
              },
            ),
            RadioListTile<FeedingHours>(
              title: const Text('4 Hours'),
              value: FeedingHours.hrs4,
              groupValue: _character,
              onChanged: (FeedingHours value) {
                setState(() {
                  _character = value;
                });
              },
            ),
            RadioListTile<FeedingHours>(
              title: const Text('6 Hours'),
              value: FeedingHours.hrs6,
              groupValue: _character,
              onChanged: (FeedingHours value) {
                setState(() {
                  _character = value;
                });
              },
            ),
          ]),
    )));
  }
}
