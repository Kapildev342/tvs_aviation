import 'dart:convert';

GetBrandTypeModel getBrandTypeModelFromJson(String str) => GetBrandTypeModel.fromJson(json.decode(str));

String getBrandTypeModelToJson(GetBrandTypeModel data) => json.encode(data.toJson());

class GetBrandTypeModel {
  final bool status;
  final List<BrandType> brandType;
  final int totalBrands;
  final int totalPages;
  final int currentPage;

  GetBrandTypeModel({
    required this.status,
    required this.brandType,
    required this.totalBrands,
    required this.totalPages,
    required this.currentPage,
  });

  factory GetBrandTypeModel.fromJson(Map<String, dynamic> json) => GetBrandTypeModel(
        status: json["status"] ?? false,
        brandType: List<BrandType>.from((json["brandType"] ?? "").map((x) => BrandType.fromJson(x))),
        totalBrands: json["totalBrands"] ?? 0,
        totalPages: json["totalPages"] ?? 1,
        currentPage: json["currentPage"] ?? 1,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "brandType": List<dynamic>.from(brandType.map((x) => x.toJson())),
        "totalBrands": totalBrands,
        "totalPages": totalPages,
        "currentPage": currentPage,
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
