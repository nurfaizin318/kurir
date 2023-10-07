import 'dart:convert';

DestinationModel destinationModelFromJson(String str) =>
    DestinationModel.fromJson(json.decode(str));

String destinationModelToJson(DestinationModel data) =>
    json.encode(data.toJson());

class DestinationModel {
  String name;
  String address;
  String latitude;
  String longitude;
  String distance;
  String amount;

  DestinationModel({
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.distance,
    required this.amount,
  });

  DestinationModel copyWith({
    String? name,
    String? address,
    String? latitude,
    String? longitude,
    String? distance,
    String? amount,
  }) =>
      DestinationModel(
        name: name ?? this.name,
        address: address ?? this.address,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        distance: distance ?? this.distance,
        amount: amount ?? this.amount,
      );

  factory DestinationModel.fromJson(Map<String, dynamic> json) =>
      DestinationModel(
        name: json["name"],
        address: json["address"],
        latitude: json["latitude "],
        longitude: json["longitude"],
        distance: json["distance"],
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "address": address,
        "latitude ": latitude,
        "longitude": longitude,
        "distance": distance,
        "amount": amount,
      };
}
