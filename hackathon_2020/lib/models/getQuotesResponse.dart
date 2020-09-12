class GetQuotesResponse {
  final List<dynamic> quotesList;
  GetQuotesResponse({
    this.quotesList,
  });

  GetQuotesResponse.fromJson(Map json) : quotesList = json['quotesList'];
}

class Quote {
  final String quoteDiscriminator;
  final String hash;
  final String quoteId;
  final String status;
  final dynamic shippingPlan;
  final dynamic additionalShipmentInfo;
  final dynamic price;
  final dynamic quoteInfo;
  final dynamic productInfo;
  final List<dynamic> links;
  Quote.fromJson(Map json)
      : quoteDiscriminator = json['quoteDiscriminator'],
        hash = json['hash'],
        quoteId = json['quoteId'],
        status = json['status'],
        shippingPlan = json['shippingPlan'],
        additionalShipmentInfo = json['additionalShipmentInfo'],
        price = json['price'],
        quoteInfo = json['quoteInfo'],
        productInfo = json['productInfo'],
        links = json['links'];
}

class ShippingPlan {
  final String marketingAwbPrefix;
  final dynamic marketingFlight;
  final String transportTime;
  final String estimatedTimeOfAvailability;
  final List<dynamic> flights;
  ShippingPlan.fromJson(Map json)
      : marketingAwbPrefix = json['marketingAwbPrefix'],
        marketingFlight = json['marketingFlight'],
        transportTime = json['transportTime'],
        estimatedTimeOfAvailability = json['estimatedTimeOfAvailability'],
        flights = json['flights'];
}

class Flight {
  final String flightDiscriminator;
  final String flight;
  final String flightDate;
  final String boardPoint;
  final String offPoint;
  final String scheduledTimeOfDeparture;
  final String scheduledTimeOfArrival;
  final String aircraftType;
  final String serviceType;
  final String marketingCarrierCode;
  final String operatingCarrierCode;
  Flight.fromJson(Map json)
      : flightDiscriminator = json['flightDiscriminator'],
        flight = json['flight'],
        flightDate = json['flightDate'],
        boardPoint = json['boardPoint'],
        offPoint = json['offPoint'],
        scheduledTimeOfDeparture = json['scheduledTimeOfDeparture'],
        scheduledTimeOfArrival = json['scheduledTimeOfArrival'],
        aircraftType = json['aircraftType'],
        serviceType = json['serviceType'],
        marketingCarrierCode = json['marketingCarrierCode'],
        operatingCarrierCode = json['marketingCarrierCode'];
}

class AdditionalShipmentInfo {
  final String serviceLevel;
  final bool knownShipper;
  final bool shipmentSecured;
  AdditionalShipmentInfo.fromJson(Map json)
      : serviceLevel = json['serviceLevel'],
        knownShipper = json['knownShipper'],
        shipmentSecured = json['shipmentSecured'];
}

class Price {
  final String currencyCode;
  final double total;
  final dynamic freightCharges;
  final dynamic surcharges;
  Price.fromJson(Map json)
      : currencyCode = json['currencyCode'],
        total = json['total'],
        freightCharges = json['freightCharges'],
        surcharges = json['surcharges'];
}

class FreightCharge {
  final double total;
  final List<dynamic> freightChargeInfo;
  FreightCharge.fromJson(Map json)
      : total = json['total'],
        freightChargeInfo = json['freightChargeInfo'];
}

class FreightChargeInfo {
  final String rateType;
  final String rateUnit;
  final double rate;
  final double total;
  FreightChargeInfo.fromJson(Map json)
      : rateType = json['rateType'],
        rateUnit = json['rateUnit'],
        rate = json['rate'],
        total = json['total'];
}

class SurCharge {
  final double total;
  SurCharge.fromJson(Map json) : total = json['total'];
}

class QuoteInfo {
  final String additionalPriceInformation;
  final String additionalCapacityInformation;
  final bool isOnlineBookable;
  QuoteInfo.fromJson(Map json)
      : additionalPriceInformation = json['additionalPriceInformation'],
        additionalCapacityInformation = json['additionalCapacityInformation'],
        isOnlineBookable = json['isOnlineBookable'];
}

class ProductInfo {
  final String commodity;
  final List<String> specialHandlingCodes;
  final String productCode;
  final String packageCode;
  final String serviceLevel;
  ProductInfo.fromJson(Map json)
      : commodity = json['commodity'],
        specialHandlingCodes = json['specialHandlingCodes'],
        productCode = json['productCode'],
        packageCode = json['productCode'],
        serviceLevel = json['productCode'];
}

class Link {
  final String url;
  final String description;
  Link.fromJson(Map json)
      : url = json['url'],
        description = json['description'];
}
