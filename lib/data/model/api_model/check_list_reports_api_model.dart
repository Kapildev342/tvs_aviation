import 'dart:convert';

GetCheckListApiModel getCheckListApiModelFromJson(String str) => GetCheckListApiModel.fromJson(json.decode(str));

String getCheckListApiModelToJson(GetCheckListApiModel data) => json.encode(data.toJson());

class GetCheckListApiModel {
  final bool status;
  final List<Datum> data;
  final int totalPages;
  final int currentPage;

  GetCheckListApiModel({
    required this.status,
    required this.data,
    required this.totalPages,
    required this.currentPage,
  });

  factory GetCheckListApiModel.fromJson(Map<String, dynamic> json) => GetCheckListApiModel(
        status: json["status"] ?? false,
        data: List<Datum>.from((json["data"] ?? []).map((x) => Datum.fromJson(x))),
        totalPages: json["totalPages"] ?? 1,
        currentPage: json["currentPage"] ?? 1,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "totalPages": totalPages,
        "currentPage": currentPage,
      };
}

class Datum {
  final String id;
  final String reportId;
  final String date;
  final String location;
  final String crew;
  final String sector;

  Datum({
    required this.id,
    required this.reportId,
    required this.date,
    required this.location,
    required this.crew,
    required this.sector,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"] ?? "",
        reportId: json["reportID"] ?? "",
        date: json["date"] ?? "",
        location: json["location"] ?? '',
        crew: json["crew"] ?? "",
        sector: json["sector"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "reportID": reportId,
        "date": date,
        "location": location,
        "crew": crew,
        "sector": sector,
      };
}
