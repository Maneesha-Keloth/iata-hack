class Flight {
  Flight(this.airlineCode, this.flightNum, this.flightDate, this.origin, this.destination,
      this.arrival, this.departure, this.rate);
  final String airlineCode;
  final String flightNum;
  final String flightDate;
  final String origin;
  final String destination;
  final String arrival;
  final String departure;
  final double rate;
  bool selected = false;
}