import 'dart:convert';

import 'package:tvsaviation/data/hive/stock_type/stock_type_data.dart';

GetStockTypeModel getStockTypeModelFromJson(String str) => GetStockTypeModel.fromJson(json.decode(str));

String getStockTypeModelToJson(GetStockTypeModel data) => json.encode(data.toJson());

class GetStockTypeModel {
  final bool status;
  final List<StockTypeResponse> stockType;

  GetStockTypeModel({
    required this.status,
    required this.stockType,
  });

  factory GetStockTypeModel.fromJson(Map<String, dynamic> json) => GetStockTypeModel(
        status: json["status"] ?? true,
        stockType: List<StockTypeResponse>.from((json["stock_type"] ??
                [
                  {"name": "Current Stock, Food items & Disposables", "_id": "current_stock_food_items_&_disposables"},
                  {"name": "Unused & Old Stocks", "_id": "unused_stock"},
                ])
            .map((x) => StockTypeResponse.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "stock_type": List<dynamic>.from(stockType.map((x) => x.toJson())),
      };
}
