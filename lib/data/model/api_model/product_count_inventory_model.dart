import 'dart:convert';

ProductCountInventoryModel productCountByLocationModelFromJson(String str) => ProductCountInventoryModel.fromJson(json.decode(str));

String productCountByLocationModelToJson(ProductCountInventoryModel data) => json.encode(data.toJson());

class ProductCountInventoryModel {
  final bool status;
  final String message;
  final List<Location> locations;

  ProductCountInventoryModel({
    required this.status,
    required this.message,
    required this.locations,
  });

  factory ProductCountInventoryModel.fromJson(Map<String, dynamic> json) => ProductCountInventoryModel(
        status: json["status"] ?? false,
        message: json["message"] ?? "",
        locations: List<Location>.from((json["locations"] ?? []).map((x) => Location.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "locations": List<dynamic>.from(locations.map((x) => x.toJson())),
      };
}

class Location {
  final String locationId;
  final String locationName;
  final int totalQuantity;

  Location({
    required this.locationId,
    required this.locationName,
    required this.totalQuantity,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        locationId: json["locationId"] ?? "",
        locationName: json["locationName"] ?? "",
        totalQuantity: json["totalQuantity"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "locationId": locationId,
        "locationName": locationName,
        "totalQuantity": totalQuantity,
      };
}
