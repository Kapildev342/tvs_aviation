import 'dart:convert';

import 'package:tvsaviation/data/hive/location/location_data.dart';

GetLocationModel getLocationModelFromJson(String str) => GetLocationModel.fromJson(json.decode(str));

String getLocationModelToJson(GetLocationModel data) => json.encode(data.toJson());

class GetLocationModel {
  final bool status;
  final String message;
  final List<LocationResponse> locations;

  GetLocationModel({
    required this.status,
    required this.message,
    required this.locations,
  });

  factory GetLocationModel.fromJson(Map<String, dynamic> json) => GetLocationModel(
        status: json["status"] ?? false,
        message: json["message"] ?? '',
        locations: List<LocationResponse>.from((json["locations"] ?? []).map((x) => LocationResponse.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "locations": List<dynamic>.from(locations.map((x) => x.toJson())),
      };
}
