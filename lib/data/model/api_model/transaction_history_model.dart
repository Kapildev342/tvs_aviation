import 'dart:convert';

TransactionHistoryModel transactionHistoryModelFromJson(String str) => TransactionHistoryModel.fromJson(json.decode(str));

String transactionHistoryModelToJson(TransactionHistoryModel data) => json.encode(data.toJson());

class TransactionHistoryModel {
  final bool status;
  final List<TransactionHistory> transactionHistory;
  final int totalPages;
  final int currentPage;
  final String message;

  TransactionHistoryModel({
    required this.status,
    required this.transactionHistory,
    required this.totalPages,
    required this.currentPage,
    required this.message,
  });

  factory TransactionHistoryModel.fromJson(Map<String, dynamic> json) => TransactionHistoryModel(
        status: json["status"] ?? false,
        transactionHistory: List<TransactionHistory>.from((json["transactionHistory"] ?? []).map((x) => TransactionHistory.fromJson(x))),
        totalPages: json["totalPages"] ?? 1,
        currentPage: json["currentPage"] ?? 1,
        message: json["message"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "transactionHistory": List<dynamic>.from(transactionHistory.map((x) => x.toJson())),
        "totalPages": totalPages,
        "currentPage": currentPage,
        "message": message,
      };
}

class TransactionHistory {
  final String id;
  final String transId;
  final String from;
  final String to;
  final String sender;
  final String receiver;
  final String fromDate;
  final String receivedDate;
  int disputeQuantity;
  final int totalQty;

  TransactionHistory({
    required this.id,
    required this.transId,
    required this.from,
    required this.to,
    required this.sender,
    required this.receiver,
    required this.fromDate,
    required this.receivedDate,
    required this.disputeQuantity,
    required this.totalQty,
  });

  factory TransactionHistory.fromJson(Map<String, dynamic> json) => TransactionHistory(
        id: json["_id"] ?? "",
        transId: json["TransId"] ?? '',
        from: json["from"] ?? "",
        to: json["to"] ?? "",
        sender: json["sender"] ?? "",
        receiver: json["receiver"] ?? "",
        fromDate: json["fromDate"] ?? "",
        receivedDate: json["receivedDate"] ?? "",
        disputeQuantity: json["disputeQuantity"] ?? 0,
        totalQty: json["totalQty"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "TransId": transId,
        "from": from,
        "to": to,
        "sender": sender,
        "receiver": receiver,
        "fromDate": fromDate,
        "receivedDate": receivedDate,
        "disputeQuantity": disputeQuantity,
        "totalQty": totalQty,
      };
}
