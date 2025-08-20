import 'dart:convert';

GetInventoryCategoryModel getInventoryCategoryModelFromJson(String str) => GetInventoryCategoryModel.fromJson(json.decode(str));

String getInventoryCategoryModelToJson(GetInventoryCategoryModel data) => json.encode(data.toJson());

class GetInventoryCategoryModel {
  final bool status;
  final List<Category> categories;

  GetInventoryCategoryModel({
    required this.status,
    required this.categories,
  });

  factory GetInventoryCategoryModel.fromJson(Map<String, dynamic> json) => GetInventoryCategoryModel(
        status: json["status"] ?? false,
        categories: List<Category>.from((json["categories"] ?? []).map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
      };
}

class Category {
  final String id;
  final String name;

  Category({
    required this.id,
    required this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["_id"] ?? "",
        name: json["name"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
      };
}
