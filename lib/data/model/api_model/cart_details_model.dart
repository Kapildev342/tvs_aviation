import 'dart:convert';
import 'package:tvsaviation/resources/constants.dart';

CartDetailsModel cartDetailsModelFromJson(String str) => CartDetailsModel.fromJson(json.decode(str));

String cartDetailsModelToJson(CartDetailsModel data) => json.encode(data.toJson());

class CartDetailsModel {
  bool status;
  Cart cart;

  CartDetailsModel({
    required this.status,
    required this.cart,
  });

  factory CartDetailsModel.fromJson(Map<String, dynamic> json) => CartDetailsModel(
        status: json["status"] ?? false,
        cart: Cart.fromJson(json["cart"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "cart": cart.toJson(),
      };
}

class Cart {
  String id;
  String userId;
  String locationId;
  String remarks;
  String status;
  List<Item> items;
  String createdAt;
  String updatedAt;

  Cart({
    required this.id,
    required this.userId,
    required this.locationId,
    required this.remarks,
    required this.status,
    required this.items,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        id: json["_id"] ?? "",
        userId: json["userId"] ?? "",
        locationId: json["locationId"] ?? "",
        remarks: json["remarks"] ?? "",
        status: json["status"] ?? "",
        items: List<Item>.from((json["items"] ?? []).map((x) => Item.fromJson(x))),
        createdAt: json["createdAt"] == null ? "-" : mainFunctions.dateFormat(date: json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? "-" : mainFunctions.dateFormat(date: json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "locationId": locationId,
        "remarks": remarks,
        "status": status,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      };
}

class Item {
  String inventoryId;
  InventorySnapshot inventorySnapshot;
  int quantityAdded;
  String id;

  Item({
    required this.inventoryId,
    required this.inventorySnapshot,
    required this.quantityAdded,
    required this.id,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        inventoryId: json["inventoryId"] ?? "",
        inventorySnapshot: InventorySnapshot.fromJson(json["inventorySnapshot"] ?? {}),
        quantityAdded: json["quantityAdded"] ?? 0,
        id: json["_id"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "inventoryId": inventoryId,
        "inventorySnapshot": inventorySnapshot.toJson(),
        "quantityAdded": quantityAdded,
        "_id": id,
      };
}

class InventorySnapshot {
  ProductDetails productDetails;
  String id;
  String locationId;
  String productId;
  String stockType;
  String category;
  String barcode;
  String purchaseDate;
  String expiryDate;
  int minLevel;
  num quantity;
  String createdAt;
  String updatedAt;

  InventorySnapshot({
    required this.productDetails,
    required this.id,
    required this.locationId,
    required this.productId,
    required this.stockType,
    required this.category,
    required this.barcode,
    required this.purchaseDate,
    required this.expiryDate,
    required this.minLevel,
    required this.quantity,
    required this.createdAt,
    required this.updatedAt,
  });

  factory InventorySnapshot.fromJson(Map<String, dynamic> json) => InventorySnapshot(
        productDetails: ProductDetails.fromJson(json["productDetails"] ?? {}),
        id: json["_id"] ?? "",
        locationId: json["locationId"] ?? "",
        productId: json["productId"] ?? "",
        stockType: json["stockType"] ?? "",
        category: json["category"] ?? "",
        barcode: json["barcode"] ?? "",
        purchaseDate: json["purchaseDate"] == null ? "-" : mainFunctions.dateFormat(date: json["purchaseDate"]),
        expiryDate: json["expiryDate"] == null ? "-" : mainFunctions.dateFormat(date: json["expiryDate"]),
        minLevel: json["minLevel"] ?? 0,
        quantity: json["quantity"] ?? 0,
        createdAt: json["createdAt"] == null ? "-" : mainFunctions.dateFormat(date: json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? "-" : mainFunctions.dateFormat(date: json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "productDetails": productDetails.toJson(),
        "_id": id,
        "locationId": locationId,
        "productId": productId,
        "stockType": stockType,
        "category": category,
        "barcode": barcode,
        "purchaseDate": purchaseDate,
        "expiryDate": expiryDate,
        "minLevel": minLevel,
        "quantity": quantity,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      };
}

class ProductDetails {
  String productName;
  String productId;
  String productImage;
  String brandType;
  bool deleted;

  ProductDetails({
    required this.productName,
    required this.productId,
    required this.productImage,
    required this.brandType,
    required this.deleted,
  });

  factory ProductDetails.fromJson(Map<String, dynamic> json) => ProductDetails(
        productName: json["productName"] ?? "",
        productId: json["productId"] ?? "",
        productImage: json["productImage"] ?? "",
        brandType: json["brandType"] ?? "",
        deleted: json["deleted"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "productName": productName,
        "productId": productId,
        "productImage": productImage,
        "brandType": brandType,
        "deleted": deleted,
      };
}

class CartChangeModel {
  String productName;
  String brandName;
  String purchaseDate;
  String expiryDate;
  int quantity;

  CartChangeModel({
    required this.productName,
    required this.brandName,
    required this.purchaseDate,
    required this.expiryDate,
    required this.quantity,
  });

  factory CartChangeModel.fromJson(Map<String, dynamic> json) => CartChangeModel(
        productName: json["inventorySnapshot"]["productDetails"]["productName"] ?? "",
        brandName: json["inventorySnapshot"]["productDetails"]["brandType"] ?? "",
        purchaseDate: json["inventorySnapshot"]["purchaseDate"] == null
            ? "-"
            : mainFunctions.dateFormat(date: json["inventorySnapshot"]["purchaseDate"]),
        expiryDate: json["inventorySnapshot"]["expiryDate"] == null
            ? "-"
            : mainFunctions.dateFormat(date: json["inventorySnapshot"]["expiryDate"]),
        quantity: json["inventorySnapshot"]["quantity"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "productName": productName,
        "brandName": brandName,
        "purchaseDate": purchaseDate,
        "expiryDate": expiryDate,
        "quantity": quantity,
      };
}

class UpdateCartDetailsModel {
  String message;
  UpdateCartResponse cart;

  UpdateCartDetailsModel({
    required this.message,
    required this.cart,
  });

  factory UpdateCartDetailsModel.fromJson(Map<String, dynamic> json) => UpdateCartDetailsModel(
        message: json["message"],
        cart: UpdateCartResponse.fromJson(json["cart"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "cart": cart.toJson(),
      };
}

class UpdateCartResponse {
  String id;
  int totalProductCount;
  int totalQuantityCount;

  UpdateCartResponse({
    required this.id,
    required this.totalProductCount,
    required this.totalQuantityCount,
  });

  factory UpdateCartResponse.fromJson(Map<String, dynamic> json) => UpdateCartResponse(
        id: json["_id"] ?? "",
        totalProductCount: json["totalProductCount"] ?? 0,
        totalQuantityCount: json["totalQuantityCount"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "totalProductCount": totalProductCount,
        "totalQuantityCount": totalQuantityCount,
      };
}
