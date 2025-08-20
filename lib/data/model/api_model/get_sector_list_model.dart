import 'dart:convert';

GetSectorListModel getSectorListModelFromJson(String str) => GetSectorListModel.fromJson(json.decode(str));

String getSectorListModelToJson(GetSectorListModel data) => json.encode(data.toJson());

class GetSectorListModel {
  final bool status;
  final String message;
  final List<Sector> sectors;
  final int totalSectors;
  final int totalPages;
  final int currentPage;

  GetSectorListModel({
    required this.status,
    required this.message,
    required this.sectors,
    required this.totalSectors,
    required this.totalPages,
    required this.currentPage,
  });

  factory GetSectorListModel.fromJson(Map<String, dynamic> json) => GetSectorListModel(
        status: json["status"] ?? false,
        message: json["message"] ?? "",
        sectors: List<Sector>.from((json["sectors"] ?? []).map((x) => Sector.fromJson(x))),
        totalSectors: json["totalSectors"] ?? 0,
        totalPages: json["totalPages"] ?? 1,
        currentPage: json["currentPage"] ?? 1,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "sectors": List<dynamic>.from(sectors.map((x) => x.toJson())),
        "totalSectors": totalSectors,
        "totalPages": totalPages,
        "currentPage": currentPage,
      };
}

class Sector {
  final String id;
  final String icao;
  final String iata;
  final String airportName;
  final String city;
  final bool activeStatus;
  final String createdAt;
  final String updatedAt;

  Sector({
    required this.id,
    required this.icao,
    required this.iata,
    required this.airportName,
    required this.city,
    required this.activeStatus,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Sector.fromJson(Map<String, dynamic> json) => Sector(
        id: json["_id"] ?? "",
        icao: json["icao"] ?? "",
        iata: json["iata"] ?? '',
        airportName: json["airportName"] ?? "",
        city: json["city"] ?? "",
        activeStatus: json["activeStatus"] ?? false,
        createdAt: json["createdAt"] ?? "",
        updatedAt: json["updatedAt"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "icao": icao,
        "iata": iata,
        "airportName": airportName,
        "city": city,
        "activeStatus": activeStatus,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      };
}
