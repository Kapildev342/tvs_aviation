import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tvsaviation/data/model/variable_model/received_stocks_variables.dart';

StockMovementVariables stockMovementVariablesFromJson(String str) => StockMovementVariables.fromJson(json.decode(str));

String stockMovementVariablesToJson(StockMovementVariables data) => json.encode(data.toJson());

class StockMovementVariables {
  bool loader;
  int currentPage;
  TextEditingController searchBar;
  SendDataValueModel sendData;
  SenderDatum senderInfo;
  ReceiverDatum receiverInfo;
  StockMovementInventory stockMovementInventory;
  int totalPages;
  bool stockMovementExit;
  List<String> selectedProductsIdList = [];
  List<int> selectedQuantityList = [];
  List<AddProductsList> selectedProductsList = [];
  ScrollController scrollController;
  RxBool onTappedRegion;

  StockMovementVariables({
    required this.loader,
    required this.currentPage,
    required this.searchBar,
    required this.sendData,
    required this.senderInfo,
    required this.receiverInfo,
    required this.stockMovementInventory,
    required this.totalPages,
    required this.stockMovementExit,
    required this.selectedProductsIdList,
    required this.selectedQuantityList,
    required this.selectedProductsList,
    required this.scrollController,
    required this.onTappedRegion,
  });

  factory StockMovementVariables.fromJson(Map<String, dynamic> json) => StockMovementVariables(
        loader: json["loader"] ?? false,
        currentPage: json["current_page"] ?? 1,
        searchBar: json["search_bar"] ?? TextEditingController(),
        sendData: SendDataValueModel.fromJson(json["send_data"] ??
            {
              "senderName": "",
              "receivertype": "",
              "receiverName": "",
              "senderLocation": "",
              "receiverLocation": "",
              "senderstockType": "",
              "receivertockType": "",
              "inventories": [
                {"inventory": "", "quantity": 0}
              ],
              "sectorFrom": "",
              "sectorTo": "",
              "handlerName": "",
              "handlerPhoneNo": "",
              "handlerSignature": "",
              "crewSignature": "",
              "remarks": ""
            }),
        senderInfo: SenderDatum.fromJson(json["sender_info"] ?? {}),
        receiverInfo: ReceiverDatum.fromJson(json["receiver"] ?? {}),
        stockMovementInventory: StockMovementInventory.fromJson(json["stock_movement_inventory"] ??
            {
              "table_heading": ["Photo", "Barcode", "Products", "Brands", "M.O Purchase", "Expiry Date", "Qty", "Send Qty"],
              "table_data": []
            }),
        totalPages: json["total_pages"] ?? 1,
        stockMovementExit: json["stock_movement_exit"] ?? false,
        selectedProductsIdList: List<String>.from((json["selected_products_id_list"] ?? []).map((x) => x)),
        selectedQuantityList: List<int>.from((json["selected_quantity_list"] ?? []).map((x) => x)),
        selectedProductsList: List<AddProductsList>.from((json["selected_products_list"] ?? []).map((x) => AddProductsList.fromJson(x))),
        scrollController: json["scroll_controller"] ?? ScrollController(),
        onTappedRegion: ((json["on_tapped_region"] ?? false) as bool).obs,
      );

  Map<String, dynamic> toJson() => {
        "loader": loader,
        "current_page": currentPage,
        "search_bar": searchBar,
        "send_data": sendData,
        "sender_info": senderInfo.toJson(),
        "receiver-info": receiverInfo.toJson(),
        "stock_movement_inventory": stockMovementInventory.toJson(),
        "total_pages": totalPages,
        "stock_movement_exit": stockMovementExit,
        "selected_products_id_list": List<dynamic>.from(selectedProductsIdList.map((x) => x)),
        "selected_quantity_list": List<dynamic>.from(selectedQuantityList.map((x) => x)),
        "selected_products_list": List<dynamic>.from(selectedProductsList.map((x) => x)),
        "scroll_controller": scrollController,
        "on_tapped_region": onTappedRegion,
      };
}

class StockMovementInventory {
  List<String> tableHeading;
  List<List<String>> tableData;

  StockMovementInventory({
    required this.tableHeading,
    required this.tableData,
  });

  factory StockMovementInventory.fromJson(Map<String, dynamic> json) => StockMovementInventory(
        tableHeading: List<String>.from((json["table_heading"] ?? []).map((x) => x)),
        tableData: List<List<String>>.from((json["table_data"] ?? []).map((x) => List<String>.from(x.map((x) => x)))),
      );

  Map<String, dynamic> toJson() => {
        "table_heading": List<dynamic>.from(tableHeading.map((x) => x)),
        "table_data": List<dynamic>.from(tableData.map((x) => List<dynamic>.from(x.map((x) => x)))),
      };
}

class AddProductsList {
  String inventory;
  int quantity;

  AddProductsList({
    required this.inventory,
    required this.quantity,
  });

  factory AddProductsList.fromJson(Map<String, dynamic> json) => AddProductsList(
        inventory: json["inventory"] ?? "",
        quantity: json["quantity"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "inventory": inventory,
        "quantity": quantity,
      };
}

class SendDataValueModel {
  String senderName;
  String receiverType;
  String receiverName;
  String senderLocation;
  String receiverLocation;
  String senderStockType;
  String receiverStockType;
  List<AddProductsList> inventories;
  String sectorFrom;
  String sectorTo;
  String handlerName;
  String handlerPhoneNo;
  String handlerSignature;
  String crewSignature;
  String remarks;

  SendDataValueModel({
    required this.senderName,
    required this.receiverType,
    required this.receiverName,
    required this.senderLocation,
    required this.receiverLocation,
    required this.senderStockType,
    required this.receiverStockType,
    required this.inventories,
    required this.sectorFrom,
    required this.sectorTo,
    required this.handlerName,
    required this.handlerPhoneNo,
    required this.handlerSignature,
    required this.crewSignature,
    required this.remarks,
  });

  factory SendDataValueModel.fromJson(Map<String, dynamic> json) => SendDataValueModel(
        senderName: json["senderName"] ?? "",
        receiverType: json["receivertype"] ?? "",
        receiverName: json["receiverName"] ?? "",
        senderLocation: json["senderLocation"] ?? "",
        receiverLocation: json["receiverLocation"] ?? "",
        senderStockType: json["senderstockType"] ?? "",
        receiverStockType: json["receivertockType"] ?? "",
        inventories: List<AddProductsList>.from((json["inventories"] ?? []).map((x) => AddProductsList.fromJson(x))),
        sectorFrom: json["sectorFrom"] ?? "",
        sectorTo: json["sectorTo"] ?? "",
        handlerName: json["handlerName"] ?? "",
        handlerPhoneNo: json["handlerPhoneNo"] ?? "",
        handlerSignature: json["handlerSignature"] ?? "",
        crewSignature: json["crewSignature"] ?? "",
        remarks: json["remarks"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "senderName": senderName,
        "receivertype": receiverType,
        "receiverName": receiverName,
        "senderLocation": senderLocation,
        "receiverLocation": receiverLocation,
        "senderstockType": senderStockType,
        "receivertockType": receiverStockType,
        "inventories": List<dynamic>.from(inventories.map((x) => x.toJson())),
        "sectorFrom": sectorFrom,
        "sectorTo": sectorTo,
        "handlerName": handlerName,
        "handlerPhoneNo": handlerPhoneNo,
        "handlerSignature": handlerSignature,
        "crewSignature": crewSignature,
        "remarks": remarks,
      };
}
