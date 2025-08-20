import 'dart:convert';

OverallReportsModel overallReportsModelFromJson(String str) => OverallReportsModel.fromJson(json.decode(str));

String overallReportsModelToJson(OverallReportsModel data) => json.encode(data.toJson());

class OverallReportsModel {
  final bool status;
  final List<OverallStockReport> overallStockReports;
  final int totalPages;
  final int currentPage;
  final String message;

  OverallReportsModel({
    required this.status,
    required this.overallStockReports,
    required this.totalPages,
    required this.currentPage,
    required this.message,
  });

  factory OverallReportsModel.fromJson(Map<String, dynamic> json) => OverallReportsModel(
        status: json["status"] ?? false,
        overallStockReports:
            List<OverallStockReport>.from((json["overallStockReports"] ?? []).map((x) => OverallStockReport.fromJson(x))),
        totalPages: json["totalPages"] ?? 1,
        currentPage: json["currentPage"] ?? 1,
        message: json["message"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "overallStockReports": List<dynamic>.from(overallStockReports.map((x) => x.toJson())),
        "totalPages": totalPages,
        "currentPage": currentPage,
        "message": message,
      };
}

class OverallStockReport {
  final String id;
  final String barcode;
  final int quantity;
  final String productName;
  final String productImage;
  final String location;
  final String brandType;

  OverallStockReport({
    required this.id,
    required this.barcode,
    required this.quantity,
    required this.productName,
    required this.productImage,
    required this.location,
    required this.brandType,
  });

  factory OverallStockReport.fromJson(Map<String, dynamic> json) => OverallStockReport(
        id: json["_id"] ?? "",
        barcode: json["barcode"] ?? "",
        quantity: json["quantity"] ?? 0,
        productName: json["productName"] ?? "",
        productImage: json["productImage"] ?? '',
        location: json["location"] ?? "",
        brandType: json["brandType"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "barcode": barcode,
        "quantity": quantity,
        "productName": productName,
        "productImage": productImage,
        "location": location,
        "brandType": brandType,
      };
}
