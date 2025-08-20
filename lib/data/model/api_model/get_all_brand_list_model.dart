import 'dart:convert';

GetAllBrandListModel getAllBrandListModelFromJson(String str) => GetAllBrandListModel.fromJson(json.decode(str));

String getAllBrandListModelToJson(GetAllBrandListModel data) => json.encode(data.toJson());

class GetAllBrandListModel {
  final bool status;
  final String message;
  final List<BrandType> brandTypes;

  GetAllBrandListModel({
    required this.status,
    required this.message,
    required this.brandTypes,
  });

  factory GetAllBrandListModel.fromJson(Map<String, dynamic> json) => GetAllBrandListModel(
        status: json["status"] ?? false,
        message: json["message"] ?? '',
        brandTypes: List<BrandType>.from((json["brandTypes"] ?? []).map((x) => BrandType.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "brandTypes": List<dynamic>.from(brandTypes.map((x) => x.toJson())),
      };
}

class BrandType {
  final String id;
  final String name;
  final String createdAt;
  final String updatedAt;

  BrandType({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BrandType.fromJson(Map<String, dynamic> json) => BrandType(
        id: json["_id"] ?? "",
        name: json["name"] ?? "",
        createdAt: json["createdAt"] ?? "",
        updatedAt: json["updatedAt"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      };
}
