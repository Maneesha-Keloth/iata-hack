import 'package:flutter/material.dart';
class AvailabilityListItem{

  String route;
  //Time alone in hh24:mi
  String staAtOrign;
  //Time alone in hh24:mi
  String staAtDestination;
  //Date as dd-Mon
  String flightDate;
  //Time in hh24:mi
  String transportTime;

  String quote;

  String currency;

//Flight number as carrierCode flightNumber
  List<String> flightNumbers = List();

  addFlight(String flt){
    flightNumbers.add(flt);
  }

  AvailabilityListItem({this.route, this.staAtOrign, this.staAtDestination,
    this.transportTime, this.quote,this.flightDate});
}

class AvailabilityListItemWidget extends StatelessWidget{
  AvailabilityListItem avlItem;
  GestureTapCallback onTap;




  Widget _rateItem(String quote,String currency){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Column(
        children: [

          Text(
            "${currency}"+"\n"+"${quote}",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    )

    ;
  }

  Widget _row1(String stdTime,String staTime,String route){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          children: [
            Text(stdTime),
            Icon(Icons.arrow_forward),
            Text(staTime),
          ],
        ),

      ],
    );
  }

  Widget _row2(List<String> flightNumbers,String flightDate,String transportTime){
    return Row(

      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(flightNumbers.join(",")),
        Row(
          children: [
            /*Text(flightDate),*/
            Text(" "),
            Text(transportTime),
          ],
        )

      ],
    );
  }

  Widget _row3(String route){
    return Row(

      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(route),
      ],
    );
  }

  _makeCard() => Card(
    elevation: 8.0,
    margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    child: Container(
      decoration: BoxDecoration(color: Colors.white70),
      child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          onTap: onTap,
          title: _row1(avlItem.staAtOrign,avlItem.staAtDestination,avlItem.route),
          subtitle: _row2(avlItem.flightNumbers,avlItem.flightDate,avlItem.route),
          trailing:_rateItem(avlItem.quote,avlItem.currency)

      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return _makeCard();
  }

  AvailabilityListItemWidget({this.avlItem, this.onTap});

}