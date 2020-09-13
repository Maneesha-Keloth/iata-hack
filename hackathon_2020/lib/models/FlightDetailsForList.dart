import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
class AvailabilityListItem{


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
  List<String> route= List();
  addFlight(String flt){
    flightNumbers.add(flt);
  }

  addRoute(String flt){
    if(route==null){
      route=[];
      route.add(flt);
    }else {
      route.add(flt);
    }
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

  Widget _row1(String stdTime,String staTime,List<String> route){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
        Row(
          children: [
                Text(stdTime,style: const TextStyle(fontSize: 12.0,fontWeight: FontWeight.bold),),
            Icon(Icons.arrow_forward),
                Text(staTime,style: const TextStyle(fontSize: 12.0,fontWeight: FontWeight.bold),),
                Text("   "),
                Text(route.join('-'),style: const TextStyle(fontSize: 12.0,fontWeight: FontWeight.bold),),
          ],
            )
          ],
        )

      ],
    );
  }

  Widget _row2(List<String> flightNumbers,String flightDate,String fltDate){
    return Row(

      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
        Row(
          children: [
                Text(flightNumbers.join(","),style: const TextStyle(fontSize: 14.0,fontWeight: FontWeight.bold),),
            Text(" "),
                Text(fltDate,style: const TextStyle(fontSize: 14.0,fontWeight: FontWeight.bold),),
          ],
        )
      ],
        )


      ],
    );
  }



  _makeCard() => Card(
    elevation: 8.0,
    margin: new EdgeInsets.symmetric(horizontal: 0.0, vertical: 6.0),
    child: Container(
      decoration: BoxDecoration(color: Colors.white70),
      child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),
          onTap: onTap,
          leading: CircleAvatar(
            backgroundColor: Colors.amber,
            child:Icon(Icons.flight ),
          ),
          title: _row1(avlItem.staAtOrign,avlItem.staAtDestination,avlItem.route),
          subtitle: _row2(avlItem.flightNumbers,avlItem.flightDate,avlItem.flightDate),
          trailing:_rateItem(avlItem.quote,avlItem.currency),
          isThreeLine: true,

      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return _makeCard();
  }

  AvailabilityListItemWidget({this.avlItem, this.onTap});

}