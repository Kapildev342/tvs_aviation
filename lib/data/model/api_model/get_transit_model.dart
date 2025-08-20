import 'dart:convert';

TransitModel transitModelFromJson(String str) => TransitModel.fromJson(json.decode(str));

String transitModelToJson(TransitModel data) => json.encode(data.toJson());

class TransitModel {
  final bool status;
  final List<StockMovement> stockMovements;
  final int totalPages;
  final int currentPage;

  TransitModel({
    required this.status,
    required this.stockMovements,
    required this.totalPages,
    required this.currentPage,
  });

  factory TransitModel.fromJson(Map<String, dynamic> json) => TransitModel(
        status: json["status"] ?? "",
        stockMovements: List<StockMovement>.from((json["stockMovements"] ?? []).map((x) => StockMovement.fromJson(x))),
        totalPages: json["totalPages"] ?? 1,
        currentPage: json["currentPage"] ?? 1,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "stockMovements": List<dynamic>.from(stockMovements.map((x) => x.toJson())),
        "totalPages": totalPages,
        "currentPage": currentPage,
      };
}

class StockMovement {
  final String id;
  final String senderName;
  final String receiverName;
  final String senderStockType;
  final String receiverStockType;
  final String createdAt;
  final String transId;
  final String senderLocation;
  final String receiverLocation;
  final int quantity;
  final String productName;
  final String brandTypeName;

  StockMovement({
    required this.id,
    required this.senderName,
    required this.receiverName,
    required this.senderStockType,
    required this.receiverStockType,
    required this.createdAt,
    required this.transId,
    required this.senderLocation,
    required this.receiverLocation,
    required this.quantity,
    required this.productName,
    required this.brandTypeName,
  });

  factory StockMovement.fromJson(Map<String, dynamic> json) => StockMovement(
        id: json["_id"] ?? "",
        senderName: json["senderName"] ?? '',
        receiverName: json["receiverName"] ?? "",
        senderStockType: json["senderstockType"] ?? '',
        receiverStockType: json["receivertockType"] ?? '',
        createdAt: json["createdAt"] ?? "",
        transId: json["TransId"] ?? "",
        senderLocation: json["senderLocation"] ?? "",
        receiverLocation: json["receiverLocation"] ?? "",
        quantity: json["quantity"] ?? 0,
        productName: json["productName"] ?? "",
        brandTypeName: json["brandTypeName"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "senderName": senderName,
        "receiverName": receiverName,
        "senderstockType": senderStockType,
        "receivertockType": receiverStockType,
        "createdAt": createdAt,
        "TransId": transId,
        "senderLocation": senderLocation,
        "receiverLocation": receiverLocation,
        "quantity": quantity,
        "productName": productName,
        "brandTypeName": brandTypeName,
      };
}
