import 'FlightSegments.dart';
import 'partner.dart';
import 'shipment.dart';

class Booking{
  Booking(this.shipmentInfo,this.flightSegmentInfo,this.pickupPartner,this.deliveryPartner);
  final Shipment shipmentInfo;
  final FlightSegments flightSegmentInfo;
  final Partner pickupPartner;
  final Partner deliveryPartner;

  Map toJson() => {
    "@type": [
        "https://onerecord.iata.org/Booking"
    ],
    "https://onerecord.iata.org/Booking#carrier": [
        {
            "@type": [
                "https://onerecord.iata.org/Company"
            ],
            "https://onerecord.iata.org/Company#airlineCode": "A1",
            "https://onerecord.iata.org/Company#airlinePrefix": 0,
           
            "https://onerecord.iata.org/Company#companyName": pickupPartner.partnerName,
            "https://onerecord.iata.org/Company#iataCargoAgentCode": 0,
            "id": "A1"
        }
    ],
    "https://onerecord.iata.org/Booking#consignee": {
        "@type": [
            "https://onerecord.iata.org/Company"
        ],
        "https://onerecord.iata.org/Company#airlineCode": "A1",
        "https://onerecord.iata.org/Company#airlinePrefix": 0,
        "https://onerecord.iata.org/Company#companyName": deliveryPartner.partnerName,
        "https://onerecord.iata.org/Company#iataCargoAgentCode": 0,
        "id": "A1"
    },
    "https://onerecord.iata.org/Booking#freightForwarder": [
        {
            "@type": [
                "https://onerecord.iata.org/Company"
            ],
            "https://onerecord.iata.org/Company#airlineCode": "A1",
            "https://onerecord.iata.org/Company#airlinePrefix": 0,
            "https://onerecord.iata.org/Company#companyName": "A1",
            "https://onerecord.iata.org/Company#iataCargoAgentCode": 123123,
            "id": "A1"
        }
    ],
      "https://onerecord.iata.org/Booking#offer": {
    "@type": [
      "https://onerecord.iata.org/Offer"
    ],
    "https://onerecord.iata.org/LogisticsObject#companyIdentifier": "http://localhost:8080/companies/A1",
    "https://onerecord.iata.org/Offer#commodity": {
      "@type": [
        "https://onerecord.iata.org/Product"
      ],
      "https://onerecord.iata.org/LogisticsObject#companyIdentifier": shipmentInfo.commodity,
      "https://onerecord.iata.org/Product#commodityCode": shipmentInfo.commodity,
      "https://onerecord.iata.org/Product#commodityDescription": "Live Animal",
      "https://onerecord.iata.org/Product#commodityName": "Live Animals",
      "https://onerecord.iata.org/Product#commodityType": "GEN"
    },
    "https://onerecord.iata.org/Offer#requestMatchInd": true,
    "https://onerecord.iata.org/Offer#shipmentDetails": {
      "@type": [
        "https://onerecord.iata.org/Shipment"
      ],
      "https://onerecord.iata.org/LogisticsObject#companyIdentifier": "http://localhost:8080/companies/A1",
      "https://onerecord.iata.org/Shipment#totalGrossWeight": {
        "@type": [
          "https://onerecord.iata.org/Value"
        ],
        "https://onerecord.iata.org/Value#unit": "K",
        "https://onerecord.iata.org/Value#value": shipmentInfo.weight,
        "id": "string"
      },
      "https://onerecord.iata.org/Shipment#totalPieceCount": 1,
      "https://onerecord.iata.org/Shipment#totalSLAC": 1,
      "https://onerecord.iata.org/Shipment#volumetricWeight": [
        {
          "@type": [
            "https://onerecord.iata.org/VolumetricWeight"
          ],
          "https://onerecord.iata.org/VolumetricWeight#chargeableWeight": {
            "@type": [
              "https://onerecord.iata.org/Value"
            ],
            "https://onerecord.iata.org/Value#unit": "L",
            "https://onerecord.iata.org/Value#value": 100          
          }
        }
      ],
      "https://onerecord.iata.org/Shipment#waybillNumber": {
        "@type": [
          "https://onerecord.iata.org/Waybill"
        ],
        "https://onerecord.iata.org/LogisticsObject#companyIdentifier": "http://localhost:8080/companies/A1",
        "https://onerecord.iata.org/Waybill#waybillNumber": 12312311,
        "https://onerecord.iata.org/Waybill#waybillType": "Console"
      }
    },
    "https://onerecord.iata.org/Offer#transportMovement": {
      "@type": [
        "https://onerecord.iata.org/TransportSegment"
      ],
      "https://onerecord.iata.org/LogisticsObject#companyIdentifier": "http://localhost:8080/companies/A1",
      "https://onerecord.iata.org/TransportSegment#arrivalLocation": {
        "@type": [
          "https://onerecord.iata.org/Location"
        ],
        "https://onerecord.iata.org/Location#code": flightSegmentInfo.flightSegmentOrigin,
        "https://onerecord.iata.org/Location#locationName": "Singapore",
        "https://onerecord.iata.org/Location#locationType": "ARP"
      },
      "https://onerecord.iata.org/TransportSegment#departureLocation": {
        "@type": [
          "https://onerecord.iata.org/Location"
        ],
        "https://onerecord.iata.org/Location#code": flightSegmentInfo.flightSegmentDestination,

        "https://onerecord.iata.org/Location#locationName": "Frankfurt",
        "https://onerecord.iata.org/Location#locationType": "ARP"
      }
    }
  },
    "https://onerecord.iata.org/Booking#price": {
        "@type": [
            "https://onerecord.iata.org/Price"
        ],
        "https://onerecord.iata.org/LogisticsObject#companyIdentifier": "http://localhost:8080/companies/A1",
        "https://onerecord.iata.org/Price#ratings": {
            "@type": [
                "https://onerecord.iata.org/Ratings"
            ],
            "https://onerecord.iata.org/LogisticsObject#companyIdentifier": "http://localhost:8080/companies/A1",
            "https://onerecord.iata.org/Ratings#chargeCode": "C1",
            "https://onerecord.iata.org/Ratings#chargeDescription": "Best",
            "https://onerecord.iata.org/Ratings#chargeType": "IATA",
            "https://onerecord.iata.org/Ratings#priceSpecification": "S1",
            "https://onerecord.iata.org/Ratings#priceSpecificationRef": "S1",
            "id": "R1"
        },
        "id": "Price001"
    },
    "https://onerecord.iata.org/Booking#shipper": {
        "@type": [
            "https://onerecord.iata.org/Company"
        ],
        "https://onerecord.iata.org/Company#airlineCode": "A1",
        "https://onerecord.iata.org/Company#airlinePrefix": 0,
        "https://onerecord.iata.org/Company#companyName": "A1",
        "https://onerecord.iata.org/Company#iataCargoAgentCode": 0,
        "id": "A1"
    },
    "https://onerecord.iata.org/Booking#waybillNumber": {
        "@type": [
            "https://onerecord.iata.org/Waybill"
        ],
        "https://onerecord.iata.org/LogisticsObject#companyIdentifier": "http://localhost:8080/companies/A1",
        "https://onerecord.iata.org/Waybill#waybillNumber": 12312311,
        "https://onerecord.iata.org/Waybill#waybillType": "Console",
        "id": "Waybill_12312311"
    },
    "https://onerecord.iata.org/LogisticsObject#companyIdentifier": "http://localhost:8080/companies/A1"
};

}