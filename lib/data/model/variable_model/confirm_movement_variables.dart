import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tvsaviation/data/model/variable_model/received_stocks_variables.dart';
import 'package:tvsaviation/data/model/variable_model/stock_movement_variables.dart';

ConfirmMovementVariables confirmMovementVariablesFromJson(String str) => ConfirmMovementVariables.fromJson(json.decode(str));

String confirmMovementVariablesToJson(ConfirmMovementVariables data) => json.encode(data.toJson());

class ConfirmMovementVariables {
  bool loader;
  TextEditingController searchBar;
  SenderDatum senderInfo;
  ReceiverDatum receiverInfo;
  StockMovementInventory stockMovementInventory;

  ConfirmMovementVariables({
    required this.loader,
    required this.searchBar,
    required this.senderInfo,
    required this.receiverInfo,
    required this.stockMovementInventory,
  });

  factory ConfirmMovementVariables.fromJson(Map<String, dynamic> json) => ConfirmMovementVariables(
        loader: json["loader"] ?? false,
        searchBar: json["search_bar"] ?? TextEditingController(),
        senderInfo: SenderDatum.fromJson(json["sender_info"] ?? {}),
        receiverInfo: ReceiverDatum.fromJson(json["receiver"] ?? {}),
        stockMovementInventory: StockMovementInventory.fromJson(json["stock_movement_inventory"] ??
            {
              "table_heading": ["Photo", "Barcode", "Products", "Brands", "M.O Purchase", "Expiry Date", "Qty"],
              "table_data": []
            }),
      );

  Map<String, dynamic> toJson() => {
        "loader": loader,
        "search_bar": searchBar,
        "sender_info": senderInfo.toJson(),
        "receiver": receiverInfo.toJson(),
        "stock_movement_inventory": stockMovementInventory.toJson(),
      };
}
