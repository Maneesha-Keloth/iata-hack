import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'models/Booking.dart';

Future<String> saveBooking(Booking booking) async {
String requestBody = jsonEncode(booking);
print(requestBody);
final response =
  await http.post("https://hackathon2020-test.herokuapp.com/companies/Lufthansa/los", headers: {
    "Content-Type": "application/ld+json",
  }, body:requestBody);
print(response.statusCode);
return response.headers["Location"];
}