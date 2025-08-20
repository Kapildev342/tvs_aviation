import 'dart:convert';

ProductTransitListModel productTransitListModelFromJson(String str) => ProductTransitListModel.fromJson(json.decode(str));

String productTransitListModelToJson(ProductTransitListModel data) => json.encode(data.toJson());

class ProductTransitListModel {
  final bool status;
  final List<TransitDatum> stockMovements;
  final String message;

  ProductTransitListModel({
    required this.status,
    required this.stockMovements,
    required this.message,
  });

  factory ProductTransitListModel.fromJson(Map<String, dynamic> json) => ProductTransitListModel(
        status: json["status"] ?? false,
        stockMovements: List<TransitDatum>.from((json["stockMovements"] ?? []).map((x) => TransitDatum.fromJson(x))),
        message: json["message"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "stockMovements": List<dynamic>.from(stockMovements.map((x) => x.toJson())),
        "message": message,
      };
}

class TransitDatum {
  final String id;
  final String senderName;
  final String transId;
  final String date;
  final String senderLocation;
  final String receiverLocation;
  final String productName;
  final int quantity;
  final String receiverName;

  TransitDatum({
    required this.id,
    required this.senderName,
    required this.transId,
    required this.date,
    required this.senderLocation,
    required this.receiverLocation,
    required this.productName,
    required this.quantity,
    required this.receiverName,
  });

  factory TransitDatum.fromJson(Map<String, dynamic> json) => TransitDatum(
        id: json["_id"] ?? "",
        senderName: json["senderName"] ?? "",
        transId: json["TransId"] ?? "",
        date: json["date"] ?? "",
        senderLocation: json["senderLocation"] ?? "",
        receiverLocation: json["receiverLocation"] ?? '',
        productName: json["productName"] ?? "",
        quantity: json["quantity"] ?? 0,
        receiverName: json["receiverName"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "senderName": senderName,
        "TransId": transId,
        "date": date,
        "senderLocation": senderLocation,
        "receiverLocation": receiverLocation,
        "productName": productName,
        "quantity": quantity,
        "receiverName": receiverName,
      };
}
