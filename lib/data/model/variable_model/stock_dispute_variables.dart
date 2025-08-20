import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:tvsaviation/resources/drop_down_lib/dropdown_textfield.dart';

StockDisputeVariables stockDisputeVariablesFromJson(String str) => StockDisputeVariables.fromJson(json.decode(str));

String stockDisputeVariablesToJson(StockDisputeVariables data) => json.encode(data.toJson());

class StockDisputeVariables {
  bool loader;
  DropDownValueModel senderLocationChoose;
  DropDownValueModel senderDisputeChoose;
  TextEditingController searchBar;
  int currentPage;
  int totalPages;
  StockDisputeInventory stockDisputeInventory;
  bool stockDisputeExit;
  SendDataModel sendData;
  List<DropDownValueModel> disputeDropDownList;
  List<String> selectedProductsIdList = [];
  List<int> selectedQuantityList = [];
  List<ProductValueModel> selectedProductsList = [];
  NumberPaginatorController? numberController;
  TextEditingController commentsBar;

  StockDisputeVariables({
    required this.loader,
    required this.senderLocationChoose,
    required this.senderDisputeChoose,
    required this.searchBar,
    required this.currentPage,
    required this.totalPages,
    required this.stockDisputeInventory,
    required this.stockDisputeExit,
    required this.sendData,
    required this.disputeDropDownList,
    required this.selectedProductsIdList,
    required this.selectedQuantityList,
    required this.selectedProductsList,
    required this.numberController,
    required this.commentsBar,
  });

  factory StockDisputeVariables.fromJson(Map<String, dynamic> json) => StockDisputeVariables(
        loader: json["loader"] ?? false,
        senderLocationChoose: DropDownValueModel.fromJson(json["sender_location_choose"] ?? {}),
        senderDisputeChoose: DropDownValueModel.fromJson(json["sender_dispute_choose"] ?? {}),
        searchBar: json["search_bar"] ?? TextEditingController(),
        currentPage: json["current_page"] ?? 1,
        totalPages: json["total_pages"] ?? 1,
        stockDisputeInventory: StockDisputeInventory.fromJson(json["stock_dispute_inventory"] ??
            {
              "table_heading": ["Photo", "Barcode", "Products", "Brands", "M.O Purchase", "Expiry Date", "Qty", "Send Qty"],
              "table_data": []
            }),
        stockDisputeExit: json["stock_dispute_exit"] ?? false,
        sendData: SendDataModel.fromJson(json["send_data"] ??
            {
              "crew": "",
              "location": "",
              "disputeReason": "",
              "comments": "",
              "transitId": "",
              "products": [
                {"inventory": "", "quantity": 0},
                {"inventory": "", "quantity": 0}
              ]
            }),
        disputeDropDownList: List<DropDownValueModel>.from((json["dispute_drop_down_list"] ??
                [
                  {"name": "Broken", "value": "broken"},
                  {"name": "Missing", "value": "missing"},
                  {"name": "Damaged", "value": "damaged"},
                  {"name": "Others", "value": "others"},
                ])
            .map((x) => DropDownValueModel.fromJson(x))),
        selectedProductsIdList: List<String>.from((json["selected_products_id_list"] ?? []).map((x) => x)),
        selectedQuantityList: List<int>.from((json["selected_quantity_list"] ?? []).map((x) => x)),
        selectedProductsList: List<ProductValueModel>.from((json["selected_products_list"] ?? []).map((x) => ProductValueModel.fromJson(x))),
        numberController: json["number_controller"],
        commentsBar: json["comments_bar"] ?? TextEditingController(),
      );

  Map<String, dynamic> toJson() => {
        "loader": loader,
        "sender_location_choose": senderLocationChoose,
        "sender_dispute_choose": senderDisputeChoose,
        "search_bar": searchBar,
        "current_page": currentPage,
        "total_pages": totalPages,
        "stock_dispute_inventory": stockDisputeInventory.toJson(),
        "stock_dispute_exit": stockDisputeExit,
        "send_data": sendData,
        "dispute_drop_down_list": disputeDropDownList,
        "selected_products_id_list": List<dynamic>.from(selectedProductsIdList.map((x) => x)),
        "selected_quantity_list": List<dynamic>.from(selectedQuantityList.map((x) => x)),
        "selected_products_list": List<dynamic>.from(selectedProductsList.map((x) => x)),
        "number_controller": numberController,
        "comments_bar": commentsBar,
      };
}

class StockDisputeInventory {
  List<String> tableHeading;
  List<List<String>> tableData;

  StockDisputeInventory({
    required this.tableHeading,
    required this.tableData,
  });

  factory StockDisputeInventory.fromJson(Map<String, dynamic> json) => StockDisputeInventory(
        tableHeading: List<String>.from((json["table_heading"] ?? []).map((x) => x)),
        tableData: List<List<String>>.from(json["table_data"].map((x) => List<String>.from(x.map((x) => x)))),
      );

  Map<String, dynamic> toJson() => {
        "table_heading": List<dynamic>.from(tableHeading.map((x) => x)),
        "table_data": List<dynamic>.from(tableData.map((x) => List<dynamic>.from(x.map((x) => x)))),
      };
}

class SendDataModel {
  String crew;
  String location;
  String disputeReason;
  String comments;
  String transitId;
  List<ProductValueModel> products;

  SendDataModel({
    required this.crew,
    required this.location,
    required this.disputeReason,
    required this.comments,
    required this.transitId,
    required this.products,
  });

  factory SendDataModel.fromJson(Map<String, dynamic> json) => SendDataModel(
        crew: json["crew"] ?? "",
        location: json["location"] ?? "",
        disputeReason: json["disputeReason"] ?? "",
        comments: json["comments"] ?? "",
        transitId: json["transitId"] ?? "",
        products: List<ProductValueModel>.from((json["products"] ?? []).map((x) => ProductValueModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "crew": crew,
        "location": location,
        "disputeReason": disputeReason,
        "comments": comments,
        "transitId": transitId,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
      };
}

class ProductValueModel {
  String inventory;
  int quantity;

  ProductValueModel({
    required this.inventory,
    required this.quantity,
  });

  factory ProductValueModel.fromJson(Map<String, dynamic> json) => ProductValueModel(
        inventory: json["inventory"] ?? "",
        quantity: json["quantity"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "inventory": inventory,
        "quantity": quantity,
      };
}
