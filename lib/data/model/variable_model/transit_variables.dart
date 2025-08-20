import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

TransitVariables transitVariablesFromJson(String str) => TransitVariables.fromJson(json.decode(str));

String transitVariablesToJson(TransitVariables data) => json.encode(data.toJson());

class TransitVariables {
  bool loader;
  int currentPage;
  int totalPages;
  OverallTransit overallTransit;
  TextEditingController searchController;
  TextEditingController filterController;
  DateTime? filterSelectedStartDate;
  DateTime? filterSelectedEndDate;
  bool filterCalenderEnabled;
  bool selectAllEnabled;
  bool receivedPageOpened;
  List<bool> locationSelectEnabledList;
  List<String> selectedLocationsList;
  RxString selectedCount;

  TransitVariables({
    required this.loader,
    required this.currentPage,
    required this.totalPages,
    required this.overallTransit,
    required this.searchController,
    required this.filterController,
    required this.filterSelectedStartDate,
    required this.filterSelectedEndDate,
    required this.filterCalenderEnabled,
    required this.selectAllEnabled,
    required this.receivedPageOpened,
    required this.locationSelectEnabledList,
    required this.selectedLocationsList,
    required this.selectedCount,
  });

  factory TransitVariables.fromJson(Map<String, dynamic> json) => TransitVariables(
        loader: json["loader"] ?? false,
        currentPage: json["current_page"] ?? 1,
        searchController: json["search_controller"] ?? TextEditingController(),
        filterController: json["filter_controller"] ?? TextEditingController(),
        overallTransit: OverallTransit.fromJson(json["overall"] ??
            {
              "heading": "Overall Stock In Hand Report",
              "table_heading": ["S.No", "Trans ID", "", "From", "To", "Sender", "Receiver", "Date", "Qty"],
              "table_data": []
            }),
        totalPages: json["total_pages"] ?? 1,
        filterSelectedStartDate: json["filter_selected_start_date"],
        filterSelectedEndDate: json["filter_selected_end_date"],
        filterCalenderEnabled: json["filter_calender_enabled"] ?? false,
        receivedPageOpened: json["received_page_opened"] ?? false,
        locationSelectEnabledList: json["location_select_enabled_list"] ?? List.generate(6, (index) => true),
        selectAllEnabled: json["select_all_enabled"] ?? true,
        selectedCount: (json["selected_count"] ?? "").toString().obs,
        selectedLocationsList: List<String>.from((json["selected_locations_list"] ?? []).map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "loader": loader,
        "search_controller": searchController,
        "filter_controller": filterController,
        "current_page": currentPage,
        "total_pages": totalPages,
        "overall": overallTransit.toJson(),
        "filter_selected_start_date": filterSelectedStartDate,
        "filter_selected_end_date": filterSelectedEndDate,
        "filter_calender_enabled": filterCalenderEnabled,
        "select_all_enabled": selectAllEnabled,
        "received_page_opened": receivedPageOpened,
        "location_select_enabled_list": locationSelectEnabledList,
        "selected_count": selectedCount,
        "selected_locations_list": List<dynamic>.from(selectedLocationsList.map((x) => x)),
      };
}

class OverallTransit {
  final String heading;
  final List<String> tableHeading;
  final List<List<String>> tableData;

  OverallTransit({
    required this.heading,
    required this.tableHeading,
    required this.tableData,
  });

  factory OverallTransit.fromJson(Map<String, dynamic> json) => OverallTransit(
        heading: json["heading"] ?? "",
        tableHeading: List<String>.from((json["table_heading"] ?? []).map((x) => x)),
        tableData: List<List<String>>.from(json["table_data"].map((x) => List<String>.from(x.map((x) => x)))),
      );

  Map<String, dynamic> toJson() => {
        "heading": heading,
        "table_heading": List<dynamic>.from(tableHeading.map((x) => x)),
        "table_data": List<dynamic>.from(tableData.map((x) => List<dynamic>.from(x.map((x) => x)))),
      };
}
