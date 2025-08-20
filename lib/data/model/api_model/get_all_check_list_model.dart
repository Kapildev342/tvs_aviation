import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

GetCheckListModel getCheckListModelFromJson(String str) => GetCheckListModel.fromJson(json.decode(str));

String getCheckListModelToJson(GetCheckListModel data) => json.encode(data.toJson());

class GetCheckListModel {
  bool status;
  Data data;

  GetCheckListModel({
    required this.status,
    required this.data,
  });

  factory GetCheckListModel.fromJson(Map<String, dynamic> json) => GetCheckListModel(
        status: json["status"] ?? "",
        data: Data.fromJson(json["data"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
      };
}

class Data {
  OtherList otherList;
  String listName;
  List<Checklist> checklists;

  Data({
    required this.otherList,
    required this.listName,
    required this.checklists,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        otherList: OtherList.fromJson(json["otherlist"] ?? {}),
        listName: json["listName"] ?? "",
        checklists: List<Checklist>.from((json["checklists"] ?? []).map((x) => Checklist.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "otherlist": otherList.toJson(),
        "listName": listName,
        "checklists": List<dynamic>.from(checklists.map((x) => x.toJson())),
      };
}

class Checklist {
  String fieldName;
  bool isTopicSelected;
  bool isRemarksDisabled;
  TextEditingController remarksController;
  List<ChecklistCheck> checks;
  bool activeButtonsEnabled;
  String remarks;
  String id;

  Checklist({
    required this.fieldName,
    required this.isTopicSelected,
    required this.remarksController,
    required this.isRemarksDisabled,
    required this.checks,
    required this.activeButtonsEnabled,
    required this.remarks,
    required this.id,
  });

  factory Checklist.fromJson(Map<String, dynamic> json) => Checklist(
        fieldName: json["fieldName"] ?? "",
        isTopicSelected: json["is_topic_selected"] ?? false,
        isRemarksDisabled: json["is_remarks_enabled"] ?? false,
        remarksController: json["remarks_controller"] ?? TextEditingController(),
        checks: List<ChecklistCheck>.from((json["checks"] ?? []).map((x) => ChecklistCheck.fromJson(x))),
        activeButtonsEnabled: json["active_buttons_enabled"] ?? false,
        remarks: json["remarks"] ?? "",
        id: json["_id"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "fieldName": fieldName,
        "is_topic_selected": isTopicSelected,
        "is_remarks_enabled": isTopicSelected,
        "remarks_controller": isRemarksDisabled,
        "checks": List<dynamic>.from(checks.map((x) => x.toJson())),
        "active_buttons_enabled": activeButtonsEnabled,
        "remarks": remarks,
        "_id": id,
      };
}

class ChecklistCheck {
  String name;
  bool status;
  bool isCheckSelected;
  bool isDeleteEnabled;
  bool isAdded;
  TextEditingController addController;
  String id;

  ChecklistCheck({
    required this.name,
    required this.status,
    required this.isCheckSelected,
    required this.isDeleteEnabled,
    required this.isAdded,
    required this.addController,
    required this.id,
  });

  factory ChecklistCheck.fromJson(Map<String, dynamic> json) => ChecklistCheck(
        name: json["name"] ?? "",
        status: json["status"] ?? false,
        isCheckSelected: json["is_check_selected"] ?? false,
        isDeleteEnabled: json["is_delete_enabled"] ?? true,
        isAdded: json["is_added"] ?? false,
        addController: json["add_controller"] ?? TextEditingController(),
        id: json["_id"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "status": status,
        "is_check_selected": isCheckSelected,
        "is_delete_enabled": isDeleteEnabled,
        "is_added": isAdded,
        "add_controller": addController,
        "_id": id,
      };
}

class OtherList {
  List<String> fieldName;
  bool isTopicSelected;
  TextEditingController remarksController;
  List<OtherListCheck> checks;
  String remarks;
  bool isRemarkEnabled;
  bool activeButtonsEnabled;
  String id;

  OtherList({
    required this.fieldName,
    required this.isTopicSelected,
    required this.remarksController,
    required this.checks,
    required this.remarks,
    required this.isRemarkEnabled,
    required this.activeButtonsEnabled,
    required this.id,
  });

  factory OtherList.fromJson(Map<String, dynamic> json) => OtherList(
        fieldName: ["Other Defects Found ", "(Scratches/Pen Marks/Tears/Cracks/Missing Or Broken Parts)"],
        isTopicSelected: json["is_topic_selected"] ?? false,
        remarksController: json["remarks_controller"] ?? TextEditingController(),
        checks: List<OtherListCheck>.from((json["checks"] ?? []).map((x) => OtherListCheck.fromJson(x))),
        remarks: json["remarks"] ?? "",
        isRemarkEnabled: json["is_remark_enabled"] ?? false,
        activeButtonsEnabled: json["active_buttons_enabled"] ?? false,
        id: json["_id"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "fieldName": fieldName,
        "is_topic_selected": isTopicSelected,
        "remarks_controller": remarksController,
        "checks": List<dynamic>.from(checks.map((x) => x.toJson())),
        "remarks": remarks,
        "is_remark_enabled": isRemarkEnabled,
        "active_buttons_enabled": activeButtonsEnabled,
        "_id": id
      };
}

class OtherListCheck {
  String name;
  bool status;
  bool isCheckSelected;
  bool isDeleteEnabled;
  bool isAdded;
  TextEditingController addController;

  OtherListCheck({
    required this.name,
    required this.status,
    required this.isCheckSelected,
    required this.isDeleteEnabled,
    required this.isAdded,
    required this.addController,
  });

  factory OtherListCheck.fromJson(Map<String, dynamic> json) => OtherListCheck(
        name: json["name"] ?? "",
        status: json["status"] ?? false,
        isCheckSelected: json["is_check_selected"] ?? false,
        isDeleteEnabled: json["is_delete_enabled"] ?? false,
        isAdded: json["is_added"] ?? false,
        addController: json["add_controller"] ?? TextEditingController(),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "status": status,
        "is_check_selected": isCheckSelected,
        "is_delete_enabled": isDeleteEnabled,
        "is_added": isAdded,
        "add_controller": addController,
      };
}
