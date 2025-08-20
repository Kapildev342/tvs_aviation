import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tvsaviation/data/hive/user/user_data.dart';
import 'package:tvsaviation/ui/home/home_screen.dart';

GeneralVariables generalVariablesFromJson(String str) => GeneralVariables.fromJson(json.decode(str));

String generalVariablesToJson(GeneralVariables data) => json.encode(data.toJson());

class GeneralVariables {
  double height;
  double width;
  TextScaler? text;
  bool isLoggedIn;
  int railNavigateIndex;
  int railNavigateBackIndex;
  Widget mainScreenWidget;
  String userToken;
  User userData;
  RxString currentPage;
  String selectedTransId;
  String selectedTransTempId;
  String selectedDisputeId;
  String selectedCheckListId;
  int selectedProductIndexForDispute;

  GeneralVariables({
    required this.height,
    required this.width,
    required this.text,
    required this.isLoggedIn,
    required this.railNavigateIndex,
    required this.railNavigateBackIndex,
    required this.mainScreenWidget,
    required this.userToken,
    required this.userData,
    required this.currentPage,
    required this.selectedTransId,
    required this.selectedTransTempId,
    required this.selectedDisputeId,
    required this.selectedCheckListId,
    required this.selectedProductIndexForDispute,
  });

  factory GeneralVariables.fromJson(Map<String, dynamic> json) => GeneralVariables(
        height: json["kHeight"] ?? 0.0,
        width: json["kWidth"] ?? 0.0,
        text: json["kText"],
        isLoggedIn: json["is_logged_in"] ?? false,
        railNavigateIndex: json["rail_navigate_index"] ?? 0,
        railNavigateBackIndex: json["rail_navigate_back_index"] ?? 0,
        mainScreenWidget: json["main_screen_widget"] ?? const HomeScreen(),
        userToken: json["user_token"] ?? "",
        userData: User.fromJson(json["user_data"] ?? {}),
        currentPage: "${json["current_page"] ?? ""}".obs,
        selectedTransId: json["selected_trans_id"] ?? "",
        selectedTransTempId: json["selected_trans_temp_id"] ?? "",
        selectedDisputeId: json["selected_dispute_id"] ?? "",
        selectedCheckListId: json["selected_check_list_id"] ?? "",
        selectedProductIndexForDispute: json["selected_product_index_for_dispute"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "kHeight": height,
        "kWidth": width,
        "kText": text,
        "is_logged_in": isLoggedIn,
        "rail_navigate_index": railNavigateIndex,
        "rail_navigate_back_index": railNavigateBackIndex,
        "main_screen_widget": mainScreenWidget,
        "user_token": userToken,
        "user_data": userData.toJson(),
        "current_page": currentPage,
        "selected_trans_id": selectedTransId,
        "selected_trans_temp_id": selectedTransTempId,
        "selected_dispute_id": selectedDisputeId,
        "selected_check_list_id": selectedCheckListId,
        "selected_product_index_for_dispute": selectedProductIndexForDispute,
      };
}
