import 'dart:convert';

List<CategoryListModel> getAllCategoryListModelFromJson(String str) => List<CategoryListModel>.from(json.decode(str).map((x) => CategoryListModel.fromJson(x)));

String getAllCategoryListModelToJson(List<CategoryListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetAllCategoryListModel {
  final bool status;
  final String message;
  final List<CategoryListModel> categories;

  GetAllCategoryListModel({
    required this.status,
    required this.message,
    required this.categories,
  });

  factory GetAllCategoryListModel.fromJson(Map<String, dynamic> json) => GetAllCategoryListModel(
        status: json["status"] ?? "",
        message: json["message"] ?? "",
        categories: List<CategoryListModel>.from((json["categories"] ?? []).map((x) => CategoryListModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "categories": categories,
      };
}

class CategoryListModel {
  final String id;
  final String name;
  final bool activeStatus;
  final String createdAt;
  final String updatedAt;

  CategoryListModel({
    required this.id,
    required this.name,
    required this.activeStatus,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CategoryListModel.fromJson(Map<String, dynamic> json) => CategoryListModel(
        id: json["_id"] ?? "",
        name: json["name"] ?? "",
        activeStatus: json["activeStatus"] ?? false,
        createdAt: json["createdAt"] ?? "",
        updatedAt: json["updatedAt"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "activeStatus": activeStatus,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      };
}
