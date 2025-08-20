import 'dart:convert';

GetHandlersListModel getHandlersListModelFromJson(String str) => GetHandlersListModel.fromJson(json.decode(str));

String getHandlersListModelToJson(GetHandlersListModel data) => json.encode(data.toJson());

class GetHandlersListModel {
  final bool status;
  final List<Handler> handlers;
  final int totalHandlers;
  final int totalPages;
  final int currentPage;

  GetHandlersListModel({
    required this.status,
    required this.handlers,
    required this.totalHandlers,
    required this.totalPages,
    required this.currentPage,
  });

  factory GetHandlersListModel.fromJson(Map<String, dynamic> json) => GetHandlersListModel(
        status: json["status"] ?? false,
        handlers: List<Handler>.from((json["handlers"] ?? []).map((x) => Handler.fromJson(x))),
        totalHandlers: json["totalHandlers"] ?? 0,
        totalPages: json["totalPages"] ?? 1,
        currentPage: json["currentPage"] ?? 1,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "handlers": List<dynamic>.from(handlers.map((x) => x.toJson())),
        "totalHandlers": totalHandlers,
        "totalPages": totalPages,
        "currentPage": currentPage,
      };
}

class Handler {
  final String id;
  final String name;
  final bool activeStatus;
  final String createdAt;
  final String updatedAt;

  Handler({
    required this.id,
    required this.name,
    required this.activeStatus,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Handler.fromJson(Map<String, dynamic> json) => Handler(
        id: json["_id"] ?? "",
        name: json["name"] ?? "",
        activeStatus: json["activeStatus"] ?? false,
        createdAt: json["createdAt"] ?? '',
        updatedAt: json["updatedAt"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "activeStatus": activeStatus,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      };
}
