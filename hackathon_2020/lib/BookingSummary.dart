import 'package:flutter/material.dart';
import 'package:hackathon_2020/models/FlightSegments.dart';
import 'package:hackathon_2020/models/partner.dart';
import 'package:hackathon_2020/models/shipment.dart';
import 'package:hackathon_2020/models/FlightDetailsForList.dart';
import 'package:hackathon_2020/models/RateDetails.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
class BookingSummary extends StatefulWidget {
  final Shipment shipmentInfo;
  final AvailabilityListItem flightSegmentInfo;
  final Partner pickupPartner;
  final Partner deliveryPartner;
  final RateDetails rateDetails;
  final double total;
  BookingSummary({Key key, this.shipmentInfo,this.flightSegmentInfo,this.pickupPartner,this.deliveryPartner,this.rateDetails,this.total}) : super(key: key);
  BookingSummaryState createState() => BookingSummaryState();
}
class NewItem {
  bool isExpanded;
  final String header;
  final Widget body;
  final Icon iconpic;
  NewItem(this.isExpanded, this.header, this.body, this.iconpic);
}
class BookingSummaryState extends State<BookingSummary> {
  @override
  void initState() {
    _pickuppartners = _pickpartnerList;
    _deliverypartners = _delpartnerList;

    NewItem delItem = new NewItem(
        true, // isExpanded ?
        'Shipment Details :', // header
        Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    '${widget.shipmentInfo.origin}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  Icon(
                    Icons.flight_takeoff,
                    color: Colors.blueGrey,
                  ),
                  Text(
                    '${widget.shipmentInfo.destination}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    '${widget.shipmentInfo.originDescription}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  Text(
                    '${widget.shipmentInfo.destinationDescription}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    '${widget.shipmentInfo.pieces}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                  Text(
                    '${widget.shipmentInfo.weight}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                  Text(
                    '${widget.shipmentInfo.commodity}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ],
              ),
            ])), // body
        Icon(
          Icons.euro_symbol,
          color: Colors.blue,
        ) // iconPic
        );
    items.add(delItem);

    NewItem flightElem = new NewItem(
        true, // isExpanded ?
        'Flight Details :', // header
        Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text('${widget.shipmentInfo.origin}'),
                  Text('${widget.shipmentInfo.destination}'),
                  Text('${widget.total}'),
                ],
              ),
            ])), // body
        Icon(
          Icons.flight,
          color: Colors.blue,
        ) // iconPic
        );
    items.add(flightElem);
    super.initState();
  }

  List<Partner> _pickuppartners = [];
  List<Partner> _deliverypartners = [];
  List<NewItem> items = <NewItem>[];
  ListView List_Criteria;
  Widget build(BuildContext context) {
    List_Criteria = ListView(
      children: [
        Padding(
          padding: EdgeInsets.all(10.0),
          child: ExpansionPanelList(
            expansionCallback: (int index, bool isExpanded) {
              setState(() {
                items[index].isExpanded = !items[index].isExpanded;
              });
            },
            children: items.map((NewItem item) {
              return ExpansionPanel(
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return ListTile(
                      leading: item.iconpic,
                      title: Text(
                        item.header,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w800,
                          color: Color(0xff13378d),
                        ),
                      ));
                },
                isExpanded: item.isExpanded,
                body: item.body,
              );
            }).toList(),
          ),
        ),
        Container(
          child: Center(
            child: RaisedButton(
              child: Text('Confirm'),
              color: Color(0xffffcc00),
              onPressed: () {
                Alert(context: context, title: "Confirmation", desc: "Booking Saved Successfully in One Record Server.").show();
              },
            ),
          ),
        )
      ],
    );
    Scaffold scaffold = Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_left, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Color(0xff13378d),
          toolbarHeight: 70,
          shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(65),
                  bottomRight: Radius.circular(65))),
          title: new Text('Booking Summary'),
        ),
        body: List_Criteria,
        backgroundColor: Color(0xff13378d));
    return scaffold;
  }

  final List<Partner> _pickpartnerList = <Partner>[
    Partner('Uber Freight', '12 SEP 02-03 PM', 'Certified to Handle Pets', true,
        'Premium', 156, 10),
    Partner('Freight Express', '11 SEP Based on availability', '', false, 'Std',
        156, 10)
  ];
  final List<Partner> _delpartnerList = <Partner>[
    Partner('Uber Freight', '12 SEP 02-03 PM', 'Certified to Handle Pets', true,
        'Premium', 156, 10),
    Partner('Freight Express', '11 SEP Based on availability', '', false, 'Std',
        156, 10)
  ];
  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(5.0),
    );
  }
}
