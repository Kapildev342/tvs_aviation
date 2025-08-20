import 'dart:convert';

InventoryProductListModel inventoryProductListModelFromJson(String str) => InventoryProductListModel.fromJson(json.decode(str));

String inventoryProductListModelToJson(InventoryProductListModel data) => json.encode(data.toJson());

class InventoryProductListModel {
  final bool status;
  final List<ProductList> products;
  final String message;

  InventoryProductListModel({
    required this.status,
    required this.products,
    required this.message,
  });

  factory InventoryProductListModel.fromJson(Map<String, dynamic> json) => InventoryProductListModel(
      status: json["status"] ?? false,
      products: List<ProductList>.from((json["result"] ?? []).map((x) => ProductList.fromJson(x))),
      message: json["message"] ?? "");

  Map<String, dynamic> toJson() => {
        "status": status,
        "result": List<dynamic>.from(products.map((x) => x.toJson())),
        "message": message,
      };
}

class ProductList {
  int totalQuantity;
  String productName;
  String brandType;
  String productImage;
  String filter;
  String productId;
  String stockType;
  String categoryId;
  String categoryName;
  bool hasExpiry;

  ProductList({
    required this.totalQuantity,
    required this.productName,
    required this.brandType,
    required this.productImage,
    required this.filter,
    required this.productId,
    required this.stockType,
    required this.categoryId,
    required this.categoryName,
    required this.hasExpiry,
  });

  factory ProductList.fromJson(Map<String, dynamic> json) => ProductList(
        totalQuantity: json["totalQuantity"] ?? 0,
        productName: json["productName"] ?? '',
        brandType: json["brandType"] ?? '',
        productImage: json["productImage"] ?? '',
        filter: json["filter"] ?? "",
        productId: json["productId"] ?? '',
        stockType: json["stockType"] ?? '',
        categoryId: json["category"] ?? '',
        categoryName: json["categoryName"] ?? '',
        hasExpiry: json["hasExpiry"] ?? true,
      );

  Map<String, dynamic> toJson() => {
        "totalQuantity": totalQuantity,
        "productName": productName,
        "brandType": brandType,
        "productImage": productImage,
        "filter": filter,
        "productId": productId,
        "stockType": stockType,
        "category": categoryId,
        "categoryName": categoryName,
        "hasExpiry": hasExpiry,
      };
}
