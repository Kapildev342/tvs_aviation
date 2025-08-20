import 'dart:convert';

GetCheckListValueModel getCheckListValueModelFromJson(String str) => GetCheckListValueModel.fromJson(json.decode(str));

String getCheckListValueModelToJson(GetCheckListValueModel data) => json.encode(data.toJson());

class GetCheckListValueModel {
  final bool status;
  bool selectAllStatus;
  final Data data;

  GetCheckListValueModel({
    required this.status,
    required this.selectAllStatus,
    required this.data,
  });

  factory GetCheckListValueModel.fromJson(Map<String, dynamic> json) => GetCheckListValueModel(
        status: json["status"] ?? false,
        selectAllStatus: json["select_all_status"] ?? false,
        data: Data.fromJson(json["data"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "select_all_status": selectAllStatus,
        "data": data.toJson(),
      };
}

class Data {
  final OtherListsSingle otherLists;
  final String id;
  final String listName;
  final String userFullName;
  final String date;
  final String locationId;
  final String locationName;
  final String sectorFromId;
  final String sectorFrom;
  final String sectorToId;
  final String sectorTo;
  final List<ChecklistSingle> checklistsSingle;
  final String createdAt;
  final String updatedAt;
  final String reportId;

  Data({
    required this.otherLists,
    required this.id,
    required this.listName,
    required this.userFullName,
    required this.date,
    required this.locationId,
    required this.locationName,
    required this.sectorFromId,
    required this.sectorFrom,
    required this.sectorToId,
    required this.sectorTo,
    required this.checklistsSingle,
    required this.createdAt,
    required this.updatedAt,
    required this.reportId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        otherLists: OtherListsSingle.fromJson(json["otherlists"] ?? {}),
        id: json["_id"] ?? "",
        listName: json["listName"] ?? "",
        userFullName: json["userFullName"] ?? "",
        date: json["date"] ?? "",
        locationId: json["locationId"] ?? "",
        locationName: json["locationName"] ?? "",
        sectorFromId: json["sectorFromId"] ?? "",
        sectorFrom: json["sectorFrom"] ?? "",
        sectorToId: json["sectorToId"] ?? "",
        sectorTo: json["sectorTo"] ?? "",
        checklistsSingle: List<ChecklistSingle>.from((json["checklists"] ?? []).map((x) => ChecklistSingle.fromJson(x))),
        createdAt: json["createdAt"] ?? "",
        updatedAt: json["updatedAt"] ?? "",
        reportId: json["reportId"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "otherlists": otherLists.toJson(),
        "_id": id,
        "listName": listName,
        "userFullName": userFullName,
        "date": date,
        "locationId": locationId,
        "locationName": locationName,
        "sectorFromId": sectorFromId,
        "sectorFrom": sectorFrom,
        "sectorToId": sectorToId,
        "sectorTo": sectorTo,
        "checklists": List<dynamic>.from(checklistsSingle.map((x) => x.toJson())),
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "reportId": reportId,
      };
}

class ChecklistSingle {
  final String fieldName;
  bool status;
  final List<GetCheckListCheck> checks;
  final String remarks;
  final String id;

  ChecklistSingle({
    required this.fieldName,
    required this.status,
    required this.checks,
    required this.remarks,
    required this.id,
  });

  factory ChecklistSingle.fromJson(Map<String, dynamic> json) => ChecklistSingle(
        fieldName: json["fieldName"] ?? "",
        status: json["status"] ?? false,
        checks: List<GetCheckListCheck>.from((json["checks"] ?? []).map((x) => GetCheckListCheck.fromJson(x))),
        remarks: json["remarks"] ?? "",
        id: json["_id"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "fieldName": fieldName,
        "status": status,
        "checks": List<dynamic>.from(checks.map((x) => x.toJson())),
        "remarks": remarks,
        "_id": id,
      };
}

class OtherListsSingle {
  bool status;
  final List<GetCheckListCheck> checks;
  String remarks;

  OtherListsSingle({
    required this.status,
    required this.checks,
    required this.remarks,
  });

  factory OtherListsSingle.fromJson(Map<String, dynamic> json) => OtherListsSingle(
        status: json["status"] ?? false,
        checks: List<GetCheckListCheck>.from((json["checks"] ?? []).map((x) => GetCheckListCheck.fromJson(x))),
        remarks: json["remarks"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "checks": List<dynamic>.from(checks.map((x) => x)),
        "remarks": remarks,
      };
}

class GetCheckListCheck {
  final String name;
  final bool status;
  final String id;

  GetCheckListCheck({
    required this.name,
    required this.status,
    required this.id,
  });

  factory GetCheckListCheck.fromJson(Map<String, dynamic> json) => GetCheckListCheck(
        name: json["name"] ?? "",
        status: (json["status"] ?? false) as bool,
        id: json["_id"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "status": status,
        "_id": id,
      };
}
