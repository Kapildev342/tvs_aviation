import 'dart:convert';

LowStockReportsModel lowStockReportsModelFromJson(String str) => LowStockReportsModel.fromJson(json.decode(str));

String lowStockReportsModelToJson(LowStockReportsModel data) => json.encode(data.toJson());

class LowStockReportsModel {
  final bool status;
  final List<LowStockItem> lowStockItems;
  final int totalPages;
  final int currentPage;

  LowStockReportsModel({
    required this.status,
    required this.lowStockItems,
    required this.totalPages,
    required this.currentPage,
  });

  factory LowStockReportsModel.fromJson(Map<String, dynamic> json) => LowStockReportsModel(
        status: json["status"] ?? false,
        lowStockItems: List<LowStockItem>.from((json["lowStockItems"] ?? []).map((x) => LowStockItem.fromJson(x))),
        totalPages: json["totalPages"],
        currentPage: json["currentPage"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "lowStockItems": List<dynamic>.from(lowStockItems.map((x) => x.toJson())),
        "totalPages": totalPages,
        "currentPage": currentPage,
      };
}

class LowStockItem {
  final String productName;
  final String productPhoto;
  final String date;
  final String location;
  final int currentQty;
  final int minQty;
  final String brandType;

  LowStockItem({
    required this.productName,
    required this.productPhoto,
    required this.date,
    required this.location,
    required this.currentQty,
    required this.minQty,
    required this.brandType,
  });

  factory LowStockItem.fromJson(Map<String, dynamic> json) => LowStockItem(
        productName: json["productName"] ?? "",
        productPhoto: json["productPhoto"] ?? '',
        date: json["date"] ?? '',
        location: json["location"] ?? "",
        currentQty: json["currentQty"] ?? 0,
        minQty: json["minQty"] ?? 0,
    brandType: json["brandType"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "productName": productName,
        "productPhoto": productPhoto,
        "date": date,
        "location": location,
        "currentQty": currentQty,
        "minQty": minQty,
        "brandType": brandType,
      };
}
