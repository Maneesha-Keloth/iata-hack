import 'dart:async';
import 'dart:convert';
import 'package:hackathon_2020/models/getQuotesResponse.dart';
import 'package:hackathon_2020/models/getQuotesRequest.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:hackathon_2020/models/shipment.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';

import 'package:hackathon_2020/models/RateDetails.dart';
import 'package:hackathon_2020/models/FlightDetailsForList.dart';
import 'package:hackathon_2020/ExpansionPanelRev.dart';
Future<List<AvailabilityListItem>> fetchAllQuotes(Shipment shipment,String access_token) async {

  AdditionalShipmentInformation additionalShipmentInformation=new AdditionalShipmentInformation("STANDARD",true,false);
  print(shipment.shippingDate.toString().substring(0,10));
  String quoteId=shipment.shipmentId;
  GetQuotesRequest request=new GetQuotesRequest(shipment.shippingDate.toString().substring(0,10),additionalShipmentInformation);
  print(jsonEncode(request));
  print(shipment.shipmentId);
  String url='https://api-ute2-ext.airfranceklm.com/cargo/customers/86873/shipments/'+quoteId+'/get-quotes';
  print(url);
  final response =
  await http.post(url, headers: {
    "Content-Type": "application/json",
    "Authorization": "Bearer "+access_token
  },
    body: jsonEncode(request),);
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    //print(response.body);
    //Map data = json.decode(response.body);

    Map<String, dynamic> map = json.decode(response.body);
    GetQuotesResponse res = GetQuotesResponse.fromJson(map);
    Iterable iterableRoutes=map["quotesList"];
    List<Quote> quotes =
    iterableRoutes.map((l) => Quote.fromJson(l)).toList();
    print(quotes.length);
    List<AvailabilityListItem> availableFlight=[];
    for(Quote quoteforPlan in quotes){
      print(quoteforPlan.shippingPlan);
      
      ShippingPlan plan=ShippingPlan.fromJson(quoteforPlan.shippingPlan);
      print(plan.transportTime);
      Iterable iterableRoutes=plan.flights;
      List<Flight> flightsAvailable =
      iterableRoutes.map((l) => Flight.fromJson(l)).toList();
      print(flightsAvailable.length);
      Price priceforQuote=Price.fromJson(quoteforPlan.price);
      AvailabilityListItem availItems=new AvailabilityListItem();
      print(priceforQuote.currencyCode+' '+priceforQuote.total.toString());
      availItems.quote=priceforQuote.total.toString();
      availItems.currency=priceforQuote.currencyCode;
      availItems.transportTime=plan.transportTime;
      print(plan.transportTime);
      String route="";
      String flightNumbers="";
      int count=0;
      for(Flight flight in flightsAvailable){
        if(count ==0){
          availItems.staAtOrign=flight.scheduledTimeOfDeparture.substring(11,16);
          availItems.flightDate=flight.flightDate;
        }
        route=route+'-'+flight.boardPoint;
        count++;
        if(count ==flightsAvailable.length){
          print('for last segment'+flight.scheduledTimeOfArrival);
          availItems.staAtDestination=flight.scheduledTimeOfArrival.substring(11,16);
          route=route+'-'+flight.offPoint;
        }
        availItems.addFlight(flight.marketingCarrierCode+flight.flight);
      }
      print(route);
      availItems.route=route;
      availableFlight.add(availItems);
    }
    print(availableFlight.length);
    /*Iterable data = map["quotesList"];
    print(data);
    List<Quote> flightQuotes =
    data.map((l) => Quote.fromJson(l)).toList();
    print(flightQuotes.length);*/
    /*GetQuotesResponse res = GetQuotesResponse.fromJson(data);
    print(res.quotesList.length);*/
    /*Iterable iterableRoutes=map["quotesList"];;
    List<Quote> quotes =
    iterableRoutes.map((l) => Quote.fromJson(l)).toList();
    print(quotes.length);*/
    //List<AvailabilityListItem> availableFlight=[AvailabilityListItem(route:"FRA-AMS-SIN",flightDate:"15 SEP",staAtOrign: "05:35",staAtDestination: "14:20",transportTime: "29.15",quote:"600"),AvailabilityListItem(route:"FRA-AMS-SIN",flightDate:"15 SEP",staAtOrign: "05:35",staAtDestination: "14:20",transportTime: "29.15",quote:"600"),AvailabilityListItem(route:"FRA-AMS-SIN",flightDate:"15 SEP",staAtOrign: "05:35",staAtDestination: "14:20",transportTime: "29.15",quote:"600"),AvailabilityListItem(route:"FRA-AMS-SIN",flightDate:"15 SEP",staAtOrign: "05:35",staAtDestination: "14:20",transportTime: "29.15",quote:"600"),AvailabilityListItem(route:"FRA-AMS-SIN",flightDate:"15 SEP",staAtOrign: "05:35",staAtDestination: "14:20",transportTime: "29.15",quote:"600"),AvailabilityListItem(route:"FRA-AMS-SIN",flightDate:"15 SEP",staAtOrign: "05:35",staAtDestination: "14:20",transportTime: "29.15",quote:"600"),AvailabilityListItem(route:"FRA-AMS-SIN",flightDate:"15 SEP",staAtOrign: "05:35",staAtDestination: "14:20",transportTime: "29.15",quote:"600")];

    /*for(Quote quoteforPlan in quotes){
      print(quoteforPlan.shippingPlan);
      Iterable iterableRoutes=quoteforPlan.shippingPlan.flights;
      List<Flight> flightsAvailable =
      iterableRoutes.map((l) => Flight.fromJson(l)).toList();
      Price priceforQuote=quoteforPlan.price;
      AvailabilityListItem availItems=new AvailabilityListItem();
      availItems.quote=priceforQuote.currencyCode+' '+priceforQuote.total.toString();
      availItems.transportTime=quoteforPlan.shippingPlan.transportTime;
      String route="";
      String flightNumbers="";
      int count=1;
      for(Flight flight in flightsAvailable){
         if(count ==0){
           availItems.staAtOrign=flight.scheduledTimeOfDeparture;
           availItems.flightDate=flight.flightDate;
         }
         route=route+'-'+flight.boardPoint;
         count++;
         if(count ==flightsAvailable.length){
           availItems.staAtDestination=flight.scheduledTimeOfArrival;
           route=route+'-'+flight.offPoint;
         }
         availItems.addFlight(flight.flight);
      }
      availItems.route=route;
      availableFlight.add(availItems);
    }

*/
    return availableFlight;
  } else {

    print(response.body);
    // If the server did not return a 200 OK response,
    // then throw an exception.
   // throw Exception('Failed to load album');
  }
}

class FlightQuotes extends StatefulWidget {
  final Shipment shipmentInfo;
  final String access_token;
  FlightQuotes({Key key, this.shipmentInfo,this.access_token}) : super(key: key);
  @override
  _FlightQuotesState createState() => _FlightQuotesState();
}

class _FlightQuotesState extends State<FlightQuotes> {
  Future<List<AvailabilityListItem>> futureRoutes;
  List<AvailabilityListItem> routes=[];
  static const int sortName = 0;
  static const int sortStatus = 1;
  bool isAscending = true;
  int sortType = sortName;
  @override
  void initState() {
    super.initState();
    futureRoutes = fetchAllQuotes(widget.shipmentInfo,widget.access_token);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      debugShowCheckedModeBanner: false,
      /*theme: ThemeData(
        primarySwatch: Colors.blue,
      ),*/
      home: Scaffold(
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


          title: Row(
            children: <Widget>[
              new Text("${widget.shipmentInfo.origin}"),
              SizedBox(width: 10), // give it width
              Icon(
                Icons.flight,
                color: Colors.white,
                size: 15.0,
              ),
              SizedBox(width: 10),
              Text("${widget.shipmentInfo.destination}"),
              SizedBox(width: 10),
              AutoSizeText(
                "${widget.shipmentInfo.shippingDate.toString().substring(0,10)}",
                style: TextStyle(fontSize: 16),
                maxLines: 2,
              ),
              SizedBox(width: 10),
              AutoSizeText(
                "${widget.shipmentInfo.weight}",
                style: TextStyle(fontSize: 16),
                maxLines: 2,
              ),
              SizedBox(width: 10),
              AutoSizeText(
                "${widget.shipmentInfo.commodity}",
                style: TextStyle(fontSize: 16),
                maxLines: 2,
              )
            ],
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(0),

          child: FutureBuilder<List<AvailabilityListItem>>(
            future: futureRoutes,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                this.routes=snapshot.data;
                return
                new Container(
                    child: new SingleChildScrollView(
                        child: Column(
                          children: [
                            for(AvailabilityListItem listItem in routes)
                              AvailabilityListItemWidget(avlItem: listItem,onTap: ()=>Navigator.push(
                                context,
                                MaterialPageRoute(
                    builder: (context) => new PartnerScreen(
                          shipmentInfo: widget.shipmentInfo,
                          flightSegmentInfo: listItem,
                          rate: new RateDetails(double.parse(listItem.quote), listItem.currency, 0, 0),
                        )),
                              ),),

                          ],
                        )
                    )
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return Center(
                  child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child:CircularProgressIndicator(
                      backgroundColor: Colors.cyan,
                      strokeWidth: 5,),
                  )
              );
            },
          ),
        ),
      ),
    );
  }


}