import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tvsaviation/data/model/variable_model/stock_dispute_variables.dart';

AddDisputeVariables addDisputeVariablesFromJson(String str) => AddDisputeVariables.fromJson(json.decode(str));

String addDisputeVariablesToJson(AddDisputeVariables data) => json.encode(data.toJson());

class AddDisputeVariables {
  bool loader;
  bool isResolved;
  String crewName;
  String disputeId;
  String location;
  String disputeReason;
  TextEditingController commentsBar;
  TextEditingController adminCommentsBar;
  StockDisputeInventory stockDisputeInventory;
  int totalProducts;
  int totalQuantity;

  AddDisputeVariables({
    required this.loader,
    required this.isResolved,
    required this.crewName,
    required this.disputeId,
    required this.location,
    required this.disputeReason,
    required this.commentsBar,
    required this.adminCommentsBar,
    required this.stockDisputeInventory,
    required this.totalProducts,
    required this.totalQuantity,
  });

  factory AddDisputeVariables.fromJson(Map<String, dynamic> json) => AddDisputeVariables(
        loader: json["loader"] ?? false,
        isResolved: json["is_resolved"] ?? false,
        crewName: json["crew_name"] ?? "",
        disputeId: json["dispute_id"] ?? "",
        location: json["location"] ?? "",
        disputeReason: json["dispute_reason"] ?? "",
        commentsBar: json["comments_bar"] ?? TextEditingController(),
        adminCommentsBar: json["admin_comments_bar"] ?? TextEditingController(),
        stockDisputeInventory: StockDisputeInventory.fromJson(json["stock_dispute_inventory"] ??
            {
              "table_heading": ["Photo", "Barcode", "Products", "Brands", "M.O Purchase", "Expiry Date", "Qty"],
              "table_data": []
            }),
        totalProducts: json["total_products"] ?? 0,
        totalQuantity: json["total_quantity"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "loader": loader,
        "is_resolved": isResolved,
        "crew_name": crewName,
        "dispute_id": disputeId,
        "location": location,
        "dispute_reason": disputeReason,
        "comments_bar": commentsBar,
        "admin_comments_bar": adminCommentsBar,
        "stock_dispute_inventory": stockDisputeInventory,
        "total_products": totalProducts,
        "total_quantity": totalQuantity,
      };
}
