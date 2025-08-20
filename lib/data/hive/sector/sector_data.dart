import 'package:hive/hive.dart';
part 'sector_data.g.dart';

@HiveType(typeId: 5)
class SectorResponse extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String icao;

  @HiveField(2)
  late String iata;

  @HiveField(3)
  late String airportName;

  @HiveField(4)
  late String city;

  @HiveField(5)
  late bool activeStatus;

  @HiveField(6)
  late DateTime createdAt;

  @HiveField(7)
  late DateTime updatedAt;

  SectorResponse({
    required this.id,
    required this.icao,
    required this.iata,
    required this.airportName,
    required this.city,
    required this.createdAt,
    required this.updatedAt,
    required this.activeStatus,
  });

  factory SectorResponse.fromJson(Map<String, dynamic> json) => SectorResponse(
        id: json["_id"] ?? "",
        icao: json["icao"] ?? "",
        iata: json["iata"] ?? '',
        airportName: json["airportName"] ?? "",
        city: json["city"] ?? '',
        activeStatus: json["activeStatus"] ?? false,
        createdAt: json["createdAt"] == null ? DateTime.now() : DateTime.parse("${json["createdAt"]}"),
        updatedAt: json["updatedAt"] == null ? DateTime.now() : DateTime.parse("${json["updatedAt"]}"),
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
