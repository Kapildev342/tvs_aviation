import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:number_paginator/number_paginator.dart';

ReportsVariables reportsVariablesFromJson(String str) => ReportsVariables.fromJson(json.decode(str));

String reportsVariablesToJson(ReportsVariables data) => json.encode(data.toJson());

class ReportsVariables {
  bool loader;
  TextEditingController searchController;
  TextEditingController filterController;
  int totalPages;
  int currentPage;
  int reportsSelectedIndex;
  Overall overall;
  LowStock lowStock;
  Expiry expiry;
  Dispute dispute;
  Transaction transaction;
  CabinGalley cabinGalley;
  PreFlight preflight;
  PostFlight postFlight;
  Maintenance maintenance;
  Safety safety;
  bool filterCalenderEnabled;
  bool addDisputePageChanged;
  DateTime? filterSelectedStartDate;
  DateTime? filterSelectedEndDate;
  bool selectAllEnabled;
  List<bool> locationSelectEnabledList;
  RxString selectedCount;
  List<String> selectedLocationsList;
  int sortInt;
  NumberPaginatorController? numberController;
  int selectedResolutionIndex;

  ReportsVariables({
    required this.loader,
    required this.searchController,
    required this.filterController,
    required this.totalPages,
    required this.currentPage,
    required this.reportsSelectedIndex,
    required this.overall,
    required this.lowStock,
    required this.expiry,
    required this.dispute,
    required this.transaction,
    required this.cabinGalley,
    required this.preflight,
    required this.postFlight,
    required this.maintenance,
    required this.safety,
    required this.filterCalenderEnabled,
    required this.addDisputePageChanged,
    required this.filterSelectedStartDate,
    required this.filterSelectedEndDate,
    required this.selectAllEnabled,
    required this.locationSelectEnabledList,
    required this.selectedCount,
    required this.selectedLocationsList,
    required this.sortInt,
    required this.numberController,
    required this.selectedResolutionIndex,
  });

  factory ReportsVariables.fromJson(Map<String, dynamic> json) => ReportsVariables(
        loader: json["loader"] ?? false,
        searchController: json["search_controller"] ?? TextEditingController(),
        filterController: json["filter_controller"] ?? TextEditingController(),
        totalPages: json["total_pages"] ?? 1,
        currentPage: json["current_page"] ?? 1,
        reportsSelectedIndex: json["reports_selected_index"] ?? 0,
        overall: Overall.fromJson(json["overall"] ??
            {
              "heading": "Overall Stock In Hand Report",
              "table_heading": ["Photo", "Product","Brand", "Quantity", "Location"],
              "table_data": []
            }),
        lowStock: LowStock.fromJson(json["lowStock"] ??
            {
              "heading": "Low Stock Report",
              "table_heading": ["Photo", "Product","Brand", "Date", "Location", "Current Qty", "Minimum Qty"],
              "table_data": []
            }),
        expiry: Expiry.fromJson(json["expiry"] ??
            {
              "heading": "Expiry Report",
              "table_heading": ["Photo", "Product","Brand", "Location", "Expiry Date", "Days untill Expiry", "Qty"],
              "table_data": []
            }),
        dispute: Dispute.fromJson(json["dispute"] ??
            {
              "heading": "Resolution Report",
              "table_heading": ["Dispute ID", "Date", "Crew/Handler", "Location", "Qty", "Action"],
              "table_data": []
            }),
        transaction: Transaction.fromJson(json["transaction"] ??
            {
              "heading": "Transaction History",
              "table_heading": ["S.No", "Trans ID", "From", "To", "Sender", "Receiver", "From Date", "Rcv Date", "Disputes", "Total Qty"],
              "table_data": []
            }),
        cabinGalley: CabinGalley.fromJson(json["Cabin_galley"] ??
            {
              "heading": "Cabin and Galley Report",
              "table_heading": ["S.No", "Trans ID", "Date", "From", "To", "Crew", "Sector", "Qty"],
              "table_data": []
            }),
        preflight: PreFlight.fromJson(json["preflight"] ??
            {
              "heading": "Pre Flight Safety Checklist Report",
              "table_heading": ["S.No", "Report ID", "Date", "Aircraft", "Crew", "Sector"],
              "table_data": []
            }),
        postFlight: PostFlight.fromJson(json["post_flight"] ??
            {
              "heading": "Post Flight Safety Checklist Report",
              "table_heading": ["S.No", "Report ID", "Date", "Aircraft", "Crew", "Sector"],
              "table_data": []
            }),
        maintenance: Maintenance.fromJson(json["maintenance"] ??
            {
              "heading": "Maintenance Checklist Report",
              "table_heading": ["S.No", "Report ID", "Date", "Aircraft", "Crew", "Sector"],
              "table_data": []
            }),
        safety: Safety.fromJson(json["safety"] ??
            {
              "heading": "Safety Checklist Report",
              "table_heading": ["S.No", "Report ID", "Date", "Aircraft", "Crew", "Sector"],
              "table_data": []
            }),
        filterCalenderEnabled: json["filter_calender_enabled"] ?? false,
        addDisputePageChanged: json["add_dispute_page_changed"] ?? false,
        selectAllEnabled: json["select_all_enabled"] ?? true,
        locationSelectEnabledList: json["location_select_enabled_list"] ?? List.generate(6, (index) => true),
        filterSelectedStartDate: json["filter_selected_start_date"],
        filterSelectedEndDate: json["filter_selected_end_date"],
        selectedCount: (json["selected_count"] ?? "").toString().obs,
        selectedLocationsList: List<String>.from((json["selected_locations_list"] ?? []).map((x) => x)),
        sortInt: json["sort_int"] ?? -1,
        numberController: json["number_controller"],
        selectedResolutionIndex: json["selected_resolution_index"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "loader": loader,
        "search_controller": searchController,
        "filter_controller": filterController,
        "total_pages": totalPages,
        "current_page": currentPage,
        "reports_selected_index": reportsSelectedIndex,
        "overall": overall.toJson(),
        "lowStock": lowStock.toJson(),
        "expiry": expiry.toJson(),
        "dispute": dispute.toJson(),
        "transaction": transaction.toJson(),
        "Cabin_galley": cabinGalley.toJson(),
        "preflight": preflight.toJson(),
        "post_flight": postFlight.toJson(),
        "maintenance": maintenance.toJson(),
        "safety": safety.toJson(),
        "filter_calender_enabled": filterCalenderEnabled,
        "add_dispute_page_changed": addDisputePageChanged,
        "filter_selected_start_date": filterSelectedStartDate,
        "filter_selected_end_date": filterSelectedEndDate,
        "select_all_enabled": selectAllEnabled,
        "location_select_enabled_list": locationSelectEnabledList,
        "selected_count": selectedCount,
        "selected_locations_list": List<dynamic>.from(selectedLocationsList.map((x) => x)),
        "sort_int": sortInt,
        "number_controller": numberController,
        "selected_resolution_index": selectedResolutionIndex,
      };
}

class Overall {
  final String heading;
  final List<String> tableHeading;
  final List<List<String>> tableData;

  Overall({
    required this.heading,
    required this.tableHeading,
    required this.tableData,
  });

  factory Overall.fromJson(Map<String, dynamic> json) => Overall(
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

class LowStock {
  final String heading;
  final List<String> tableHeading;
  final List<List<String>> tableData;

  LowStock({
    required this.heading,
    required this.tableHeading,
    required this.tableData,
  });

  factory LowStock.fromJson(Map<String, dynamic> json) => LowStock(
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

class Expiry {
  final String heading;
  final List<String> tableHeading;
  final List<List<String>> tableData;

  Expiry({
    required this.heading,
    required this.tableHeading,
    required this.tableData,
  });

  factory Expiry.fromJson(Map<String, dynamic> json) => Expiry(
        heading: json["heading"] ?? "",
        tableHeading: List<String>.from((json["table_heading"] ?? "").map((x) => x)),
        tableData: List<List<String>>.from(json["table_data"].map((x) => List<String>.from(x.map((x) => x)))),
      );

  Map<String, dynamic> toJson() => {
        "heading": heading,
        "table_heading": List<dynamic>.from(tableHeading.map((x) => x)),
        "table_data": List<dynamic>.from(tableData.map((x) => List<dynamic>.from(x.map((x) => x)))),
      };
}

class Dispute {
  final String heading;
  final List<String> tableHeading;
  final List<List<String>> tableData;

  Dispute({
    required this.heading,
    required this.tableHeading,
    required this.tableData,
  });

  factory Dispute.fromJson(Map<String, dynamic> json) => Dispute(
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

class Transaction {
  final String heading;
  final List<String> tableHeading;
  final List<List<String>> tableData;

  Transaction({
    required this.heading,
    required this.tableHeading,
    required this.tableData,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
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

class CabinGalley {
  final String heading;
  final List<String> tableHeading;
  final List<List<String>> tableData;

  CabinGalley({
    required this.heading,
    required this.tableHeading,
    required this.tableData,
  });

  factory CabinGalley.fromJson(Map<String, dynamic> json) => CabinGalley(
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

class PreFlight {
  final String heading;
  final List<String> tableHeading;
  final List<List<String>> tableData;

  PreFlight({
    required this.heading,
    required this.tableHeading,
    required this.tableData,
  });

  factory PreFlight.fromJson(Map<String, dynamic> json) => PreFlight(
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

class PostFlight {
  final String heading;
  final List<String> tableHeading;
  final List<List<String>> tableData;

  PostFlight({
    required this.heading,
    required this.tableHeading,
    required this.tableData,
  });

  factory PostFlight.fromJson(Map<String, dynamic> json) => PostFlight(
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

class Maintenance {
  final String heading;
  final List<String> tableHeading;
  final List<List<String>> tableData;

  Maintenance({
    required this.heading,
    required this.tableHeading,
    required this.tableData,
  });

  factory Maintenance.fromJson(Map<String, dynamic> json) => Maintenance(
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

class Safety {
  final String heading;
  final List<String> tableHeading;
  final List<List<String>> tableData;

  Safety({
    required this.heading,
    required this.tableHeading,
    required this.tableData,
  });

  factory Safety.fromJson(Map<String, dynamic> json) => Safety(
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
