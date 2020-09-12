import 'package:flutter/material.dart';
import 'package:hackathon_2020/models/flight.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'dart:convert';

class FlightList extends StatefulWidget {
  @override
  _FlightListState createState() => _FlightListState();
}

class _FlightListState extends State<FlightList> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _sortColumnIndex;
  bool _sortAscending = true;

  @override
  void initState() {
    _flights = _flightList;
    super.initState();
  }

  /*void _sort<T>(Comparable<T> getField(Flight d), int columnIndex,
      bool ascending) {
    _flights.sort((Flight a, Flight b) {
      if (!ascending) {
        final Flight c = a;
        a = b;
        b = c;
      }
      final Comparable<T> aValue = getField(a);
      final Comparable<T> bValue = getField(b);
      return Comparable.compare(aValue, bValue);
    });
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
    });
  }*/

  List<Flight> _flights = [];
  int _rowsOffset = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: Image.asset('assets/icons/u57.png'),
          backgroundColor: Color(0xff13378d),
          toolbarHeight:70,
          shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(65),
                  bottomRight: Radius.circular(65))),

          //title: new Text('FRA DXB'),
          title:  Row(
            children: <Widget>[
              Text("FRA"),
              SizedBox(width: 10), // give it width
              Icon(
                Icons.flight,
                color: Colors.white,
                size: 30.0,
              ),
              SizedBox(width: 10),
              Text("DXB"),
              SizedBox(width: 10),
              AutoSizeText(
                '10 pcs',
                style: TextStyle(fontSize: 16),
                maxLines: 2,
              ),
              SizedBox(width: 10),
              AutoSizeText(
                '10 kg',
                style: TextStyle(fontSize: 16),
                maxLines: 2,
              )
            ],
          ),

         ),
        body: Padding(
          padding: const EdgeInsets.all(0),
          child: Table(border: TableBorder(
              horizontalInside: new BorderSide(color: Colors.blueGrey, width: 0.5),
          ),
            children: [
              for(var item in _flights )
              TableRow(
                  children: [
                    Container(
                        padding: EdgeInsets.only(bottom: 30),
                        child:  Text(item?.airlineCode+' '+item?.flightNum,style: TextStyle(fontSize: 20),)),
                    Container(
                        padding: EdgeInsets.only(bottom: 30),
                        child:  Column(
                            children: <Widget>[
                            Text(item?.arrival),
                      SizedBox(width: 10), // give it width
                      Icon(
                        Icons.flight,
                        color: Colors.black,
                        size: 15.0,
                      ),
                      SizedBox(width: 10),
                      Text(item?.departure),

                     ]
                        )),

                    Container(
                        padding: EdgeInsets.only(bottom: 30),
                        child:  Text('${item.rate}',style: TextStyle(fontSize: 20),)),
              ]),

            ],
          ),
        ),
      ),
    );
  }
  final List<Flight> _flightList = <Flight>[Flight('LH','1234','29 Mon Sep 2020','FRA','DXB','05:25','14:30',1.0),
    Flight('AV','1000','29 Mon Sep 2020','FRA','DXB','15:25','14:30',1.0),
    Flight('XY','1234','29 Mon Sep 2020','FRA','DXB','08:25','14:30',1.0),
    Flight('AF','1234','29 Mon Sep 2020','FRA','DXB','08:25','14:30',1.0),
    Flight('LH','1234','29 Mon Sep 2020','FRA','DXB','05:25','14:30',1.0),
    Flight('AV','1000','29 Mon Sep 2020','FRA','DXB','15:25','14:30',1.0),
    Flight('XY','1234','29 Mon Sep 2020','FRA','DXB','08:25','14:30',1.0),
    Flight('AF','1234','29 Mon Sep 2020','FRA','DXB','08:25','14:30',1.0),
    Flight('LH','1234','29 Mon Sep 2020','FRA','DXB','05:25','14:30',1.0),
    Flight('AV','1000','29 Mon Sep 2020','FRA','DXB','15:25','14:30',1.0),
    Flight('XY','1234','29 Mon Sep 2020','FRA','DXB','08:25','14:30',1.0),
    Flight('AF','1234','29 Mon Sep 2020','FRA','DXB','08:25','14:30',1.0),
    Flight('LH','1234','29 Mon Sep 2020','FRA','DXB','05:25','14:30',1.0),
    Flight('AV','1000','29 Mon Sep 2020','FRA','DXB','15:25','14:30',1.0),
    Flight('XY','1234','29 Mon Sep 2020','FRA','DXB','08:25','14:30',1.0),
    Flight('AF','1234','29 Mon Sep 2020','FRA','DXB','08:25','14:30',1.0)
  ];

  //final Map valueMap = json.decode();
}