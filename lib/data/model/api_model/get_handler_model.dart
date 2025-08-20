import 'dart:convert';

import 'package:tvsaviation/data/hive/handler/handler_data.dart';

GetHandlerModel getHandlerModelFromJson(String str) => GetHandlerModel.fromJson(json.decode(str));

String getHandlerModelToJson(GetHandlerModel data) => json.encode(data.toJson());

class GetHandlerModel {
  final bool status;
  final List<HandlerResponse> handlers;

  GetHandlerModel({
    required this.status,
    required this.handlers,
  });

  factory GetHandlerModel.fromJson(Map<String, dynamic> json) => GetHandlerModel(
        status: json["status"] ?? false,
        handlers: List<HandlerResponse>.from((json["handlers"] ?? []).map((x) => HandlerResponse.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "handlers": List<dynamic>.from(handlers.map((x) => x.toJson())),
      };
}
