import 'dart:convert';

GetSingleProductDetails getSingleProductDetailsFromJson(String str) => GetSingleProductDetails.fromJson(json.decode(str));

String getSingleProductDetailsToJson(GetSingleProductDetails data) => json.encode(data.toJson());

class GetSingleProductDetails {
  final bool status;
  final Product product;

  GetSingleProductDetails({
    required this.status,
    required this.product,
  });

  factory GetSingleProductDetails.fromJson(Map<String, dynamic> json) => GetSingleProductDetails(
        status: json["status"] ?? false,
        product: Product.fromJson(json["product"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "product": product.toJson(),
      };
}

class Product {
  final String id;
  final String productName;
  final BrandType brandType;
  final String productImage;
  final Category category;
  final int daysUntilExpiry;
  final bool activeStatus;
  final String createdAt;
  final String updatedAt;

  Product({
    required this.id,
    required this.productName,
    required this.brandType,
    required this.productImage,
    required this.category,
    required this.daysUntilExpiry,
    required this.activeStatus,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["_id"] ?? "",
        productName: json["productName"] ?? "",
        brandType: BrandType.fromJson(json["brandType"] ?? {}),
        productImage: json["productImage"] ?? "",
        category: Category.fromJson(json["category"] ?? {}),
        daysUntilExpiry: json["daysUntilExpiry"] ?? 0,
        activeStatus: json["activeStatus"] ?? false,
        createdAt: json["createdAt"] ?? "",
        updatedAt: json["updatedAt"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "productName": productName,
        "brandType": brandType.toJson(),
        "productImage": productImage,
        "category": category.toJson(),
        "daysUntilExpiry": daysUntilExpiry,
        "activeStatus": activeStatus,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
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
