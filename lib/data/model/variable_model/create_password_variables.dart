import 'dart:convert';
import 'package:flutter/material.dart';

CreatePasswordVariables createPasswordVariablesFromJson(String str) => CreatePasswordVariables.fromJson(json.decode(str));

String createPasswordVariablesToJson(CreatePasswordVariables data) => json.encode(data.toJson());

class CreatePasswordVariables {
  bool loader;
  bool isNewVisible;
  bool isConfirmVisible;
  bool isPasswordEmpty;
  bool isMatched;
  bool forMatchedText;
  bool isCorrectPassword;
  TextEditingController newPassword;
  TextEditingController confirmPassword;
  String passwordStatus;
  double passwordStrength;
  Color progressColor;
  int counter;
  List<String> statusList;
  List<Color> colorsList;
  bool lowerCase;
  bool upperCase;
  bool lengthCase;
  bool symbolCase;
  bool numberCase;

  CreatePasswordVariables({
    required this.loader,
    required this.isNewVisible,
    required this.isConfirmVisible,
    required this.isPasswordEmpty,
    required this.isMatched,
    required this.forMatchedText,
    required this.isCorrectPassword,
    required this.newPassword,
    required this.confirmPassword,
    required this.passwordStatus,
    required this.passwordStrength,
    required this.progressColor,
    required this.counter,
    required this.statusList,
    required this.colorsList,
    required this.lowerCase,
    required this.symbolCase,
    required this.upperCase,
    required this.lengthCase,
    required this.numberCase,
  });

  factory CreatePasswordVariables.fromJson(Map<String, dynamic> json) => CreatePasswordVariables(
        loader: json["loader"] ?? false,
        isNewVisible: json["is_new_visible"] ?? true,
        isConfirmVisible: json["is_confirm_visible"] ?? true,
        isPasswordEmpty: json["is_password_empty"] ?? false,
        isMatched: json["is_matched"] ?? true,
        forMatchedText: json["for_matched_text"] ?? false,
        isCorrectPassword: json["is_correct_password"] ?? true,
        passwordStatus: json["password_status"] ?? "Very Weak",
        passwordStrength: json["password_strength"] ?? 0.0,
        progressColor: json["progress_color"] ?? Colors.blue,
        counter: json["counter"] ?? 0,
        statusList: json["status_list"] ??
            [
              "very weak",
              "weak",
              "medium",
              "strong",
              "secure",
            ],
        colorsList: json["colors_list"] ??
            [
              Colors.red,
              Colors.redAccent,
              Colors.yellow,
              Colors.greenAccent,
              Colors.green,
            ],
        newPassword: json["new_password"] ?? TextEditingController(),
        confirmPassword: json["confirm_password"] ?? TextEditingController(),
        lowerCase: json["lower_case"] ?? false,
        upperCase: json["upper_case"] ?? false,
        lengthCase: json["length_case"] ?? false,
        symbolCase: json["symbol_case"] ?? false,
        numberCase: json["number_case"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "loader": loader,
        "is_new_visible": isNewVisible,
        "is_confirm_visible": isConfirmVisible,
        "is_password_empty": isPasswordEmpty,
        "is_matched": isMatched,
        "for_matched_text": forMatchedText,
        "is_correct_password": isCorrectPassword,
        "new_password": newPassword,
        "confirm_password": confirmPassword,
        "progress_color": progressColor,
        "password_status": passwordStatus,
        "password_strength": passwordStrength,
        "counter": counter,
        "status_list": statusList,
        "colors_list": colorsList,
        "lower_case": lowerCase,
        "upper_case": upperCase,
        "length_case": lengthCase,
        "symbol_case": symbolCase,
        "number_case": numberCase,
      };
}
