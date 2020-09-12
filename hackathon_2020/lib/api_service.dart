import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:hackathon_2020/models/FlightSegments.dart';
import 'models/user.dart';

class ApiService {
  static String url(int nrResults) {
    //return 'http://api.randomuser.me/?results=$nrResults';
    return 'https://api.lufthansa.com/v2/cargo/routes/get?origin=FRA&destination=HKG&fromDate=2020-09-12&productCode=YNZ';
  }

  static Future<List<User>> getUsers({int nrUsers = 1}) async {
    try {
      var response = await http.get(url(nrUsers), headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer kz7um5kncbtchf2qcmzt4bk4"
      });

      if (response.statusCode == 200) {
        print(response.body);
        /*Map data = json.decode(response.body);
        Iterable list = data["results"];
        List<User> users = list.map((l)=>User.fromJson(l)).toList();*/

        Map data = json.decode(response.body);
        /*// RoutesResponse routesResponse = ;
        print(data["getRoutesResponse"].toString());

        Map routesMap=json.decode(data["getRoutesResponse"].toString());*/

        /*Iterable res=data["getRoutesResponse"];
        List<RoutesResponse> users = res.map((l)=>RoutesResponse.fromJson(l)).toList();
        print(users.length);*/
        RoutesResponse res = RoutesResponse.fromJson(data['getRoutesResponse']);
        Iterable iterableRoutes = res.routes;
        List<RouteData> routes =
            iterableRoutes.map((l) => RouteData.fromJson(l)).toList();
        List<FlightSegments> segments = [];
        for (RouteData route in routes) {
          Iterable iterableSegment = route.segments;
          segments.addAll(
              iterableSegment.map((l) => FlightSegments.fromJson(l)).toList());
        }
        print(segments.length);

        for(FlightSegments segment in segments){

          print(segment.arrivalDatetimeLocal);
        }
        return [];
      } else {
        print(response.body);
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }
}
