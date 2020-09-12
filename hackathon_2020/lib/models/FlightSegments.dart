class GetRoutesResponse {

  final RoutesResponse getRoutesResponse;

  GetRoutesResponse({

    this.getRoutesResponse,
  });

  GetRoutesResponse.fromJson(Map json)
      : getRoutesResponse = json['getRoutesResponse'];
}

class RoutesResponse{

  final double requestID;
  final List<dynamic> routes;
  final dynamic routeHeaderInformation;
  RoutesResponse.fromJson(Map json)
      : requestID=json['requestID'],
        routes=json['routes'],
        routeHeaderInformation=json['routeHeaderInformation'];
}
class RouteHeader{
  final String latestTOAFromOfferedRoutings;
  final String productCode;
  final String latForLaterFlightSearch;
  final String toaForEarlierFlightSearch;
  final String shipmentDestination;
  final String earliestLATFromOfferedRoutings;
  final String shipmentOrigin;
  RouteHeader.fromJson(Map json)
      : latestTOAFromOfferedRoutings=json['latestTOAFromOfferedRoutings'],
        productCode=json['productCode'],
        latForLaterFlightSearch=json['latForLaterFlightSearch'],
        toaForEarlierFlightSearch=json['toaForEarlierFlightSearch'],
        shipmentDestination=json['shipmentDestination'],
        earliestLATFromOfferedRoutings=json['earliestLATFromOfferedRoutings'],
        shipmentOrigin=json['shipmentOrigin'];
}
class RouteData{
  final String earliestTimeOfAvailabilityOfRouting;
  final List<dynamic> segments;
  final String latestAcceptanceTimeOfRouting;
  final double routeNo;
  RouteData.fromJson(Map json)
      : earliestTimeOfAvailabilityOfRouting=json['earliestTimeOfAvailabilityOfRouting'],
        segments=json['FlightSegments'],
        latestAcceptanceTimeOfRouting=json['latestAcceptanceTimeOfRouting'],
        routeNo=json['routeNo'];
}
class FlightSegments{
  final String aircraftType;
  final String flightOriginDate;
  final String flightSegmentDestination;
  final double flightSegmentNo;
  final String departureDateTimeLocal;
  final String flightNumber;
  final String flightSegmentOrigin;
  final String arrivalDatetimeLocal;
  FlightSegments.fromJson(Map json)
      : aircraftType = json['aircraftType'],
        flightOriginDate = json['flightOriginDate'],
        flightSegmentDestination = json['flightSegmentDestination'],
        flightSegmentNo= json['flightSegmentNo'],
        departureDateTimeLocal= json['departureDateTimeLocal'],
        flightNumber= json['flightNumber'],
        flightSegmentOrigin=json['flightSegmentOrigin'],
        arrivalDatetimeLocal=json['arrivalDatetimeLocal'];
}