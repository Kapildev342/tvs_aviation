import 'dart:convert';

DisputeReportsModel disputeReportsModelFromJson(String str) => DisputeReportsModel.fromJson(json.decode(str));

String disputeReportsModelToJson(DisputeReportsModel data) => json.encode(data.toJson());

class DisputeReportsModel {
  final bool status;
  final List<StockDispute> stockDisputes;
  final int totalPages;
  final int currentPage;

  DisputeReportsModel({
    required this.status,
    required this.stockDisputes,
    required this.totalPages,
    required this.currentPage,
  });

  factory DisputeReportsModel.fromJson(Map<String, dynamic> json) => DisputeReportsModel(
        status: json["status"] ?? false,
        stockDisputes: List<StockDispute>.from((json["stockDisputes"] ?? []).map((x) => StockDispute.fromJson(x))),
        totalPages: json["totalPages"] ?? 1,
        currentPage: json["currentPage"] ?? 1,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "stockDisputes": List<dynamic>.from(stockDisputes.map((x) => x.toJson())),
        "totalPages": totalPages,
        "currentPage": currentPage,
      };
}

class StockDispute {
  final String id;
  final String disputeReason;
  final String comments;
  final bool resolve;
  final String createdAt;
  final String stockDisputeId;
  final int totalQuantity;
  final String crew;
  final String location;
  final String transitId;

  StockDispute({
    required this.id,
    required this.disputeReason,
    required this.comments,
    required this.resolve,
    required this.createdAt,
    required this.stockDisputeId,
    required this.totalQuantity,
    required this.crew,
    required this.location,
    required this.transitId,
  });

  factory StockDispute.fromJson(Map<String, dynamic> json) => StockDispute(
        id: json["_id"] ?? "",
        disputeReason: json["disputeReason"] ?? "",
        comments: json["comments"] ?? "",
        resolve: json["resolve"] ?? false,
        createdAt: json["createdAt"] ?? "",
        stockDisputeId: json["stockDisputeId"] ?? "",
        totalQuantity: json["totalQuantity"] ?? 0,
        crew: json["crew"] ?? "",
        location: json["location"] ?? "",
        transitId: json["transitId"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "disputeReason": disputeReason,
        "comments": comments,
        "resolve": resolve,
        "createdAt": createdAt,
        "stockDisputeId": stockDisputeId,
        "totalQuantity": totalQuantity,
        "crew": crew,
        "location": location,
        "transitId": transitId,
      };
}
