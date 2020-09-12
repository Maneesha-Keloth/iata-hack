import 'package:flutter/material.dart';
import 'package:hackathon_2020/models/flight.dart';
import 'package:hackathon_2020/models/shipment.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:hackathon_2020/models/user.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:popup_menu/popup_menu.dart';
import 'package:hackathon_2020/partnerList.dart';
import 'package:hackathon_2020/ExpansionPanel.dart';
import 'package:hackathon_2020/api_service.dart';
import 'package:hackathon_2020/models/FlightSegments.dart';
/**
 * author maneesha
 */
class FlightList extends StatefulWidget {
  final Shipment shipmentInfo;
  FlightList({Key key, this.shipmentInfo}) : super(key: key);
  @override
  _FlightListState createState() => _FlightListState();
}

class _FlightListState extends State<FlightList> {
  List<GlobalKey> _listOfKeys = List<GlobalKey>();
  static const int sortName = 0;
  static const int sortStatus = 1;
  bool isAscending = true;
  int sortType = sortName;
  PopupMenu menu;
  @override
  void initState() {
    flight.initData();

    ApiService.getUsers().then((value) => users=value);

    menu = PopupMenu(items: [
      // MenuItem(title: 'Copy', image: Image.asset('assets/copy.png')),
      // MenuItem(title: 'Home', image: Icon(Icons.home, color: Colors.white,)),
      MenuItem(
          title: 'Mail',
          image: Icon(
            Icons.mail,
            color: Colors.white,
          )),
      MenuItem(
          title: 'Power',
          image: Icon(
            Icons.power,
            color: Colors.white,
          )),
      MenuItem(
          title: 'Setting',
          image: Icon(
            Icons.settings,
            color: Colors.white,
          )),
      MenuItem(
          title: 'PopupMenu',
          image: Icon(
            Icons.menu,
            color: Colors.white,
          ))
    ], onClickMenu: onClickMenu, onDismiss: onDismiss, maxColumn: 4);
    super.initState();
  }
  void onClickMenu(MenuItemProvider item) {
    print('Click menu -> ${item.menuTitle}');
  }

  void onDismiss() {
    print('Menu is dismiss');
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
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

          title: new Text(users.length.toString()),
          /*title: Row(
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
                "${widget.shipmentInfo.pieces}",
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
          ),*/
        ),
        body: Padding(
          padding: const EdgeInsets.all(0),
          child: HorizontalDataTable(
            leftHandSideColumnWidth: 80,
            rightHandSideColumnWidth: 500,
            isFixedHeader: true,
            headerWidgets: _getTitleWidget(),
            leftSideItemBuilder: _generateFirstColumnRow,
            rightSideItemBuilder: _generateRightHandSideColumnRow,
            itemCount: flight.flightInfo.length,
            rowSeparatorWidget: const Divider(
              color: Colors.black54,
              height: 1.0,
              thickness: 0.0,
            ),
            leftHandSideColBackgroundColor: Color(0xFFFFFFFF),
            rightHandSideColBackgroundColor: Color(0xFFFFFFFF),
          ),
        ),
      ),
    );
  }

  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {

    _listOfKeys.add(new GlobalKey());
    PopupMenu.context = context;
    return Row(
      children: <Widget>[
        Container(
          child: Row(
            children: <Widget>[
              Text(flight.flightInfo[index].departure),
              Icon(Icons.flight, color: Colors.black),
              Text(flight.flightInfo[index].arrival),
            ],
          ),
          width: 100,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: Text(flight.flightInfo[index].rate.toString()),
          width: 50,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: Text(flight.flightInfo[index].origin+'-'+flight.flightInfo[index].destination),
          width: 100,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        /*Container(
          child: Icon(Icons.bookmark, color: Colors.black),
          width: 100,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),*/
        Container(
          child: MaterialButton(
            height: 45.0,
            key: _listOfKeys[index],
           // onPressed:() =>  maxColumn(index),
            onPressed: () {
              // Navigate to second route when tapped.
              Navigator.push(
                context,
                //MaterialPageRoute(builder: (context) => new PartnerList(flight: flight.flightInfo[index],)),
                MaterialPageRoute(builder: (context) => new Expansionpanel()),
              );
            },
            child: Icon(Icons.bookmark, color: Colors.black),
          ),
          width: 100,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
      ],
    );
  }

  List<Widget> _getTitleWidget() {
    return [
      FlatButton(
        padding: EdgeInsets.all(0),
        child: _getTitleItemWidget(
            //'Flight' + (sortType == sortName ? (isAscending ? '↓' : '↑') : ''),
          '',
            100),
        onPressed: () {
          sortType = sortName;
          isAscending = !isAscending;
          flight.sortName(isAscending);
          setState(() {});
        },
      ),
      /* FlatButton(
        padding: EdgeInsets.all(0),
        child: _getTitleItemWidget('Status' +
            (sortType == sortStatus ? (isAscending ? '↓' : '↑') : ''), 100),
        onPressed: () {
          sortType = sortStatus;
          isAscending = !isAscending;
          user.sortStatus(isAscending);
          setState(() {

          });
        },
      ),*/
      _getTitleItemWidget(' ', 200),

      _getTitleItemWidget(' ', 100),

    ];
  }

  Widget _getTitleItemWidget(String label, double width) {
    return Container(
      child: Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
      width: width,
      height: 56,
      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
    );
  }

  Widget _generateFirstColumnRow(BuildContext context, int index) {
    return Container(
      child: Text(flight.flightInfo[index].airlineCode +
          ' ' +
          flight.flightInfo[index].flightNum),
      width: 100,
      height: 52,
      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
    );
  }
  void maxColumn(int index) {
    PopupMenu menu = PopupMenu(
      // backgroundColor: Colors.teal,
      // lineColor: Colors.tealAccent,
        maxColumn: 3,
        items: [
          MenuItem(title: 'Copy', image: Image.asset('assets/copy.png')),
          // MenuItem(
          //     title: 'Home',
          //     // textStyle: TextStyle(fontSize: 10.0, color: Colors.tealAccent),
          //     image: Icon(
          //       Icons.home,
          //       color: Colors.white,
          //     )),
          // MenuItem(
          //     title: 'Mail',
          //     image: Icon(
          //       Icons.mail,
          //       color: Colors.white,
          //     )),
          MenuItem(
              title: 'Power',
              image: Icon(
                Icons.power,
                color: Colors.red,
              )),
          MenuItem(
              title: 'Setting',
              image: Icon(
                Icons.settings,
                color: Colors.red,
              )),
          MenuItem(
              title: 'PopupMenu',
              image: Icon(
                Icons.menu,
                color: Colors.red,
              ))
        ],
        onClickMenu: onClickMenu,
        stateChanged: stateChanged,
        onDismiss: onDismiss);
    menu.show(widgetKey: _listOfKeys[index]);
  }

  void stateChanged(bool isShow) {
    print('menu is ${isShow ? 'showing' : 'closed'}');
  }
}

FlightInfo flight = FlightInfo();
List<User> users=[];
class FlightInfo {
  //List<Flight> _listOfFlights = List<Flight>();

  void initData() {
    _flightList = <Flight>[
      Flight(
          'LH', '1234', '29 Mon Sep 2020', 'FRA', 'DXB', '05:25', '14:30', 1.0),
      Flight(
          'AV', '1000', '29 Mon Sep 2020', 'FRA', 'DXB', '15:25', '14:30', 1.0),
      Flight(
          'XY', '1234', '29 Mon Sep 2020', 'FRA', 'DXB', '08:25', '14:30', 1.0),
      Flight(
          'AF', '1234', '29 Mon Sep 2020', 'FRA', 'DXB', '08:25', '14:30', 1.0),
      Flight(
          'LH', '1234', '29 Mon Sep 2020', 'FRA', 'DXB', '05:25', '14:30', 1.0),
      Flight(
          'AV', '1000', '29 Mon Sep 2020', 'FRA', 'DXB', '15:25', '14:30', 1.0),
      Flight(
          'XY', '1234', '29 Mon Sep 2020', 'FRA', 'DXB', '08:25', '14:30', 1.0),
      Flight(
          'AF', '1234', '29 Mon Sep 2020', 'FRA', 'DXB', '08:25', '14:30', 1.0),
      Flight(
          'LH', '1234', '29 Mon Sep 2020', 'FRA', 'DXB', '05:25', '14:30', 1.0),
      Flight(
          'AV', '1000', '29 Mon Sep 2020', 'FRA', 'DXB', '15:25', '14:30', 1.0),
      Flight(
          'XY', '1234', '29 Mon Sep 2020', 'FRA', 'DXB', '08:25', '14:30', 1.0),
      Flight(
          'AF', '1234', '29 Mon Sep 2020', 'FRA', 'DXB', '08:25', '14:30', 1.0),
      Flight(
          'LH', '1234', '29 Mon Sep 2020', 'FRA', 'DXB', '05:25', '14:30', 1.0),
      Flight(
          'AV', '1000', '29 Mon Sep 2020', 'FRA', 'DXB', '15:25', '14:30', 1.0),
      Flight(
          'XY', '1234', '29 Mon Sep 2020', 'FRA', 'DXB', '08:25', '14:30', 1.0),
      Flight(
          'AF', '1234', '29 Mon Sep 2020', 'FRA', 'DXB', '08:25', '14:30', 1.0)
    ];
  }

  List<Flight> _flightList;

  List<Flight> get flightInfo => _flightList;

  set flightInfo(List<Flight> value) {
    _flightList = value;
  }

  ///
  /// Single sort, sort Name's id
  void sortName(bool isAscending) {
    _flightList.sort((a, b) {
      int aId = int.tryParse(a.flightNum.replaceFirst('User_', ''));
      int bId = int.tryParse(b.flightNum.replaceFirst('User_', ''));
      return (aId - bId) * (isAscending ? 1 : -1);
    });
  }

  /* ///
  /// sort with Status and Name as the 2nd Sort
  void sortStatus(bool isAscending) {
    _flightList.sort((a, b) {
      if (a.rate == b.rate) {
        int aId = int.tryParse(a.rate.replaceFirst('User_', ''));
        int bId = int.tryParse(b.name.replaceFirst('User_', ''));
        return (aId - bId);
      } else if (a.status) {
        return isAscending ? 1 : -1;
      } else {
        return isAscending ? -1 : 1;
      }
    });
  }*/
}
