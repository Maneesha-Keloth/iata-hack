class ShipmentResponse{
  String id;
  String status;
  ShipmentResponse.fromJson(Map json)
      : id=json['id'],
        status=json['status'];
}