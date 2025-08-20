import 'dart:convert';

GetWareHouseOrAirCraftModel getWareHouseOrAirCraftModelFromJson(String str) => GetWareHouseOrAirCraftModel.fromJson(json.decode(str));

String getWareHouseOrAirCraftModelToJson(GetWareHouseOrAirCraftModel data) => json.encode(data.toJson());

class GetWareHouseOrAirCraftModel {
  final bool status;
  final String message;
  final List<Location> locations;
  final int totalLocations;
  final int totalPages;
  final int currentPage;

  GetWareHouseOrAirCraftModel({
    required this.status,
    required this.message,
    required this.locations,
    required this.totalLocations,
    required this.totalPages,
    required this.currentPage,
  });

  factory GetWareHouseOrAirCraftModel.fromJson(Map<String, dynamic> json) => GetWareHouseOrAirCraftModel(
        status: json["status"] ?? false,
        message: json["message"] ?? "",
        locations: List<Location>.from((json["locations"] ?? []).map((x) => Location.fromJson(x))),
        totalLocations: json["totalLocations"] ?? 0,
        totalPages: json["totalPages"] ?? 1,
        currentPage: json["currentPage"] ?? 1,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "locations": List<dynamic>.from(locations.map((x) => x.toJson())),
        "totalLocations": totalLocations,
        "totalPages": totalPages,
        "currentPage": currentPage,
      };
}

class Location {
  final String id;
  final String name;
  final String type;
  final String createdAt;
  final String updatedAt;
  final bool activeStatus;

  Location({
    required this.id,
    required this.name,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
    required this.activeStatus,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        id: json["_id"] ?? "",
        name: json["name"] ?? "",
        type: json["type"] ?? '',
        createdAt: json["createdAt"] ?? '',
        updatedAt: json["updatedAt"] ?? '',
        activeStatus: json["activeStatus"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "type": type,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "activeStatus": activeStatus,
      };
}
