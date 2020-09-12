import 'package:flutter/material.dart';
import 'package:hackathon_2020/models/shipment.dart';

class CheckList extends StatelessWidget {
  Shipment shipment;
  String info;
  List<String> restrictions=[];
  CheckList(Shipment shipment) {
    shipment = shipment;
    info = shipment.commodity + shipment.origin + shipment.destination;
    if(shipment.origin=='FRA') {
      restrictions.add('Vaccination Mandatory');
    }else{
      restrictions.add('No specific restrictions for shipping this cargo');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Card(
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      Container(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    for(var res in restrictions)
                      Text(
                        '${res}',
                        overflow: TextOverflow.ellipsis,
                      ),
                  ],
                ),
                ],),
    )])));
  }
}
