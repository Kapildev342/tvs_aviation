import 'dart:convert';

NotificationModel notificationModelFromJson(String str) => NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) => json.encode(data.toJson());

class NotificationModel {
  final bool status;
  final List<NotificationData> notifications;
  final String message;
  int unreadCountAll;
  int unreadCountTransit;
  int unreadCountExpiry;
  int unreadCountLowStock;
  int unreadCountDispute;
  int unreadCountChecklist;

  NotificationModel({
    required this.status,
    required this.notifications,
    required this.message,
    required this.unreadCountAll,
    required this.unreadCountTransit,
    required this.unreadCountExpiry,
    required this.unreadCountLowStock,
    required this.unreadCountDispute,
    required this.unreadCountChecklist,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
        status: json["status"] ?? false,
        notifications: List<NotificationData>.from((json["notifications"] ?? []).map((x) => NotificationData.fromJson(x))),
        message: json["message"] ?? "",
        unreadCountAll: json["unread_count_all"] ?? 0,
        unreadCountTransit: json["unread_count_transit"] ?? 0,
        unreadCountExpiry: json["unread_count_expiry"] ?? 0,
        unreadCountLowStock: json["unread_count_low_stock"] ?? 0,
        unreadCountDispute: json["unread_count_dispute"] ?? 0,
        unreadCountChecklist: json["unread_count_checklist"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "notifications": List<dynamic>.from(notifications.map((x) => x.toJson())),
        "message": message,
        "unread_count_all": unreadCountAll,
        "unread_count_transit": unreadCountTransit,
        "unread_count_expiry": unreadCountExpiry,
        "unread_count_low_stock": unreadCountLowStock,
        "unread_count_dispute": unreadCountDispute,
        "unread_count_checklist": unreadCountChecklist,
      };
}

class NotificationData {
  String id;
  String message;
  String category;
  bool readStatus;
  String date;
  String bottomId;
  String productImage;
  String changedDate;
  String changedTime;
  bool isChanged;

  NotificationData({
    required this.id,
    required this.message,
    required this.category,
    required this.readStatus,
    required this.date,
    required this.bottomId,
    required this.productImage,
    required this.changedDate,
    required this.changedTime,
    required this.isChanged,
  });

  factory NotificationData.fromJson(Map<String, dynamic> json) => NotificationData(
        id: json["_id"] ?? "",
        message: json["message"] ?? "",
        category: json["category"] ?? '',
        readStatus: json["readStatus"] ?? false,
        date: json["date"] ?? "",
        bottomId: json["bottomId"] ?? "",
        productImage: (Uri.parse("${(json["productImage"] ?? "")}")).toString(),
        changedDate: json["changed_date"] ?? "",
        changedTime: json["changed_time"] ?? "",
        isChanged: json["is_changed"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "message": message,
        "category": category,
        "readStatus": readStatus,
        "date": date,
        "bottomId": bottomId,
        "productImage": productImage,
        "changed_date": changedDate,
        "changed_time": changedTime,
        "is_changed": isChanged,
      };
}
