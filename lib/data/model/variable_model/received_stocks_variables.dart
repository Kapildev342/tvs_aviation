import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:tvsaviation/resources/drop_down_lib/dropdown_textfield.dart';

ReceivedStocksVariables receivedStocksVariablesFromJson(String str) => ReceivedStocksVariables.fromJson(json.decode(str));

String receivedStocksVariablesToJson(ReceivedStocksVariables data) => json.encode(data.toJson());

class ReceivedStocksVariables {
  bool loader;
  bool continueLoader;
  SenderDatum senderInfo;
  ReceiverDatum receiverInfo;
  ReceivedStocksInventory receivedStocksInventory;
  ReceivedStocksDisputes receivedStocksDisputes;
  String tempTransId;
  String pageState;
  String totalProducts;
  String totalDisputeProducts;
  String totalQuantity;
  String totalDisputeQuantity;
  TextEditingController senderRemarksController;
  TextEditingController receiverRemarksController;
  bool isAllowToReceive;
  bool disputePageOpened;

  ReceivedStocksVariables({
    required this.loader,
    required this.continueLoader,
    required this.senderInfo,
    required this.receiverInfo,
    required this.receivedStocksInventory,
    required this.receivedStocksDisputes,
    required this.tempTransId,
    required this.pageState,
    required this.totalProducts,
    required this.totalDisputeProducts,
    required this.totalQuantity,
    required this.totalDisputeQuantity,
    required this.senderRemarksController,
    required this.receiverRemarksController,
    required this.isAllowToReceive,
    required this.disputePageOpened,
  });

  factory ReceivedStocksVariables.fromJson(Map<String, dynamic> json) => ReceivedStocksVariables(
        loader: json["loader"] ?? false,
        continueLoader: json["continue_loader"] ?? false,
        senderInfo: SenderDatum.fromJson(json["sender_info"] ?? {}),
        receiverInfo: ReceiverDatum.fromJson(json["receiver"] ?? {}),
        receivedStocksInventory: ReceivedStocksInventory.fromJson(json["received_stocks_inventory"] ??
            {
              "heading": "Inventory",
              "table_heading": ["Photo", "Barcode", "Products", "Brands", "M.O Purchase", "Expiry Date", "Qty", "Action"],
              "table_data": []
            }),
        receivedStocksDisputes: ReceivedStocksDisputes.fromJson(json["received_stocks_disputes"] ??
            {
              "heading": "Inventory",
              "table_heading": ["Photo", "Dispute Id", "Products", "Brands", "M.O Purchase", "Expiry Date", "Qty"],
              "table_data": []
            }),
        tempTransId: json["temp_trans_id"] ?? "",
        pageState: json["page_state"] ?? "reports",
        totalProducts: json["totalProducts"] ?? "0",
        totalDisputeProducts: json["totalDisputeProducts"] ?? "0",
        totalQuantity: json["totalQuantity"] ?? "0",
        totalDisputeQuantity: json["totalDisputeQuantity"] ?? "0",
        senderRemarksController: json["sender_remarks_controller"] ?? TextEditingController(),
        receiverRemarksController: json["receiver_remarks_controller"] ?? TextEditingController(),
        isAllowToReceive: json["is_allow_to_receive"] ?? false,
        disputePageOpened: json["dispute_page_opened"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "loader": loader,
        "continue_loader": continueLoader,
        "sender_info": senderInfo.toJson(),
        "receiver-info": receiverInfo.toJson(),
        "received_stocks_inventory": receivedStocksInventory.toJson(),
        "received_stocks_disputes": receivedStocksDisputes.toJson(),
        "temp_trans_id": tempTransId,
        "page_state": pageState,
        "totalProducts": totalProducts,
        "totalDisputeProducts": totalDisputeProducts,
        "totalQuantity": totalQuantity,
        "totalDisputeQuantity": totalDisputeQuantity,
        "sender_remarks_controller": senderRemarksController,
        "receiver_remarks_controller": receiverRemarksController,
        "is_allow_to_receive": isAllowToReceive,
        "dispute_page_opened": disputePageOpened,
      };
}

class SenderDatum {
  DropDownValueModel senderLocationChoose;
  DropDownValueModel senderStockTypeChoose;
  DropDownValueModel senderFromSectorChoose;
  DropDownValueModel senderToSectorChoose;

  List<DropDownValueModel> locationDropDownList;
  List<DropDownValueModel> stockTypeDropDownList;
  List<DropDownValueModel> categoryDropDownList;
  List<DropDownValueModel> sectorDropDownList;
  final TextEditingController crewHandlerController;
  final TextEditingController crewHandlerNameController;
  final TextEditingController locationController;
  final TextEditingController stockTypeController;
  final TextEditingController handlerNameController;
  final TextEditingController handlerNumberController;
  final String crewHandler;
  final String crewHandlerName;
  final String location;
  final String stockType;
  String image1;
  String image2;

  SenderDatum({
    required this.senderLocationChoose,
    required this.senderStockTypeChoose,
    required this.senderFromSectorChoose,
    required this.senderToSectorChoose,
    required this.locationDropDownList,
    required this.stockTypeDropDownList,
    required this.categoryDropDownList,
    required this.sectorDropDownList,
    required this.crewHandler,
    required this.crewHandlerName,
    required this.location,
    required this.stockType,
    required this.crewHandlerController,
    required this.crewHandlerNameController,
    required this.locationController,
    required this.stockTypeController,
    required this.handlerNameController,
    required this.handlerNumberController,
    required this.image1,
    required this.image2,
  });

  factory SenderDatum.fromJson(Map<String, dynamic> json) => SenderDatum(
        senderLocationChoose: DropDownValueModel.fromJson(json["sender_location_choose"] ?? {}),
        senderStockTypeChoose: DropDownValueModel.fromJson(json["sender_stock_type_choose"] ?? {}),
        senderFromSectorChoose: DropDownValueModel.fromJson(json["sender_from_sector_choose"] ?? {}),
        senderToSectorChoose: DropDownValueModel.fromJson(json["sender_to_sector_choose"] ?? {}),
        locationDropDownList: List<DropDownValueModel>.from((json["location_drop_down_list"] ?? []).map((x) => DropDownValueModel.fromJson(x))),
        stockTypeDropDownList: List<DropDownValueModel>.from((json["stock_type_drop_down_list"] ?? []).map((x) => DropDownValueModel.fromJson(x))),
        categoryDropDownList: List<DropDownValueModel>.from((json["category_drop_downList"] ?? []).map((x) => DropDownValueModel.fromJson(x))),
        sectorDropDownList: List<DropDownValueModel>.from((json["sector_drop_down_list"] ?? []).map((x) => DropDownValueModel.fromJson(x))),
        crewHandler: json["crew_handler"] ?? "",
        crewHandlerName: json["crew_handler_name"] ?? "",
        location: json["location"] ?? "",
        stockType: json["stock_type"] ?? "",
        crewHandlerController: json["crew_handler_controller"] ?? TextEditingController(),
        crewHandlerNameController: json["crew_handler_name_controller"] ?? TextEditingController(),
        locationController: json["location_controller"] ?? TextEditingController(),
        stockTypeController: json["stock_type_controller"] ?? TextEditingController(),
        handlerNameController: json["handle_name_controller"] ?? TextEditingController(),
        handlerNumberController: json["handler_number_controller"] ?? TextEditingController(),
        image1: json["image1"] ?? "",
        image2: json["image2"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "sender_location_choose": senderLocationChoose,
        "sender_stock_type_choose": senderStockTypeChoose,
        "sender_from_sector_choose": senderFromSectorChoose,
        "sender_to_sector_choose": senderToSectorChoose,
        "location_drop_down_list": locationDropDownList,
        "stock_type_drop_down_list": stockTypeDropDownList,
        "category_drop_downList": categoryDropDownList,
        "sector_drop_down_list": sectorDropDownList,
        "crew_handler": crewHandler,
        "crew_handler_name": crewHandlerName,
        "location": location,
        "stock_type": stockType,
        "crew_handler_controller": crewHandlerController,
        "crew_handler_name_controller": crewHandlerNameController,
        "location_controller": locationController,
        "stock_type_controller": stockTypeController,
        "handle_name_controller": handlerNameController,
        "handler_number_controller": handlerNumberController,
        "image1": image1,
        "image2": image2,
      };
}

class ReceiverDatum {
  String receiverType;
  DropDownValueModel crewChoose;
  DropDownValueModel handlerChoose;
  DropDownValueModel receiverLocationChoose;
  DropDownValueModel receiverStockTypeChoose;

  List<String> receiverTypeList;
  List<DropDownValueModel> crewDropDownList;
  List<DropDownValueModel> handlerDropDownList;
  final TextEditingController crewHandlerController;
  final TextEditingController locationController;
  final TextEditingController stockTypeController;
  final TextEditingController fromSectorController;
  final TextEditingController toSectorController;

  final String crewHandler;
  final String location;
  final String stockType;
  final String fromSector;
  final String toSector;

  ReceiverDatum({
    required this.receiverType,
    required this.crewChoose,
    required this.handlerChoose,
    required this.receiverLocationChoose,
    required this.receiverStockTypeChoose,
    required this.receiverTypeList,
    required this.crewDropDownList,
    required this.handlerDropDownList,
    required this.crewHandler,
    required this.location,
    required this.stockType,
    required this.fromSector,
    required this.toSector,
    required this.crewHandlerController,
    required this.locationController,
    required this.stockTypeController,
    required this.fromSectorController,
    required this.toSectorController,
  });

  factory ReceiverDatum.fromJson(Map<String, dynamic> json) => ReceiverDatum(
        receiverType: json["receiver_type"] ?? "Crew",
        crewChoose: DropDownValueModel.fromJson(json["crew_choose"] ?? {}),
        handlerChoose: DropDownValueModel.fromJson(json["handler_choose"] ?? {}),
        receiverLocationChoose: DropDownValueModel.fromJson(json["receiver_location_choose"] ?? {}),
        receiverStockTypeChoose: DropDownValueModel.fromJson(json["stock_type_choose"] ?? {}),
        receiverTypeList: List<String>.from((json["receiver_type_list"] ?? ["Crew", "Handler"]).map((x) => x)),
        crewDropDownList: List<DropDownValueModel>.from((json["crew_drop_down_list"] ?? []).map((x) => DropDownValueModel.fromJson(x))),
        handlerDropDownList: List<DropDownValueModel>.from((json["handler_drop_down_list"] ?? []).map((x) => DropDownValueModel.fromJson(x))),
        crewHandler: json["crew_handler"] ?? "",
        location: json["location"] ?? "",
        stockType: json["stock_type"] ?? "",
        fromSector: json["from_sector"] ?? "",
        toSector: json["to_sector"] ?? "",
        crewHandlerController: json["crew_handler_controller"] ?? TextEditingController(),
        locationController: json["location_controller"] ?? TextEditingController(),
        stockTypeController: json["stock_type_controller"] ?? TextEditingController(),
        fromSectorController: json["from_sector_controller"] ?? TextEditingController(),
        toSectorController: json["to_sector_controller"] ?? TextEditingController(),
      );

  Map<String, dynamic> toJson() => {
        "receiver_type": receiverType,
        "crew_or_handler_choose": crewChoose,
        "handler_choose": handlerChoose,
        "receiver_location_choose": receiverLocationChoose,
        "stock_type_choose": receiverStockTypeChoose,
        "receiver_type_list": receiverTypeList,
        "crew_drop_down_list": crewDropDownList,
        "handler_drop_down_list": handlerDropDownList,
        "crew_handler": crewHandler,
        "location": location,
        "stock_type": stockType,
        "from_sector": fromSector,
        "to_sector": toSector,
        "crew_handler_controller": crewHandlerController,
        "location_controller": locationController,
        "stock_type_controller": stockTypeController,
        "from_sector_controller": fromSectorController,
        "to_sector_controller": toSectorController,
      };
}

class ReceivedStocksInventory {
  final String heading;
  final List<String> tableHeading;
  final List<List<String>> tableData;

  ReceivedStocksInventory({
    required this.heading,
    required this.tableHeading,
    required this.tableData,
  });

  factory ReceivedStocksInventory.fromJson(Map<String, dynamic> json) => ReceivedStocksInventory(
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

class ReceivedStocksDisputes {
  final String heading;
  final List<String> tableHeading;
  final List<List<String>> tableData;

  ReceivedStocksDisputes({
    required this.heading,
    required this.tableHeading,
    required this.tableData,
  });

  factory ReceivedStocksDisputes.fromJson(Map<String, dynamic> json) => ReceivedStocksDisputes(
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
