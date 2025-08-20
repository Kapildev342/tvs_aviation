import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

HomeVariables homeVariablesFromJson(String str) => HomeVariables.fromJson(json.decode(str));

String homeVariablesToJson(HomeVariables data) => json.encode(data.toJson());

class HomeVariables {
  bool loader;
  bool profileSavingLoader;
  bool quickLinksEnabled;
  int badgeNotifyCount;
  int homeLocationSelectedIndex;
  List<String> locationList;
  List<String> locationIdList;
  List<int> locationCountList;
  List<HomeDatum> quickLinksList;
  TextEditingController firstNameController;
  TextEditingController lastNameController;
  TextEditingController mailController;
  TextEditingController currentPasswordController;
  bool currentPasswordObscure;
  TextEditingController newPasswordController;
  bool newPasswordObscure;
  TextEditingController confirmPasswordController;
  bool confirmPasswordObscure;
  bool isMatched;
  bool forMatchedText;
  bool isCorrectPassword;
  String passwordStatus;
  double passwordStrength;
  Color progressColor;
  int counter;
  File? selectedImage;
  String selectedFileName;
  String networkImage;
  List<String> statusList;
  List<Color> colorsList;
  bool isPasswordEmpty;
  bool passwordEmpty;
  bool lowerCase;
  bool upperCase;
  bool lengthCase;
  bool symbolCase;
  bool numberCase;

  HomeVariables({
    required this.loader,
    required this.profileSavingLoader,
    required this.quickLinksEnabled,
    required this.badgeNotifyCount,
    required this.homeLocationSelectedIndex,
    required this.locationList,
    required this.locationCountList,
    required this.locationIdList,
    required this.quickLinksList,
    required this.firstNameController,
    required this.lastNameController,
    required this.mailController,
    required this.currentPasswordController,
    required this.currentPasswordObscure,
    required this.newPasswordController,
    required this.newPasswordObscure,
    required this.confirmPasswordController,
    required this.confirmPasswordObscure,
    required this.isMatched,
    required this.forMatchedText,
    required this.isCorrectPassword,
    required this.passwordStatus,
    required this.passwordStrength,
    required this.progressColor,
    required this.counter,
    required this.networkImage,
    required this.selectedFileName,
    this.selectedImage,
    required this.statusList,
    required this.colorsList,
    required this.isPasswordEmpty,
    required this.passwordEmpty,
    required this.lowerCase,
    required this.symbolCase,
    required this.upperCase,
    required this.lengthCase,
    required this.numberCase,
  });

  factory HomeVariables.fromJson(Map<String, dynamic> json) => HomeVariables(
        loader: json["loader"] ?? false,
        profileSavingLoader: json["profile_saving_loader"] ?? false,
        quickLinksEnabled: json["quick_links_enabled"] ?? false,
        badgeNotifyCount: json["badge_notify_count"] ?? 0,
        homeLocationSelectedIndex: json["home_location_selected_index"] ?? -1,
        locationList: List<String>.from((json["location_list"] ?? []).map((x) => x)),
        locationIdList: List<String>.from((json["location_ids"] ?? []).map((x) => x)),
        locationCountList: List<int>.from((json["location_counts"] ?? []).map((x) => x)),
        quickLinksList: List<HomeDatum>.from((json["quick_links_list"] ??
                [
                  {"text": "Current Stocks", "image_data": "assets/home/current_stocks.png"},
                  {"text": "Food Items & Disposables", "image_data": "assets/home/food_disposals.png"},
                  {"text": "Unused & Old Stocks", "image_data": "assets/home/used_old_stocks.png"},
                  {"text": "Preflight Safety Checklist", "image_data": "assets/home/preflight.png"},
                  {"text": "Post Flight Checklist", "image_data": "assets/home/postflight.png"},
                  {"text": "Maintenance Checklist", "image_data": "assets/home/maintenance.png"}
                ])
            .map((x) => HomeDatum.fromJson(x))),
        firstNameController: json["first_name_controller"] ?? TextEditingController(),
        lastNameController: json["last_name_controller"] ?? TextEditingController(),
        mailController: json["mail_controller"] ?? TextEditingController(),
        currentPasswordController: json["current_password_controller"] ?? TextEditingController(),
        currentPasswordObscure: json["current_password_obscure"] ?? true,
        newPasswordController: json["new_password_controller"] ?? TextEditingController(),
        newPasswordObscure: json["new_password_obscure"] ?? true,
        confirmPasswordController: json["confirm_password_controller"] ?? TextEditingController(),
        confirmPasswordObscure: json["confirm_password_obscure"] ?? true,
        isMatched: json["is_matched"] ?? true,
        forMatchedText: json["for_matched_text"] ?? false,
        isCorrectPassword: json["is_correct_password"] ?? true,
        passwordStatus: json["password_status"] ?? "Very Weak",
        passwordStrength: json["password_strength"] ?? 0.0,
        progressColor: json["progress_color"] ?? Colors.blue,
        counter: json["counter"] ?? 0,
        selectedImage: json["selected_image"],
        networkImage: json["network_image"] ?? "",
        selectedFileName: json["selected_file_name"] ?? "",
        statusList: json["status_list"] ?? ["very weak", "weak", "medium", "strong", "secure"],
        colorsList: json["colors_list"] ?? [Colors.red, Colors.redAccent, Colors.yellow, Colors.greenAccent, Colors.green],
        isPasswordEmpty: json["is_password_empty"] ?? false,
        passwordEmpty: json["ppassword_empty"] ?? false,
        lowerCase: json["lower_case"] ?? false,
        upperCase: json["upper_case"] ?? false,
        lengthCase: json["length_case"] ?? false,
        symbolCase: json["symbol_case"] ?? false,
        numberCase: json["number_case"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "loader": loader,
        "profile_saving_loader": profileSavingLoader,
        "quick_links_enabled": quickLinksEnabled,
        "badge_notify_count": badgeNotifyCount,
        "home_location_selected_index": homeLocationSelectedIndex,
        "location_list": locationList,
        "location_counts": List<dynamic>.from(locationCountList.map((x) => x)),
        "location_ids": List<dynamic>.from(locationIdList.map((x) => x)),
        "quick_links_list": quickLinksList,
        "first_name_controller": firstNameController,
        "last_name_controller": lastNameController,
        "mail_controller": mailController,
        "current_password_controller": currentPasswordController,
        "current_password_obscure": currentPasswordObscure,
        "new_password_controller": newPasswordController,
        "new_password_obscure": newPasswordObscure,
        "confirm_password_controller": confirmPasswordController,
        "confirm_password_obscure": confirmPasswordObscure,
        "is_matched": isMatched,
        "for_matched_text": forMatchedText,
        "is_correct_password": isCorrectPassword,
        "progress_color": progressColor,
        "password_status": passwordStatus,
        "password_strength": passwordStrength,
        "counter": counter,
        "selected_image": selectedImage,
        "selected_file_name": selectedFileName,
        "network_image": networkImage,
        "status_list": statusList,
        "colors_list": colorsList,
        "is_password_empty": isPasswordEmpty,
        "password_empty": passwordEmpty,
        "lower_case": lowerCase,
        "upper_case": upperCase,
        "length_case": lengthCase,
        "symbol_case": symbolCase,
        "number_case": numberCase,
      };
}

class HomeDatum {
  final String text;
  final String imageData;

  HomeDatum({
    required this.text,
    required this.imageData,
  });

  factory HomeDatum.fromJson(Map<String, dynamic> json) => HomeDatum(
        imageData: json["image_data"] ?? "",
        text: json["text"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "image_data": imageData,
        "text": text,
      };
}
