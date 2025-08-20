import 'dart:convert';

GetProductListModel getProductListModelFromJson(String str) => GetProductListModel.fromJson(json.decode(str));

String getProductListModelToJson(GetProductListModel data) => json.encode(data.toJson());

class GetProductListModel {
  final bool status;
  final List<NewProductResponse> products;
  final int totalProducts;
  final int totalPages;
  final int currentPage;

  GetProductListModel({
    required this.status,
    required this.products,
    required this.totalProducts,
    required this.totalPages,
    required this.currentPage,
  });

  factory GetProductListModel.fromJson(Map<String, dynamic> json) => GetProductListModel(
        status: json["status"] ?? false,
        products: List<NewProductResponse>.from((json["products"] ?? []).map((x) => NewProductResponse.fromJson(x))),
        totalProducts: json["totalProducts"] ?? 0,
        totalPages: json["totalPages"] ?? 1,
        currentPage: json["currentPage"] ?? 1,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
        "totalProducts": totalProducts,
        "totalPages": totalPages,
        "currentPage": currentPage,
      };
}

class NewProductResponse {
  final String id;
  final String productName;
  final String productImage;
  final bool activeStatus;
  final String categoryName;
  final String categoryId;
  final String brandTypeName;
  final String brandTypeId;
  final String combinedName;
  final int daysUntilExpiry;

  NewProductResponse({
    required this.id,
    required this.productName,
    required this.productImage,
    required this.activeStatus,
    required this.categoryName,
    required this.categoryId,
    required this.brandTypeName,
    required this.brandTypeId,
    required this.combinedName,
    required this.daysUntilExpiry,
  });

  factory NewProductResponse.fromJson(Map<String, dynamic> json) => NewProductResponse(
        id: json["_id"] ?? "",
        productName: json["productName"] ?? "",
        productImage: json["productImage"] ?? "",
        activeStatus: json["activeStatus"] ?? false,
        categoryName: json["categoryName"] ?? "",
        categoryId: json["categoryId"] ?? "",
        brandTypeName: json["brandTypeName"] ?? "",
        brandTypeId: json["brandTypeId"] ?? "",
        combinedName: json["combinedName"] ?? "",
        daysUntilExpiry: json["daysUntilExpiry"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "productName": productName,
        "productImage": productImage,
        "activeStatus": activeStatus,
        "categoryName": categoryName,
        "categoryId": categoryId,
        "brandTypeName": brandTypeName,
        "brandTypeId": brandTypeId,
        "combinedName": combinedName,
        "daysUntilExpiry": daysUntilExpiry,
      };
}
