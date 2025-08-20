import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

CodeVerifyVariables codeVerifyVariablesFromJson(String str) => CodeVerifyVariables.fromJson(json.decode(str));

String codeVerifyVariablesToJson(CodeVerifyVariables data) => json.encode(data.toJson());

class CodeVerifyVariables {
  bool loader;
  TextEditingController otpController;
  int timerCount;
  bool otpEmpty;
  bool otpNotFilled;
  bool enableResend;
  Timer? timer;
  String otp;

  CodeVerifyVariables({
    required this.loader,
    required this.otpController,
    required this.timerCount,
    required this.otpEmpty,
    required this.otpNotFilled,
    required this.enableResend,
    required this.timer,
    required this.otp,
  });

  factory CodeVerifyVariables.fromJson(Map<String, dynamic> json) => CodeVerifyVariables(
        loader: json["loader"] ?? false,
        otpController: json["otp_Controller"] ?? TextEditingController(),
        timerCount: json["timer_count"] ?? 30,
        otpEmpty: json["otp_empty"] ?? false,
        otpNotFilled: json["otp_not_filled"] ?? false,
        enableResend: json["enable_resend"] ?? false,
        timer: json["timer"],
        otp: json["otp"] ?? "000000",
      );

  Map<String, dynamic> toJson() => {
        "loader": loader,
        "otp_Controller": otpController,
        "timer_count": timerCount,
        "otp_empty": otpEmpty,
        "otp_not_filled": otpNotFilled,
        "enable_resend": enableResend,
        "timer": timer,
        "otp": otp,
      };
}
