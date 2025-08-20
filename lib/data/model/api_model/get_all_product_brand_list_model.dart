import 'dart:convert';

GetAllProductBrandListModel getAllProductBrandListModelFromJson(String str) => GetAllProductBrandListModel.fromJson(json.decode(str));

String getAllProductBrandListModelToJson(GetAllProductBrandListModel data) => json.encode(data.toJson());

class GetAllProductBrandListModel {
  final bool status;
  final String message;
  final List<Product> products;

  GetAllProductBrandListModel({
    required this.status,
    required this.message,
    required this.products,
  });

  factory GetAllProductBrandListModel.fromJson(Map<String, dynamic> json) => GetAllProductBrandListModel(
        status: json["status"] ?? false,
        message: json["message"] ?? "",
        products: List<Product>.from((json["products"] ?? []).map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
      };
}

class Product {
  final String id;
  final String combinedName;

  Product({
    required this.id,
    required this.combinedName,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["_id"] ?? "",
        combinedName: json["combinedName"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "combinedName": combinedName,
      };
}
