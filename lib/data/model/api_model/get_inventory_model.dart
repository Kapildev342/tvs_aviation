import 'dart:convert';

GetInventoryModel getInventoryModelFromJson(String str) => GetInventoryModel.fromJson(json.decode(str));

String getInventoryModelToJson(GetInventoryModel data) => json.encode(data.toJson());

class GetInventoryModel {
  final bool status;
  final String message;
  final int totalPages;
  final int page;
  final List<Inventory> inventory;

  GetInventoryModel({
    required this.status,
    required this.message,
    required this.totalPages,
    required this.page,
    required this.inventory,
  });

  factory GetInventoryModel.fromJson(Map<String, dynamic> json) => GetInventoryModel(
        status: json["status"] ?? false,
        message: json["message"] ?? "",
        totalPages: json["totalPages"] ?? 0,
        page: json["page"] ?? 1,
        inventory: List<Inventory>.from((json["inventory"] ?? []).map((x) => Inventory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "totalPages": totalPages,
        "page": page,
        "inventory": List<dynamic>.from(inventory.map((x) => x.toJson())),
      };
}

class Inventory {
  final String id;
  final String locationId;
  final String productId;
  final String category;
  final String barcode;
  final String purchaseDate;
  final String expiryDate;
  final int minLevel;
  final int quantity;
  final String productName;
  final String productImage;
  final String brandName;

  Inventory({
    required this.id,
    required this.locationId,
    required this.productId,
    required this.category,
    required this.barcode,
    required this.purchaseDate,
    required this.expiryDate,
    required this.minLevel,
    required this.quantity,
    required this.productName,
    required this.productImage,
    required this.brandName,
  });

  factory Inventory.fromJson(Map<String, dynamic> json) => Inventory(
        id: json["_id"] ?? "",
        locationId: json["locationId"] ?? "",
        productId: json["productId"] ?? "",
        category: json["category"] ?? "",
        barcode: json["barcode"] ?? "",
        purchaseDate: json["purchaseDate"] ?? "_",
        expiryDate: json["expiryDate"] ?? "_",
        minLevel: json["minLevel"] ?? 0,
        quantity: json["quantity"] ?? 0,
        productName: json["productName"] ?? "",
        productImage: json["productImage"] ?? "",
        brandName: json["brandName"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "locationId": locationId,
        "productId": productId,
        "category": category,
        "barcode": barcode,
        "purchaseDate": purchaseDate,
        "expiryDate": expiryDate,
        "minLevel": minLevel,
        "quantity": quantity,
        "productName": productName,
        "productImage": productImage,
        "brandName": brandName,
      };
}
