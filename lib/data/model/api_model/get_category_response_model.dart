import 'dart:convert';

import 'package:tvsaviation/data/hive/category/category_data.dart';

GetCategoryResponseModel categoryResponseModelFromJson(String str) => GetCategoryResponseModel.fromJson(json.decode(str));

String categoryResponseModelToJson(GetCategoryResponseModel data) => json.encode(data.toJson());

class GetCategoryResponseModel {
  final bool status;
  final List<CategoryResponse> categoryResponse;
  final String message;

  GetCategoryResponseModel({
    required this.status,
    required this.categoryResponse,
    required this.message,
  });

  factory GetCategoryResponseModel.fromJson(Map<String, dynamic> json) => GetCategoryResponseModel(
        status: json["status"] ?? false,
        categoryResponse: List<CategoryResponse>.from((json["categories"] ?? []).map((x) => CategoryResponse.fromJson(x))),
        message: json["message"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "categories": List<dynamic>.from(categoryResponse.map((x) => x.toJson())),
        "message": message,
      };
}
