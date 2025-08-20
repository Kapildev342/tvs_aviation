import 'dart:convert';

NotificationCountModel notificationCountModelFromJson(String str) => NotificationCountModel.fromJson(json.decode(str));

String notificationCountModelToJson(NotificationCountModel data) => json.encode(data.toJson());

class NotificationCountModel {
  final List<LocationCount> locationCounts;
  final int totalUnreadCount;

  NotificationCountModel({
    required this.locationCounts,
    required this.totalUnreadCount,
  });

  factory NotificationCountModel.fromJson(Map<String, dynamic> json) => NotificationCountModel(
        locationCounts: List<LocationCount>.from((json["locationCounts"] ?? []).map((x) => LocationCount.fromJson(x))),
        totalUnreadCount: json["totalUnreadCount"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "locationCounts": List<dynamic>.from(locationCounts.map((x) => x.toJson())),
        "totalUnreadCount": totalUnreadCount,
      };
}

class LocationCount {
  final String id;
  final String name;
  final int count;

  LocationCount({
    required this.id,
    required this.name,
    required this.count,
  });

  factory LocationCount.fromJson(Map<String, dynamic> json) => LocationCount(
        id: json["_id"] ?? "",
        name: json["locationName"] ?? "",
        count: json["count"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "locationName": name,
        "count": count,
      };
}
