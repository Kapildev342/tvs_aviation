import 'dart:convert';

import 'package:tvsaviation/data/hive/sector/sector_data.dart';

GetSectorModel getSectorModelFromJson(String str) => GetSectorModel.fromJson(json.decode(str));

String getSectorModelToJson(GetSectorModel data) => json.encode(data.toJson());

class GetSectorModel {
  final bool status;
  final List<SectorResponse> sectors;

  GetSectorModel({
    required this.status,
    required this.sectors,
  });

  factory GetSectorModel.fromJson(Map<String, dynamic> json) => GetSectorModel(
        status: json["status"] ?? false,
        sectors: List<SectorResponse>.from((json["sectors"] ?? []).map((x) => SectorResponse.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "sectors": List<dynamic>.from(sectors.map((x) => x.toJson())),
      };
}
