// To parse this JSON data, do
//
//     final findPlaceModel = findPlaceModelFromJson(jsonString);

import 'dart:convert';

FindPlaceModel findPlaceModelFromJson(String str) =>
    FindPlaceModel.fromJson(json.decode(str));

String findPlaceModelToJson(FindPlaceModel data) => json.encode(data.toJson());

class FindPlaceModel {
  List<Candidate> candidates;
  String status;

  FindPlaceModel({
    required this.candidates,
    required this.status,
  });

  FindPlaceModel copyWith({
    List<Candidate>? candidates,
    String? status,
  }) =>
      FindPlaceModel(
        candidates: candidates ?? this.candidates,
        status: status ?? this.status,
      );

  factory FindPlaceModel.fromJson(Map<String, dynamic> json) => FindPlaceModel(
        candidates: List<Candidate>.from(
            json["candidates"].map((x) => Candidate.fromJson(x))),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "candidates": List<dynamic>.from(candidates.map((x) => x.toJson())),
        "status": status,
      };
}

class Candidate {
  String formattedAddress;
  Geometry geometry;
  String name;

  Candidate({
    required this.formattedAddress,
    required this.geometry,
    required this.name,
  });

  Candidate copyWith({
    String? formattedAddress,
    Geometry? geometry,
    String? name,
  }) =>
      Candidate(
        formattedAddress: formattedAddress ?? this.formattedAddress,
        geometry: geometry ?? this.geometry,
        name: name ?? this.name,
      );

  factory Candidate.fromJson(Map<String, dynamic> json) => Candidate(
        formattedAddress: json["formatted_address"],
        geometry: Geometry.fromJson(json["geometry"]),
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "formatted_address": formattedAddress,
        "geometry": geometry.toJson(),
        "name": name,
      };
}

class Geometry {
  Location location;
  Viewport viewport;

  Geometry({
    required this.location,
    required this.viewport,
  });

  Geometry copyWith({
    Location? location,
    Viewport? viewport,
  }) =>
      Geometry(
        location: location ?? this.location,
        viewport: viewport ?? this.viewport,
      );

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        location: Location.fromJson(json["location"]),
        viewport: Viewport.fromJson(json["viewport"]),
      );

  Map<String, dynamic> toJson() => {
        "location": location.toJson(),
        "viewport": viewport.toJson(),
      };
}

class Location {
  double lat;
  double lng;

  Location({
    required this.lat,
    required this.lng,
  });

  Location copyWith({
    double? lat,
    double? lng,
  }) =>
      Location(
        lat: lat ?? this.lat,
        lng: lng ?? this.lng,
      );

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        lat: json["lat"]?.toDouble(),
        lng: json["lng"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
      };
}

class Viewport {
  Location northeast;
  Location southwest;

  Viewport({
    required this.northeast,
    required this.southwest,
  });

  Viewport copyWith({
    Location? northeast,
    Location? southwest,
  }) =>
      Viewport(
        northeast: northeast ?? this.northeast,
        southwest: southwest ?? this.southwest,
      );

  factory Viewport.fromJson(Map<String, dynamic> json) => Viewport(
        northeast: Location.fromJson(json["northeast"]),
        southwest: Location.fromJson(json["southwest"]),
      );

  Map<String, dynamic> toJson() => {
        "northeast": northeast.toJson(),
        "southwest": southwest.toJson(),
      };
}
