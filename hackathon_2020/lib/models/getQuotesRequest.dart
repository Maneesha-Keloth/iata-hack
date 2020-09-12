class GetQuotesRequest{

  final String requestedDate;
  final AdditionalShipmentInformation additionalShipmentInfo;

  GetQuotesRequest(this.requestedDate,this.additionalShipmentInfo);

  Map<String, dynamic> toJson(){
    return {
      "requestedDate": this.requestedDate,
      "additionalShipmentInfo": this.additionalShipmentInfo
    };
  }
}

class AdditionalShipmentInformation{

  final String serviceLevel;
  final bool knownShipper;
  final bool shipmentSecured;
  AdditionalShipmentInformation(this.serviceLevel,this.knownShipper,this.shipmentSecured);
  Map<String, dynamic> toJson(){
    return {
      "serviceLevel": this.serviceLevel,
      "knownShipper": this.knownShipper,
      "shipmentSecured": this.shipmentSecured
    };
  }
}