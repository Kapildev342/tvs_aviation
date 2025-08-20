import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tvsaviation/data/model/api_model/inventory_products_list_model.dart';
import 'package:tvsaviation/data/model/api_model/product_transit_list_model.dart';
import 'package:tvsaviation/resources/drop_down_lib/dropdown_textfield.dart';
import 'notification_variables.dart';

InventoryVariables inventoryVariablesFromJson(String str) => InventoryVariables.fromJson(json.decode(str));

String inventoryVariablesToJson(InventoryVariables data) => json.encode(data.toJson());

class InventoryVariables {
  bool loader;
  bool countLoader;
  bool tabPressed;
  TextEditingController searchBar;
  TextEditingController minimumController;
  TextEditingController quantityController;
  int selectedListIndex;
  int tabControllerIndex;
  Rx<int> filterIndex;
  // TabController? tabController;
  List<TabsText> tabsWidgetList;
  List<bool> tabsEnableList;
  List<TransitDatum> transitList;
  List<String> productListHeading;
  List<String> productExpiryListHeading;
  List<List<String>> productDataList;
  List<String> shortageListHeading;
  List<List<String>> shortageDataList;
  Rx<DropDownValueModel> selectedChoiceChip;
  RxList<DropDownValueModel> categoryDropDownList;
  List<DropDownValueModel> filterTypeList;
  String selectedFilterType;
  String selectedLocationId;
  String selectedStockTypeId;
  String selectedProductId;
  String selectedProductName;
  bool selectedProductHasExpiry;
  List<ProductList> products;
  List<int> locationCount;
  int minimumLevelCount;

  InventoryVariables({
    required this.loader,
    required this.countLoader,
    required this.tabPressed,
    required this.searchBar,
    required this.minimumController,
    required this.quantityController,
    required this.selectedListIndex,
    required this.tabControllerIndex,
    required this.filterIndex,
    //required this.tabController,
    required this.tabsWidgetList,
    required this.tabsEnableList,
    required this.transitList,
    required this.productListHeading,
    required this.productExpiryListHeading,
    required this.productDataList,
    required this.shortageListHeading,
    required this.shortageDataList,
    required this.selectedChoiceChip,
    required this.categoryDropDownList,
    required this.selectedLocationId,
    required this.selectedStockTypeId,
    required this.selectedProductId,
    required this.selectedProductName,
    required this.selectedProductHasExpiry,
    required this.selectedFilterType,
    required this.filterTypeList,
    required this.products,
    required this.locationCount,
    required this.minimumLevelCount,
  });

  factory InventoryVariables.fromJson(Map<String, dynamic> json) => InventoryVariables(
        loader: json["loader"] ?? false,
        countLoader: json["count_loader"] ?? false,
        tabPressed: json["tab_pressed"] ?? false,
        searchBar: json["search_bar"] ?? TextEditingController(),
        minimumController: json["minimum_controller"] ?? TextEditingController(),
        quantityController: json["quantity_controller"] ?? TextEditingController(),
        selectedListIndex: json["selected_list_index"] ?? 0,
        tabControllerIndex: json["tab_controller_index"] ?? 0,
        filterIndex: int.parse((json["filter_index"] ?? 0).toString()).obs,
        //tabController: json["tab_controller"],
        tabsWidgetList: List<TabsText>.from((json["tabs_widget_list"] ??
                [
                  {"text": "Current Stocks"},
                  {"text": "Food Items & Disposables"},
                  {"text": "Unused & Old Stocks"}
                ])
            .map((x) => TabsText.fromJson(x))),
        tabsEnableList: json["tabs_enable_list"] ?? List.generate(3, (index) => false),
        transitList: List<TransitDatum>.from((json["transit_list"] ?? []).map((x) => TransitDatum.fromJson(x))),
        productListHeading: json["product_list_heading"] ?? ["Barcode", "M.O Purchase", "Location", "Qty", "Action"],
        productExpiryListHeading: json["product_expiry_list_heading"] ?? ["Barcode", "Expiry Date", "Location", "Qty", "Action"],
        productDataList: List<List<String>>.from((json["product_data_list"] ?? []).map((x) => x)),
        shortageListHeading: json["shortage_list_heading"] ?? ["Dispute Id", "M.O Purchase", "Crew Name", "Location", "Qty"],
        shortageDataList: json["shortage_data_list"] ?? [],
        selectedChoiceChip: (DropDownValueModel.fromJson(json["selected_choice_chip"] ?? {})).obs,
        categoryDropDownList: RxList<DropDownValueModel>.from((json["category_drop_downList"] ?? []).map((x) => DropDownValueModel.fromJson(x))),
        selectedLocationId: json["selected_location_id"] ?? "",
        selectedStockTypeId: json["selected_stock_type_id"] ?? "current_stock",
        selectedFilterType: json["selected_filter_type"] ?? "",
        selectedProductId: json["selected_product_id"] ?? "",
        selectedProductName: json["selected_product_name"] ?? "",
        selectedProductHasExpiry: json["selected_product_has_expiry"] ?? true,
        filterTypeList: List<DropDownValueModel>.from((json["filter_type_list"] ??
                [
                  {"name": "All", "value": ""},
                  {"name": "Low Stock", "value": "low_stock"},
                  {"name": "Expiry", "value": "expiry"},
                ])
            .map((x) => DropDownValueModel.fromJson(x))),
        products: List<ProductList>.from((json["products"] ?? []).map((x) => ProductList.fromJson(x))),
        locationCount: List<int>.from((json["location_count"] ?? []).map((x) => x)),
        minimumLevelCount: json["minimum_level_count"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "loader": loader,
        "count_loader": countLoader,
        "tab_pressed": tabPressed,
        "search_bar": searchBar,
        "minimum_controller": minimumController,
        "quantity_controller": quantityController,
        "selected_list_index": selectedListIndex,
        "tab_controller_index": tabControllerIndex,
        "filter_index": filterIndex,
        //"tab_controller": tabController,
        "tab_widget_list": tabsWidgetList,
        "tabs_enable_list": tabsEnableList,
        "transit_list": transitList,
        "product_list_heading": productListHeading,
        "product_expiry_list_heading": productExpiryListHeading,
        "product_data_list": productDataList,
        "shortage_list_heading": shortageListHeading,
        "shortage_data_list": shortageDataList,
        "selected_choice_chip": selectedChoiceChip,
        "category_drop_downList": categoryDropDownList,
        "selected_location_id": selectedLocationId,
        "selected_product_id": selectedProductId,
        "selected_product_name": selectedProductName,
        "selected_product_has_expiry": selectedProductHasExpiry,
        "selected_stock_type_id": selectedStockTypeId,
        "products": products,
        "location_count": locationCount,
        "minimum_level_count": minimumLevelCount,
      };
}

class InventoryDatum {
  final String text;
  final String imageData;
  final int deviceCount;

  InventoryDatum({
    required this.text,
    required this.imageData,
    required this.deviceCount,
  });

  factory InventoryDatum.fromJson(Map<String, dynamic> json) => InventoryDatum(
        imageData: json["image_data"] ?? "",
        text: json["text"] ?? "",
        deviceCount: json["device_count"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "image_data": imageData,
        "text": text,
        "device_count": deviceCount,
      };
}
