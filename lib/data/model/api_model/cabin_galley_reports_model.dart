import 'dart:convert';

CabinGalleyReportModel cabinGalleyReportModelFromJson(String str) => CabinGalleyReportModel.fromJson(json.decode(str));

String cabinGalleyReportModelToJson(CabinGalleyReportModel data) => json.encode(data.toJson());

class CabinGalleyReportModel {
  final bool status;
  final List<CabinAndGalleyReport> cabinAndGalleyReports;
  final int totalPages;
  final int currentPage;

  CabinGalleyReportModel({
    required this.status,
    required this.cabinAndGalleyReports,
    required this.totalPages,
    required this.currentPage,
  });

  factory CabinGalleyReportModel.fromJson(Map<String, dynamic> json) => CabinGalleyReportModel(
        status: json["status"] ?? false,
        cabinAndGalleyReports: List<CabinAndGalleyReport>.from((json["cabinAndGalleyReports"] ?? []).map((x) => CabinAndGalleyReport.fromJson(x))),
        totalPages: json["totalPages"] ?? 1,
        currentPage: json["currentPage"] ?? 1,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "cabinAndGalleyReports": List<dynamic>.from(cabinAndGalleyReports.map((x) => x.toJson())),
        "totalPages": totalPages,
        "currentPage": currentPage,
      };
}

class CabinAndGalleyReport {
  final String id;
  final String transId;
  final String createdAt;
  final String senderName;
  final String senderLocation;
  final String receiverLocation;
  final int quantity;
  final String sector;

  CabinAndGalleyReport({
    required this.id,
    required this.transId,
    required this.createdAt,
    required this.senderName,
    required this.senderLocation,
    required this.receiverLocation,
    required this.quantity,
    required this.sector,
  });

  factory CabinAndGalleyReport.fromJson(Map<String, dynamic> json) => CabinAndGalleyReport(
        id: json["_id"] ?? "",
        transId: json["TransId"] ?? "",
        createdAt: json["createdAt"] ?? "",
        senderName: json["senderName"] ?? "",
        senderLocation: json["senderLocation"] ?? "",
        receiverLocation: json["receiverLocation"] ?? "",
        quantity: json["quantity"] ?? 0,
        sector: json["sector"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "TransId": transId,
        "createdAt": createdAt,
        "senderName": senderName,
        "senderLocation": senderLocation,
        "receiverLocation": receiverLocation,
        "quantity": quantity,
        "sector": sector,
      };
}
