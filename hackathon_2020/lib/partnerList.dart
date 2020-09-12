import 'package:flutter/material.dart';
import 'package:hackathon_2020/models/partner.dart';
import 'package:hackathon_2020/models/flight.dart';

class PartnerList extends StatefulWidget {
  final Flight flight;
  PartnerList({Key key, this.flight}) : super(key: key);
  @override
  _PartnerListState createState() => _PartnerListState();
}

class _PartnerListState extends State<PartnerList> {
  List<Partner> _partners = [];
  @override
  void initState() {
    _partners = _partnerList;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Color(0xff13378d),
          toolbarHeight: 70,
          shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(65),
                  bottomRight: Radius.circular(65))),

          //title: new Text('FRA DXB'),
          title: Row(
            children: <Widget>[
              new Text("Confirm Your Partner"),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
                children: <Widget>[

              Table(border: TableBorder(
                horizontalInside: new BorderSide(color: Colors.blueGrey, width: 0.5),
              ),
                children: [
                  for(var item in _partners )
                    TableRow(
                        children: [
                          Container(
                              padding: EdgeInsets.only(bottom: 30),
                              child:  Text(item?.partnertype.toString(),style: TextStyle(fontSize: 20),)),
                          Container(
                              padding: EdgeInsets.only(bottom: 30),
                              child:  Text(item?.transitInhours.toString(),style: TextStyle(fontSize: 20),)),

                          Container(
                              padding: EdgeInsets.only(bottom: 30),
                              child:  Text('${item.rate}',style: TextStyle(fontSize: 20),)),
                        ]),

                ],
              ),
              Table(border: TableBorder(
                horizontalInside: new BorderSide(color: Colors.blueGrey, width: 0.5),
              ),
                children: [
                  for(var item in _partners )
                    TableRow(
                        children: [
                          Container(
                              padding: EdgeInsets.only(bottom: 30),
                              child:  Text(item?.partnertype.toString(),style: TextStyle(fontSize: 20),)),
                          Container(
                              padding: EdgeInsets.only(bottom: 30),
                              child:  Text(item?.transitInhours.toString(),style: TextStyle(fontSize: 20),)),

                          Container(
                              padding: EdgeInsets.only(bottom: 30),
                              child:  Text('${item.rate}',style: TextStyle(fontSize: 20),)),
                        ]),

                ],
              ),
              Table(border: TableBorder(
                horizontalInside: new BorderSide(color: Colors.blueGrey, width: 0.5),
              ),
                children: [
                  for(var item in _partners )
                    TableRow(
                        children: [
                          Container(
                              padding: EdgeInsets.only(bottom: 30),
                              child:  Text(item?.partnertype.toString(),style: TextStyle(fontSize: 20),)),
                          Container(
                              padding: EdgeInsets.only(bottom: 30),
                              child:  Text(item?.transitInhours.toString(),style: TextStyle(fontSize: 20),)),

                          Container(
                              padding: EdgeInsets.only(bottom: 30),
                              child:  Text('${item.rate}',style: TextStyle(fontSize: 20),)),
                        ]),

                ],
              ),
            ],
          )
        ),
      ),
      ),
    );
  }
  final List<Partner> _partnerList = <Partner>[Partner('Uber Freight','11 SEP 02-03 PM','Certified to Handle Pets',true,"Premium",156,10),
    Partner('Freight Express','11 SEP Based on availability','',false,'Std',156,10)
  ];
}

class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Route"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            // Navigate back to first route when tapped.
            Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }

}