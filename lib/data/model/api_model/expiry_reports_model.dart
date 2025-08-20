import 'dart:convert';

ExpiryReportsModel expiryReportsModelFromJson(String str) => ExpiryReportsModel.fromJson(json.decode(str));

String expiryReportsModelToJson(ExpiryReportsModel data) => json.encode(data.toJson());

class ExpiryReportsModel {
  final bool status;
  final List<ExpiryList> expiryList;
  final int totalPages;
  final int currentPage;

  ExpiryReportsModel({
    required this.status,
    required this.expiryList,
    required this.totalPages,
    required this.currentPage,
  });

  factory ExpiryReportsModel.fromJson(Map<String, dynamic> json) => ExpiryReportsModel(
        status: json["status"] ?? false,
        expiryList: List<ExpiryList>.from((json["expiryList"] ?? []).map((x) => ExpiryList.fromJson(x))),
        totalPages: json["totalPages"] ?? 1,
        currentPage: json["currentPage"] ?? 1,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "expiryList": List<dynamic>.from(expiryList.map((x) => x.toJson())),
        "totalPages": totalPages,
        "currentPage": currentPage,
      };
}

class ExpiryList {
  final String id;
  final String barcode;
  final String expiryDate;
  final int quantity;
  final int daysUntilExpiry;
  final String productName;
  final String productImage;
  final String locationName;
  final String brandType;

  ExpiryList({
    required this.id,
    required this.barcode,
    required this.expiryDate,
    required this.quantity,
    required this.productName,
    required this.productImage,
    required this.locationName,
    required this.daysUntilExpiry,
    required this.brandType,
  });

  factory ExpiryList.fromJson(Map<String, dynamic> json) => ExpiryList(
        id: json["_id"] ?? "",
        barcode: json["barcode"] ?? '',
        expiryDate: json["expiryDate"] ?? "",
        quantity: json["quantity"] ?? 0,
        productName: json["productName"] ?? "",
        productImage: json["productImage"] ?? "",
        locationName: json["locationName"] ?? "",
        daysUntilExpiry: json["daysUntilExpiry"] ?? 0,
    brandType: json["brandType"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "barcode": barcode,
        "expiryDate": expiryDate,
        "quantity": quantity,
        "productName": productName,
        "productImage": productImage,
        "locationName": locationName,
        "daysUntilExpiry": daysUntilExpiry,
        "brandType": brandType,
      };
}
