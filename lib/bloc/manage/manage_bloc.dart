import 'dart:async';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:tvsaviation/data/hive/category/category_data.dart';
import 'package:tvsaviation/data/hive/crew/crew_data.dart';
import 'package:tvsaviation/data/hive/handler/handler_data.dart';
import 'package:tvsaviation/data/hive/location/location_data.dart';
import 'package:tvsaviation/data/hive/sector/sector_data.dart';
import 'package:tvsaviation/data/hive/user/user_data.dart';
import 'package:tvsaviation/data/model/api_model/add_manage_model.dart';
import 'package:tvsaviation/data/model/api_model/get_all_brand_list_model.dart';
import 'package:tvsaviation/data/model/api_model/get_all_category_list_model.dart';
import 'package:tvsaviation/data/model/api_model/get_all_product_brand_list_model.dart';
import 'package:tvsaviation/data/model/api_model/get_brand_type_model.dart';
import 'package:tvsaviation/data/model/api_model/get_category_model.dart';
import 'package:tvsaviation/data/model/api_model/get_category_response_model.dart';
import 'package:tvsaviation/data/model/api_model/get_crew_list_model.dart';
import 'package:tvsaviation/data/model/api_model/get_crew_model.dart';
import 'package:tvsaviation/data/model/api_model/get_handler_model.dart';
import 'package:tvsaviation/data/model/api_model/get_handlers_list_model.dart';
import 'package:tvsaviation/data/model/api_model/get_location_model.dart';
import 'package:tvsaviation/data/model/api_model/get_product_list_model.dart';
import 'package:tvsaviation/data/model/api_model/get_sector_list_model.dart';
import 'package:tvsaviation/data/model/api_model/get_sector_model.dart';
import 'package:tvsaviation/data/model/api_model/get_single_product_details.dart';
import 'package:tvsaviation/data/model/api_model/get_warehouse_or_aircraft_model.dart';
import 'package:tvsaviation/data/model/variable_model/inventory_change_model.dart';
import 'package:tvsaviation/resources/constants.dart';
import 'package:tvsaviation/resources/drop_down_lib/dropdown_textfield.dart';
import 'package:tvsaviation/resources/easy_auto_complete_lib/easy_autocomplete.dart';

part 'manage_event.dart';
part 'manage_state.dart';

class ManageBloc extends Bloc<ManageEvent, ManageState> {
  ManageBloc() : super(const ManageLoading()) {
    on<ManagePageChangingEvent>(managePageChangingFunction);
    on<ManagePageFilterEvent>(managePageFilterFunction);
    on<ManageCalenderEnablingEvent>(calenderEnablingFunction);
    on<InventoryBulkUploadEvent>(inventoryBulkUploadFunction);
    on<GetProductDetailsEvent>(getProductDetails);
    on<CsvFileSelectionEvent>(csvFileSelection);
    on<AddBrandTypeEvent>(addBrandTypeFunction);
    on<DeleteBrandTypeEvent>(deleteBrandTypeFunction);
    on<EditBrandTypeEvent>(editBrandTypeFunction);
    on<AddCategoryEvent>(addCategoryFunction);
    on<DeleteCategoryEvent>(deleteCategoryFunction);
    on<EditCategoryEvent>(editCategoryFunction);
    on<AddHandlerEvent>(addHandlerFunction);
    on<DeleteHandlerEvent>(deleteHandlerFunction);
    on<EditHandlerEvent>(editHandlerFunction);
    on<AddWarehouseOrAircraftEvent>(addWarehouseOrAircraftFunction);
    on<DeleteWarehouseOrAircraftEvent>(deleteWarehouseOrAircraftFunction);
    on<EditWarehouseOrAircraftEvent>(editWarehouseOrAircraftFunction);
    on<AddSectorEvent>(addSectorFunction);
    on<DeleteSectorEvent>(deleteSectorFunction);
    on<EditSectorEvent>(editSectorFunction);
    on<AddCrewEvent>(addCrewFunction);
    on<DeleteCrewEvent>(deleteCrewFunction);
    on<EditCrewEvent>(editCrewFunction);
    on<CrewActivateEvent>(crewActivateFunction);
    on<CrewDeactivateEvent>(crewDeactivateFunction);
    on<AddProductEvent>(addProductFunction);
    on<DeleteProductEvent>(deleteProductFunction);
    on<EditProductEvent>(editProductFunction);
    on<ProductActivateEvent>(productActivateFunction);
    on<ProductDeactivateEvent>(productDeactivateFunction);
    on<ProductMiniLevelExpiryEvent>(productMiniLevelExpiryFunction);
    on<AddInventoryEvent>(addInventoryFunction);
  }

  Future<void> managePageChangingFunction(ManagePageChangingEvent event, Emitter<ManageState> emit) async {
    emit(const ManageLoading());
    mainVariables.manageVariables.manageSelectedWithinScreen = event.withinScreen ?? "";
    mainVariables.manageVariables.manageSelectedIndex = event.index;
    mainVariables.manageVariables.addInventory.isChecked = false;
    mainVariables.manageVariables.csvUploadFileLoader = false;
    mainVariables.manageVariables.addInventory.isScanning = false;
    mainVariables.manageVariables.selectedFileName = "";
    mainVariables.manageVariables.totalPages = 1;
    mainVariables.manageVariables.currentPage = 1;
    mainVariables.manageVariables.addProduct.searchBar.clear();
    mainVariables.manageVariables.addBrand.searchBar.clear();
    mainVariables.manageVariables.addCategory.searchBar.clear();
    mainVariables.manageVariables.addCrew.searchBar.clear();
    mainVariables.manageVariables.addHandler.searchBar.clear();
    mainVariables.manageVariables.addWareHouse.searchBar.clear();
    mainVariables.manageVariables.addAirCraft.searchBar.clear();
    mainVariables.manageVariables.addSector.searchBar.clear();
    mainVariables.manageVariables.addCrew.crewObscureText = true;
    mainVariables.manageVariables.addCrew.crewObscureText2 = true;
    mainVariables.manageVariables.addProduct.isCreate = true;
    mainVariables.manageVariables.addProduct.isEdit = false;
    await mainVariables.repoImpl.getAllProductBrand().onError((error, stackTrace) {}).then((value) {
      if (value != null) {
        GetAllProductBrandListModel getAllProductBrandListModel = GetAllProductBrandListModel.fromJson(value);
        if (getAllProductBrandListModel.status) {
          if (getAllProductBrandListModel.products.isEmpty) {
            mainVariables.manageVariables.productBrandTypeSuggestionList.clear();
            mainVariables.manageVariables.productBrandTypeSuggestionList = [];
          } else {
            mainVariables.manageVariables.productBrandTypeSuggestionList.clear();
            mainVariables.manageVariables.productBrandTypeSuggestionList = [];
            for (int i = 0; i < getAllProductBrandListModel.products.length; i++) {
              mainVariables.manageVariables.productBrandTypeSuggestionList.add(
                DropDownValueModel(
                  name: getAllProductBrandListModel.products[i].combinedName,
                  value: getAllProductBrandListModel.products[i].id,
                ),
              );
            }
          }
        } else {
          mainVariables.manageVariables.productBrandTypeSuggestionList.clear();
          mainVariables.manageVariables.productBrandTypeSuggestionList = [];
        }
      }
    });
    await mainVariables.repoImpl.getAllCategory().onError((error, stackTrace) {}).then((value) {
      if (value != null) {
        GetAllCategoryListModel getAllCategoryListModel = GetAllCategoryListModel.fromJson(value);
        if (getAllCategoryListModel.status) {
          if (getAllCategoryListModel.categories.isEmpty) {
            mainVariables.manageVariables.categorySuggestionList.clear();
            mainVariables.manageVariables.categorySuggestionList = [];
          } else {
            mainVariables.manageVariables.categorySuggestionList.clear();
            mainVariables.manageVariables.categorySuggestionList = [];
            for (int i = 0; i < getAllCategoryListModel.categories.length; i++) {
              mainVariables.manageVariables.categorySuggestionList.add(
                DropDownValueModel(
                  name: getAllCategoryListModel.categories[i].name,
                  value: getAllCategoryListModel.categories[i].id,
                ),
              );
            }
          }
        } else {
          mainVariables.manageVariables.categorySuggestionList.clear();
          mainVariables.manageVariables.categorySuggestionList = [];
        }
      }
    });
    await mainVariables.repoImpl.getAllBrand().onError((error, stackTrace) {}).then((value) {
      if (value != null) {
        GetAllBrandListModel getAllBrandListModel = GetAllBrandListModel.fromJson(value);
        if (getAllBrandListModel.status) {
          if (getAllBrandListModel.brandTypes.isEmpty) {
            mainVariables.manageVariables.brandTypeSuggestionList.clear();
            mainVariables.manageVariables.brandTypeSuggestionList = [];
          } else {
            mainVariables.manageVariables.brandTypeSuggestionList.clear();
            mainVariables.manageVariables.brandTypeSuggestionList = [];
            for (int i = 0; i < getAllBrandListModel.brandTypes.length; i++) {
              mainVariables.manageVariables.brandTypeSuggestionList.add(
                DropDownValueModel(
                  name: getAllBrandListModel.brandTypes[i].name,
                  value: getAllBrandListModel.brandTypes[i].id,
                ),
              );
            }
          }
        } else {
          mainVariables.manageVariables.brandTypeSuggestionList.clear();
          mainVariables.manageVariables.brandTypeSuggestionList = [];
        }
      }
    });
    switch (event.index) {
      case 1:
        {
          await mainVariables.repoImpl.getProductsList(query: {
            "page": 1,
            "limit": 7,
            "searchQuery": "",
          }).onError((error, stackTrace) {
            emit(ManageFailure(errorMessage: error.toString()));
            emit(const ManageLoading());
          }).then((value) async {
            if (value != null) {
              GetProductListModel getProductListModel = GetProductListModel.fromJson(value);
              if (getProductListModel.status) {
                mainVariables.manageVariables.totalPages = getProductListModel.totalPages == 0 ? 1 : getProductListModel.totalPages;
                mainVariables.manageVariables.currentPage = 1;
                if (getProductListModel.products.isEmpty) {
                  mainVariables.manageVariables.addProduct.tableData.clear();
                  mainVariables.manageVariables.addProduct.tableData = [];
                } else {
                  mainVariables.manageVariables.addProduct.tableData.clear();
                  for (int i = 0; i < getProductListModel.products.length; i++) {
                    ProductChangeModel productChangeModel = ProductChangeModel.fromJson(getProductListModel.products[i].toJson());
                    mainVariables.manageVariables.addProduct.tableData.add(productChangeModel.toJson().entries.map((entry) => (entry.value.toString())).toList());
                  }
                }
                emit(const ManageDummy());
                emit(const ManageLoaded());
              } else {
                mainVariables.manageVariables.addProduct.tableData.clear();
                mainVariables.manageVariables.addProduct.tableData = [];
                emit(ManageFailure(errorMessage: value["message"]));
                emit(const ManageLoading());
              }
            } else {
              emit(const ManageFailure(errorMessage: "Something went wrong"));
              emit(const ManageLoaded());
            }
          });
        }
      case 2:
        {
          await mainVariables.repoImpl.getBrandTypeList(query: {
            "page": 1,
            "limit": 7,
            "search": "",
          }).onError((error, stackTrace) {
            emit(ManageFailure(errorMessage: error.toString()));
            emit(const ManageLoading());
          }).then((value) async {
            if (value != null) {
              GetBrandTypeModel getBrandTypeModel = GetBrandTypeModel.fromJson(value);
              if (getBrandTypeModel.status) {
                mainVariables.manageVariables.totalPages = getBrandTypeModel.totalPages == 0 ? 1 : getBrandTypeModel.totalPages;
                mainVariables.manageVariables.currentPage = 1;
                if (getBrandTypeModel.brandType.isEmpty) {
                  mainVariables.manageVariables.addBrand.tableData.clear();
                  mainVariables.manageVariables.addBrand.tableData = [];
                } else {
                  mainVariables.manageVariables.addBrand.tableData.clear();
                  for (int i = 0; i < getBrandTypeModel.brandType.length; i++) {
                    BrandChangeModel brandChangeModel = BrandChangeModel.fromJson(getBrandTypeModel.brandType[i].toJson());
                    mainVariables.manageVariables.addBrand.tableData.add(brandChangeModel.toJson().entries.map((entry) => (entry.value.toString())).toList());
                  }
                }
                emit(const ManageDummy());
                emit(const ManageLoaded());
              } else {
                mainVariables.manageVariables.addBrand.tableData.clear();
                mainVariables.manageVariables.addBrand.tableData = [];
                emit(ManageFailure(errorMessage: value["message"]));
                emit(const ManageLoading());
              }
            } else {
              emit(const ManageFailure(errorMessage: "Something went wrong"));
              emit(const ManageLoaded());
            }
          });
        }
      case 3:
        {
          await mainVariables.repoImpl.getCategoriesList(query: {
            "page": 1,
            "limit": 7,
            "search": "",
          }).onError((error, stackTrace) {
            emit(ManageFailure(errorMessage: error.toString()));
            emit(const ManageLoading());
          }).then((value) async {
            if (value != null) {
              GetCategoryModel getCategoryModel = GetCategoryModel.fromJson(value);
              if (getCategoryModel.status) {
                mainVariables.manageVariables.totalPages = getCategoryModel.totalPages == 0 ? 1 : getCategoryModel.totalPages;
                mainVariables.manageVariables.currentPage = 1;
                if (getCategoryModel.categories.isEmpty) {
                  mainVariables.manageVariables.addCategory.tableData.clear();
                  mainVariables.manageVariables.addCategory.tableData = [];
                } else {
                  mainVariables.manageVariables.addCategory.tableData.clear();
                  for (int i = 0; i < getCategoryModel.categories.length; i++) {
                    CategoryChangeModel categoryModel = CategoryChangeModel.fromJson(getCategoryModel.categories[i].toJson());
                    mainVariables.manageVariables.addCategory.tableData.add(categoryModel.toJson().entries.map((entry) => (entry.value.toString())).toList());
                  }
                }
                emit(const ManageDummy());
                emit(const ManageLoaded());
              } else {
                mainVariables.manageVariables.addCategory.tableData.clear();
                mainVariables.manageVariables.addCategory.tableData = [];
                emit(ManageFailure(errorMessage: value["message"]));
                emit(const ManageLoading());
              }
            } else {
              emit(const ManageFailure(errorMessage: "Something went wrong"));
              emit(const ManageLoaded());
            }
          });
        }
      case 4:
        {
          await mainVariables.repoImpl.getCrewList(query: {
            "page": 1,
            "limit": 7,
            "query": "",
          }).onError((error, stackTrace) {
            emit(ManageFailure(errorMessage: error.toString()));
            emit(const ManageLoading());
          }).then((value) async {
            if (value != null) {
              GetCrewListModel getCrewListModel = GetCrewListModel.fromJson(value);
              if (getCrewListModel.status) {
                mainVariables.manageVariables.totalPages = getCrewListModel.totalPages == 0 ? 1 : getCrewListModel.totalPages;
                mainVariables.manageVariables.currentPage = 1;
                if (getCrewListModel.users.isEmpty) {
                  mainVariables.manageVariables.addCrew.tableData.clear();
                  mainVariables.manageVariables.addCrew.tableData = [];
                } else {
                  mainVariables.manageVariables.addCrew.tableData.clear();
                  for (int i = 0; i < getCrewListModel.users.length; i++) {
                    CrewChangeModel crewChangeModel = CrewChangeModel.fromJson(getCrewListModel.users[i].toJson());
                    mainVariables.manageVariables.addCrew.tableData.add(crewChangeModel.toJson().entries.map((entry) => (entry.value.toString())).toList());
                  }
                }
                emit(const ManageDummy());
                emit(const ManageLoaded());
              } else {
                mainVariables.manageVariables.addCrew.tableData.clear();
                mainVariables.manageVariables.addCrew.tableData = [];
                emit(ManageFailure(errorMessage: value["message"]));
                emit(const ManageLoading());
              }
            } else {
              emit(const ManageFailure(errorMessage: "Something went wrong"));
              emit(const ManageLoaded());
            }
          });
        }
      case 5:
        {
          await mainVariables.repoImpl.getHandlerList(query: {
            "page": 1,
            "limit": 7,
            "search": "",
          }).onError((error, stackTrace) {
            emit(ManageFailure(errorMessage: error.toString()));
            emit(const ManageLoading());
          }).then((value) async {
            if (value != null) {
              GetHandlersListModel getHandlersListModel = GetHandlersListModel.fromJson(value);
              if (getHandlersListModel.status) {
                mainVariables.manageVariables.totalPages = getHandlersListModel.totalPages == 0 ? 1 : getHandlersListModel.totalPages;
                mainVariables.manageVariables.currentPage = 1;
                if (getHandlersListModel.handlers.isEmpty) {
                  mainVariables.manageVariables.addHandler.tableData.clear();
                  mainVariables.manageVariables.addHandler.tableData = [];
                } else {
                  mainVariables.manageVariables.addHandler.tableData.clear();
                  for (int i = 0; i < getHandlersListModel.handlers.length; i++) {
                    HandlerChangeModel handlerModel = HandlerChangeModel.fromJson(getHandlersListModel.handlers[i].toJson());
                    mainVariables.manageVariables.addHandler.tableData.add(handlerModel.toJson().entries.map((entry) => (entry.value.toString())).toList());
                  }
                }
                emit(const ManageDummy());
                emit(const ManageLoaded());
              } else {
                mainVariables.manageVariables.addCategory.tableData.clear();
                mainVariables.manageVariables.addCategory.tableData = [];
                emit(ManageFailure(errorMessage: value["message"]));
                emit(const ManageLoading());
              }
            } else {
              emit(const ManageFailure(errorMessage: "Something went wrong"));
              emit(const ManageLoaded());
            }
          });
        }
      case 6:
        {
          await mainVariables.repoImpl.getWarehouseOrAircraftList(query: {
            "page": 1,
            "type": "warehouse",
            "limit": 7,
            "search": "",
          }).onError((error, stackTrace) {
            emit(ManageFailure(errorMessage: error.toString()));
            emit(const ManageLoading());
          }).then((value) async {
            if (value != null) {
              GetWareHouseOrAirCraftModel getWareHouseOrAirCraftModel = GetWareHouseOrAirCraftModel.fromJson(value);
              if (getWareHouseOrAirCraftModel.status) {
                mainVariables.manageVariables.totalPages = getWareHouseOrAirCraftModel.totalPages == 0 ? 1 : getWareHouseOrAirCraftModel.totalPages;
                mainVariables.manageVariables.currentPage = 1;
                if (getWareHouseOrAirCraftModel.locations.isEmpty) {
                  mainVariables.manageVariables.addWareHouse.tableData.clear();
                  mainVariables.manageVariables.addWareHouse.tableData = [];
                } else {
                  mainVariables.manageVariables.addWareHouse.tableData.clear();
                  for (int i = 0; i < getWareHouseOrAirCraftModel.locations.length; i++) {
                    WarehouseOrAirCraftModel warehouseOrAirCraftModel = WarehouseOrAirCraftModel.fromJson(getWareHouseOrAirCraftModel.locations[i].toJson());
                    mainVariables.manageVariables.addWareHouse.tableData.add(warehouseOrAirCraftModel.toJson().entries.map((entry) => (entry.value.toString())).toList());
                  }
                }
                emit(const ManageDummy());
                emit(const ManageLoaded());
              } else {
                mainVariables.manageVariables.addWareHouse.tableData.clear();
                mainVariables.manageVariables.addWareHouse.tableData = [];
                emit(ManageFailure(errorMessage: getWareHouseOrAirCraftModel.message));
                emit(const ManageLoading());
              }
            } else {
              emit(const ManageFailure(errorMessage: "Something went wrong"));
              emit(const ManageLoaded());
            }
          });
        }
      case 7:
        {
          await mainVariables.repoImpl.getWarehouseOrAircraftList(query: {
            "page": 1,
            "type": "aircraft",
            "limit": 7,
            "search": "",
          }).onError((error, stackTrace) {
            emit(ManageFailure(errorMessage: error.toString()));
            emit(const ManageLoading());
          }).then((value) async {
            if (value != null) {
              GetWareHouseOrAirCraftModel getWareHouseOrAirCraftModel = GetWareHouseOrAirCraftModel.fromJson(value);
              if (getWareHouseOrAirCraftModel.status) {
                mainVariables.manageVariables.totalPages = getWareHouseOrAirCraftModel.totalPages == 0 ? 1 : getWareHouseOrAirCraftModel.totalPages;
                mainVariables.manageVariables.currentPage = 1;
                if (getWareHouseOrAirCraftModel.locations.isEmpty) {
                  mainVariables.manageVariables.addAirCraft.tableData.clear();
                  mainVariables.manageVariables.addAirCraft.tableData = [];
                } else {
                  mainVariables.manageVariables.addAirCraft.tableData.clear();
                  for (int i = 0; i < getWareHouseOrAirCraftModel.locations.length; i++) {
                    WarehouseOrAirCraftModel warehouseOrAirCraftModel = WarehouseOrAirCraftModel.fromJson(getWareHouseOrAirCraftModel.locations[i].toJson());
                    mainVariables.manageVariables.addAirCraft.tableData.add(warehouseOrAirCraftModel.toJson().entries.map((entry) => (entry.value.toString())).toList());
                  }
                }
                emit(const ManageDummy());
                emit(const ManageLoaded());
              } else {
                mainVariables.manageVariables.addAirCraft.tableData.clear();
                mainVariables.manageVariables.addAirCraft.tableData = [];
                emit(ManageFailure(errorMessage: getWareHouseOrAirCraftModel.message));
                emit(const ManageLoading());
              }
            } else {
              emit(const ManageFailure(errorMessage: "Something went wrong"));
              emit(const ManageLoaded());
            }
          });
        }
      case 8:
        {
          await mainVariables.repoImpl.getSectorList(query: {
            "page": 1,
            "search": "",
            "limit": 7,
          }).onError((error, stackTrace) {
            emit(ManageFailure(errorMessage: error.toString()));
            emit(const ManageLoading());
          }).then((value) async {
            if (value != null) {
              GetSectorListModel getSectorListModel = GetSectorListModel.fromJson(value);
              if (getSectorListModel.status) {
                mainVariables.manageVariables.totalPages = getSectorListModel.totalPages == 0 ? 1 : getSectorListModel.totalPages;
                mainVariables.manageVariables.currentPage = 1;
                if (getSectorListModel.sectors.isEmpty) {
                  mainVariables.manageVariables.addSector.tableData.clear();
                  mainVariables.manageVariables.addSector.tableData = [];
                } else {
                  mainVariables.manageVariables.addSector.tableData.clear();
                  for (int i = 0; i < getSectorListModel.sectors.length; i++) {
                    SectorChangeModel sectorChangeModel = SectorChangeModel.fromJson(getSectorListModel.sectors[i].toJson());
                    mainVariables.manageVariables.addSector.tableData.add(sectorChangeModel.toJson().entries.map((entry) => (entry.value.toString())).toList());
                  }
                }
                emit(const ManageDummy());
                emit(const ManageLoaded());
              } else {
                mainVariables.manageVariables.addSector.tableData.clear();
                mainVariables.manageVariables.addSector.tableData = [];
                emit(ManageFailure(errorMessage: getSectorListModel.message));
                emit(const ManageLoading());
              }
            } else {
              emit(const ManageFailure(errorMessage: "Something went wrong"));
              emit(const ManageLoaded());
            }
          });
        }
      default:
        {}
    }
    emit(const ManageDummy());
    emit(const ManageLoaded());
  }

  Future<void> managePageFilterFunction(ManagePageFilterEvent event, Emitter<ManageState> emit) async {
    switch (mainVariables.manageVariables.manageSelectedIndex) {
      case 1:
        {
          await mainVariables.repoImpl.getProductsList(query: {
            "page": mainVariables.manageVariables.currentPage,
            "limit": 7,
            "searchQuery": mainVariables.manageVariables.addProduct.searchBar.text,
          }).onError((error, stackTrace) {
            emit(ManageFailure(errorMessage: error.toString()));
            emit(const ManageLoading());
          }).then((value) async {
            if (value != null) {
              GetProductListModel getProductListModel = GetProductListModel.fromJson(value);
              if (getProductListModel.status) {
                mainVariables.manageVariables.totalPages = getProductListModel.totalPages == 0 ? 1 : getProductListModel.totalPages;

                if (getProductListModel.products.isEmpty) {
                  mainVariables.manageVariables.addProduct.tableData.clear();
                  mainVariables.manageVariables.addProduct.tableData = [];
                } else {
                  mainVariables.manageVariables.addProduct.tableData.clear();
                  for (int i = 0; i < getProductListModel.products.length; i++) {
                    ProductChangeModel productChangeModel = ProductChangeModel.fromJson(getProductListModel.products[i].toJson());
                    mainVariables.manageVariables.addProduct.tableData.add(productChangeModel.toJson().entries.map((entry) => (entry.value.toString())).toList());
                  }
                }
                emit(const ManageDummy());
                emit(const ManageLoaded());
              } else {
                mainVariables.manageVariables.addProduct.tableData.clear();
                mainVariables.manageVariables.addProduct.tableData = [];
                emit(ManageFailure(errorMessage: value["message"]));
                emit(const ManageLoading());
              }
            } else {
              emit(const ManageFailure(errorMessage: "Something went wrong"));
              emit(const ManageLoaded());
            }
          });
        }
      case 2:
        {
          await mainVariables.repoImpl.getBrandTypeList(query: {
            "page": mainVariables.manageVariables.currentPage,
            "limit": 7,
            "search": mainVariables.manageVariables.addBrand.searchBar.text,
          }).onError((error, stackTrace) {
            emit(ManageFailure(errorMessage: error.toString()));
            emit(const ManageLoading());
          }).then((value) async {
            if (value != null) {
              GetBrandTypeModel getBrandTypeModel = GetBrandTypeModel.fromJson(value);
              if (getBrandTypeModel.status) {
                mainVariables.manageVariables.totalPages = getBrandTypeModel.totalPages == 0 ? 1 : getBrandTypeModel.totalPages;
                if (getBrandTypeModel.brandType.isEmpty) {
                  mainVariables.manageVariables.addBrand.tableData.clear();
                  mainVariables.manageVariables.addBrand.tableData = [];
                } else {
                  mainVariables.manageVariables.addBrand.tableData.clear();
                  for (int i = 0; i < getBrandTypeModel.brandType.length; i++) {
                    BrandChangeModel brandChangeModel = BrandChangeModel.fromJson(getBrandTypeModel.brandType[i].toJson());
                    mainVariables.manageVariables.addBrand.tableData.add(brandChangeModel.toJson().entries.map((entry) => (entry.value.toString())).toList());
                  }
                }
                emit(const ManageDummy());
                emit(const ManageLoaded());
              } else {
                mainVariables.manageVariables.addBrand.tableData.clear();
                mainVariables.manageVariables.addBrand.tableData = [];
                emit(ManageFailure(errorMessage: value["message"]));
                emit(const ManageLoading());
              }
            } else {
              emit(const ManageFailure(errorMessage: "Something went wrong"));
              emit(const ManageLoaded());
            }
          });
        }
      case 3:
        {
          await mainVariables.repoImpl.getCategoriesList(query: {
            "page": mainVariables.manageVariables.currentPage,
            "limit": 7,
            "search": mainVariables.manageVariables.addCategory.searchBar.text,
          }).onError((error, stackTrace) {
            emit(ManageFailure(errorMessage: error.toString()));
            emit(const ManageLoading());
          }).then((value) async {
            if (value != null) {
              GetCategoryModel getCategoryModel = GetCategoryModel.fromJson(value);
              if (getCategoryModel.status) {
                mainVariables.manageVariables.totalPages = getCategoryModel.totalPages == 0 ? 1 : getCategoryModel.totalPages;
                if (getCategoryModel.categories.isEmpty) {
                  mainVariables.manageVariables.addCategory.tableData.clear();
                  mainVariables.manageVariables.addCategory.tableData = [];
                } else {
                  mainVariables.manageVariables.addCategory.tableData.clear();
                  for (int i = 0; i < getCategoryModel.categories.length; i++) {
                    CategoryChangeModel categoryModel = CategoryChangeModel.fromJson(getCategoryModel.categories[i].toJson());
                    mainVariables.manageVariables.addCategory.tableData.add(categoryModel.toJson().entries.map((entry) => (entry.value.toString())).toList());
                  }
                }
                emit(const ManageDummy());
                emit(const ManageLoaded());
              } else {
                mainVariables.manageVariables.addCategory.tableData.clear();
                mainVariables.manageVariables.addCategory.tableData = [];
                emit(ManageFailure(errorMessage: value["message"]));
                emit(const ManageLoading());
              }
            } else {
              emit(const ManageFailure(errorMessage: "Something went wrong"));
              emit(const ManageLoaded());
            }
          });
        }
      case 4:
        {
          await mainVariables.repoImpl.getCrewList(query: {
            "page": mainVariables.manageVariables.currentPage,
            "limit": 7,
            "query": mainVariables.manageVariables.addCrew.searchBar.text,
          }).onError((error, stackTrace) {
            emit(ManageFailure(errorMessage: error.toString()));
            emit(const ManageLoading());
          }).then((value) async {
            if (value != null) {
              GetCrewListModel getCrewListModel = GetCrewListModel.fromJson(value);
              if (getCrewListModel.status) {
                mainVariables.manageVariables.totalPages = getCrewListModel.totalPages == 0 ? 1 : getCrewListModel.totalPages;
                if (getCrewListModel.users.isEmpty) {
                  mainVariables.manageVariables.addCrew.tableData.clear();
                  mainVariables.manageVariables.addCrew.tableData = [];
                } else {
                  mainVariables.manageVariables.addCrew.tableData.clear();
                  for (int i = 0; i < getCrewListModel.users.length; i++) {
                    CrewChangeModel crewChangeModel = CrewChangeModel.fromJson(getCrewListModel.users[i].toJson());
                    mainVariables.manageVariables.addCrew.tableData.add(crewChangeModel.toJson().entries.map((entry) => (entry.value.toString())).toList());
                  }
                }
                emit(const ManageDummy());
                emit(const ManageLoaded());
              } else {
                mainVariables.manageVariables.addCrew.tableData.clear();
                mainVariables.manageVariables.addCrew.tableData = [];
                emit(ManageFailure(errorMessage: value["message"]));
                emit(const ManageLoading());
              }
            } else {
              emit(const ManageFailure(errorMessage: "Something went wrong"));
              emit(const ManageLoaded());
            }
          });
        }
      case 5:
        {
          await mainVariables.repoImpl.getHandlerList(query: {
            "page": mainVariables.manageVariables.currentPage,
            "limit": 7,
            "search": mainVariables.manageVariables.addHandler.searchBar.text,
          }).onError((error, stackTrace) {
            emit(ManageFailure(errorMessage: error.toString()));
            emit(const ManageLoading());
          }).then((value) async {
            if (value != null) {
              GetHandlersListModel getHandlersListModel = GetHandlersListModel.fromJson(value);
              if (getHandlersListModel.status) {
                mainVariables.manageVariables.totalPages = getHandlersListModel.totalPages == 0 ? 1 : getHandlersListModel.totalPages;
                if (getHandlersListModel.handlers.isEmpty) {
                  mainVariables.manageVariables.addHandler.tableData.clear();
                  mainVariables.manageVariables.addHandler.tableData = [];
                } else {
                  mainVariables.manageVariables.addHandler.tableData.clear();
                  for (int i = 0; i < getHandlersListModel.handlers.length; i++) {
                    HandlerChangeModel handlerModel = HandlerChangeModel.fromJson(getHandlersListModel.handlers[i].toJson());
                    mainVariables.manageVariables.addHandler.tableData.add(handlerModel.toJson().entries.map((entry) => (entry.value.toString())).toList());
                  }
                }
                emit(const ManageDummy());
                emit(const ManageLoaded());
              } else {
                mainVariables.manageVariables.addHandler.tableData.clear();
                mainVariables.manageVariables.addHandler.tableData = [];
                emit(ManageFailure(errorMessage: value["message"]));
                emit(const ManageLoading());
              }
            } else {
              emit(const ManageFailure(errorMessage: "Something went wrong"));
              emit(const ManageLoaded());
            }
          });
        }
      case 6:
        {
          await mainVariables.repoImpl.getWarehouseOrAircraftList(query: {
            "page": mainVariables.manageVariables.currentPage,
            "type": "warehouse",
            "limit": 7,
            "search": mainVariables.manageVariables.addWareHouse.searchBar.text,
          }).onError((error, stackTrace) {
            emit(ManageFailure(errorMessage: error.toString()));
            emit(const ManageLoading());
          }).then((value) async {
            if (value != null) {
              GetWareHouseOrAirCraftModel getWareHouseOrAirCraftModel = GetWareHouseOrAirCraftModel.fromJson(value);
              if (getWareHouseOrAirCraftModel.status) {
                mainVariables.manageVariables.totalPages = getWareHouseOrAirCraftModel.totalPages == 0 ? 1 : getWareHouseOrAirCraftModel.totalPages;
                if (getWareHouseOrAirCraftModel.locations.isEmpty) {
                  mainVariables.manageVariables.addWareHouse.tableData.clear();
                  mainVariables.manageVariables.addWareHouse.tableData = [];
                } else {
                  mainVariables.manageVariables.addWareHouse.tableData.clear();
                  for (int i = 0; i < getWareHouseOrAirCraftModel.locations.length; i++) {
                    WarehouseOrAirCraftModel warehouseOrAirCraftModel = WarehouseOrAirCraftModel.fromJson(getWareHouseOrAirCraftModel.locations[i].toJson());
                    mainVariables.manageVariables.addWareHouse.tableData.add(warehouseOrAirCraftModel.toJson().entries.map((entry) => (entry.value.toString())).toList());
                  }
                }
                emit(const ManageDummy());
                emit(const ManageLoaded());
              } else {
                mainVariables.manageVariables.addWareHouse.tableData.clear();
                mainVariables.manageVariables.addWareHouse.tableData = [];
                emit(ManageFailure(errorMessage: getWareHouseOrAirCraftModel.message));
                emit(const ManageLoading());
              }
            } else {
              emit(const ManageFailure(errorMessage: "Something went wrong"));
              emit(const ManageLoaded());
            }
          });
        }
      case 7:
        {
          await mainVariables.repoImpl.getWarehouseOrAircraftList(query: {
            "page": mainVariables.manageVariables.currentPage,
            "type": "aircraft",
            "limit": 7,
            "search": mainVariables.manageVariables.addAirCraft.searchBar.text,
          }).onError((error, stackTrace) {
            emit(ManageFailure(errorMessage: error.toString()));
            emit(const ManageLoading());
          }).then((value) async {
            if (value != null) {
              GetWareHouseOrAirCraftModel getWareHouseOrAirCraftModel = GetWareHouseOrAirCraftModel.fromJson(value);
              if (getWareHouseOrAirCraftModel.status) {
                mainVariables.manageVariables.totalPages = getWareHouseOrAirCraftModel.totalPages == 0 ? 1 : getWareHouseOrAirCraftModel.totalPages;
                if (getWareHouseOrAirCraftModel.locations.isEmpty) {
                  mainVariables.manageVariables.addAirCraft.tableData.clear();
                  mainVariables.manageVariables.addAirCraft.tableData = [];
                } else {
                  mainVariables.manageVariables.addAirCraft.tableData.clear();
                  for (int i = 0; i < getWareHouseOrAirCraftModel.locations.length; i++) {
                    WarehouseOrAirCraftModel warehouseOrAirCraftModel = WarehouseOrAirCraftModel.fromJson(getWareHouseOrAirCraftModel.locations[i].toJson());
                    mainVariables.manageVariables.addAirCraft.tableData.add(warehouseOrAirCraftModel.toJson().entries.map((entry) => (entry.value.toString())).toList());
                  }
                }
                emit(const ManageDummy());
                emit(const ManageLoaded());
              } else {
                mainVariables.manageVariables.addAirCraft.tableData.clear();
                mainVariables.manageVariables.addAirCraft.tableData = [];
                emit(ManageFailure(errorMessage: getWareHouseOrAirCraftModel.message));
                emit(const ManageLoading());
              }
            } else {
              emit(const ManageFailure(errorMessage: "Something went wrong"));
              emit(const ManageLoaded());
            }
          });
        }
      case 8:
        {
          await mainVariables.repoImpl.getSectorList(query: {
            "page": mainVariables.manageVariables.currentPage,
            "limit": 7,
            "search": mainVariables.manageVariables.addSector.searchBar.text,
          }).onError((error, stackTrace) {
            emit(ManageFailure(errorMessage: error.toString()));
            emit(const ManageLoading());
          }).then((value) async {
            if (value != null) {
              GetSectorListModel getSectorListModel = GetSectorListModel.fromJson(value);
              if (getSectorListModel.status) {
                mainVariables.manageVariables.totalPages = getSectorListModel.totalPages == 0 ? 1 : getSectorListModel.totalPages;
                if (getSectorListModel.sectors.isEmpty) {
                  mainVariables.manageVariables.addSector.tableData.clear();
                  mainVariables.manageVariables.addSector.tableData = [];
                } else {
                  mainVariables.manageVariables.addSector.tableData.clear();
                  for (int i = 0; i < getSectorListModel.sectors.length; i++) {
                    SectorChangeModel sectorChangeModel = SectorChangeModel.fromJson(getSectorListModel.sectors[i].toJson());
                    mainVariables.manageVariables.addSector.tableData.add(sectorChangeModel.toJson().entries.map((entry) => (entry.value.toString())).toList());
                  }
                }
                emit(const ManageDummy());
                emit(const ManageLoaded());
              } else {
                mainVariables.manageVariables.addSector.tableData.clear();
                mainVariables.manageVariables.addSector.tableData = [];
                emit(ManageFailure(errorMessage: getSectorListModel.message));
                emit(const ManageLoading());
              }
            } else {
              emit(const ManageFailure(errorMessage: "Something went wrong"));
              emit(const ManageLoaded());
            }
          });
        }
      default:
        {}
    }
    emit(const ManageDummy());
    emit(const ManageLoaded());
  }

  Future<void> calenderEnablingFunction(ManageCalenderEnablingEvent event, Emitter<ManageState> emit) async {
    mainVariables.manageVariables.addInventory.filterCalenderEnabled = !mainVariables.manageVariables.addInventory.filterCalenderEnabled;
    emit(const ManageDummy());
    emit(const ManageLoaded());
  }

  Future<void> inventoryBulkUploadFunction(InventoryBulkUploadEvent event, Emitter<ManageState> emit) async {
    event.setState(() {
      mainVariables.manageVariables.csvUploadFileLoader = true;
    });
    await mainVariables.repoImpl.fileCsvUpload(files: {"csvFile": mainVariables.manageVariables.selectedFile!}).onError((error, stackTrace) {
      emit(ManageFailure(errorMessage: error.toString()));
      emit(const ManageLoaded());
    }).then((value) async {
      if (value != null) {
        if (value["status"]) {
          event.setState(() {
            mainVariables.manageVariables.csvUploadFileLoader = false;
          });
          emit(ManageSuccess(message: value["message"]));
          emit(const ManageLoaded());
        } else {
          event.setState(() {
            mainVariables.manageVariables.csvUploadFileLoader = false;
          });
          emit(ManageFailure(errorMessage: value["message"]));
          emit(const ManageLoaded());
        }
      } else {
        event.setState(() {
          mainVariables.manageVariables.csvUploadFileLoader = false;
        });
        emit(const ManageFailure(errorMessage: "Something went wrong"));
        emit(const ManageLoaded());
      }
    });
  }

  FutureOr<void> csvFileSelection(CsvFileSelectionEvent event, Emitter<ManageState> emit) async {
    event.setState(() {
      mainVariables.manageVariables.csvUploadFileLoader = true;
    });
    String path = await mainFunctions.pickFiles(isPdf: false, context: event.context);
    if (path.isNotEmpty) {
      mainVariables.manageVariables.selectedFile = File(path);
      List<String> pathList = path.split("/");
      event.setState(() {
        if (pathList.isNotEmpty) {
          mainVariables.manageVariables.selectedFileName = pathList.last;
        }
        mainVariables.manageVariables.csvUploadFileLoader = false;
      });
    } else {
      event.setState(() {
        mainVariables.manageVariables.csvUploadFileLoader = false;
      });
    }
  }

  Future<void> getProductDetails(GetProductDetailsEvent event, Emitter<ManageState> emit) async {
    await mainVariables.repoImpl.getProduct(query: {"id": mainVariables.manageVariables.addInventory.productId}).onError((error, stackTrace) {
      emit(ManageFailure(errorMessage: error.toString()));
      emit(const ManageLoaded());
    }).then((value) async {
      GetSingleProductDetails getSingleProductDetails = GetSingleProductDetails.fromJson(value);
      if (getSingleProductDetails.status) {
        mainVariables.manageVariables.addInventory.categoryController.text = getSingleProductDetails.product.category.name;
        mainVariables.manageVariables.addInventory.categoryId = getSingleProductDetails.product.category.id;
        emit(const ManageDummy());
        emit(const ManageLoaded());
      } else {
        emit(const ManageFailure(errorMessage: "Something went wrong"));
        emit(const ManageLoaded());
      }
    });
  }

  FutureOr<void> addBrandTypeFunction(AddBrandTypeEvent event, Emitter<ManageState> emit) async {
    await mainVariables.repoImpl.addBrandType(query: {
      "name": mainVariables.manageVariables.addBrand.brandController.text,
    }).onError((error, stackTrace) {
      emit(ManageFailure(errorMessage: error.toString()));
      emit(const ManageLoaded());
    }).then((value) async {
      if (value != null) {
        AddBrandTypeModel addBrandTypeModel = AddBrandTypeModel.fromJson(value);
        if (addBrandTypeModel.status) {
          mainVariables.manageVariables.addBrand.brandController.clear();
          mainVariables.manageVariables.addBrand.tableData.insert(0, [
            addBrandTypeModel.brandType.name,
            "-",
            addBrandTypeModel.brandType.id,
          ]);
          emit(ManageSuccess2(message: addBrandTypeModel.message));
          emit(const ManageLoaded());
        } else {
          emit(ManageFailure(errorMessage: value["message"]));
          emit(const ManageLoaded());
        }
      } else {
        emit(const ManageFailure(errorMessage: "Something went wrong"));
        emit(const ManageLoaded());
      }
    });
  }

  FutureOr<void> deleteBrandTypeFunction(DeleteBrandTypeEvent event, Emitter<ManageState> emit) async {
    await mainVariables.repoImpl.deleteBrandType(query: {
      "id": mainVariables.manageVariables.addBrand.tableData[event.index][2],
    }).onError((error, stackTrace) {
      emit(ManageFailure(errorMessage: error.toString()));
      emit(const ManageLoaded());
    }).then((value) async {
      if (value != null) {
        if (value["status"]) {
          mainVariables.manageVariables.addBrand.tableData.removeAt(event.index);
          emit(ManageSuccess2(message: value["message"]));
          emit(const ManageLoaded());
        } else {
          emit(ManageFailure(errorMessage: value["message"]));
          emit(const ManageLoaded());
        }
      } else {
        emit(const ManageFailure(errorMessage: "Something went wrong"));
        emit(const ManageLoaded());
      }
    });
  }

  FutureOr<void> editBrandTypeFunction(EditBrandTypeEvent event, Emitter<ManageState> emit) async {
    await mainVariables.repoImpl.editBrandType(query: {
      "id": mainVariables.manageVariables.addBrand.tableData[event.index][2],
      "name": mainVariables.manageVariables.addBrand.editBrandController.text,
    }).onError((error, stackTrace) {
      emit(ManageFailure(errorMessage: error.toString()));
      emit(const ManageLoaded());
    }).then((value) async {
      if (value != null) {
        AddBrandTypeModel addBrandTypeModel = AddBrandTypeModel.fromJson(value);
        if (addBrandTypeModel.status) {
          mainVariables.manageVariables.addBrand.editBrandController.clear();
          mainVariables.manageVariables.addBrand.tableData[event.index][0] = addBrandTypeModel.brandType.name;
          emit(ManageSuccess2(message: addBrandTypeModel.message));
          emit(const ManageLoaded());
        } else {
          emit(ManageFailure(errorMessage: value["message"]));
          emit(const ManageLoaded());
        }
      } else {
        emit(const ManageFailure(errorMessage: "Something went wrong"));
        emit(const ManageLoaded());
      }
    });
  }

  FutureOr<void> addCategoryFunction(AddCategoryEvent event, Emitter<ManageState> emit) async {
    await mainVariables.repoImpl.addCategory(query: {
      "name": mainVariables.manageVariables.addCategory.categoryController.text,
    }).onError((error, stackTrace) {
      emit(ManageFailure(errorMessage: error.toString()));
      emit(const ManageLoaded());
    }).then((value) async {
      if (value != null) {
        AddCategoryModel addCategoryModel = AddCategoryModel.fromJson(value);
        if (addCategoryModel.status) {
          mainVariables.manageVariables.addCategory.categoryController.clear();
          mainVariables.manageVariables.addCategory.tableData.insert(0, [
            addCategoryModel.category.name,
            "-",
            addCategoryModel.category.id,
          ]);
          var categoryBox = await Hive.openBox<CategoryResponse>('category');
          await categoryBox.clear();
          mainVariables.stockMovementVariables.senderInfo.categoryDropDownList.clear();
          await mainVariables.repoImpl.getCategory().onError((error, stackTrace) {}).then((value) async {
            if (value != null) {
              GetCategoryResponseModel getCategoryType = GetCategoryResponseModel.fromJson(value);
              final box = Hive.box<CategoryResponse>('category');
              for (int i = 0; i < getCategoryType.categoryResponse.length; i++) {
                await box.put(getCategoryType.categoryResponse[i].id, getCategoryType.categoryResponse[i]);
                mainVariables.stockMovementVariables.senderInfo.categoryDropDownList.add(
                  DropDownValueModel(
                    name: getCategoryType.categoryResponse[i].name.toLowerCase().capitalizeFirst!,
                    value: getCategoryType.categoryResponse[i].id,
                  ),
                );
              }
            }
          });
          emit(ManageSuccess2(message: addCategoryModel.message));
          emit(const ManageLoaded());
        } else {
          emit(ManageFailure(errorMessage: value["message"]));
          emit(const ManageLoaded());
        }
      } else {
        emit(const ManageFailure(errorMessage: "Something went wrong"));
        emit(const ManageLoaded());
      }
    });
  }

  FutureOr<void> deleteCategoryFunction(DeleteCategoryEvent event, Emitter<ManageState> emit) async {
    await mainVariables.repoImpl.deleteCategory(query: {
      "id": mainVariables.manageVariables.addCategory.tableData[event.index][2],
    }).onError((error, stackTrace) {
      emit(ManageFailure(errorMessage: error.toString()));
      emit(const ManageLoaded());
    }).then((value) async {
      if (value != null) {
        if (value["status"]) {
          mainVariables.manageVariables.addCategory.tableData.removeAt(event.index);
          var categoryBox = await Hive.openBox<CategoryResponse>('category');
          await categoryBox.clear();
          mainVariables.stockMovementVariables.senderInfo.categoryDropDownList.clear();
          await mainVariables.repoImpl.getCategory().onError((error, stackTrace) {}).then((value) async {
            if (value != null) {
              GetCategoryResponseModel getCategoryType = GetCategoryResponseModel.fromJson(value);
              final box = Hive.box<CategoryResponse>('category');
              for (int i = 0; i < getCategoryType.categoryResponse.length; i++) {
                await box.put(getCategoryType.categoryResponse[i].id, getCategoryType.categoryResponse[i]);
                mainVariables.stockMovementVariables.senderInfo.categoryDropDownList.add(
                  DropDownValueModel(
                    name: getCategoryType.categoryResponse[i].name.toLowerCase().capitalizeFirst!,
                    value: getCategoryType.categoryResponse[i].id,
                  ),
                );
              }
            }
          });
          emit(ManageSuccess2(message: value["message"]));
          emit(const ManageLoaded());
        } else {
          emit(ManageFailure(errorMessage: value["message"]));
          emit(const ManageLoaded());
        }
      } else {
        emit(const ManageFailure(errorMessage: "Something went wrong"));
        emit(const ManageLoaded());
      }
    });
  }

  FutureOr<void> editCategoryFunction(EditCategoryEvent event, Emitter<ManageState> emit) async {
    await mainVariables.repoImpl.editCategory(query: {
      "id": mainVariables.manageVariables.addCategory.tableData[event.index][2],
      "name": mainVariables.manageVariables.addCategory.editCategoryController.text,
    }).onError((error, stackTrace) {
      emit(ManageFailure(errorMessage: error.toString()));
      emit(const ManageLoaded());
    }).then((value) async {
      if (value != null) {
        AddCategoryModel categoryModel = AddCategoryModel.fromJson(value);
        if (categoryModel.status) {
          mainVariables.manageVariables.addCategory.editCategoryController.clear();
          mainVariables.manageVariables.addCategory.tableData[event.index][0] = categoryModel.category.name;
          emit(ManageSuccess2(message: categoryModel.message));
          emit(const ManageLoaded());
        } else {
          emit(ManageFailure(errorMessage: categoryModel.message));
          emit(const ManageLoaded());
        }
      } else {
        emit(const ManageFailure(errorMessage: "Something went wrong"));
        emit(const ManageLoaded());
      }
    });
  }

  FutureOr<void> addHandlerFunction(AddHandlerEvent event, Emitter<ManageState> emit) async {
    await mainVariables.repoImpl.addHandler(query: {
      "name": mainVariables.manageVariables.addHandler.handlerController.text,
    }).onError((error, stackTrace) {
      emit(ManageFailure(errorMessage: error.toString()));
      emit(const ManageLoaded());
    }).then((value) async {
      if (value != null) {
        AddHandlerModel addHandlerModel = AddHandlerModel.fromJson(value);
        if (addHandlerModel.status) {
          mainVariables.manageVariables.addHandler.handlerController.clear();
          mainVariables.manageVariables.addHandler.tableData.insert(0, [
            addHandlerModel.handler.name,
            "-",
            addHandlerModel.handler.id,
          ]);
          var handlerBox = await Hive.openBox<HandlerResponse>('handler');
          await handlerBox.clear();
          await mainVariables.repoImpl.getHandler().onError((error, stackTrace) {}).then((value) async {
            if (value != null) {
              GetHandlerModel getHandlerResponse = GetHandlerModel.fromJson(value);
              if (getHandlerResponse.status) {
                final box = Hive.box<HandlerResponse>('handler');
                for (int i = 0; i < getHandlerResponse.handlers.length; i++) {
                  await box.put(getHandlerResponse.handlers[i].id, getHandlerResponse.handlers[i]);
                  mainVariables.stockMovementVariables.receiverInfo.handlerDropDownList.add(
                    DropDownValueModel(
                      name: getHandlerResponse.handlers[i].name,
                      value: getHandlerResponse.handlers[i].id,
                    ),
                  );
                }
              }
            }
          });
          emit(ManageSuccess2(message: addHandlerModel.message));
          emit(const ManageLoaded());
        } else {
          emit(ManageFailure(errorMessage: value["message"]));
          emit(const ManageLoaded());
        }
      } else {
        emit(const ManageFailure(errorMessage: "Something went wrong"));
        emit(const ManageLoaded());
      }
    });
  }

  FutureOr<void> deleteHandlerFunction(DeleteHandlerEvent event, Emitter<ManageState> emit) async {
    await mainVariables.repoImpl.deleteHandler(query: {
      "id": mainVariables.manageVariables.addHandler.tableData[event.index][2],
    }).onError((error, stackTrace) {
      emit(ManageFailure(errorMessage: error.toString()));
      emit(const ManageLoaded());
    }).then((value) async {
      if (value != null) {
        if (value["status"]) {
          mainVariables.manageVariables.addHandler.tableData.removeAt(event.index);
          var handlerBox = await Hive.openBox<HandlerResponse>('handler');
          await handlerBox.clear();
          await mainVariables.repoImpl.getHandler().onError((error, stackTrace) {}).then((value) async {
            if (value != null) {
              GetHandlerModel getHandlerResponse = GetHandlerModel.fromJson(value);
              if (getHandlerResponse.status) {
                final box = Hive.box<HandlerResponse>('handler');
                for (int i = 0; i < getHandlerResponse.handlers.length; i++) {
                  await box.put(getHandlerResponse.handlers[i].id, getHandlerResponse.handlers[i]);
                  mainVariables.stockMovementVariables.receiverInfo.handlerDropDownList.add(
                    DropDownValueModel(
                      name: getHandlerResponse.handlers[i].name,
                      value: getHandlerResponse.handlers[i].id,
                    ),
                  );
                }
              }
            }
          });
          emit(ManageSuccess2(message: value["message"]));
          emit(const ManageLoaded());
        } else {
          emit(ManageFailure(errorMessage: value["message"]));
          emit(const ManageLoaded());
        }
      } else {
        emit(const ManageFailure(errorMessage: "Something went wrong"));
        emit(const ManageLoaded());
      }
    });
  }

  FutureOr<void> editHandlerFunction(EditHandlerEvent event, Emitter<ManageState> emit) async {
    await mainVariables.repoImpl.editHandler(query: {
      "id": mainVariables.manageVariables.addHandler.tableData[event.index][2],
      "name": mainVariables.manageVariables.addHandler.editHandlerController.text,
    }).onError((error, stackTrace) {
      emit(ManageFailure(errorMessage: error.toString()));
      emit(const ManageLoaded());
    }).then((value) async {
      if (value != null) {
        AddHandlerModel addHandlerModel = AddHandlerModel.fromJson(value);
        if (addHandlerModel.status) {
          mainVariables.manageVariables.addHandler.editHandlerController.clear();
          mainVariables.manageVariables.addHandler.tableData[event.index][0] = addHandlerModel.handler.name;
          var handlerBox = await Hive.openBox<HandlerResponse>('handler');
          await handlerBox.clear();
          await mainVariables.repoImpl.getHandler().onError((error, stackTrace) {}).then((value) async {
            if (value != null) {
              GetHandlerModel getHandlerResponse = GetHandlerModel.fromJson(value);
              if (getHandlerResponse.status) {
                final box = Hive.box<HandlerResponse>('handler');
                for (int i = 0; i < getHandlerResponse.handlers.length; i++) {
                  await box.put(getHandlerResponse.handlers[i].id, getHandlerResponse.handlers[i]);
                  mainVariables.stockMovementVariables.receiverInfo.handlerDropDownList.add(
                    DropDownValueModel(
                      name: getHandlerResponse.handlers[i].name,
                      value: getHandlerResponse.handlers[i].id,
                    ),
                  );
                }
              }
            }
          });
          emit(ManageSuccess2(message: addHandlerModel.message));
          emit(const ManageLoaded());
        } else {
          emit(ManageFailure(errorMessage: addHandlerModel.message));
          emit(const ManageLoaded());
        }
      } else {
        emit(const ManageFailure(errorMessage: "Something went wrong"));
        emit(const ManageLoaded());
      }
    });
  }

  FutureOr<void> addWarehouseOrAircraftFunction(AddWarehouseOrAircraftEvent event, Emitter<ManageState> emit) async {
    await mainVariables.repoImpl.addWarehouseOrAircraft(query: {
      "name": mainVariables.manageVariables.manageSelectedIndex == 6 ? mainVariables.manageVariables.addWareHouse.wareHouseController.text : mainVariables.manageVariables.addAirCraft.airCraftController.text,
      "type": mainVariables.manageVariables.manageSelectedIndex == 6 ? "warehouse" : "aircraft",
    }).onError((error, stackTrace) {
      emit(ManageFailure(errorMessage: error.toString()));
      emit(const ManageLoaded());
    }).then((value) async {
      if (value != null) {
        AddWareHouseOrAirCraftModel addWareHouseOrAirCraftModel = AddWareHouseOrAirCraftModel.fromJson(value);
        if (addWareHouseOrAirCraftModel.status) {
          if (mainVariables.manageVariables.manageSelectedIndex == 6) {
            mainVariables.manageVariables.addWareHouse.wareHouseController.clear();
            mainVariables.manageVariables.addWareHouse.tableData.insert(0, [
              addWareHouseOrAirCraftModel.location.name,
              "-",
              addWareHouseOrAirCraftModel.location.id,
            ]);
          } else {
            mainVariables.manageVariables.addAirCraft.airCraftController.clear();
            mainVariables.manageVariables.addAirCraft.tableData.insert(0, [
              addWareHouseOrAirCraftModel.location.name,
              "-",
              addWareHouseOrAirCraftModel.location.id,
            ]);
          }
          var locationBox = await Hive.openBox<LocationResponse>('locations');
          await locationBox.clear();
          await mainVariables.repoImpl.getLocation().onError((error, stackTrace) {}).then((value) async {
            if (value != null) {
              GetLocationModel getLocationResponse = GetLocationModel.fromJson(value);
              if (getLocationResponse.status) {
                final box = Hive.box<LocationResponse>('locations');
                for (int i = 0; i < getLocationResponse.locations.length; i++) {
                  await box.put(getLocationResponse.locations[i].id, getLocationResponse.locations[i]);
                  mainVariables.stockMovementVariables.senderInfo.locationDropDownList.add(
                    DropDownValueModel(
                      name: getLocationResponse.locations[i].name,
                      value: getLocationResponse.locations[i].id,
                    ),
                  );
                }
              }
            }
          });
          emit(ManageSuccess2(message: addWareHouseOrAirCraftModel.message));
          emit(const ManageLoaded());
        } else {
          emit(ManageFailure(errorMessage: value["message"]));
          emit(const ManageLoaded());
        }
      } else {
        emit(const ManageFailure(errorMessage: "Something went wrong"));
        emit(const ManageLoaded());
      }
    });
  }

  FutureOr<void> deleteWarehouseOrAircraftFunction(DeleteWarehouseOrAircraftEvent event, Emitter<ManageState> emit) async {
    await mainVariables.repoImpl.deleteWarehouseOrAircraft(query: {
      "id": mainVariables.manageVariables.manageSelectedIndex == 6 ? mainVariables.manageVariables.addWareHouse.tableData[event.index][2] : mainVariables.manageVariables.addAirCraft.tableData[event.index][2],
    }).onError((error, stackTrace) {
      emit(ManageFailure(errorMessage: error.toString()));
      emit(const ManageLoaded());
    }).then((value) async {
      if (value != null) {
        if (value["status"]) {
          mainVariables.manageVariables.manageSelectedIndex == 6 ? mainVariables.manageVariables.addWareHouse.tableData.removeAt(event.index) : mainVariables.manageVariables.addAirCraft.tableData.removeAt(event.index);
          var locationBox = await Hive.openBox<LocationResponse>('locations');
          await locationBox.clear();
          await mainVariables.repoImpl.getLocation().onError((error, stackTrace) {}).then((value) async {
            if (value != null) {
              GetLocationModel getLocationResponse = GetLocationModel.fromJson(value);
              if (getLocationResponse.status) {
                final box = Hive.box<LocationResponse>('locations');
                for (int i = 0; i < getLocationResponse.locations.length; i++) {
                  await box.put(getLocationResponse.locations[i].id, getLocationResponse.locations[i]);
                  mainVariables.stockMovementVariables.senderInfo.locationDropDownList.add(
                    DropDownValueModel(
                      name: getLocationResponse.locations[i].name,
                      value: getLocationResponse.locations[i].id,
                    ),
                  );
                }
              }
            }
          });
          emit(ManageSuccess2(message: value["message"]));
          emit(const ManageLoaded());
        } else {
          emit(ManageFailure(errorMessage: value["message"]));
          emit(const ManageLoaded());
        }
      } else {
        emit(const ManageFailure(errorMessage: "Something went wrong"));
        emit(const ManageLoaded());
      }
    });
  }

  FutureOr<void> editWarehouseOrAircraftFunction(EditWarehouseOrAircraftEvent event, Emitter<ManageState> emit) async {
    await mainVariables.repoImpl.editWarehouseOrAircraft(query: {
      "id": mainVariables.manageVariables.manageSelectedIndex == 6 ? mainVariables.manageVariables.addWareHouse.tableData[event.index][2] : mainVariables.manageVariables.addAirCraft.tableData[event.index][2],
      "name": mainVariables.manageVariables.manageSelectedIndex == 6 ? mainVariables.manageVariables.addWareHouse.editWareHouseController.text : mainVariables.manageVariables.addAirCraft.editAirCraftController.text,
      "type": mainVariables.manageVariables.manageSelectedIndex == 6 ? "warehouse" : "aircraft",
    }).onError((error, stackTrace) {
      emit(ManageFailure(errorMessage: error.toString()));
      emit(const ManageLoaded());
    }).then((value) async {
      if (value != null) {
        AddWareHouseOrAirCraftModel addWareHouseOrAirCraftModel = AddWareHouseOrAirCraftModel.fromJson(value);
        if (addWareHouseOrAirCraftModel.status) {
          if (mainVariables.manageVariables.manageSelectedIndex == 6) {
            mainVariables.manageVariables.addWareHouse.editWareHouseController.clear();
            mainVariables.manageVariables.addWareHouse.tableData[event.index][0] = addWareHouseOrAirCraftModel.location.name;
          } else {
            mainVariables.manageVariables.addAirCraft.editAirCraftController.clear();
            mainVariables.manageVariables.addAirCraft.tableData[event.index][0] = addWareHouseOrAirCraftModel.location.name;
          }
          var locationBox = await Hive.openBox<LocationResponse>('locations');
          await locationBox.clear();
          await mainVariables.repoImpl.getLocation().onError((error, stackTrace) {}).then((value) async {
            if (value != null) {
              GetLocationModel getLocationResponse = GetLocationModel.fromJson(value);
              if (getLocationResponse.status) {
                final box = Hive.box<LocationResponse>('locations');
                for (int i = 0; i < getLocationResponse.locations.length; i++) {
                  await box.put(getLocationResponse.locations[i].id, getLocationResponse.locations[i]);
                  mainVariables.stockMovementVariables.senderInfo.locationDropDownList.add(
                    DropDownValueModel(
                      name: getLocationResponse.locations[i].name,
                      value: getLocationResponse.locations[i].id,
                    ),
                  );
                }
              }
            }
          });
          emit(ManageSuccess2(message: addWareHouseOrAirCraftModel.message));
          emit(const ManageLoaded());
        } else {
          emit(ManageFailure(errorMessage: addWareHouseOrAirCraftModel.message));
          emit(const ManageLoaded());
        }
      } else {
        emit(const ManageFailure(errorMessage: "Something went wrong"));
        emit(const ManageLoaded());
      }
    });
  }

  FutureOr<void> addSectorFunction(AddSectorEvent event, Emitter<ManageState> emit) async {
    await mainVariables.repoImpl.addSector(query: {
      "icao": mainVariables.manageVariables.addSector.icaoController.text,
      "iata": mainVariables.manageVariables.addSector.iataController.text,
      "airportName": mainVariables.manageVariables.addSector.airportController.text,
      "city": mainVariables.manageVariables.addSector.cityController.text,
    }).onError((error, stackTrace) {
      emit(ManageFailure(errorMessage: error.toString()));
      emit(const ManageLoaded());
    }).then((value) async {
      if (value != null) {
        AddSectorModel addSectorModel = AddSectorModel.fromJson(value);
        if (addSectorModel.status) {
          mainVariables.manageVariables.addSector.iataController.clear();
          mainVariables.manageVariables.addSector.icaoController.clear();
          mainVariables.manageVariables.addSector.airportController.clear();
          mainVariables.manageVariables.addSector.cityController.clear();
          mainVariables.manageVariables.addSector.tableData.insert(0, [
            addSectorModel.sector.airportName,
            addSectorModel.sector.city,
            addSectorModel.sector.icao,
            addSectorModel.sector.iata,
            "-",
            addSectorModel.sector.id,
          ]);
          var sectorBox = await Hive.openBox<SectorResponse>('sector');
          await sectorBox.clear();
          await mainVariables.repoImpl.getSector().onError((error, stackTrace) {}).then((value) async {
            if (value != null) {
              GetSectorModel getSectorResponse = GetSectorModel.fromJson(value);
              if (getSectorResponse.status) {
                final box = Hive.box<SectorResponse>('sector');
                for (int i = 0; i < getSectorResponse.sectors.length; i++) {
                  await box.put(getSectorResponse.sectors[i].id, getSectorResponse.sectors[i]);
                  mainVariables.stockMovementVariables.senderInfo.sectorDropDownList.add(
                    DropDownValueModel(
                      name: getSectorResponse.sectors[i].icao,
                      value: getSectorResponse.sectors[i].id,
                      iata: getSectorResponse.sectors[i].iata,
                      airportName: getSectorResponse.sectors[i].airportName,
                      city: getSectorResponse.sectors[i].city,
                    ),
                  );
                }
              }
            }
          });
          emit(ManageSuccess2(message: addSectorModel.message));
          emit(const ManageLoaded());
        } else {
          emit(ManageFailure(errorMessage: value["message"]));
          emit(const ManageLoaded());
        }
      } else {
        emit(const ManageFailure(errorMessage: "Something went wrong"));
        emit(const ManageLoaded());
      }
    });
  }

  FutureOr<void> deleteSectorFunction(DeleteSectorEvent event, Emitter<ManageState> emit) async {
    await mainVariables.repoImpl.deleteSector(query: {
      "id": mainVariables.manageVariables.addSector.tableData[event.index][5],
    }).onError((error, stackTrace) {
      emit(ManageFailure(errorMessage: error.toString()));
      emit(const ManageLoaded());
    }).then((value) async {
      if (value != null) {
        if (value["status"]) {
          mainVariables.manageVariables.addSector.tableData.removeAt(event.index);
          var sectorBox = await Hive.openBox<SectorResponse>('sector');
          await sectorBox.clear();
          await mainVariables.repoImpl.getSector().onError((error, stackTrace) {}).then((value) async {
            if (value != null) {
              GetSectorModel getSectorResponse = GetSectorModel.fromJson(value);
              if (getSectorResponse.status) {
                final box = Hive.box<SectorResponse>('sector');
                for (int i = 0; i < getSectorResponse.sectors.length; i++) {
                  await box.put(getSectorResponse.sectors[i].id, getSectorResponse.sectors[i]);
                  mainVariables.stockMovementVariables.senderInfo.sectorDropDownList.add(
                    DropDownValueModel(
                      name: getSectorResponse.sectors[i].icao,
                      value: getSectorResponse.sectors[i].id,
                      iata: getSectorResponse.sectors[i].iata,
                      airportName: getSectorResponse.sectors[i].airportName,
                      city: getSectorResponse.sectors[i].city,
                    ),
                  );
                }
              }
            }
          });
          emit(ManageSuccess2(message: value["message"]));
          emit(const ManageLoaded());
        } else {
          emit(ManageFailure(errorMessage: value["message"]));
          emit(const ManageLoaded());
        }
      } else {
        emit(const ManageFailure(errorMessage: "Something went wrong"));
        emit(const ManageLoaded());
      }
    });
  }

  FutureOr<void> editSectorFunction(EditSectorEvent event, Emitter<ManageState> emit) async {
    await mainVariables.repoImpl.editSector(query: {
      "id": mainVariables.manageVariables.addSector.tableData[event.index][5],
      "icao": mainVariables.manageVariables.addSector.icaoEditController.text,
      "iata": mainVariables.manageVariables.addSector.iataEditController.text,
      "airportName": mainVariables.manageVariables.addSector.airportEditController.text,
      "city": mainVariables.manageVariables.addSector.cityEditController.text,
    }).onError((error, stackTrace) {
      emit(ManageFailure(errorMessage: error.toString()));
      emit(const ManageLoaded());
    }).then((value) async {
      if (value != null) {
        AddSectorModel addSectorModel = AddSectorModel.fromJson(value);
        if (addSectorModel.status) {
          mainVariables.manageVariables.addSector.iataEditController.clear();
          mainVariables.manageVariables.addSector.icaoEditController.clear();
          mainVariables.manageVariables.addSector.airportEditController.clear();
          mainVariables.manageVariables.addSector.cityEditController.clear();
          mainVariables.manageVariables.addSector.tableData[event.index][0] = addSectorModel.sector.airportName;
          mainVariables.manageVariables.addSector.tableData[event.index][1] = addSectorModel.sector.city;
          mainVariables.manageVariables.addSector.tableData[event.index][2] = addSectorModel.sector.icao;
          mainVariables.manageVariables.addSector.tableData[event.index][3] = addSectorModel.sector.iata;
          var sectorBox = await Hive.openBox<SectorResponse>('sector');
          await sectorBox.clear();
          await mainVariables.repoImpl.getSector().onError((error, stackTrace) {}).then((value) async {
            if (value != null) {
              GetSectorModel getSectorResponse = GetSectorModel.fromJson(value);
              if (getSectorResponse.status) {
                final box = Hive.box<SectorResponse>('sector');
                for (int i = 0; i < getSectorResponse.sectors.length; i++) {
                  await box.put(getSectorResponse.sectors[i].id, getSectorResponse.sectors[i]);
                  mainVariables.stockMovementVariables.senderInfo.sectorDropDownList.add(
                    DropDownValueModel(
                      name: getSectorResponse.sectors[i].icao,
                      value: getSectorResponse.sectors[i].id,
                      iata: getSectorResponse.sectors[i].iata,
                      airportName: getSectorResponse.sectors[i].airportName,
                      city: getSectorResponse.sectors[i].city,
                    ),
                  );
                }
              }
            }
          });
          emit(ManageSuccess2(message: addSectorModel.message));
          emit(const ManageLoaded());
        } else {
          emit(ManageFailure(errorMessage: addSectorModel.message));
          emit(const ManageLoaded());
        }
      } else {
        emit(const ManageFailure(errorMessage: "Something went wrong"));
        emit(const ManageLoaded());
      }
    });
  }

  FutureOr<void> addCrewFunction(AddCrewEvent event, Emitter<ManageState> emit) async {
    if (mainVariables.manageVariables.addCrew.crewController.text.isNotEmpty) {
      bool isEmailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(mainVariables.manageVariables.addCrew.crewEmailController.text);
      if (isEmailValid) {
        bool passwordValid = RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&.])[A-Za-z\d@$!%*?&.]{8,40}$").hasMatch(mainVariables.manageVariables.addCrew.passwordController.text);
        if (passwordValid) {
          if (mainVariables.manageVariables.addCrew.passwordController.text == mainVariables.manageVariables.addCrew.confirmPasswordController.text) {
            await mainVariables.repoImpl.addCrew(query: {
              "firstName": mainVariables.manageVariables.addCrew.crewController.text,
              "lastName": "",
              "email": mainVariables.manageVariables.addCrew.crewEmailController.text,
              "password": mainVariables.manageVariables.addCrew.confirmPasswordController.text,
              "role": mainVariables.manageVariables.addCrew.selectedRole,
            }).onError((error, stackTrace) {
              emit(ManageFailure(errorMessage: error.toString()));
              emit(const ManageLoaded());
            }).then((value) async {
              if (value != null) {
                AddCrewModel addCrewModel = AddCrewModel.fromJson(value);
                if (addCrewModel.status) {
                  mainVariables.manageVariables.addCrew.crewController.clear();
                  mainVariables.manageVariables.addCrew.crewEmailController.clear();
                  mainVariables.manageVariables.addCrew.passwordController.clear();
                  mainVariables.manageVariables.addCrew.confirmPasswordController.clear();
                  mainVariables.manageVariables.addCrew.tableData.insert(0, [
                    addCrewModel.newUser.profilePhoto,
                    "${addCrewModel.newUser.firstName} ${addCrewModel.newUser.lastName}",
                    addCrewModel.newUser.email,
                    addCrewModel.newUser.activeStatus ? "active" : "inactive",
                    "-",
                    addCrewModel.newUser.id,
                    addCrewModel.newUser.role,
                  ]);
                  var crewBox = await Hive.openBox<CrewResponse>('crew');
                  await crewBox.clear();
                  await mainVariables.repoImpl.getCrew().onError((error, stackTrace) {}).then((value) async {
                    if (value != null) {
                      GetCrewModel getCrewResponse = GetCrewModel.fromJson(value);
                      if (getCrewResponse.status) {
                        final box = Hive.box<CrewResponse>('crew');
                        for (int i = 0; i < getCrewResponse.crews.length; i++) {
                          await box.put(getCrewResponse.crews[i].firstName, getCrewResponse.crews[i]);
                          mainVariables.stockMovementVariables.receiverInfo.crewDropDownList.add(
                            DropDownValueModel(
                              name: "${getCrewResponse.crews[i].firstName} ${getCrewResponse.crews[i].lastName}",
                              value: getCrewResponse.crews[i].id,
                            ),
                          );
                        }
                      }
                    }
                  });
                  emit(ManageSuccess2(message: addCrewModel.message));
                  emit(const ManageLoaded());
                } else {
                  emit(ManageFailure(errorMessage: value["message"]));
                  emit(const ManageLoaded());
                }
              } else {
                emit(const ManageFailure(errorMessage: "Something went wrong"));
                emit(const ManageLoaded());
              }
            });
          } else {
            emit(ManageFailure(errorMessage: mainVariables.manageVariables.addCrew.confirmPasswordController.text.isEmpty ? "Confirm Password field is Empty, Please add" : "Password & confirm password were not matched, Please verify & resubmit"));
            emit(const ManageLoaded());
          }
        } else {
          emit(ManageFailure(errorMessage: mainVariables.manageVariables.addCrew.passwordController.text.isEmpty ? "Password field is empty, Please add" : "Please enter the valid password, refer the password instructions"));
          emit(const ManageLoaded());
        }
      } else {
        emit(ManageFailure(errorMessage: mainVariables.manageVariables.addCrew.crewEmailController.text.isEmpty ? "Email field is empty, Please add" : "Email is not valid, Please enter the valid email"));
        emit(const ManageLoaded());
      }
    } else {
      emit(const ManageFailure(errorMessage: "Crew name is empty, Please add "));
      emit(const ManageLoaded());
    }
  }

  FutureOr<void> deleteCrewFunction(DeleteCrewEvent event, Emitter<ManageState> emit) async {
    await mainVariables.repoImpl.deleteCrew(query: {
      "userId": mainVariables.manageVariables.addCrew.tableData[event.index][5],
    }).onError((error, stackTrace) {
      emit(ManageFailure(errorMessage: error.toString()));
      emit(const ManageLoaded());
    }).then((value) async {
      if (value != null) {
        if (value["status"]) {
          mainVariables.manageVariables.addCrew.tableData.removeAt(event.index);
          var crewBox = await Hive.openBox<CrewResponse>('crew');
          await crewBox.clear();
          await mainVariables.repoImpl.getCrew().onError((error, stackTrace) {}).then((value) async {
            if (value != null) {
              GetCrewModel getCrewResponse = GetCrewModel.fromJson(value);
              if (getCrewResponse.status) {
                final box = Hive.box<CrewResponse>('crew');
                for (int i = 0; i < getCrewResponse.crews.length; i++) {
                  await box.put(getCrewResponse.crews[i].firstName, getCrewResponse.crews[i]);
                  mainVariables.stockMovementVariables.receiverInfo.crewDropDownList.add(
                    DropDownValueModel(
                      name: "${getCrewResponse.crews[i].firstName} ${getCrewResponse.crews[i].lastName}",
                      value: getCrewResponse.crews[i].id,
                    ),
                  );
                }
              }
            }
          });
          emit(ManageSuccess2(message: value["message"]));
          emit(const ManageLoaded());
        } else {
          emit(ManageFailure(errorMessage: value["message"]));
          emit(const ManageLoaded());
        }
      } else {
        emit(const ManageFailure(errorMessage: "Something went wrong"));
        emit(const ManageLoaded());
      }
    });
  }

  FutureOr<void> editCrewFunction(EditCrewEvent event, Emitter<ManageState> emit) async {
    await mainVariables.repoImpl.editCrew(query: {
      "userId": mainVariables.manageVariables.addCrew.tableData[event.index][5],
      "firstName": mainVariables.manageVariables.addCrew.crewEditController.text,
      "lastName": "",
      "email": mainVariables.manageVariables.addCrew.crewEmailEditController.text,
      "role": mainVariables.manageVariables.addCrew.selectedRole2
    }).onError((error, stackTrace) {
      emit(ManageFailure(errorMessage: error.toString()));
      emit(const ManageLoaded());
    }).then((value) async {
      if (value != null) {
        AddCrewModel addCrewModel = AddCrewModel.fromJson(value);
        if (addCrewModel.status) {
          mainVariables.manageVariables.addCrew.crewEditController.clear();
          mainVariables.manageVariables.addCrew.crewEmailEditController.clear();
          mainVariables.manageVariables.addCrew.tableData[event.index][0] = addCrewModel.newUser.profilePhoto;
          mainVariables.manageVariables.addCrew.tableData[event.index][1] = "${addCrewModel.newUser.firstName} ${addCrewModel.newUser.lastName}";
          mainVariables.manageVariables.addCrew.tableData[event.index][2] = addCrewModel.newUser.email;
          mainVariables.manageVariables.addCrew.tableData[event.index][3] = addCrewModel.newUser.activeStatus ? "active" : "inactive";
          mainVariables.manageVariables.addCrew.tableData[event.index][6] = addCrewModel.newUser.role;
          var crewBox = await Hive.openBox<CrewResponse>('crew');
          await crewBox.clear();
          var userBox = await Hive.openBox('boxData');
          await userBox.clear();
          await mainVariables.repoImpl.getCrew().onError((error, stackTrace) {}).then((value) async {
            if (value != null) {
              GetCrewModel getCrewResponse = GetCrewModel.fromJson(value);
              if (getCrewResponse.status) {
                for (int i = 0; i < getCrewResponse.crews.length; i++) {
                  if (getCrewResponse.crews[i].id == mainVariables.generalVariables.userData.id) {
                    UserResponse userResponse = UserResponse(
                      token: mainVariables.generalVariables.userToken,
                      user: User(
                        id: getCrewResponse.crews[i].id,
                        firstName: getCrewResponse.crews[i].firstName,
                        lastName: "",
                        email: getCrewResponse.crews[i].email,
                        role: getCrewResponse.crews[i].role,
                        createdAt: getCrewResponse.crews[i].createdAt,
                        updatedAt: getCrewResponse.crews[i].updatedAt,
                        activeStatus: getCrewResponse.crews[i].activeStatus,
                        verificationCode: getCrewResponse.crews[i].verificationCode,
                        verificationCodeExpiry: getCrewResponse.crews[i].verificationCodeExpiry == "" ? DateTime.now() : DateTime.parse(getCrewResponse.crews[i].verificationCodeExpiry),
                        profilePhoto: getCrewResponse.crews[i].profilePhoto,
                      ),
                      status: true,
                    );
                    await userBox.put('user_response', userResponse);
                    final box = Hive.box<CrewResponse>('crew');
                    await box.put(getCrewResponse.crews[i].firstName, getCrewResponse.crews[i]);
                    mainVariables.stockMovementVariables.receiverInfo.crewDropDownList.add(
                      DropDownValueModel(
                        name: "${getCrewResponse.crews[i].firstName} ${getCrewResponse.crews[i].lastName}",
                        value: getCrewResponse.crews[i].id,
                      ),
                    );
                  } else {
                    final box = Hive.box<CrewResponse>('crew');
                    await box.put(getCrewResponse.crews[i].firstName, getCrewResponse.crews[i]);
                    mainVariables.stockMovementVariables.receiverInfo.crewDropDownList.add(
                      DropDownValueModel(
                        name: "${getCrewResponse.crews[i].firstName} ${getCrewResponse.crews[i].lastName}",
                        value: getCrewResponse.crews[i].id,
                      ),
                    );
                  }
                }
              }
            }
          });
          emit(ManageSuccess2(message: addCrewModel.message));
          emit(const ManageLoaded());
        } else {
          emit(ManageFailure(errorMessage: addCrewModel.message));
          emit(const ManageLoaded());
        }
      } else {
        emit(const ManageFailure(errorMessage: "Something went wrong"));
        emit(const ManageLoaded());
      }
    });
  }

  FutureOr<void> crewActivateFunction(CrewActivateEvent event, Emitter<ManageState> emit) async {
    await mainVariables.repoImpl.activateCrew(query: {
      "userId": mainVariables.manageVariables.addCrew.tableData[event.index][5],
    }).onError((error, stackTrace) {
      emit(ManageFailure(errorMessage: error.toString()));
      emit(const ManageLoaded());
    }).then((value) async {
      if (value != null) {
        if (value["status"]) {
          mainVariables.manageVariables.addCrew.tableData[event.index][3] = "active";
          emit(ManageSuccess2(message: value["message"]));
          emit(const ManageLoaded());
        } else {
          emit(ManageFailure(errorMessage: value["message"]));
          emit(const ManageLoaded());
        }
      } else {
        emit(const ManageFailure(errorMessage: "Something went wrong"));
        emit(const ManageLoaded());
      }
    });
  }

  FutureOr<void> crewDeactivateFunction(CrewDeactivateEvent event, Emitter<ManageState> emit) async {
    await mainVariables.repoImpl.deactivateCrew(query: {
      "userId": mainVariables.manageVariables.addCrew.tableData[event.index][5],
    }).onError((error, stackTrace) {
      emit(ManageFailure(errorMessage: error.toString()));
      emit(const ManageLoaded());
    }).then((value) async {
      if (value != null) {
        if (value["status"]) {
          mainVariables.manageVariables.addCrew.tableData[event.index][3] = "inactive";
          emit(ManageSuccess2(message: value["message"]));
          emit(const ManageLoaded());
        } else {
          emit(ManageFailure(errorMessage: value["message"]));
          emit(const ManageLoaded());
        }
      } else {
        emit(const ManageFailure(errorMessage: "Something went wrong"));
        emit(const ManageLoaded());
      }
    });
  }

  FutureOr<void> addProductFunction(AddProductEvent event, Emitter<ManageState> emit) async {
    if (event.key4.currentState!.specialController.text.isEmpty || mainVariables.manageVariables.addProduct.productController.text.isEmpty || event.key5.currentState!.specialController.text.isEmpty) {
      emit(const ManageFailure(errorMessage: "Please enter the all the field"));
      emit(const ManageLoaded());
    } else {
      if (mainVariables.manageVariables.addProduct.isChecked) {
        if (mainVariables.manageVariables.addProduct.daysUntilController.text.isEmpty || int.parse(mainVariables.manageVariables.addProduct.daysUntilController.text) == 0) {
          emit(const ManageFailure(errorMessage: "if product has expiry, daysuntilexpiry field should not be 0 or empty"));
          emit(const ManageLoaded());
        } else {
          await mainVariables.repoImpl.addProduct(query: {
            "productName": mainVariables.manageVariables.addProduct.productController.text,
            "brandType": mainVariables.manageVariables.addProduct.brandId,
            "category": mainVariables.manageVariables.addProduct.categoryId,
            "daysUntilExpiry": mainVariables.manageVariables.addProduct.daysUntilController.text.isEmpty ? 0 : mainVariables.manageVariables.addProduct.daysUntilController.text,
          }, files: {
            "productImage": mainVariables.manageVariables.addProduct.selectedImage ?? File("")
          }).onError((error, stackTrace) {
            emit(ManageFailure(errorMessage: error.toString()));
            emit(const ManageLoaded());
          }).then((value) async {
            if (value != null) {
              AddProductModel addProductModel = AddProductModel.fromJson(value);
              if (addProductModel.status) {
                event.key4.currentState!.specialController.clear();
                mainVariables.manageVariables.addProduct.productController.clear();
                event.key5.currentState!.specialController.clear();
                mainVariables.manageVariables.addProduct.daysUntilController.clear();
                mainVariables.manageVariables.addProduct.brandId = "";
                mainVariables.manageVariables.addProduct.categoryId = "";
                mainVariables.manageVariables.addProduct.tableData.insert(0, [
                  addProductModel.products.productImage,
                  addProductModel.products.combinedName,
                  addProductModel.products.categoryName,
                  addProductModel.products.activeStatus ? "active" : "inactive",
                  "-",
                  addProductModel.products.id,
                  addProductModel.products.productName,
                  addProductModel.products.brandTypeName,
                  addProductModel.products.categoryId,
                  addProductModel.products.brandTypeId,
                  addProductModel.products.daysUntilExpiry.toString(),
                ]);
                emit(const ManageSuccess2(message: "Product added successfully"));
                emit(const ManageLoaded());
              } else {
                emit(ManageFailure(errorMessage: value["message"]));
                emit(const ManageLoaded());
              }
            } else {
              emit(const ManageFailure(errorMessage: "Something went wrong"));
              emit(const ManageLoaded());
            }
          });
        }
      } else {
        await mainVariables.repoImpl.addProduct(query: {
          "productName": mainVariables.manageVariables.addProduct.productController.text,
          "brandType": mainVariables.manageVariables.addProduct.brandId,
          "category": mainVariables.manageVariables.addProduct.categoryId,
          "daysUntilExpiry": mainVariables.manageVariables.addProduct.daysUntilController.text.isEmpty ? 0 : mainVariables.manageVariables.addProduct.daysUntilController.text,
        }, files: {
          "productImage": mainVariables.manageVariables.addProduct.selectedImage ?? File("")
        }).onError((error, stackTrace) {
          emit(ManageFailure(errorMessage: error.toString()));
          emit(const ManageLoaded());
        }).then((value) async {
          if (value != null) {
            AddProductModel addProductModel = AddProductModel.fromJson(value);
            if (addProductModel.status) {
              event.key4.currentState!.specialController.clear();
              mainVariables.manageVariables.addProduct.productController.clear();
              event.key5.currentState!.specialController.clear();
              mainVariables.manageVariables.addProduct.daysUntilController.clear();
              mainVariables.manageVariables.addProduct.brandId = "";
              mainVariables.manageVariables.addProduct.categoryId = "";
              mainVariables.manageVariables.addProduct.tableData.insert(0, [
                addProductModel.products.productImage,
                addProductModel.products.combinedName,
                addProductModel.products.categoryName,
                addProductModel.products.activeStatus ? "active" : "inactive",
                "-",
                addProductModel.products.id,
                addProductModel.products.productName,
                addProductModel.products.brandTypeName,
                addProductModel.products.categoryId,
                addProductModel.products.brandTypeId,
                addProductModel.products.daysUntilExpiry.toString(),
              ]);
              emit(const ManageSuccess2(message: "Product added successfully"));
              emit(const ManageLoaded());
            } else {
              emit(ManageFailure(errorMessage: value["message"]));
              emit(const ManageLoaded());
            }
          } else {
            emit(const ManageFailure(errorMessage: "Something went wrong"));
            emit(const ManageLoaded());
          }
        });
      }
    }
  }

  FutureOr<void> deleteProductFunction(DeleteProductEvent event, Emitter<ManageState> emit) async {
    await mainVariables.repoImpl.deleteProduct(query: {
      "id": mainVariables.manageVariables.addProduct.tableData[event.index][5],
    }).onError((error, stackTrace) {
      emit(ManageFailure(errorMessage: error.toString()));
      emit(const ManageLoaded());
    }).then((value) async {
      if (value != null) {
        if (value["status"]) {
          mainVariables.manageVariables.addProduct.tableData.removeAt(event.index);
          emit(ManageSuccess2(message: value["message"]));
          emit(const ManageLoaded());
        } else {
          emit(ManageFailure(errorMessage: value["message"]));
          emit(const ManageLoaded());
        }
      } else {
        emit(const ManageFailure(errorMessage: "Something went wrong"));
        emit(const ManageLoaded());
      }
    });
  }

  FutureOr<void> editProductFunction(EditProductEvent event, Emitter<ManageState> emit) async {
    await mainVariables.repoImpl.editProduct(query: {
      "id": mainVariables.manageVariables.addProduct.tableData[event.index][5],
      "productName": mainVariables.manageVariables.addProduct.productEditController.text,
      "brandType": mainVariables.manageVariables.addProduct.brandEditId,
      "category": mainVariables.manageVariables.addProduct.categoryEditId,
      "daysUntilExpiry": mainVariables.manageVariables.addProduct.daysUntilEditController.text.isEmpty ? 0 : mainVariables.manageVariables.addProduct.daysUntilEditController.text,
    }, files: {
      "productImage": mainVariables.manageVariables.addProduct.selectedEditImage ?? File("")
    }).onError((error, stackTrace) {
      emit(ManageFailure(errorMessage: error.toString()));
      emit(const ManageLoaded());
    }).then((value) async {
      if (value != null) {
        AddProductModel addProductModel = AddProductModel.fromJson(value);
        if (addProductModel.status) {
          mainVariables.manageVariables.addProduct.tableData[event.index][0] = addProductModel.products.productImage;
          mainVariables.manageVariables.addProduct.tableData[event.index][1] = addProductModel.products.combinedName;
          mainVariables.manageVariables.addProduct.tableData[event.index][2] = addProductModel.products.categoryName;
          mainVariables.manageVariables.addProduct.tableData[event.index][3] = addProductModel.products.activeStatus ? "active" : "inactive";
          mainVariables.manageVariables.addProduct.tableData[event.index][4] = "-";
          mainVariables.manageVariables.addProduct.tableData[event.index][5] = addProductModel.products.id;
          mainVariables.manageVariables.addProduct.tableData[event.index][6] = addProductModel.products.productName;
          mainVariables.manageVariables.addProduct.tableData[event.index][7] = addProductModel.products.brandTypeName;
          mainVariables.manageVariables.addProduct.tableData[event.index][8] = addProductModel.products.categoryId;
          mainVariables.manageVariables.addProduct.tableData[event.index][9] = addProductModel.products.brandTypeId;
          mainVariables.manageVariables.addProduct.tableData[event.index][10] = addProductModel.products.daysUntilExpiry.toString();
          emit(ManageSuccess2(message: addProductModel.message));
          emit(const ManageLoaded());
        } else {
          emit(ManageFailure(errorMessage: addProductModel.message));
          emit(const ManageLoaded());
        }
      } else {
        emit(const ManageFailure(errorMessage: "Something went wrong"));
        emit(const ManageLoaded());
      }
    });
  }

  FutureOr<void> productActivateFunction(ProductActivateEvent event, Emitter<ManageState> emit) async {
    await mainVariables.repoImpl.activateProduct(query: {
      "id": mainVariables.manageVariables.addProduct.tableData[event.index][5],
    }).onError((error, stackTrace) {
      emit(ManageFailure(errorMessage: error.toString()));
      emit(const ManageLoaded());
    }).then((value) async {
      if (value != null) {
        if (value["status"]) {
          mainVariables.manageVariables.addProduct.tableData[event.index][3] = "active";
          emit(ManageSuccess2(message: value["message"]));
          emit(const ManageLoaded());
        } else {
          emit(ManageFailure(errorMessage: value["message"]));
          emit(const ManageLoaded());
        }
      } else {
        emit(const ManageFailure(errorMessage: "Something went wrong"));
        emit(const ManageLoaded());
      }
    });
  }

  FutureOr<void> productDeactivateFunction(ProductDeactivateEvent event, Emitter<ManageState> emit) async {
    await mainVariables.repoImpl.deactivateProduct(query: {
      "id": mainVariables.manageVariables.addProduct.tableData[event.index][5],
    }).onError((error, stackTrace) {
      emit(ManageFailure(errorMessage: error.toString()));
      emit(const ManageLoaded());
    }).then((value) async {
      if (value != null) {
        if (value["status"]) {
          mainVariables.manageVariables.addProduct.tableData[event.index][3] = "inactive";
          emit(ManageSuccess2(message: value["message"]));
          emit(const ManageLoaded());
        } else {
          emit(ManageFailure(errorMessage: value["message"]));
          emit(const ManageLoaded());
        }
      } else {
        emit(const ManageFailure(errorMessage: "Something went wrong"));
        emit(const ManageLoaded());
      }
    });
  }

  FutureOr<void> productMiniLevelExpiryFunction(ProductMiniLevelExpiryEvent event, Emitter<ManageState> emit) async {
    await mainVariables.repoImpl.productMiniLevelExpiry(query: {
      "productId": mainVariables.manageVariables.addInventory.productId,
      "locationId": mainVariables.manageVariables.addInventory.locationId,
    }).onError((error, stackTrace) {
      emit(ManageFailure(errorMessage: error.toString()));
      emit(const ManageLoaded());
    }).then((value) async {
      if (value != null) {
        if (value["status"]) {
          mainVariables.manageVariables.addInventory.optimumController.text = value["minLevel"].toString();
          mainVariables.manageVariables.addInventory.isChecked = value["daysUntilExpiry"] == 0 ? false : true;
          emit(const ManageDummy());
          emit(const ManageLoaded());
        }
      }
    });
  }

  FutureOr<void> addInventoryFunction(AddInventoryEvent event, Emitter<ManageState> emit) async {
    if (mainVariables.manageVariables.addInventory.locationId == "" ||
        mainVariables.manageVariables.addInventory.productId == "" ||
        mainVariables.manageVariables.addInventory.stockTypeId == "" ||
        mainVariables.manageVariables.addInventory.categoryController.text.isEmpty ||
        mainVariables.manageVariables.addInventory.purchaseMonthController.text.isEmpty ||
        mainVariables.manageVariables.addInventory.optimumController.text.isEmpty ||
        mainVariables.manageVariables.addInventory.quantityController.text == "0" ||
        mainVariables.manageVariables.addInventory.quantityController.text.isEmpty) {
      if (mainVariables.manageVariables.addInventory.locationId == "") {
        emit(const ManageFailure(errorMessage: "Please add or select the location"));
        emit(const ManageLoaded());
      } else if (mainVariables.manageVariables.addInventory.productId == "") {
        emit(const ManageFailure(errorMessage: "Please add or select the product"));
        emit(const ManageLoaded());
      } else if (mainVariables.manageVariables.addInventory.stockTypeId == "") {
        emit(const ManageFailure(errorMessage: "Please add or select the stockType"));
        emit(const ManageLoaded());
      } else if (mainVariables.manageVariables.addInventory.categoryController.text.isEmpty) {
        emit(const ManageFailure(errorMessage: "Please add or select the category"));
        emit(const ManageLoaded());
      } else if (mainVariables.manageVariables.addInventory.purchaseMonthController.text.isEmpty) {
        emit(ManageFailure(errorMessage: "Please add or select the ${mainVariables.manageVariables.addInventory.isChecked ? "expiry date" : "purchase date"}"));
        emit(const ManageLoaded());
      } else if (mainVariables.manageVariables.addInventory.optimumController.text.isEmpty) {
        emit(const ManageFailure(errorMessage: "Please add or select the minimum level"));
        emit(const ManageLoaded());
      } else if (mainVariables.manageVariables.addInventory.quantityController.text.isEmpty) {
        emit(const ManageFailure(errorMessage: "Please add or select the quantity or count"));
        emit(const ManageLoaded());
      } else if (mainVariables.manageVariables.addInventory.quantityController.text == "0") {
        emit(const ManageFailure(errorMessage: "Optimum Level can't be zero, Please add optimum level"));
        emit(const ManageLoaded());
      }
    } else {
      await mainVariables.repoImpl
          .addInventory(
              query: mainVariables.manageVariables.addInventory.isChecked
                  ? {
                      "locationId": mainVariables.manageVariables.addInventory.locationId,
                      "productId": mainVariables.manageVariables.addInventory.productId,
                      "stockType": mainVariables.manageVariables.addInventory.stockTypeId,
                      "category": mainVariables.manageVariables.addInventory.categoryId,
                      "barcode": mainVariables.manageVariables.addInventory.barCodeController.text,
                      "expiryDate": mainVariables.manageVariables.addInventory.purchaseMonthController.text,
                      "minLevel": mainVariables.manageVariables.addInventory.optimumController.text,
                      "quantity": mainVariables.manageVariables.addInventory.quantityController.text,
                    }
                  : {
                      "locationId": mainVariables.manageVariables.addInventory.locationId,
                      "productId": mainVariables.manageVariables.addInventory.productId,
                      "stockType": mainVariables.manageVariables.addInventory.stockTypeId,
                      "category": mainVariables.manageVariables.addInventory.categoryId,
                      "barcode": mainVariables.manageVariables.addInventory.barCodeController.text,
                      "purchaseDate": mainVariables.manageVariables.addInventory.purchaseMonthController.text,
                      "minLevel": mainVariables.manageVariables.addInventory.optimumController.text,
                      "quantity": mainVariables.manageVariables.addInventory.quantityController.text,
                    })
          .onError((error, stackTrace) {
        emit(ManageFailure(errorMessage: error.toString()));
        emit(const ManageLoaded());
      }).then((value) async {
        if (value != null) {
          AddInventoryModel addInventoryModel = AddInventoryModel.fromJson(value);
          if (addInventoryModel.status) {
            event.key1.currentState!.specialController.clear();
            event.key2.currentState!.specialController.clear();
            event.key3.currentState!.specialController.clear();
            mainVariables.manageVariables.addInventory.locationId = "";
            mainVariables.manageVariables.addInventory.productId = "";
            mainVariables.manageVariables.addInventory.stockTypeId = "";
            mainVariables.manageVariables.addInventory.categoryController.clear();
            mainVariables.manageVariables.addInventory.categoryId = "";
            mainVariables.manageVariables.addInventory.barCodeController.clear();
            mainVariables.manageVariables.addInventory.purchaseMonthController.clear();
            mainVariables.manageVariables.addInventory.optimumController.clear();
            mainVariables.manageVariables.addInventory.quantityController.clear();
            emit(const ManageSuccess2(message: "Inventory added successfully"));
            emit(const ManageLoaded());
          } else {
            emit(ManageFailure(errorMessage: value["message"]));
            emit(const ManageLoaded());
          }
        } else {
          emit(const ManageFailure(errorMessage: "Something went wrong"));
          emit(const ManageLoaded());
        }
      });
    }
  }
}
