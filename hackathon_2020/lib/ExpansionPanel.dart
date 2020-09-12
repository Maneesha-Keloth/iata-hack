import 'package:flutter/material.dart';
import 'package:hackathon_2020/models/FlightSegments.dart';
import 'package:hackathon_2020/models/partner.dart';
import 'package:hackathon_2020/BookingSummary.dart';
import 'package:hackathon_2020/models/shipment.dart';
import 'package:hackathon_2020/models/RateDetails.dart';

class Expansionpanel extends StatefulWidget {
  final Shipment shipmentInfo;
  final FlightSegments flightSegmentInfo;
  final RateDetails rate;
  Expansionpanel(
      {Key key, this.shipmentInfo, this.flightSegmentInfo, this.rate})
      : super(key: key);
  ExpansionpanelState createState() => ExpansionpanelState();
}

class NewItem {
  bool isExpanded;
  final String header;
  final Widget body;
  final Icon iconpic;
  NewItem(this.isExpanded, this.header, this.body, this.iconpic);
}

class ExpansionpanelState extends State<Expansionpanel> {
  @override
  void initState() {
    _pickuppartners = _pickpartnerList;
    _deliverypartners = _delpartnerList;

    NewItem itemElement = new NewItem(
        true, // isExpanded ?
        'Select Preferred Pickup Option:', // header
        Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(children: <Widget>[
              for (var item in _pickuppartners)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Radio(
                        value: item.partnertype.toUpperCase(),
                        groupValue: _pickupPartnerType,
                        onChanged: (value) {
                          setPickup(value);
                        }),
                    Text(
                      '${item.partnertype}',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w800,
                        color: Color(0xff13378d),
                      ),
                    ),
                    Text(
                      '${item.partnerName}',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w800,
                        color: Color(0xff13378d),
                      ),
                    ),
                    Text(
                      '${item.transitInhours}h',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w800,
                        color: Color(0xff13378d),
                      ),
                    ),
                    Text(
                      '\$${item.rate}',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w800,
                        color: Color(0xff13378d),
                      ),
                    ),
                  ],
                ),
            ])), // body
        Icon(Icons.local_taxi) // iconPic
        );
    items.add(itemElement);

    NewItem delItem = new NewItem(
        true, // isExpanded ?
        'Select Preferred Delivery Option:', // header
        Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(children: <Widget>[
              for (var item in _deliverypartners)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Radio(
                        value: item.partnertype.toUpperCase(),
                        groupValue: _deliveryPartnerType,
                        onChanged: (value) {
                          setState(() {
                            _deliveryPartnerType = value;
                          });
                        }),
                    Text(
                      '${item.partnertype}',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w800,
                        color: Color(0xff13378d),
                      ),
                    ),
                    Text(
                      '${item.partnerName}',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w800,
                        color: Color(0xff13378d),
                      ),
                    ),
                    Text(
                      '${item.transitInhours}h',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w800,
                        color: Color(0xff13378d),
                      ),
                    ),
                    Text(
                      '\$${item.rate}',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w800,
                        color: Color(0xff13378d),
                      ),
                    ),
                  ],
                ),
            ])), // body
        Icon(Icons.local_taxi) // iconPic
        );
    items.add(delItem);

    NewItem flightElem = new NewItem(
        false, // isExpanded ?
        'Selected Flight Details', // header
        Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(widget.flightSegmentInfo.flightNumber),
                  Text(widget.flightSegmentInfo.flightSegmentOrigin),
                  Text(widget.flightSegmentInfo.flightSegmentDestination),
                  Text(widget.rate.flightrate.toString() + 'EUR'),
                ],
              ),
            ])), // body
        Icon(Icons.flight) // iconPic
        );
    items.add(flightElem);
    super.initState();
  }

  String _pickupPartnerType = "PREMIUM";
  String _deliveryPartnerType = "PREMIUM";
  void setPickup(val) {
    setState(() {
      _pickupPartnerType = val;
      print(_pickupPartnerType);
    });
  }

  List<Partner> _pickuppartners = [];
  List<Partner> _deliverypartners = [];
  List<NewItem> items = <NewItem>[];
  ListView List_Criteria;

  @override
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
              child: Text('Confirm Booking'),
              color: Color(0xffffcc00),
              onPressed: () {
                /*Navigator.push(
                  context,
                  //MaterialPageRoute(builder: (context) => new PartnerList(flight: flight.flightInfo[index],)),
                  MaterialPageRoute(
                      builder: (context) => new BookingSummary(
                            shipmentInfo: widget.shipmentInfo,
                            flightSegmentInfo: widget.flightSegmentInfo,
                            pickupPartner: Partner(
                                'Uber Freight',
                                '12 SEP 02-03 PM',
                                'Certified to Handle Pets',
                                true,
                                'Premium',
                                156,
                                10),
                            deliveryPartner: Partner(
                                'Freight Express',
                                '11 SEP Based on availability',
                                '',
                                false,
                                'Std',
                                156,
                                10),
                          )),
                );*/
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
          title: new Text('Confirm Partners'),
        ),
        body: List_Criteria,
        backgroundColor: Color(0xff13378d));
    return scaffold;
  }

  final List<Partner> _pickpartnerList = <Partner>[
    Partner('Uber Freight', '12 SEP 02-03 PM', 'Certified to Handle Pets', true,
        'Premium', 156, 120),
    Partner('Freight Express', '11 SEP Based on availability', '', false,
        'Standard', 156, 60)
  ];
  final List<Partner> _delpartnerList = <Partner>[
    Partner('Uber Freight', '12 SEP 02-03 PM', 'Certified to Handle Pets', true,
        'Premium', 156, 200),
    Partner('Freight Express', '11 SEP Based on availability', '', false,
        'Standard', 156, 69)
  ];
}
