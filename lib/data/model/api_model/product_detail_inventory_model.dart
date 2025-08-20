import 'dart:convert';

ProductDetailInventoryModel productCountByProductModelFromJson(String str) => ProductDetailInventoryModel.fromJson(json.decode(str));

String productCountByProductModelToJson(ProductDetailInventoryModel data) => json.encode(data.toJson());

class ProductDetailInventoryModel {
  final bool status;
  final String message;
  final int minLevel;
  final List<ProductDetail> productDetails;

  ProductDetailInventoryModel({
    required this.status,
    required this.message,
    required this.minLevel,
    required this.productDetails,
  });

  factory ProductDetailInventoryModel.fromJson(Map<String, dynamic> json) => ProductDetailInventoryModel(
        status: json["status"] ?? false,
        message: json["message"] ?? "",
        minLevel: json["minLevel"] ?? 0,
        productDetails: List<ProductDetail>.from((json["productDetails"] ?? []).map((x) => ProductDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "minLevel": minLevel,
        "productDetails": List<dynamic>.from(productDetails.map((x) => x.toJson())),
      };
}

class ProductDetail {
  final String inventoryId;
  final String barcode;
  final String expiryDate;
  final String locationId;
  final String locationName;
  final int quantity;
  final String purchaseDate;
  final String actionQty;

  ProductDetail({
    required this.inventoryId,
    required this.barcode,
    required this.expiryDate,
    required this.locationId,
    required this.locationName,
    required this.quantity,
    required this.purchaseDate,
    required this.actionQty,
  });

  factory ProductDetail.fromJson(Map<String, dynamic> json) => ProductDetail(
        inventoryId: json["inventoryId"] ?? "",
        barcode: json["barcode"] ?? "",
        expiryDate: json["expiryDate"] ?? "",
        locationId: json["locationId"] ?? "",
        locationName: json["locationName"] ?? "",
        quantity: json["quantity"] ?? 0,
        purchaseDate: json["purchaseDate"] ?? "",
    actionQty: (json["cartCount"] ?? 0).toString(),
      );

  Map<String, dynamic> toJson() => {
        "inventoryId": inventoryId,
        "barcode": barcode,
        "expiryDate": expiryDate,
        "locationId": locationId,
        "locationName": locationName,
        "quantity": quantity,
        "purchaseDate": purchaseDate,
        "cartCount": actionQty,
      };
}
