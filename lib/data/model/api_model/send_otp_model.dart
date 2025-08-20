import 'dart:convert';

SendOtpModel sendOtpModelFromJson(String str) => SendOtpModel.fromJson(json.decode(str));

String sendOtpModelToJson(SendOtpModel data) => json.encode(data.toJson());

class SendOtpModel {
  final bool status;
  final String message;

  SendOtpModel({
    required this.status,
    required this.message,
  });

  factory SendOtpModel.fromJson(Map<String, dynamic> json) => SendOtpModel(
        status: json["status"] ?? false,
        message: json["message"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
