import 'package:flutter/material.dart';

class Shipment{
  String origin;
  String originDescription;
  String destinationDescription;
  String destination;
  int pieces;
  double weight;
  String commodity;
  DateTime shippingDate;
  double height;
  double width;
  double length;
  String dimensionUnit;
  String weightUnit;
  String volumneUnit;
  double volume;
  String shipmentId;
  Shipment(this.origin,this.originDescription, this.destination,this.destinationDescription, this.pieces, this.weightUnit,this.weight,this.commodity,this.shippingDate,
      this.height,this.width,this.length,this.dimensionUnit,this.volumneUnit,this.volume,this.shipmentId);
}