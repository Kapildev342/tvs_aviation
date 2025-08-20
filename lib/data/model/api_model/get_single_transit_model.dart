import 'dart:convert';

GetSingleTransitModel getSingleTransitModelFromJson(String str) => GetSingleTransitModel.fromJson(json.decode(str));

String getSingleTransitModelToJson(GetSingleTransitModel data) => json.encode(data.toJson());

class GetSingleTransitModel {
  final bool status;
  final StockMovement stockMovement;
  final Summary inventorySummary;
  final Summary disputeSummary;

  GetSingleTransitModel({
    required this.status,
    required this.stockMovement,
    required this.inventorySummary,
    required this.disputeSummary,
  });

  factory GetSingleTransitModel.fromJson(Map<String, dynamic> json) => GetSingleTransitModel(
        status: json["status"] ?? false,
        stockMovement: StockMovement.fromJson(json["stockMovement"] ?? {}),
        inventorySummary: Summary.fromJson((json["inventorySummary"] ?? {})),
        disputeSummary: Summary.fromJson((json["disputeSummary"] ?? {})),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "stockMovement": stockMovement.toJson(),
        "inventorySummary": inventorySummary.toJson(),
        "disputeSummary": disputeSummary.toJson(),
      };
}

class Summary {
  final int totalProducts;
  final int totalQty;

  Summary({
    required this.totalProducts,
    required this.totalQty,
  });

  factory Summary.fromJson(Map<String, dynamic> json) => Summary(
        totalProducts: json["totalProducts"] ?? 0,
        totalQty: json["totalQty"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "totalProducts": totalProducts,
        "totalQty": totalQty,
      };
}

class StockMovement {
  final String id;
  final String senderName;
  final String senderStockType;
  final String receiverStockType;
  final String createdAt;
  final String transId;
  final String receiverName;
  final String senderLocation;
  final String senderLocationId;
  final String receiverLocation;
  final String receiverLocationId;
  final String sectorFrom;
  final String sectorTo;
  final List<Inventory> inventories;
  final bool access;
  final String receiverRemarks;
  final String senderRemarks;
  final String crewType;
  final String senderType;
  final String handlerName;
  final String handlerNumber;
  final String crewSignImage;
  final String handlerSignImage;

  StockMovement({
    required this.id,
    required this.senderName,
    required this.senderStockType,
    required this.receiverStockType,
    required this.createdAt,
    required this.transId,
    required this.receiverName,
    required this.senderLocation,
    required this.senderLocationId,
    required this.receiverLocation,
    required this.receiverLocationId,
    required this.sectorFrom,
    required this.sectorTo,
    required this.inventories,
    required this.access,
    required this.receiverRemarks,
    required this.senderRemarks,
    required this.crewType,
    required this.senderType,
    required this.handlerName,
    required this.handlerNumber,
    required this.crewSignImage,
    required this.handlerSignImage,
  });

  factory StockMovement.fromJson(Map<String, dynamic> json) => StockMovement(
        id: json["_id"] ?? "",
        senderName: json["senderName"] ?? "",
        senderStockType: json["senderstockType"] == null
            ? ""
            : json["senderstockType"] == "current_stock_food_items_&_disposables"
                ? "Current Stock, Food items & Disposables"
                : json["senderstockType"] == "unused_stock"
                    ? "Unused & Old Stocks"
                    : "",
        receiverStockType: json["receivertockType"] == null
            ? ""
            : json["receivertockType"] == "current_stock_food_items_&_disposables"
                ? "Current Stock, Food items & Disposables"
                : json["receivertockType"] == "unused_stock"
                    ? "Unused & Old Stocks"
                    : "",
        createdAt: json["createdAt"] ?? "",
        transId: json["TransId"] ?? "",
        receiverName: json["receiverName"] ?? "",
        senderLocation: json["senderLocation"] ?? "",
        senderLocationId: json["senderLocationId"] ?? "",
        receiverLocation: json["receiverLocation"] ?? "",
        receiverLocationId: json["receiverLocationId"] ?? "",
        sectorFrom: json["sectorFrom"] ?? "",
        sectorTo: json["sectorTo"] ?? '',
        inventories: List<Inventory>.from((json["inventories"] ?? []).map((x) => Inventory.fromJson(x))),
        access: json["access"] ?? false,
        receiverRemarks: json["receiverRemarks"] ?? "",
        senderRemarks: json["senderRemarks"] ?? "",
        crewType: json["crewType"] ?? "Crew",
        senderType: json["sendertype"] ?? "Crew",
        handlerName: json["handlerName"] ?? "",
        handlerNumber: json["handlerNumber"] == null ? "" : "${json["handlerNumber"]}",
        crewSignImage: json["crewSignImage"] ?? "",
        handlerSignImage: json["handlerSignImage"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "senderName": senderName,
        "senderstockType": senderStockType,
        "receivertockType": receiverStockType,
        "createdAt": createdAt,
        "TransId": transId,
        "receiverName": receiverName,
        "senderLocation": senderLocation,
        "senderLocationId": senderLocationId,
        "receiverLocation": receiverLocation,
        "receiverLocationId": receiverLocationId,
        "sectorFrom": sectorFrom,
        "sectorTo": sectorTo,
        "inventories": List<dynamic>.from(inventories.map((x) => x.toJson())),
        "access": access,
        "receiverRemarks": receiverRemarks,
        "senderRemarks": senderRemarks,
        "crewType": crewType,
        "senderType": senderType,
        "handlerName": handlerName,
        "handlerNumber": handlerNumber,
        "crewSignImage": crewSignImage,
        "handlerSignImage": handlerSignImage,
      };
}

class Inventory {
  final String inventoryId;
  final String productImage;
  final String barCode;
  final String productName;
  final String brandType;
  final String purchaseMonth;
  final String expiryDate;
  final int quantity;
  final bool stockDispute;
  final String stockDisputeId;
  final int stockQuantity;

  Inventory({
    required this.inventoryId,
    required this.barCode,
    required this.purchaseMonth,
    required this.expiryDate,
    required this.productImage,
    required this.productName,
    required this.brandType,
    required this.quantity,
    required this.stockDispute,
    required this.stockDisputeId,
    required this.stockQuantity,
  });

  factory Inventory.fromJson(Map<String, dynamic> json) => Inventory(
        productImage: json["productImage"] ?? "",
        productName: json["productName"] ?? "",
        brandType: json["brandType"] ?? "",
        inventoryId: json["inventoryId"] ?? "",
        barCode: json["barcode"] ?? "",
        purchaseMonth: json["monthOfPurchase"] ?? "",
        expiryDate: json["expiry"] ?? "",
        quantity: json["quantity"] ?? 0,
        stockDispute: json["stockDispute"] ?? false,
        stockDisputeId: json["stockDisputeId"] ?? "",
        stockQuantity: json["stockQuantity"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "productImage": productImage,
        "productName": productName,
        "brandType": brandType,
        "inventoryId": inventoryId,
        "barcode": barCode,
        "monthOfPurchase": purchaseMonth,
        "expiry": expiryDate,
        "quantity": quantity,
        "stockDispute": stockDispute,
        "stockDisputeId": stockDisputeId,
        "stockQuantity": stockQuantity,
      };
}
