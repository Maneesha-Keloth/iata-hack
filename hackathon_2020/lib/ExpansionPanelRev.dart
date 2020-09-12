import 'package:flutter/material.dart';
import 'package:hackathon_2020/models/FlightSegments.dart';
import 'package:hackathon_2020/models/partner.dart';
import 'package:hackathon_2020/BookingSummary.dart';
import 'package:hackathon_2020/models/shipment.dart';
import 'package:hackathon_2020/models/RateDetails.dart';
import 'package:hackathon_2020/models/FlightDetailsForList.dart';
class PartnerScreen extends StatefulWidget {
  final Shipment shipmentInfo;
  final AvailabilityListItem flightSegmentInfo;
  final RateDetails rate;
  PartnerScreen({Key key, this.shipmentInfo, this.flightSegmentInfo, this.rate})
      : super(key: key);
  @override
  _PartnerScreenState createState() => _PartnerScreenState();
}

class _PartnerScreenState extends State<PartnerScreen> {
  String pickup = 'Premium';
  String delivery = "Premium";
  double total=0;
  changeText() {

    setState(() {
      total = widget.rate.flightrate+widget.rate.pickupRate+widget.rate.deliveryRate;
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        body: Container(
          child:Column(
            children: [
              Card(
                child: Padding(
                  padding: EdgeInsets.only(
                      top: 36.0, left: 6.0, right: 6.0, bottom: 6.0),
                  child: ExpansionTile(
                    title: Text('Select Preferred Pickup Option:'),
                    leading: Icon(Icons.local_taxi),
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Radio(
                              value: "Premium",
                              groupValue: pickup,
                              onChanged: (value) {
                                setState(() {
                                  pickup = value;
                                  widget.rate.pickupRate=120.0;
                                });
                              }),
                          Text(
                            'Premium',
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w800,
                              color: Color(0xff13378d),
                            ),
                          ),
                          Text(
                            'Uber Freights',
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w800,
                              color: Color(0xff13378d),
                            ),
                          ),
                          Text(
                            '6h',
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w800,
                              color: Color(0xff13378d),
                            ),
                          ),
                          Text(
                            '120EUR',
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w800,
                              color: Color(0xff13378d),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Radio(
                              value: "Standard",
                              groupValue: pickup,
                              onChanged: (value) {
                                setState(() {
                                  pickup = value;
                                  widget.rate.pickupRate=60.0;
                                });
                              }),
                          Text(
                            'Standard',
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w800,
                              color: Color(0xff13378d),
                            ),
                          ),
                          Text(
                            'Dexter Freights',
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w800,
                              color: Color(0xff13378d),
                            ),
                          ),
                          Text(
                            '12h',
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w800,
                              color: Color(0xff13378d),
                            ),
                          ),
                          Text(
                            '60EUR',
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w800,
                              color: Color(0xff13378d),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Card(
                child: Padding(
                  padding: EdgeInsets.only(
                      top: 36.0, left: 6.0, right: 6.0, bottom: 6.0),
                  child: ExpansionTile(
                    title: Text('Select Preferred Delivery Option:'),
                    leading: Icon(Icons.local_taxi),
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Radio(
                              value: "Premium",
                              groupValue: delivery,
                              onChanged: (value) {
                                setState(() {
                                  delivery = value;
                                  widget.rate.deliveryRate=90.0;
                                });
                              }),
                          Text(
                            'Premium',
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w800,
                              color: Color(0xff13378d),
                            ),
                          ),
                          Text(
                            'Uber Freights',
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w800,
                              color: Color(0xff13378d),
                            ),
                          ),
                          Text(
                            '6h',
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w800,
                              color: Color(0xff13378d),
                            ),
                          ),
                          Text(
                            '90EUR',
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w800,
                              color: Color(0xff13378d),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Radio(
                              value: "Standard",
                              groupValue: delivery,
                              onChanged: (value) {
                                setState(() {
                                  delivery = value;
                                  widget.rate.deliveryRate=60.0;
                                });
                              }),
                          Text(
                            'Standard',
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w800,
                              color: Color(0xff13378d),
                            ),
                          ),
                          Text(
                            'Dexter Freights',
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w800,
                              color: Color(0xff13378d),
                            ),
                          ),
                          Text(
                            '12h',
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w800,
                              color: Color(0xff13378d),
                            ),
                          ),
                          Text(
                            '60EUR',
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w800,
                              color: Color(0xff13378d),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Card(
                child: Padding(
                  padding: EdgeInsets.only(
                      top: 36.0, left: 6.0, right: 6.0, bottom: 6.0),
                  child: ExpansionTile(
                    title: Text('Selected Flight Details:'),
                    leading: Icon(Icons.flight),
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(widget.flightSegmentInfo.flightNumbers.toString()),
                          Text(widget.flightSegmentInfo.route),

                          Text(widget.flightSegmentInfo.quote + widget.flightSegmentInfo.currency),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              Row(children: [
                RaisedButton(
                  child: Text('Total: $total'),
                  color: Color(0xffffcc00),
                  textColor: Colors.yellowAccent,
                  onPressed: () => changeText(),
                ),
                RaisedButton(
                  child: Text('Confirm Booking'),
                  color: Color(0xffffcc00),
                  onPressed: () {

                    Navigator.push(
                      context,
                      //MaterialPageRoute(builder: (context) => new PartnerList(flight: flight.flightInfo[index],)),
                      MaterialPageRoute(
                          builder: (context) => new BookingSummary(
                            shipmentInfo: widget.shipmentInfo,
                            flightSegmentInfo: widget.flightSegmentInfo,
                            pickupPartner: Partner(
                                pickup == "Premium"
                                    ? "Uber Freights"
                                    : "Dexter Freights",
                                '12 SEP 02-03 PM',
                                'Certified to Handle Pets',
                                true,
                                pickup,
                                pickup == "Premium" ? 120 : 60,
                                pickup == "Premium" ? 6 : 12),
                            deliveryPartner: Partner(
                                delivery == "Premium"
                                    ? "Uber Freights"
                                    : "Dexter Freights",
                                '11 SEP Based on availability',
                                '',
                                false,
                                delivery,
                                delivery == "Premium" ? 120 : 60,
                                delivery == "Premium" ? 6 : 12),
                            rateDetails: widget.rate,
                              total:total,
                          )),
                    );
                  },
                )
              ],),

            ],
          ),
        ),
        backgroundColor: Color(0xff13378d));
  }

  
}
