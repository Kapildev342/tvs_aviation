import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tvsaviation/data/model/api_model/notification_model.dart';

NotificationVariables notificationVariablesFromJson(String str) => NotificationVariables.fromJson(json.decode(str));

String notificationVariablesToJson(NotificationVariables data) => json.encode(data.toJson());

class NotificationVariables {
  bool loader;
  String locationId;
  int unreadCountAll;
  int unreadCountTransit;
  int unreadCountExpiry;
  int unreadCountLowStock;
  int unreadCountDispute;
  int unreadCountChecklist;
  TabController? tabController;
  List<TabsText> tabsWidgetList;
  List<NotificationData> notifyList;
  List<bool> tabsEnableList;
  List<String> notificationCategoryList;

  NotificationVariables({
    required this.loader,
    required this.locationId,
    required this.unreadCountAll,
    required this.unreadCountTransit,
    required this.unreadCountExpiry,
    required this.unreadCountLowStock,
    required this.unreadCountDispute,
    required this.unreadCountChecklist,
    required this.tabController,
    required this.tabsWidgetList,
    required this.notifyList,
    required this.tabsEnableList,
    required this.notificationCategoryList,
  });

  factory NotificationVariables.fromJson(Map<String, dynamic> json) => NotificationVariables(
        loader: json["loader"] ?? false,
        locationId: json["location_id"] ?? "",
        unreadCountAll: json["unread_count_all"] ?? 0,
        unreadCountTransit: json["unread_count_transit"] ?? 0,
        unreadCountExpiry: json["unread_count_expiry"] ?? 0,
        unreadCountLowStock: json["unread_count_low_stock"] ?? 0,
        unreadCountDispute: json["unread_count_dispute"] ?? 0,
        unreadCountChecklist: json["unread_count_checklist"] ?? 0,
        tabController: json["tab_controller"],
        tabsWidgetList: List<TabsText>.from((json["tabs_widget_list"] ??
                [
                  {"text": "All"},
                  {"text": "Transit"},
                  {"text": "Expiry"},
                  {"text": "Low stock"},
                  {"text": "Stock Disputes"},
                  {"text": "checklist"}
                ])
            .map((x) => TabsText.fromJson(x))),
        notifyList: List<NotificationData>.from((json["notify_list"] ?? []).map((x) => NotificationData.fromJson(x))),
        tabsEnableList: json["tabs_enable_list"] ?? List.generate(6, (index) => false),
        notificationCategoryList: json["notification_category_list"] ?? ['', 'transit', 'expiry', 'low_stock', 'stock_dispute', 'checklist'],
      );

  Map<String, dynamic> toJson() => {
        "loader": loader,
        "location_id": locationId,
        "unread_count_all": unreadCountAll,
        "unread_count_transit": unreadCountTransit,
        "unread_count_expiry": unreadCountExpiry,
        "unread_count_low_stock": unreadCountLowStock,
        "unread_count_dispute": unreadCountDispute,
        "unread_count_checklist": unreadCountChecklist,
        "tab_controller": tabController,
        "tab_widget_list": tabsWidgetList,
        "notify_list": notifyList,
        "tabs_enable_list": tabsEnableList,
        "notification_category_list": notificationCategoryList,
      };
}

class TabsText {
  String text;
  bool enabled;

  TabsText({
    required this.text,
    required this.enabled,
  });

  factory TabsText.fromJson(Map<String, dynamic> json) => TabsText(
        text: json["text"] ?? false,
        enabled: json["enabled"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "enabled": enabled,
      };
}
