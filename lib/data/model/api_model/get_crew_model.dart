import 'dart:convert';

import 'package:tvsaviation/data/hive/crew/crew_data.dart';

GetCrewModel getCrewModelFromJson(String str) => GetCrewModel.fromJson(json.decode(str));

String getCrewModelToJson(GetCrewModel data) => json.encode(data.toJson());

class GetCrewModel {
  final bool status;
  final String message;
  final List<CrewResponse> crews;

  GetCrewModel({
    required this.status,
    required this.message,
    required this.crews,
  });

  factory GetCrewModel.fromJson(Map<String, dynamic> json) => GetCrewModel(
        status: json["status"] ?? false,
        message: json["message"] ?? "",
        crews: List<CrewResponse>.from((json["activeUser"] ?? []).map((x) => CrewResponse.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "activeUser": List<dynamic>.from(crews.map((x) => x.toJson())),
      };
}
