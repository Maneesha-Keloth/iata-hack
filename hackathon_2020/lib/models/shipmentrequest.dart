class ShipmentRequest{

  final String originAirportCode;
  final String destinationAirportCode;
  final String packageCode;
  final ShipmentDetail shipmentDetails;
  ShipmentRequest(this.originAirportCode,this.destinationAirportCode,this.packageCode,this.shipmentDetails);
  Map<String, dynamic> toJson(){
    return {
      "originAirportCode": this.originAirportCode,
      "destinationAirportCode": this.destinationAirportCode,
      "packageCode": this.packageCode,
      "shipmentDetails": this.shipmentDetails
    };
  }
}
class ShipmentDetail{
  final int numberOfPieces;
  final double volume;
  final String volumeUnit;
  final double weight;
  final String weightUnit;
  final List<dynamic> looseDetails;
  ShipmentDetail(this.numberOfPieces,this.volume,this.volumeUnit,this.weight,this.weightUnit,this.looseDetails);
  Map<String, dynamic> toJson(){
    return {
      "numberOfPieces": this.numberOfPieces,
      "volume": this.volume,
      "volumeUnit": this.volumeUnit,
      "weight": this.weight,
      "weightUnit":this.weightUnit,
      "looseDetails":this.looseDetails,
    };
  }
}

class LooseDetail{
  final int numberOfPieces;
  final double height;
  final double length;
  final double width;
  final bool stackable;
  final bool turnable;
  final double weightPerPiece;
  final String dimensionUnit;
  LooseDetail(this.numberOfPieces,this.height,this.length,this.width,this.stackable,this.turnable,this.weightPerPiece,this.dimensionUnit);
  Map<String, dynamic> toJson(){
    return {
      "numberOfPieces": this.numberOfPieces,
      "height": this.height,
      "length": this.length,
      "width": this.width,
      "stackable":this.stackable,
      "turnable":this.turnable,
      "weightPerPiece":this.weightPerPiece,
      "dimensionUnit":this.dimensionUnit,
    };
  }
}