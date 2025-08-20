import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:tvsaviation/resources/drop_down_lib/dropdown_textfield.dart';

ManageVariables manageVariablesFromJson(String str) => ManageVariables.fromJson(json.decode(str));

String manageVariablesToJson(ManageVariables data) => json.encode(data.toJson());

class ManageVariables {
  bool loader;
  bool csvUploadFileLoader;
  String manageSelectedWithinScreen;
  int manageSelectedIndex;
  int manageSelectedBackIndex;
  AddInventory addInventory;
  AddProduct addProduct;
  AddBrand addBrand;
  AddCategory addCategory;
  AddCrew addCrew;
  AddHandler addHandler;
  AddWareHouse addWareHouse;
  AddAirCraft addAirCraft;
  AddSector addSector;
  String selectedFileName;
  File? selectedFile;
  int currentPage;
  int totalPages;
  List<DropDownValueModel> productBrandTypeSuggestionList;
  List<DropDownValueModel> brandTypeSuggestionList;
  List<DropDownValueModel> categorySuggestionList;

  ManageVariables({
    required this.loader,
    required this.csvUploadFileLoader,
    required this.manageSelectedWithinScreen,
    required this.manageSelectedIndex,
    required this.manageSelectedBackIndex,
    required this.addInventory,
    required this.addProduct,
    required this.addBrand,
    required this.addCategory,
    required this.addCrew,
    required this.addHandler,
    required this.addWareHouse,
    required this.addAirCraft,
    required this.addSector,
    required this.selectedFileName,
    required this.selectedFile,
    required this.currentPage,
    required this.totalPages,
    required this.productBrandTypeSuggestionList,
    required this.brandTypeSuggestionList,
    required this.categorySuggestionList,
  });

  factory ManageVariables.fromJson(Map<String, dynamic> json) => ManageVariables(
        loader: json["loader"] ?? false,
        csvUploadFileLoader: json["csv_upload_file_loader"] ?? false,
        manageSelectedWithinScreen: json["manage_selected_within_screen"] ?? "",
        manageSelectedIndex: json["manage_selected_index"] ?? 0,
        manageSelectedBackIndex: json["manage_selected_back_index"] ?? 0,
        addInventory: AddInventory.fromJson(json["add_inventory"] ?? {}),
        addProduct: AddProduct.fromJson(json["add_product"] ??
            {
              "table_heading": ["Photo", "Product & Brand/Type", "Category", "Status", "Action"],
              "table_data": []
            }),
        addBrand: AddBrand.fromJson(json["add_brand"] ??
            {
              "table_heading": ["Brand/Type", "Action"],
              "table_data": []
            }),
        addCategory: AddCategory.fromJson(json["add_category"] ??
            {
              "table_heading": ["Category", "Action"],
              "table_data": []
            }),
        addCrew: AddCrew.fromJson(json["add_crew"] ??
            {
              "table_heading": ["Photo", "Crew Name", "E-mail", "Status", "Action"],
              "table_data": []
            }),
        addHandler: AddHandler.fromJson(json["add_handler"] ??
            {
              "table_heading": ["Handler", "Action"],
              "table_data": []
            }),
        addWareHouse: AddWareHouse.fromJson(json["add_ware_house"] ??
            {
              "table_heading": ["Warehouse", "Action"],
              "table_data": []
            }),
        addAirCraft: AddAirCraft.fromJson(json["add_air_craft"] ??
            {
              "table_heading": ["Aircraft", "Action"],
              "table_data": []
            }),
        addSector: AddSector.fromJson(json["add_sector"] ??
            {
              "table_heading": ["Airport Name", "City", "ICAO", "IATA", "Action"],
              "table_data": []
            }),
        selectedFileName: json["selected_file_name"] ?? "",
        selectedFile: json["selected_file"],
        currentPage: json["current_page"] ?? 1,
        totalPages: json["total_pages"] ?? 1,
        productBrandTypeSuggestionList: List<DropDownValueModel>.from((json["product_brand_type_suggestion_list"] ?? []).map((x) => DropDownValueModel.fromJson(x))),
        brandTypeSuggestionList: List<DropDownValueModel>.from((json["brand_type_suggestion_list"] ?? []).map((x) => DropDownValueModel.fromJson(x))),
        categorySuggestionList: List<DropDownValueModel>.from((json["category_suggestion_list"] ?? []).map((x) => DropDownValueModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "loader": loader,
        "csv_upload_file_loader": csvUploadFileLoader,
        "manage_selected_within_screen": manageSelectedWithinScreen,
        "manage_selected_index": manageSelectedIndex,
        "manage_selected_back_index": manageSelectedBackIndex,
        "add_inventory": addInventory.toJson(),
        "add_product": addProduct.toJson(),
        "add_brand": addBrand.toJson(),
        "add_category": addCategory.toJson(),
        "add_ware_house": addWareHouse.toJson(),
        "add_crew": addCrew.toJson(),
        "add_air_craft": addAirCraft.toJson(),
        "add_sector": addSector.toJson(),
        "selected_file_name": selectedFileName,
        "current_page": currentPage,
        "total_pages": totalPages,
        "product_brand_type_suggestion_list": productBrandTypeSuggestionList,
        "brand_type_suggestion_list": brandTypeSuggestionList,
        "category_suggestion_list": categorySuggestionList,
      };
}

class AddInventory {
  FocusNode locationControllerFocusNode;
  String locationId;
  FocusNode productBrandControllerFocusNode;
  String productId;
  FocusNode stockTypeControllerFocusNode;
  String stockTypeId;
  TextEditingController categoryController;
  String categoryId;
  TextEditingController purchaseMonthController;
  TextEditingController quantityController;
  TextEditingController optimumController;
  TextEditingController barCodeController;
  bool isChecked;
  bool filterCalenderEnabled;
  bool isScanning;
  DateRangePickerController dateController;
  List<DropDownValueModel> stockTypeDropDownList;

  AddInventory({
    required this.locationControllerFocusNode,
    required this.locationId,
    required this.productBrandControllerFocusNode,
    required this.productId,
    required this.stockTypeControllerFocusNode,
    required this.stockTypeId,
    required this.categoryController,
    required this.categoryId,
    required this.purchaseMonthController,
    required this.quantityController,
    required this.optimumController,
    required this.isChecked,
    required this.isScanning,
    required this.filterCalenderEnabled,
    required this.dateController,
    required this.barCodeController,
    required this.stockTypeDropDownList,
  });

  factory AddInventory.fromJson(Map<String, dynamic> json) => AddInventory(
        locationControllerFocusNode: json["location_controller_focus_node"] ?? FocusNode(),
        locationId: json["location_id"] ?? "",
        productBrandControllerFocusNode: json["product_brand_controller_focus_node"] ?? FocusNode(),
        productId: json["product_brand_id"] ?? "",
        stockTypeControllerFocusNode: json["stock_type_controller_focus_node"] ?? FocusNode(),
        stockTypeId: json["stock_type_id"] ?? "",
        categoryController: json["category_controller"] ?? TextEditingController(),
        categoryId: json["category_id"] ?? "",
        purchaseMonthController: json["purchase_month_controller"] ?? TextEditingController(),
        quantityController: json["quantity_controller"] ?? TextEditingController(),
        optimumController: json["optimum_controller"] ?? TextEditingController(text: "0"),
        isChecked: json["is_checked"] ?? false,
        isScanning: json["is_scanning"] ?? false,
        filterCalenderEnabled: json["filter_calender_enabled"] ?? false,
        dateController: json["date_controller"] ?? DateRangePickerController(),
        barCodeController: json["bar_code_controller"] ?? TextEditingController(),
        stockTypeDropDownList: List<DropDownValueModel>.from((json["stock_type_drop_down_list"] ??
                [
                  {"name": "CURRENT STOCK", "value": "current_stock"},
                  {"name": "FOOD ITEMS & DISPOSABLES", "value": "food_items_&_disposables"},
                  {"name": "UNUSED & OLD STOCKS", "value": "unused_stock"},
                ])
            .map((x) => DropDownValueModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "location_controller_focus_node": locationControllerFocusNode,
        "location_id": locationId,
        "product_brand_controller_focus_node": productBrandControllerFocusNode,
        "product_brand_id": productId,
        "stock_type_controller_focus_node": stockTypeControllerFocusNode,
        "stock_type_id": stockTypeId,
        "category_controller": categoryController,
        "category_id": categoryId,
        "purchase_month_controller": purchaseMonthController,
        "quantity_controller": quantityController,
        "optimum_controller": optimumController,
        "is_checked": isChecked,
        "is_scanning": isScanning,
        "filter_calender_enabled": filterCalenderEnabled,
        "date_controller": dateController,
        "bar_code_controller": barCodeController,
        "stock_type_drop_down_list": stockTypeDropDownList,
      };
}

class AddProduct {
  TextEditingController productController;
  TextEditingController productEditController;
  FocusNode categoryControllerFocusNode;
  String categoryId;
  String categoryEditId;
  FocusNode categoryEditControllerFocusNode;
  FocusNode brandControllerFocusNode;
  String brandId;
  String brandEditId;
  FocusNode brandEditControllerFocusNode;
  TextEditingController daysUntilController;
  TextEditingController daysUntilEditController;
  TextEditingController searchBar;
  bool isChecked;
  bool isEditChecked;
  File? selectedImage;
  File? selectedEditImage;
  String selectedFileName;
  String selectedEditFileName;
  int editSelectedIndex;
  bool isEdit;
  bool isCreate;
  List<String> tableHeading;
  List<List<String>> tableData;

  AddProduct({
    required this.categoryControllerFocusNode,
    required this.categoryId,
    required this.categoryEditId,
    required this.categoryEditControllerFocusNode,
    required this.productController,
    required this.productEditController,
    required this.brandControllerFocusNode,
    required this.brandId,
    required this.brandEditId,
    required this.brandEditControllerFocusNode,
    required this.daysUntilController,
    required this.daysUntilEditController,
    required this.searchBar,
    required this.isChecked,
    required this.isEditChecked,
    required this.tableHeading,
    required this.tableData,
    required this.selectedFileName,
    required this.selectedEditFileName,
    required this.editSelectedIndex,
    required this.isEdit,
    required this.isCreate,
    this.selectedImage,
    this.selectedEditImage,
  });

  factory AddProduct.fromJson(Map<String, dynamic> json) => AddProduct(
        categoryControllerFocusNode: json["category_controller_focus_node"] ?? FocusNode(),
        categoryId: json["category_id"] ?? "",
        categoryEditId: json["category_edit_id"] ?? "",
        categoryEditControllerFocusNode: json["category_edit_controller_focus_node"] ?? FocusNode(),
        productController: json["product_controller"] ?? TextEditingController(),
        productEditController: json["product_edit_controller"] ?? TextEditingController(),
        brandControllerFocusNode: json["brand_controller_focus_node"] ?? FocusNode(),
        brandId: json["brand_id"] ?? "",
        brandEditId: json["brand_edit_id"] ?? "",
        brandEditControllerFocusNode: json["brand_edit_controller_focus_node"] ?? FocusNode(),
        daysUntilController: json["days_until_controller"] ?? TextEditingController(),
        daysUntilEditController: json["days_edit_until_controller"] ?? TextEditingController(),
        searchBar: json["search_bar"] ?? TextEditingController(),
        isChecked: json["is_checked"] ?? false,
        isEditChecked: json["is_edit_checked"] ?? false,
        selectedImage: json["selected_image"],
        selectedEditImage: json["selected_edit_image"],
        selectedFileName: json["selected_file_name"] ?? "",
        selectedEditFileName: json["selected_edit_file_name"] ?? "",
        editSelectedIndex: json["edit_selected_index"] ?? 0,
        isEdit: json["is_edit"] ?? false,
        isCreate: json["is_create"] ?? true,
        tableHeading: List<String>.from((json["table_heading"] ?? []).map((x) => x)),
        tableData: List<List<String>>.from(json["table_data"].map((x) => List<String>.from(x.map((x) => x)))),
      );

  Map<String, dynamic> toJson() => {
        "category_controller_focus_node": categoryControllerFocusNode,
        "category_id": categoryId,
        "category_edit_id": categoryEditId,
        "category_edit_controller_focus_node": categoryEditControllerFocusNode,
        "product_controller": productController,
        "product_edit_controller": productEditController,
        "brand_controller_focus_node": brandControllerFocusNode,
        "brand_id": brandId,
        "brand_edit_id": brandEditId,
        "brand_edit_controller_focus_node": brandEditControllerFocusNode,
        "days_until_controller": daysUntilController,
        "days_edit_until_controller": daysUntilEditController,
        "search_bar": searchBar,
        "is_checked": isChecked,
        "is_edit_checked": isEditChecked,
        "selected_image": selectedImage,
        "selected_edit_image": selectedEditImage,
        "selected_file_name": selectedFileName,
        "selected_edit_file_name": selectedEditFileName,
        "edit_selected_index": editSelectedIndex,
        "is_edit": isEdit,
        "is_create": isCreate,
        "table_heading": List<dynamic>.from(tableHeading.map((x) => x)),
        "table_data": List<dynamic>.from(tableData.map((x) => List<dynamic>.from(x.map((x) => x)))),
      };
}

class AddBrand {
  TextEditingController brandController;
  TextEditingController editBrandController;
  TextEditingController searchBar;
  List<String> tableHeading;
  List<List<String>> tableData;

  AddBrand({
    required this.brandController,
    required this.editBrandController,
    required this.searchBar,
    required this.tableHeading,
    required this.tableData,
  });

  factory AddBrand.fromJson(Map<String, dynamic> json) => AddBrand(
        brandController: json["brand_controller"] ?? TextEditingController(),
        editBrandController: json["edit_brand_controller"] ?? TextEditingController(),
        searchBar: json["search_bar"] ?? TextEditingController(),
        tableHeading: List<String>.from((json["table_heading"] ?? []).map((x) => x)),
        tableData: List<List<String>>.from(json["table_data"].map((x) => List<String>.from(x.map((x) => x)))),
      );

  Map<String, dynamic> toJson() => {
        "brand_controller": brandController,
        "edit_brand_controller": editBrandController,
        "search_bar": searchBar,
        "table_heading": List<dynamic>.from(tableHeading.map((x) => x)),
        "table_data": List<dynamic>.from(tableData.map((x) => List<dynamic>.from(x.map((x) => x)))),
      };
}

class AddCategory {
  TextEditingController categoryController;
  TextEditingController editCategoryController;
  TextEditingController searchBar;
  List<String> tableHeading;
  List<List<String>> tableData;

  AddCategory({
    required this.categoryController,
    required this.editCategoryController,
    required this.searchBar,
    required this.tableHeading,
    required this.tableData,
  });

  factory AddCategory.fromJson(Map<String, dynamic> json) => AddCategory(
        categoryController: json["category_controller"] ?? TextEditingController(),
        editCategoryController: json["edit_category_controller"] ?? TextEditingController(),
        searchBar: json["search_bar"] ?? TextEditingController(),
        tableHeading: List<String>.from((json["table_heading"] ?? []).map((x) => x)),
        tableData: List<List<String>>.from(json["table_data"].map((x) => List<String>.from(x.map((x) => x)))),
      );

  Map<String, dynamic> toJson() => {
        "category_controller": categoryController,
        "edit_category_controller": editCategoryController,
        "search_bar": searchBar,
        "table_heading": List<dynamic>.from(tableHeading.map((x) => x)),
        "table_data": List<dynamic>.from(tableData.map((x) => List<dynamic>.from(x.map((x) => x)))),
      };
}

class AddCrew {
  TextEditingController crewController;
  TextEditingController crewEditController;
  TextEditingController crewEmailController;
  TextEditingController crewEmailEditController;
  TextEditingController passwordController;
  TextEditingController confirmPasswordController;
  TextEditingController searchBar;
  bool crewObscureText;
  bool crewObscureText2;
  String selectedRole;
  String selectedRole2;
  List<String> tableHeading;
  List<List<String>> tableData;

  AddCrew({
    required this.crewController,
    required this.crewEditController,
    required this.crewEmailController,
    required this.crewEmailEditController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.searchBar,
    required this.crewObscureText,
    required this.crewObscureText2,
    required this.selectedRole,
    required this.selectedRole2,
    required this.tableHeading,
    required this.tableData,
  });

  factory AddCrew.fromJson(Map<String, dynamic> json) => AddCrew(
        crewController: json["crew_controller"] ?? TextEditingController(),
        crewEditController: json["crew_edit_controller"] ?? TextEditingController(),
        crewEmailController: json["crew_email_controller"] ?? TextEditingController(),
        crewEmailEditController: json["crew_email_edit_controller"] ?? TextEditingController(),
        passwordController: json["password_controller"] ?? TextEditingController(),
        confirmPasswordController: json["confirm_password_controller"] ?? TextEditingController(),
        searchBar: json["search_bar"] ?? TextEditingController(),
        crewObscureText: json["crew_obscure_text"] ?? true,
        crewObscureText2: json["crew_obscure_text2"] ?? true,
        selectedRole: json["selected_role"] ?? "admin",
        selectedRole2: json["selected_role2"] ?? "admin",
        tableHeading: List<String>.from((json["table_heading"] ?? []).map((x) => x)),
        tableData: List<List<String>>.from(json["table_data"].map((x) => List<String>.from(x.map((x) => x)))),
      );

  Map<String, dynamic> toJson() => {
        "crew_controller": crewController,
        "crew_edit_controller": crewEditController,
        "crew_email_controller": crewEmailController,
        "crew_email_edit_controller": crewEmailEditController,
        "password_controller": passwordController,
        "confirm_password_controller": confirmPasswordController,
        "search_bar": searchBar,
        "crew_obscure_text": crewObscureText,
        "crew_obscure_text2": crewObscureText2,
        "selected_role": selectedRole,
        "selected_role2": selectedRole2,
        "table_heading": List<dynamic>.from(tableHeading.map((x) => x)),
        "table_data": List<dynamic>.from(tableData.map((x) => List<dynamic>.from(x.map((x) => x)))),
      };
}

class AddHandler {
  TextEditingController handlerController;
  TextEditingController editHandlerController;
  TextEditingController searchBar;
  List<String> tableHeading;
  List<List<String>> tableData;

  AddHandler({
    required this.handlerController,
    required this.editHandlerController,
    required this.searchBar,
    required this.tableHeading,
    required this.tableData,
  });

  factory AddHandler.fromJson(Map<String, dynamic> json) => AddHandler(
        handlerController: json["handler_controller"] ?? TextEditingController(),
        editHandlerController: json["edit_handler_Controller"] ?? TextEditingController(),
        searchBar: json["search_bar"] ?? TextEditingController(),
        tableHeading: List<String>.from((json["table_heading"] ?? []).map((x) => x)),
        tableData: List<List<String>>.from(json["table_data"].map((x) => List<String>.from(x.map((x) => x)))),
      );

  Map<String, dynamic> toJson() => {
        "ware_house_controller": handlerController,
        "edit_handler_Controller": editHandlerController,
        "search_bar": searchBar,
        "table_heading": List<dynamic>.from(tableHeading.map((x) => x)),
        "table_data": List<dynamic>.from(tableData.map((x) => List<dynamic>.from(x.map((x) => x)))),
      };
}

class AddWareHouse {
  TextEditingController wareHouseController;
  TextEditingController editWareHouseController;
  TextEditingController searchBar;
  List<String> tableHeading;
  List<List<String>> tableData;

  AddWareHouse({
    required this.wareHouseController,
    required this.editWareHouseController,
    required this.searchBar,
    required this.tableHeading,
    required this.tableData,
  });

  factory AddWareHouse.fromJson(Map<String, dynamic> json) => AddWareHouse(
        wareHouseController: json["ware_house_controller"] ?? TextEditingController(),
        editWareHouseController: json["edit_ware_house_controller"] ?? TextEditingController(),
        searchBar: json["search_bar"] ?? TextEditingController(),
        tableHeading: List<String>.from((json["table_heading"] ?? []).map((x) => x)),
        tableData: List<List<String>>.from(json["table_data"].map((x) => List<String>.from(x.map((x) => x)))),
      );

  Map<String, dynamic> toJson() => {
        "ware_house_controller": wareHouseController,
        "edit_ware_house_controller": editWareHouseController,
        "search_bar": searchBar,
        "table_heading": List<dynamic>.from(tableHeading.map((x) => x)),
        "table_data": List<dynamic>.from(tableData.map((x) => List<dynamic>.from(x.map((x) => x)))),
      };
}

class AddAirCraft {
  TextEditingController airCraftController;
  TextEditingController editAirCraftController;
  TextEditingController searchBar;
  List<String> tableHeading;
  List<List<String>> tableData;

  AddAirCraft({
    required this.airCraftController,
    required this.editAirCraftController,
    required this.searchBar,
    required this.tableHeading,
    required this.tableData,
  });

  factory AddAirCraft.fromJson(Map<String, dynamic> json) => AddAirCraft(
        airCraftController: json["air_craft_Controller"] ?? TextEditingController(),
        editAirCraftController: json["edit_air_craft_controller"] ?? TextEditingController(),
        searchBar: json["search_bar"] ?? TextEditingController(),
        tableHeading: List<String>.from((json["table_heading"] ?? []).map((x) => x)),
        tableData: List<List<String>>.from(json["table_data"].map((x) => List<String>.from(x.map((x) => x)))),
      );

  Map<String, dynamic> toJson() => {
        "air_craft_Controller": airCraftController,
        "edit_air_craft_controller": editAirCraftController,
        "search_bar": searchBar,
        "table_heading": List<dynamic>.from(tableHeading.map((x) => x)),
        "table_data": List<dynamic>.from(tableData.map((x) => List<dynamic>.from(x.map((x) => x)))),
      };
}

class AddSector {
  TextEditingController icaoController;
  TextEditingController iataController;
  TextEditingController airportController;
  TextEditingController cityController;
  TextEditingController icaoEditController;
  TextEditingController iataEditController;
  TextEditingController airportEditController;
  TextEditingController cityEditController;
  TextEditingController searchBar;
  List<String> tableHeading;
  List<List<String>> tableData;

  AddSector({
    required this.icaoController,
    required this.iataController,
    required this.airportController,
    required this.cityController,
    required this.icaoEditController,
    required this.iataEditController,
    required this.airportEditController,
    required this.cityEditController,
    required this.searchBar,
    required this.tableHeading,
    required this.tableData,
  });

  factory AddSector.fromJson(Map<String, dynamic> json) => AddSector(
        icaoController: json["icao_controller"] ?? TextEditingController(),
        iataController: json["iata_controller"] ?? TextEditingController(),
        airportController: json["airport_controller"] ?? TextEditingController(),
        cityController: json["city_controller"] ?? TextEditingController(),
        icaoEditController: json["icao_edit_controller"] ?? TextEditingController(),
        iataEditController: json["iata_edit_controller"] ?? TextEditingController(),
        airportEditController: json["airport_edit_controller"] ?? TextEditingController(),
        cityEditController: json["city_edit_controller"] ?? TextEditingController(),
        searchBar: json["search_bar"] ?? TextEditingController(),
        tableHeading: List<String>.from((json["table_heading"] ?? []).map((x) => x)),
        tableData: List<List<String>>.from(json["table_data"].map((x) => List<String>.from(x.map((x) => x)))),
      );

  Map<String, dynamic> toJson() => {
        "icao_controller": icaoController,
        "iata_controller": iataController,
        "airport_controller": airportController,
        "city_controller": cityController,
        "icao_edit_controller": icaoEditController,
        "iata_edit_controller": iataEditController,
        "airport_edit_controller": airportEditController,
        "city_edit_controller": cityEditController,
        "search_bar": searchBar,
        "table_heading": List<dynamic>.from(tableHeading.map((x) => x)),
        "table_data": List<dynamic>.from(tableData.map((x) => List<dynamic>.from(x.map((x) => x)))),
      };
}
