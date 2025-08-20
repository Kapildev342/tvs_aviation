import 'dart:convert';

GetCategoryModel getCategoryModelFromJson(String str) => GetCategoryModel.fromJson(json.decode(str));

String getCategoryModelToJson(GetCategoryModel data) => json.encode(data.toJson());

class GetCategoryModel {
  final bool status;
  final String message;
  final List<Category> categories;
  final int totalCategories;
  final int totalPages;
  final int currentPage;

  GetCategoryModel({
    required this.status,
    required this.message,
    required this.categories,
    required this.totalCategories,
    required this.totalPages,
    required this.currentPage,
  });

  factory GetCategoryModel.fromJson(Map<String, dynamic> json) => GetCategoryModel(
        status: json["status"] ?? false,
        message: json["message"] ?? "",
        categories: List<Category>.from((json["categories"] ?? []).map((x) => Category.fromJson(x))),
        totalCategories: json["totalCategories"] ?? 0,
        totalPages: json["totalPages"] ?? 1,
        currentPage: json["currentPage"] ?? 1,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
        "totalCategories": totalCategories,
        "totalPages": totalPages,
        "currentPage": currentPage,
      };
}

class Category {
  final String id;
  final String name;
  final bool activeStatus;
  final String createdAt;
  final String updatedAt;

  Category({
    required this.id,
    required this.name,
    required this.activeStatus,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["_id"] ?? "",
        name: json["name"] ?? "",
        activeStatus: json["activeStatus"] ?? false,
        createdAt: json["createdAt"] ?? "",
        updatedAt: json["updatedAt"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "activeStatus": activeStatus,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      };
}
