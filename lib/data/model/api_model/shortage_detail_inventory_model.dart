import 'dart:convert';

ShortageDetailInventoryModel shortageDetailInventoryModelFromJson(String str) => ShortageDetailInventoryModel.fromJson(json.decode(str));

String shortageDetailInventoryModelToJson(ShortageDetailInventoryModel data) => json.encode(data.toJson());

class ShortageDetailInventoryModel {
  final bool status;
  final List<Dispute> disputes;

  ShortageDetailInventoryModel({
    required this.status,
    required this.disputes,
  });

  factory ShortageDetailInventoryModel.fromJson(Map<String, dynamic> json) => ShortageDetailInventoryModel(
        status: json["status"] ?? false,
        disputes: List<Dispute>.from((json["disputes"] ?? []).map((x) => Dispute.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "disputes": List<dynamic>.from(disputes.map((x) => x.toJson())),
      };
}

class Dispute {
  final String id;
  final String disputeReason;
  final String comments;
  final bool resolve;
  final String disputeId;
  final String purchaseDate;
  final String locationName;
  final String crewName;
  final String productId;
  final String productName;
  final int quantity;

  Dispute({
    required this.id,
    required this.disputeReason,
    required this.comments,
    required this.resolve,
    required this.disputeId,
    required this.purchaseDate,
    required this.locationName,
    required this.crewName,
    required this.productId,
    required this.productName,
    required this.quantity,
  });

  factory Dispute.fromJson(Map<String, dynamic> json) => Dispute(
        id: json["_id"] ?? "",
        disputeReason: json["disputeReason"] ?? "",
        comments: json["comments"] ?? "",
        resolve: json["resolve"] ?? false,
        disputeId: json["disputeId"] ?? "",
        purchaseDate: json["purchaseDate"] ?? "",
        locationName: json["locationName"] ?? "",
        crewName: json["crewName"] ?? "",
        productId: json["productId"] ?? "",
        productName: json["productName"] ?? "",
        quantity: json["quantity"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "disputeReason": disputeReason,
        "comments": comments,
        "resolve": resolve,
        "disputeId": disputeId,
        "purchaseDate": purchaseDate,
        "locationName": locationName,
        "crewName": crewName,
        "productId": productId,
        "productName": productName,
        "quantity": quantity,
      };
}
