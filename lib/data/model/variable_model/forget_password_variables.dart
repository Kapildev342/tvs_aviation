import 'dart:convert';

import 'package:flutter/cupertino.dart';

ForgetPasswordVariables forgetPasswordVariablesFromJson(String str) => ForgetPasswordVariables.fromJson(json.decode(str));

String forgetPasswordVariablesToJson(ForgetPasswordVariables data) => json.encode(data.toJson());

class ForgetPasswordVariables {
  TextEditingController emailController;
  bool loader;
  bool emailEmpty;
  bool isEmailValid;

  ForgetPasswordVariables({
    required this.emailController,
    required this.loader,
    required this.emailEmpty,
    required this.isEmailValid,
  });

  factory ForgetPasswordVariables.fromJson(Map<String, dynamic> json) => ForgetPasswordVariables(
        emailController: json["email_controller"] ?? TextEditingController(),
        loader: json["loader"] ?? false,
        emailEmpty: json["email_empty"] ?? false,
        isEmailValid: json["is_email_valid"] ?? true,
      );

  Map<String, dynamic> toJson() => {
        "email_controller": emailController,
        "loader": loader,
        "email_empty": emailEmpty,
        "is_email_valid": isEmailValid,
      };
}
