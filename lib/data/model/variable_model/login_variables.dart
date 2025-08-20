import 'dart:convert';

import 'package:flutter/cupertino.dart';

LoginVariables loginVariablesFromJson(String str) => LoginVariables.fromJson(json.decode(str));

String loginVariablesToJson(LoginVariables data) => json.encode(data.toJson());

class LoginVariables {
  TextEditingController emailController;
  TextEditingController passwordController;
  bool isVisible;
  bool loader;
  bool emailEmpty;
  bool passwordEmpty;
  bool isEmailValid;
  String fcmtoken;

  LoginVariables({
    required this.emailController,
    required this.passwordController,
    required this.isVisible,
    required this.loader,
    required this.emailEmpty,
    required this.passwordEmpty,
    required this.isEmailValid,
    required this.fcmtoken,
  });

  factory LoginVariables.fromJson(Map<String, dynamic> json) => LoginVariables(
        emailController: json["email_controller"] ?? TextEditingController(),
        passwordController: json["password_controller"] ?? TextEditingController(),
        isVisible: json["is_visible"] ?? true,
        loader: json["loader"] ?? false,
        emailEmpty: json["email_empty"] ?? false,
        passwordEmpty: json["password_empty"] ?? false,
        isEmailValid: json["is_email_valid"] ?? true,
        fcmtoken: json["fcm_token"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "email_controller": emailController,
        "password_controller": passwordController,
        "is_visible": isVisible,
        "loader": loader,
        "email_empty": emailEmpty,
        "password_empty": passwordEmpty,
        "is_email_valid": isEmailValid,
        "fcm_token": fcmtoken,
      };
}
