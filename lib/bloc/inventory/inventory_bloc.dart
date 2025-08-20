import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:tvsaviation/data/model/api_model/cart_details_model.dart';
import 'package:tvsaviation/data/model/api_model/get_inventory_category_model.dart';
import 'package:tvsaviation/data/model/api_model/inventory_products_list_model.dart';
import 'package:tvsaviation/data/model/api_model/product_count_inventory_model.dart';
import 'package:tvsaviation/data/model/api_model/product_detail_inventory_model.dart';
import 'package:tvsaviation/data/model/api_model/product_transit_list_model.dart';
import 'package:tvsaviation/data/model/api_model/shortage_detail_inventory_model.dart';
import 'package:tvsaviation/data/model/variable_model/inventory_change_model.dart';
import 'package:tvsaviation/resources/constants.dart';
import 'package:tvsaviation/resources/drop_down_lib/dropdown_textfield.dart';

part 'inventory_event.dart';
part 'inventory_state.dart';

class InventoryBloc extends Bloc<InventoryEvent, InventoryState> {
  List<List<ProductList>> searchGroupedList = [];
  int stockTypeIndexSelected = 0;
  int categoryIndexSelected = 0;
  bool isGlobalSearchEnabled = false;

  CartDetailsModel cartDetailsModel = CartDetailsModel.fromJson({});
  List<Map<String, dynamic>> updatedInventoryCartList = [];
  List<String> updatedInventoryIdsList = [];
  bool cartPageEnabled = false;
  TextEditingController cartRemarksController = TextEditingController();

  InventoryBloc() : super(const InventoryLoading()) {
    on<InventoryInitialEvent>(inventoryInitialFunction);
    on<InventoryChangeEvent>(inventoryChangeFunction);
    on<InventorySearchEvent>(inventorySearchFunction);
    on<InventoryDataEvent>(inventoryDataFunction);
    on<InventorySearchDataEvent>(inventorySearchDataFunction);
    on<InventoryUpdateDataEvent>(inventoryUpdateDataFunction);
    on<MinimumLevelUpdateEvent>(minimumLevelUpdateFunction);
    on<QuantityUpdateEvent>(quantityUpdateFunction);
    // on<GetCartEvent>(getCartFunction);
    on<UpdateCartEvent>(updateCartFunction);
    on<CartActionEvent>(cartActionFunction);
  }

  FutureOr<void> inventoryInitialFunction(InventoryInitialEvent event, Emitter<InventoryState> emit) async {
    if (mainVariables.generalVariables.currentPage.value == "inventory") {
      emit(const InventoryDummy());
      emit(const InventoryLoaded());
    } else {
      emit(const InventoryLoading());
      List<String> keysList = ["current_stock", "food_items_&_disposables", "unused_stock"];

      ///don't remove this. if you want to delete, make some delay here
      debugPrint(mainVariables.inventoryVariables.tabControllerIndex.toString());
      mainVariables.generalVariables.currentPage = "".obs;
      isGlobalSearchEnabled = false;
      mainVariables.inventoryVariables.tabsEnableList.clear();
      mainVariables.inventoryVariables.searchBar.clear();
      mainVariables.inventoryVariables.tabsEnableList = List.generate(3, (index) => false);
      mainVariables.inventoryVariables.tabsEnableList[mainVariables.inventoryVariables.tabControllerIndex] = true;
      mainVariables.inventoryVariables.selectedStockTypeId = keysList[mainVariables.inventoryVariables.tabControllerIndex];
      mainVariables.inventoryVariables.selectedLocationId = mainVariables.notificationVariables.locationId;
      mainVariables.inventoryVariables.selectedFilterType = "";
      mainVariables.inventoryVariables.selectedListIndex = 0;
      mainVariables.inventoryVariables.selectedProductId = "";
      mainVariables.inventoryVariables.selectedProductName = "";
      mainVariables.inventoryVariables.locationCount =
          List.generate(mainVariables.stockMovementVariables.senderInfo.locationDropDownList.length, (index) => 0);
      updatedInventoryIdsList.clear();
      updatedInventoryCartList.clear();
      cartPageEnabled=false;
      cartRemarksController = TextEditingController();
      await mainVariables.repoImpl.getInventoryCategory(query: {
        "stockType": mainVariables.inventoryVariables.selectedStockTypeId,
      }).onError((error, stackTrace) {
        emit(InventoryFailure(errorMessage: error.toString()));
        emit(const InventoryLoading());
      }).then((value) async {
        if (value != null) {
          GetInventoryCategoryModel getInventoryCategoryModel = GetInventoryCategoryModel.fromJson(value);
          if (getInventoryCategoryModel.status) {
            mainVariables.inventoryVariables.categoryDropDownList.clear();
            for (int i = 0; i < getInventoryCategoryModel.categories.length; i++) {
              mainVariables.inventoryVariables.categoryDropDownList.add(DropDownValueModel(
                  name: getInventoryCategoryModel.categories[i].name, value: getInventoryCategoryModel.categories[i].id));
            }
            if (mainVariables.inventoryVariables.categoryDropDownList.isNotEmpty) {
              mainVariables.inventoryVariables.selectedChoiceChip = mainVariables.inventoryVariables.categoryDropDownList[0].obs;
              event.modelSetState(() {
                mainVariables.inventoryVariables.loader = true;
              });
              await mainVariables.repoImpl.getInventoryProductsList(query: {
                "stockType": mainVariables.inventoryVariables.selectedStockTypeId,
                "locationId": mainVariables.inventoryVariables.selectedLocationId,
                "categoryId": mainVariables.inventoryVariables.selectedChoiceChip.value.value,
                "searchQuery": "",
                "filter": mainVariables.inventoryVariables.selectedFilterType,
              }).onError((error, stackTrace) {
                emit(InventoryFailure(errorMessage: error.toString()));
                emit(const InventoryLoading());
              }).then((value) async {
                if (value != null) {
                  InventoryProductListModel getInventoryProductsListResponse = InventoryProductListModel.fromJson(value);
                  if (getInventoryProductsListResponse.status) {
                    if (getInventoryProductsListResponse.products.isEmpty) {
                      mainVariables.inventoryVariables.products.clear();
                      mainVariables.inventoryVariables.transitList.clear();
                      mainVariables.inventoryVariables.productDataList.clear();
                      mainVariables.inventoryVariables.shortageDataList.clear();
                      mainVariables.inventoryVariables.locationCount =
                          List.generate(mainVariables.stockMovementVariables.senderInfo.locationDropDownList.length, (index) => 0);
                    } else {
                      mainVariables.inventoryVariables.products.clear();
                      mainVariables.inventoryVariables.products = getInventoryProductsListResponse.products;
                      mainVariables.inventoryVariables.selectedProductId = mainVariables.inventoryVariables.products[0].productId;
                      mainVariables.inventoryVariables.selectedProductName = mainVariables.inventoryVariables.products[0].productName;
                      await mainVariables.repoImpl
                          .getProductTransitList(query: {
                            "stockType": mainVariables.inventoryVariables.selectedStockTypeId,
                            "locationId": mainVariables.inventoryVariables.selectedLocationId,
                            "categoryId": mainVariables.inventoryVariables.selectedChoiceChip.value.value,
                            "productId": mainVariables.inventoryVariables.products[0].productId
                          })
                          .onError((error, stackTrace) {})
                          .then((value) {
                            ProductTransitListModel productTransitListModel = ProductTransitListModel.fromJson(value);
                            if (productTransitListModel.status) {
                              if (productTransitListModel.stockMovements.isEmpty) {
                                mainVariables.inventoryVariables.transitList.clear();
                                mainVariables.inventoryVariables.transitList = [];
                              } else {
                                mainVariables.inventoryVariables.transitList.clear();
                                mainVariables.inventoryVariables.transitList = productTransitListModel.stockMovements;
                              }
                            } else {
                              mainVariables.inventoryVariables.transitList.clear();
                              mainVariables.inventoryVariables.transitList = [];
                            }
                          });
                      await mainVariables.repoImpl
                          .productCountByLocation(query: {
                            "stockType": mainVariables.inventoryVariables.selectedStockTypeId,
                            "locationId": mainVariables.inventoryVariables.selectedLocationId,
                            "categoryId": mainVariables.inventoryVariables.selectedChoiceChip.value.value,
                            "productId": mainVariables.inventoryVariables.products[0].productId,
                          })
                          .onError((error, stackTrace) {})
                          .then((value) {
                            ProductCountInventoryModel productCountByLocationModel = ProductCountInventoryModel.fromJson(value);
                            if (productCountByLocationModel.status) {
                              if (productCountByLocationModel.locations.isEmpty) {
                                mainVariables.inventoryVariables.locationCount = List.generate(
                                    mainVariables.stockMovementVariables.senderInfo.locationDropDownList.length, (index) => 0);
                              } else {
                                List<String> locationIdList = List.generate(
                                    mainVariables.stockMovementVariables.senderInfo.locationDropDownList.length,
                                    (index) => mainVariables.stockMovementVariables.senderInfo.locationDropDownList[index].value);
                                mainVariables.inventoryVariables.locationCount = List.generate(
                                    mainVariables.stockMovementVariables.senderInfo.locationDropDownList.length, (index) => 0);
                                for (int j = 0; j < productCountByLocationModel.locations.length; j++) {
                                  if (locationIdList.contains(productCountByLocationModel.locations[j].locationId)) {
                                    mainVariables.inventoryVariables.locationCount[
                                            locationIdList.indexOf(productCountByLocationModel.locations[j].locationId)] =
                                        productCountByLocationModel.locations[j].totalQuantity;
                                  }
                                }
                              }
                            } else {
                              mainVariables.inventoryVariables.locationCount = List.generate(
                                  mainVariables.stockMovementVariables.senderInfo.locationDropDownList.length, (index) => 0);
                            }
                          });
                      await mainVariables.repoImpl
                          .productDetailsByProduct(query: {
                            "stockType": mainVariables.inventoryVariables.selectedStockTypeId,
                            "locationId": mainVariables.inventoryVariables.selectedLocationId,
                            "categoryId": mainVariables.inventoryVariables.selectedChoiceChip.value.value,
                            "productId": mainVariables.inventoryVariables.products[0].productId,
                          })
                          .onError((error, stackTrace) {})
                          .then((value) {
                            ProductDetailInventoryModel productDetailInventoryModel = ProductDetailInventoryModel.fromJson(value);
                            if (productDetailInventoryModel.status) {
                              mainVariables.inventoryVariables.minimumLevelCount = productDetailInventoryModel.minLevel;
                              if (productDetailInventoryModel.productDetails.isEmpty) {
                                mainVariables.inventoryVariables.productDataList.clear();
                                mainVariables.inventoryVariables.productDataList = [];
                              } else {
                                mainVariables.inventoryVariables.productDataList.clear();
                                for (int i = 0; i < productDetailInventoryModel.productDetails.length; i++) {
                                  InventoryProductsChangeModel inventoryProductsChangeModel =
                                      InventoryProductsChangeModel.fromJson(productDetailInventoryModel.productDetails[i].toJson());
                                  mainVariables.inventoryVariables.productDataList.add(
                                      inventoryProductsChangeModel.toJson().entries.map((entry) => (entry.value.toString())).toList());
                                }
                                if (updatedInventoryCartList.isNotEmpty) {
                                  for (int i = 0; i < mainVariables.inventoryVariables.productDataList.length; i++) {
                                    if (updatedInventoryIdsList.contains(mainVariables.inventoryVariables.productDataList[i][5])) {
                                      int inventoryIndex = updatedInventoryCartList.indexWhere(
                                          (e) => e["inventoryId"] == mainVariables.inventoryVariables.productDataList[i][5]);
                                      mainVariables.inventoryVariables.productDataList[i][3] =
                                          (num.parse(mainVariables.inventoryVariables.productDataList[i][3]) -
                                                  num.parse(updatedInventoryCartList[inventoryIndex]["quantityDelta"].toString()))
                                              .toString();
                                      mainVariables.inventoryVariables.productDataList[i][6] =
                                          (num.parse(mainVariables.inventoryVariables.productDataList[i][6]) +
                                              num.parse(updatedInventoryCartList[inventoryIndex]["quantityDelta"].toString()))
                                              .toString();
                                    }
                                  }
                                }
                              }
                            } else {
                              mainVariables.inventoryVariables.productDataList.clear();
                              mainVariables.inventoryVariables.productDataList = [];
                            }
                          });
                      await mainVariables.repoImpl
                          .shortageDetailsByProduct(query: {
                            "stockType": mainVariables.inventoryVariables.selectedStockTypeId,
                            "locationId": mainVariables.inventoryVariables.selectedLocationId,
                            "categoryId": mainVariables.inventoryVariables.selectedChoiceChip.value.value,
                            "productId": mainVariables.inventoryVariables.products[0].productId,
                          })
                          .onError((error, stackTrace) {})
                          .then((value) {
                            ShortageDetailInventoryModel shortageDetailInventoryModel = ShortageDetailInventoryModel.fromJson(value);
                            if (shortageDetailInventoryModel.status) {
                              if (shortageDetailInventoryModel.disputes.isEmpty) {
                                mainVariables.inventoryVariables.shortageDataList.clear();
                                mainVariables.inventoryVariables.shortageDataList = [];
                              } else {
                                mainVariables.inventoryVariables.shortageDataList.clear();
                                for (int i = 0; i < shortageDetailInventoryModel.disputes.length; i++) {
                                  InventoryShortageChangeModel inventoryShortageChangeModel =
                                      InventoryShortageChangeModel.fromJson(shortageDetailInventoryModel.disputes[i].toJson());
                                  mainVariables.inventoryVariables.shortageDataList.add(
                                      inventoryShortageChangeModel.toJson().entries.map((entry) => (entry.value.toString())).toList());
                                }
                              }
                            } else {
                              mainVariables.inventoryVariables.shortageDataList.clear();
                              mainVariables.inventoryVariables.shortageDataList = [];
                            }
                          });
                      if (mainVariables.inventoryVariables.selectedLocationId != "") {
                        cartDetailsModel = CartDetailsModel.fromJson(await mainVariables.repoImpl
                            .getCart(query: {"locationId": mainVariables.inventoryVariables.selectedLocationId}));
                      }
                    }
                    event.modelSetState(() {});
                    emit(const InventoryDummy());
                    emit(const InventoryLoaded());
                  } else {
                    emit(InventoryFailure(errorMessage: getInventoryProductsListResponse.message));
                    emit(const InventoryLoading());
                  }
                }
              });
            }
          }
        }
      });
    }
  }

  FutureOr<void> inventoryChangeFunction(InventoryChangeEvent event, Emitter<InventoryState> emit) async {
    emit(const InventoryLoading());
    mainVariables.inventoryVariables.selectedListIndex = 0;
    await mainVariables.repoImpl.getInventoryCategory(query: {
      "stockType": mainVariables.inventoryVariables.selectedStockTypeId,
    }).onError((error, stackTrace) {
      emit(InventoryFailure(errorMessage: error.toString()));
      emit(const InventoryLoading());
    }).then((value) async {
      if (value != null) {
        GetInventoryCategoryModel getInventoryCategoryModel = GetInventoryCategoryModel.fromJson(value);
        if (getInventoryCategoryModel.status) {
          mainVariables.inventoryVariables.categoryDropDownList.clear();
          for (int i = 0; i < getInventoryCategoryModel.categories.length; i++) {
            mainVariables.inventoryVariables.categoryDropDownList.add(DropDownValueModel(
                name: getInventoryCategoryModel.categories[i].name, value: getInventoryCategoryModel.categories[i].id));
          }
          if (mainVariables.inventoryVariables.categoryDropDownList.isNotEmpty) {
            if (mainVariables.inventoryVariables.tabPressed) {
              mainVariables.inventoryVariables.selectedChoiceChip.value = mainVariables.inventoryVariables.categoryDropDownList[0];
              mainVariables.inventoryVariables.tabPressed = false;
            }
            await mainVariables.repoImpl.getInventoryProductsList(query: {
              "stockType": mainVariables.inventoryVariables.selectedStockTypeId,
              "locationId": mainVariables.inventoryVariables.selectedLocationId,
              "categoryId": mainVariables.inventoryVariables.selectedChoiceChip.value.value,
              "searchQuery": mainVariables.inventoryVariables.searchBar.text,
              "filter": mainVariables.inventoryVariables.selectedFilterType,
            }).onError((error, stackTrace) {
              emit(InventoryFailure(errorMessage: error.toString()));
              emit(const InventoryLoaded());
            }).then((value) async {
              if (value != null) {
                InventoryProductListModel getInventoryProductsListResponse = InventoryProductListModel.fromJson(value);
                if (getInventoryProductsListResponse.status) {
                  if (getInventoryProductsListResponse.products.isEmpty) {
                    mainVariables.inventoryVariables.products.clear();
                    mainVariables.inventoryVariables.transitList.clear();
                    mainVariables.inventoryVariables.productDataList.clear();
                    mainVariables.inventoryVariables.shortageDataList.clear();
                    mainVariables.inventoryVariables.locationCount =
                        List.generate(mainVariables.stockMovementVariables.senderInfo.locationDropDownList.length, (index) => 0);
                  } else {
                    mainVariables.inventoryVariables.products.clear();
                    mainVariables.inventoryVariables.products = getInventoryProductsListResponse.products;
                    mainVariables.inventoryVariables.selectedProductId = mainVariables.inventoryVariables.products[0].productId;
                    mainVariables.inventoryVariables.selectedProductName = mainVariables.inventoryVariables.products[0].productName;
                    mainVariables.inventoryVariables.selectedProductHasExpiry = mainVariables.inventoryVariables.products[0].hasExpiry;
                    await mainVariables.repoImpl
                        .getProductTransitList(query: {
                          "stockType": mainVariables.inventoryVariables.selectedStockTypeId,
                          "locationId": mainVariables.inventoryVariables.selectedLocationId,
                          "categoryId": mainVariables.inventoryVariables.selectedChoiceChip.value.value,
                          "productId": mainVariables.inventoryVariables.products[0].productId
                        })
                        .onError((error, stackTrace) {})
                        .then((value) {
                          ProductTransitListModel productTransitListModel = ProductTransitListModel.fromJson(value);
                          if (productTransitListModel.status) {
                            if (productTransitListModel.stockMovements.isEmpty) {
                              mainVariables.inventoryVariables.transitList.clear();
                              mainVariables.inventoryVariables.transitList = [];
                            } else {
                              mainVariables.inventoryVariables.transitList.clear();
                              mainVariables.inventoryVariables.transitList = productTransitListModel.stockMovements;
                            }
                          } else {
                            mainVariables.inventoryVariables.transitList.clear();
                            mainVariables.inventoryVariables.transitList = [];
                          }
                        });
                    await mainVariables.repoImpl
                        .productCountByLocation(query: {
                          "stockType": mainVariables.inventoryVariables.selectedStockTypeId,
                          "locationId": mainVariables.inventoryVariables.selectedLocationId,
                          "categoryId": mainVariables.inventoryVariables.selectedChoiceChip.value.value,
                          "productId": mainVariables.inventoryVariables.products[0].productId,
                        })
                        .onError((error, stackTrace) {})
                        .then((value) {
                          ProductCountInventoryModel productCountByLocationModel = ProductCountInventoryModel.fromJson(value);
                          if (productCountByLocationModel.status) {
                            List<String> locationIdList = List.generate(
                                mainVariables.stockMovementVariables.senderInfo.locationDropDownList.length,
                                (index) => mainVariables.stockMovementVariables.senderInfo.locationDropDownList[index].value);
                            mainVariables.inventoryVariables.locationCount = List.generate(
                                mainVariables.stockMovementVariables.senderInfo.locationDropDownList.length, (index) => 0);
                            if (productCountByLocationModel.locations.isEmpty) {
                              mainVariables.inventoryVariables.locationCount = List.generate(
                                  mainVariables.stockMovementVariables.senderInfo.locationDropDownList.length, (index) => 0);
                            } else {
                              for (int j = 0; j < productCountByLocationModel.locations.length; j++) {
                                if (locationIdList.contains(productCountByLocationModel.locations[j].locationId)) {
                                  mainVariables.inventoryVariables
                                          .locationCount[locationIdList.indexOf(productCountByLocationModel.locations[j].locationId)] =
                                      productCountByLocationModel.locations[j].totalQuantity;
                                }
                              }
                            }
                          } else {
                            mainVariables.inventoryVariables.locationCount = List.generate(
                                mainVariables.stockMovementVariables.senderInfo.locationDropDownList.length, (index) => 0);
                          }
                        });
                    await mainVariables.repoImpl
                        .productDetailsByProduct(query: {
                          "stockType": mainVariables.inventoryVariables.selectedStockTypeId,
                          "locationId": mainVariables.inventoryVariables.selectedLocationId,
                          "categoryId": mainVariables.inventoryVariables.selectedChoiceChip.value.value,
                          "productId": mainVariables.inventoryVariables.products[0].productId,
                        })
                        .onError((error, stackTrace) {})
                        .then((value) {
                          ProductDetailInventoryModel productDetailInventoryModel = ProductDetailInventoryModel.fromJson(value);
                          if (productDetailInventoryModel.status) {
                            mainVariables.inventoryVariables.minimumLevelCount = productDetailInventoryModel.minLevel;
                            if (productDetailInventoryModel.productDetails.isEmpty) {
                              mainVariables.inventoryVariables.productDataList.clear();
                              mainVariables.inventoryVariables.productDataList = [];
                            } else {
                              mainVariables.inventoryVariables.productDataList.clear();
                              for (int i = 0; i < productDetailInventoryModel.productDetails.length; i++) {
                                InventoryProductsChangeModel inventoryProductsChangeModel =
                                    InventoryProductsChangeModel.fromJson(productDetailInventoryModel.productDetails[i].toJson());
                                mainVariables.inventoryVariables.productDataList.add(
                                    inventoryProductsChangeModel.toJson().entries.map((entry) => (entry.value.toString())).toList());
                              }
                              if (updatedInventoryCartList.isNotEmpty) {
                                for (int i = 0; i < mainVariables.inventoryVariables.productDataList.length; i++) {
                                  if (updatedInventoryIdsList.contains(mainVariables.inventoryVariables.productDataList[i][5])) {
                                    int inventoryIndex = updatedInventoryCartList.indexWhere(
                                            (e) => e["inventoryId"] == mainVariables.inventoryVariables.productDataList[i][5]);
                                    mainVariables.inventoryVariables.productDataList[i][3] =
                                        (num.parse(mainVariables.inventoryVariables.productDataList[i][3]) -
                                            num.parse(updatedInventoryCartList[inventoryIndex]["quantityDelta"].toString()))
                                            .toString();
                                    mainVariables.inventoryVariables.productDataList[i][6] =
                                        (num.parse(mainVariables.inventoryVariables.productDataList[i][6]) +
                                            num.parse(updatedInventoryCartList[inventoryIndex]["quantityDelta"].toString()))
                                            .toString();
                                  }
                                }
                              }
                            }
                          } else {
                            mainVariables.inventoryVariables.productDataList.clear();
                            mainVariables.inventoryVariables.productDataList = [];
                          }
                        });
                    await mainVariables.repoImpl
                        .shortageDetailsByProduct(query: {
                          "stockType": mainVariables.inventoryVariables.selectedStockTypeId,
                          "locationId": mainVariables.inventoryVariables.selectedLocationId,
                          "categoryId": mainVariables.inventoryVariables.selectedChoiceChip.value.value,
                          "productId": mainVariables.inventoryVariables.products[0].productId,
                        })
                        .onError((error, stackTrace) {})
                        .then((value) {
                          ShortageDetailInventoryModel shortageDetailInventoryModel = ShortageDetailInventoryModel.fromJson(value);
                          if (shortageDetailInventoryModel.status) {
                            if (shortageDetailInventoryModel.disputes.isEmpty) {
                              mainVariables.inventoryVariables.shortageDataList.clear();
                              mainVariables.inventoryVariables.shortageDataList = [];
                            } else {
                              mainVariables.inventoryVariables.shortageDataList.clear();
                              for (int i = 0; i < shortageDetailInventoryModel.disputes.length; i++) {
                                InventoryShortageChangeModel inventoryShortageChangeModel =
                                    InventoryShortageChangeModel.fromJson(shortageDetailInventoryModel.disputes[i].toJson());
                                mainVariables.inventoryVariables.shortageDataList.add(
                                    inventoryShortageChangeModel.toJson().entries.map((entry) => (entry.value.toString())).toList());
                              }
                            }
                          } else {
                            mainVariables.inventoryVariables.shortageDataList.clear();
                            mainVariables.inventoryVariables.shortageDataList = [];
                          }
                        });
                    if (mainVariables.inventoryVariables.selectedLocationId != "") {
                      cartDetailsModel = CartDetailsModel.fromJson(await mainVariables.repoImpl
                          .getCart(query: {"locationId": mainVariables.inventoryVariables.selectedLocationId}));
                    }
                  }
                  event.modelSetState(() {});
                  emit(const InventoryDummy());
                  emit(const InventoryLoaded());
                } else {
                  emit(InventoryFailure(errorMessage: getInventoryProductsListResponse.message));
                  emit(const InventoryLoaded());
                }
              }
            });
          }
        } else {}
      } else {}
    });
  }

  FutureOr<void> inventoryDataFunction(InventoryDataEvent event, Emitter<InventoryState> emit) async {
    emit(const InventoryError());
    mainVariables.inventoryVariables.selectedProductId = event.productId;
    mainVariables.inventoryVariables.selectedProductName = event.productName;
    mainVariables.inventoryVariables.selectedProductHasExpiry = event.productHasExpiry;
    await mainVariables.repoImpl
        .getProductTransitList(query: {
          "locationId": mainVariables.inventoryVariables.selectedLocationId,
          "productId": mainVariables.inventoryVariables.selectedProductId,
        })
        .onError((error, stackTrace) {})
        .then((value) {
          ProductTransitListModel productTransitListModel = ProductTransitListModel.fromJson(value);
          if (productTransitListModel.status) {
            if (productTransitListModel.stockMovements.isEmpty) {
              mainVariables.inventoryVariables.transitList.clear();
              mainVariables.inventoryVariables.transitList = productTransitListModel.stockMovements;
            } else {
              mainVariables.inventoryVariables.transitList.clear();
              mainVariables.inventoryVariables.transitList = productTransitListModel.stockMovements;
            }
          } else {
            mainVariables.inventoryVariables.transitList.clear();
            mainVariables.inventoryVariables.transitList = productTransitListModel.stockMovements;
          }
        });
    await mainVariables.repoImpl
        .productCountByLocation(query: {
          "stockType": mainVariables.inventoryVariables.selectedStockTypeId,
          "locationId": mainVariables.inventoryVariables.selectedLocationId,
          "categoryId": mainVariables.inventoryVariables.selectedChoiceChip.value.value,
          "productId": mainVariables.inventoryVariables.selectedProductId,
        })
        .onError((error, stackTrace) {})
        .then((value) {
          ProductCountInventoryModel productCountInventoryModel = ProductCountInventoryModel.fromJson(value);
          if (productCountInventoryModel.status) {
            List<String> locationIdList = List.generate(mainVariables.stockMovementVariables.senderInfo.locationDropDownList.length,
                (index) => mainVariables.stockMovementVariables.senderInfo.locationDropDownList[index].value);
            mainVariables.inventoryVariables.locationCount =
                List.generate(mainVariables.stockMovementVariables.senderInfo.locationDropDownList.length, (index) => 0);
            if (productCountInventoryModel.locations.isEmpty) {
              mainVariables.inventoryVariables.locationCount =
                  List.generate(mainVariables.stockMovementVariables.senderInfo.locationDropDownList.length, (index) => 0);
            } else {
              for (int j = 0; j < productCountInventoryModel.locations.length; j++) {
                if (locationIdList.contains(productCountInventoryModel.locations[j].locationId)) {
                  mainVariables.inventoryVariables
                          .locationCount[locationIdList.indexOf(productCountInventoryModel.locations[j].locationId)] =
                      productCountInventoryModel.locations[j].totalQuantity;
                }
              }
            }
          } else {
            mainVariables.inventoryVariables.locationCount =
                List.generate(mainVariables.stockMovementVariables.senderInfo.locationDropDownList.length, (index) => 0);
          }
        });
    await mainVariables.repoImpl
        .productDetailsByProduct(query: {
          "stockType": mainVariables.inventoryVariables.selectedStockTypeId,
          "locationId": mainVariables.inventoryVariables.selectedLocationId,
          "categoryId": mainVariables.inventoryVariables.selectedChoiceChip.value.value,
          "productId": mainVariables.inventoryVariables.selectedProductId,
        })
        .onError((error, stackTrace) {})
        .then((value) {
          ProductDetailInventoryModel productDetailInventoryModel = ProductDetailInventoryModel.fromJson(value);
          if (productDetailInventoryModel.status) {
            mainVariables.inventoryVariables.minimumLevelCount = productDetailInventoryModel.minLevel;
            if (productDetailInventoryModel.productDetails.isEmpty) {
              mainVariables.inventoryVariables.productDataList.clear();
              mainVariables.inventoryVariables.productDataList = [];
            } else {
              mainVariables.inventoryVariables.productDataList.clear();
              for (int i = 0; i < productDetailInventoryModel.productDetails.length; i++) {
                InventoryProductsChangeModel inventoryProductsChangeModel =
                    InventoryProductsChangeModel.fromJson(productDetailInventoryModel.productDetails[i].toJson());
                mainVariables.inventoryVariables.productDataList
                    .add(inventoryProductsChangeModel.toJson().entries.map((entry) => (entry.value.toString())).toList());
              }
              if (updatedInventoryCartList.isNotEmpty) {
                for (int i = 0; i < mainVariables.inventoryVariables.productDataList.length; i++) {
                  if (updatedInventoryIdsList.contains(mainVariables.inventoryVariables.productDataList[i][5])) {
                    int inventoryIndex = updatedInventoryCartList.indexWhere(
                            (e) => e["inventoryId"] == mainVariables.inventoryVariables.productDataList[i][5]);
                    mainVariables.inventoryVariables.productDataList[i][3] =
                        (num.parse(mainVariables.inventoryVariables.productDataList[i][3]) -
                            num.parse(updatedInventoryCartList[inventoryIndex]["quantityDelta"].toString()))
                            .toString();
                    mainVariables.inventoryVariables.productDataList[i][6] =
                        (num.parse(mainVariables.inventoryVariables.productDataList[i][6]) +
                            num.parse(updatedInventoryCartList[inventoryIndex]["quantityDelta"].toString()))
                            .toString();
                  }
                }
              }
            }
          } else {
            mainVariables.inventoryVariables.productDataList.clear();
            mainVariables.inventoryVariables.productDataList = [];
          }
        });
    await mainVariables.repoImpl
        .shortageDetailsByProduct(query: {
          "stockType": mainVariables.inventoryVariables.selectedStockTypeId,
          "locationId": mainVariables.inventoryVariables.selectedLocationId,
          "categoryId": mainVariables.inventoryVariables.selectedChoiceChip.value.value,
          "productId": mainVariables.inventoryVariables.selectedProductId,
        })
        .onError((error, stackTrace) {})
        .then((value) {
          ShortageDetailInventoryModel shortageDetailInventoryModel = ShortageDetailInventoryModel.fromJson(value);
          if (shortageDetailInventoryModel.status) {
            if (shortageDetailInventoryModel.disputes.isEmpty) {
              mainVariables.inventoryVariables.shortageDataList.clear();
              mainVariables.inventoryVariables.shortageDataList = [];
            } else {
              mainVariables.inventoryVariables.shortageDataList.clear();
              for (int i = 0; i < shortageDetailInventoryModel.disputes.length; i++) {
                InventoryShortageChangeModel inventoryShortageChangeModel =
                    InventoryShortageChangeModel.fromJson(shortageDetailInventoryModel.disputes[i].toJson());
                mainVariables.inventoryVariables.shortageDataList
                    .add(inventoryShortageChangeModel.toJson().entries.map((entry) => (entry.value.toString())).toList());
              }
            }
          } else {
            mainVariables.inventoryVariables.shortageDataList.clear();
            mainVariables.inventoryVariables.shortageDataList = [];
          }
        });
    if (mainVariables.inventoryVariables.selectedLocationId != "") {
      cartDetailsModel = CartDetailsModel.fromJson(
          await mainVariables.repoImpl.getCart(query: {"locationId": mainVariables.inventoryVariables.selectedLocationId}));
    }
    event.modelSetState(() {});
    emit(const InventoryDummy());
    emit(const InventoryLoaded());
  }

  FutureOr<void> minimumLevelUpdateFunction(MinimumLevelUpdateEvent event, Emitter<InventoryState> emit) async {
    emit(const InventoryError());
    await mainVariables.repoImpl.minimumLevelUpdate(query: {
      "productId": mainVariables.inventoryVariables.selectedProductId,
      "locationId": mainVariables.inventoryVariables.selectedLocationId,
      "minLevel": event.updateLevel,
    }).onError((error, stackTrace) {
      emit(InventoryFailure(errorMessage: error.toString()));
      emit(const InventoryLoaded());
    }).then((value) {
      if (value != null) {
        if (value["status"]) {
          mainVariables.inventoryVariables.minimumLevelCount = event.updateLevel;
          event.modelSetState(() {});
          emit(InventorySuccess(message: value["message"]));
          emit(const InventoryLoaded());
        } else {
          event.modelSetState(() {});
          emit(InventoryFailure(errorMessage: value["message"]));
          emit(const InventoryLoaded());
        }
      } else {
        emit(const InventoryFailure(errorMessage: "Something went wrong, Please try again"));
        emit(const InventoryLoaded());
      }
    });
  }

  FutureOr<void> quantityUpdateFunction(QuantityUpdateEvent event, Emitter<InventoryState> emit) async {
    emit(const InventoryError());
    await mainVariables.repoImpl.quantityUpdate(query: {
      "inventoryId": mainVariables.inventoryVariables.productDataList[event.index][5],
      "consumedQuantity": mainVariables.inventoryVariables.quantityController.text,
    }).onError((error, stackTrace) {
      emit(InventoryFailure(errorMessage: error.toString()));
      emit(const InventoryLoaded());
    }).then((value) {
      if (value != null) {
        if (value["status"]) {
          mainVariables.inventoryVariables.productDataList[event.index][3] =
              (int.parse(mainVariables.inventoryVariables.productDataList[event.index][3]) -
                      int.parse(mainVariables.inventoryVariables.quantityController.text))
                  .toString();
          mainVariables.inventoryVariables.products[mainVariables.inventoryVariables.selectedListIndex].totalQuantity =
              mainVariables.inventoryVariables.products[mainVariables.inventoryVariables.selectedListIndex].totalQuantity -
                  int.parse(mainVariables.inventoryVariables.quantityController.text);
          event.modelSetState(() {});
          emit(InventorySuccess(message: value["message"]));
          emit(const InventoryLoaded());
        } else {
          event.modelSetState(() {});
          emit(InventoryFailure(errorMessage: value["message"]));
          emit(const InventoryLoaded());
        }
      } else {
        emit(const InventoryFailure(errorMessage: "Something went wrong, Please try again"));
        emit(const InventoryLoaded());
      }
    });
  }

  FutureOr<void> inventorySearchFunction(InventorySearchEvent event, Emitter<InventoryState> emit) async {
    emit(const InventoryLoading());
    await mainVariables.repoImpl.getInventoryProductsList(query: {
      "stockType": "",
      "locationId": "",
      "categoryId": "",
      "searchQuery": mainVariables.inventoryVariables.searchBar.text,
      "filter": ""
    }).onError((error, stackTrace) {
      emit(InventoryFailure(errorMessage: error.toString()));
      emit(const InventoryLoading());
    }).then((value) async {
      if (value != null) {
        InventoryProductListModel getInventoryProductsListResponse = InventoryProductListModel.fromJson(value);
        if (getInventoryProductsListResponse.status) {
          if (getInventoryProductsListResponse.products.isEmpty) {
            mainVariables.inventoryVariables.products.clear();
            mainVariables.inventoryVariables.transitList.clear();
            mainVariables.inventoryVariables.productDataList.clear();
            mainVariables.inventoryVariables.shortageDataList.clear();
            mainVariables.inventoryVariables.locationCount =
                List.generate(mainVariables.stockMovementVariables.senderInfo.locationDropDownList.length, (index) => 0);
          } else {
            mainVariables.inventoryVariables.products.clear();
            mainVariables.inventoryVariables.products = getInventoryProductsListResponse.products;
            Map<String, Map<String, List<ProductList>>> grouped =
                groupProductsByStockAndCategory(mainVariables.inventoryVariables.products);
            searchGroupedList = grouped.values.expand((innerMap) => innerMap.values).toList();
            mainVariables.inventoryVariables.selectedProductId =
                searchGroupedList[stockTypeIndexSelected][categoryIndexSelected].productId;
            mainVariables.inventoryVariables.selectedProductName =
                searchGroupedList[stockTypeIndexSelected][categoryIndexSelected].productName;
            List<String> keysList = ["current_stock", "food_items_&_disposables", "unused_stock"];
            int indexValue = keysList.indexOf(searchGroupedList[stockTypeIndexSelected][categoryIndexSelected].stockType);
            mainVariables.inventoryVariables.tabControllerIndex = indexValue;
            mainVariables.inventoryVariables.tabsEnableList.clear();
            mainVariables.inventoryVariables.tabsEnableList = List.generate(3, (index) => false);
            mainVariables.inventoryVariables.tabsEnableList[indexValue] = true;
            mainVariables.inventoryVariables.selectedStockTypeId =
                searchGroupedList[stockTypeIndexSelected][categoryIndexSelected].stockType;
            mainVariables.inventoryVariables.tabPressed = true;
            await mainVariables.repoImpl.getInventoryCategory(query: {
              "stockType": mainVariables.inventoryVariables.selectedStockTypeId,
            }).onError((error, stackTrace) {
              emit(InventoryFailure(errorMessage: error.toString()));
              emit(const InventoryLoading());
            }).then((value) async {
              GetInventoryCategoryModel getInventoryCategoryModel = GetInventoryCategoryModel.fromJson(value);
              if (getInventoryCategoryModel.status) {
                mainVariables.inventoryVariables.categoryDropDownList.clear();
                for (int i = 0; i < getInventoryCategoryModel.categories.length; i++) {
                  mainVariables.inventoryVariables.categoryDropDownList.add(DropDownValueModel(
                      name: getInventoryCategoryModel.categories[i].name, value: getInventoryCategoryModel.categories[i].id));
                }
                if (mainVariables.inventoryVariables.categoryDropDownList.isNotEmpty) {
                  mainVariables.inventoryVariables.selectedChoiceChip = mainVariables.inventoryVariables.categoryDropDownList
                      .firstWhere((e) => e.value == searchGroupedList[stockTypeIndexSelected][categoryIndexSelected].categoryId)
                      .obs;
                  event.modelSetState(() {
                    mainVariables.inventoryVariables.loader = true;
                  });
                  await mainVariables.repoImpl
                      .getProductTransitList(query: {
                        "stockType": mainVariables.inventoryVariables.selectedStockTypeId,
                        "locationId": mainVariables.inventoryVariables.selectedLocationId,
                        "categoryId": mainVariables.inventoryVariables.selectedChoiceChip.value.value,
                        "productId": searchGroupedList[stockTypeIndexSelected][categoryIndexSelected].productId
                      })
                      .onError((error, stackTrace) {})
                      .then((value) {
                        ProductTransitListModel productTransitListModel = ProductTransitListModel.fromJson(value);
                        if (productTransitListModel.status) {
                          if (productTransitListModel.stockMovements.isEmpty) {
                            mainVariables.inventoryVariables.transitList.clear();
                            mainVariables.inventoryVariables.transitList = [];
                          } else {
                            mainVariables.inventoryVariables.transitList.clear();
                            mainVariables.inventoryVariables.transitList = productTransitListModel.stockMovements;
                          }
                        } else {
                          mainVariables.inventoryVariables.transitList.clear();
                          mainVariables.inventoryVariables.transitList = [];
                        }
                      });
                  await mainVariables.repoImpl
                      .productCountByLocation(query: {
                        "stockType": mainVariables.inventoryVariables.selectedStockTypeId,
                        "locationId": mainVariables.inventoryVariables.selectedLocationId,
                        "categoryId": mainVariables.inventoryVariables.selectedChoiceChip.value.value,
                        "productId": searchGroupedList[stockTypeIndexSelected][categoryIndexSelected].productId,
                      })
                      .onError((error, stackTrace) {})
                      .then((value) {
                        ProductCountInventoryModel productCountByLocationModel = ProductCountInventoryModel.fromJson(value);
                        if (productCountByLocationModel.status) {
                          if (productCountByLocationModel.locations.isEmpty) {
                            mainVariables.inventoryVariables.locationCount = List.generate(
                                mainVariables.stockMovementVariables.senderInfo.locationDropDownList.length, (index) => 0);
                          } else {
                            List<String> locationIdList = List.generate(
                                mainVariables.stockMovementVariables.senderInfo.locationDropDownList.length,
                                (index) => mainVariables.stockMovementVariables.senderInfo.locationDropDownList[index].value);
                            mainVariables.inventoryVariables.locationCount = List.generate(
                                mainVariables.stockMovementVariables.senderInfo.locationDropDownList.length, (index) => 0);
                            for (int j = 0; j < productCountByLocationModel.locations.length; j++) {
                              if (locationIdList.contains(productCountByLocationModel.locations[j].locationId)) {
                                mainVariables.inventoryVariables
                                        .locationCount[locationIdList.indexOf(productCountByLocationModel.locations[j].locationId)] =
                                    productCountByLocationModel.locations[j].totalQuantity;
                              }
                            }
                          }
                        } else {
                          mainVariables.inventoryVariables.locationCount =
                              List.generate(mainVariables.stockMovementVariables.senderInfo.locationDropDownList.length, (index) => 0);
                        }
                      });
                  await mainVariables.repoImpl
                      .productDetailsByProduct(query: {
                        "stockType": mainVariables.inventoryVariables.selectedStockTypeId,
                        "locationId": mainVariables.inventoryVariables.selectedLocationId,
                        "categoryId": mainVariables.inventoryVariables.selectedChoiceChip.value.value,
                        "productId": searchGroupedList[stockTypeIndexSelected][categoryIndexSelected].productId,
                      })
                      .onError((error, stackTrace) {})
                      .then((value) {
                        ProductDetailInventoryModel productDetailInventoryModel = ProductDetailInventoryModel.fromJson(value);
                        if (productDetailInventoryModel.status) {
                          mainVariables.inventoryVariables.minimumLevelCount = productDetailInventoryModel.minLevel;
                          if (productDetailInventoryModel.productDetails.isEmpty) {
                            mainVariables.inventoryVariables.productDataList.clear();
                            mainVariables.inventoryVariables.productDataList = [];
                          } else {
                            mainVariables.inventoryVariables.productDataList.clear();
                            for (int i = 0; i < productDetailInventoryModel.productDetails.length; i++) {
                              InventoryProductsChangeModel inventoryProductsChangeModel =
                                  InventoryProductsChangeModel.fromJson(productDetailInventoryModel.productDetails[i].toJson());
                              mainVariables.inventoryVariables.productDataList.add(
                                  inventoryProductsChangeModel.toJson().entries.map((entry) => (entry.value.toString())).toList());
                            }
                            if (updatedInventoryCartList.isNotEmpty) {
                              for (int i = 0; i < mainVariables.inventoryVariables.productDataList.length; i++) {
                                if (updatedInventoryIdsList.contains(mainVariables.inventoryVariables.productDataList[i][5])) {
                                  int inventoryIndex = updatedInventoryCartList.indexWhere(
                                          (e) => e["inventoryId"] == mainVariables.inventoryVariables.productDataList[i][5]);
                                  mainVariables.inventoryVariables.productDataList[i][3] =
                                      (num.parse(mainVariables.inventoryVariables.productDataList[i][3]) -
                                          num.parse(updatedInventoryCartList[inventoryIndex]["quantityDelta"].toString()))
                                          .toString();
                                  mainVariables.inventoryVariables.productDataList[i][6] =
                                      (num.parse(mainVariables.inventoryVariables.productDataList[i][6]) +
                                          num.parse(updatedInventoryCartList[inventoryIndex]["quantityDelta"].toString()))
                                          .toString();
                                }
                              }
                            }
                          }
                        } else {
                          mainVariables.inventoryVariables.productDataList.clear();
                          mainVariables.inventoryVariables.productDataList = [];
                        }
                      });
                  await mainVariables.repoImpl
                      .shortageDetailsByProduct(query: {
                        "stockType": mainVariables.inventoryVariables.selectedStockTypeId,
                        "locationId": mainVariables.inventoryVariables.selectedLocationId,
                        "categoryId": mainVariables.inventoryVariables.selectedChoiceChip.value.value,
                        "productId": searchGroupedList[stockTypeIndexSelected][categoryIndexSelected].productId,
                      })
                      .onError((error, stackTrace) {})
                      .then((value) {
                        ShortageDetailInventoryModel shortageDetailInventoryModel = ShortageDetailInventoryModel.fromJson(value);
                        if (shortageDetailInventoryModel.status) {
                          if (shortageDetailInventoryModel.disputes.isEmpty) {
                            mainVariables.inventoryVariables.shortageDataList.clear();
                            mainVariables.inventoryVariables.shortageDataList = [];
                          } else {
                            mainVariables.inventoryVariables.shortageDataList.clear();
                            for (int i = 0; i < shortageDetailInventoryModel.disputes.length; i++) {
                              InventoryShortageChangeModel inventoryShortageChangeModel =
                                  InventoryShortageChangeModel.fromJson(shortageDetailInventoryModel.disputes[i].toJson());
                              mainVariables.inventoryVariables.shortageDataList.add(
                                  inventoryShortageChangeModel.toJson().entries.map((entry) => (entry.value.toString())).toList());
                            }
                          }
                        } else {
                          mainVariables.inventoryVariables.shortageDataList.clear();
                          mainVariables.inventoryVariables.shortageDataList = [];
                        }
                      });
                  if (mainVariables.inventoryVariables.selectedLocationId != "") {
                    cartDetailsModel = CartDetailsModel.fromJson(await mainVariables.repoImpl
                        .getCart(query: {"locationId": mainVariables.inventoryVariables.selectedLocationId}));
                  }
                }
              }
            });
          }
          event.modelSetState(() {});
          emit(const InventoryDummy());
          emit(const InventoryLoaded());
        } else {
          emit(InventoryFailure(errorMessage: getInventoryProductsListResponse.message));
          emit(const InventoryLoading());
        }
      }
    });
  }

  FutureOr<void> inventorySearchDataFunction(InventorySearchDataEvent event, Emitter<InventoryState> emit) async {
    emit(const InventoryLoading());
    List<String> keysList = ["current_stock", "food_items_&_disposables", "unused_stock"];

    ///don't remove this. if you want to delete, make some delay here
    debugPrint(mainVariables.inventoryVariables.tabControllerIndex.toString());
    mainVariables.inventoryVariables.tabControllerIndex = 0;
    mainVariables.generalVariables.currentPage = "".obs;
    mainVariables.inventoryVariables.tabsEnableList.clear();
    mainVariables.inventoryVariables.searchBar.clear();
    mainVariables.inventoryVariables.tabsEnableList = List.generate(3, (index) => false);
    mainVariables.inventoryVariables.tabsEnableList[mainVariables.inventoryVariables.tabControllerIndex] = true;
    mainVariables.inventoryVariables.selectedStockTypeId = keysList[mainVariables.inventoryVariables.tabControllerIndex];
    mainVariables.inventoryVariables.selectedLocationId = mainVariables.notificationVariables.locationId;
    mainVariables.inventoryVariables.selectedFilterType = "";
    mainVariables.inventoryVariables.selectedListIndex = 0;
    mainVariables.inventoryVariables.selectedProductId = "";
    mainVariables.inventoryVariables.selectedProductName = "";
    mainVariables.inventoryVariables.locationCount =
        List.generate(mainVariables.stockMovementVariables.senderInfo.locationDropDownList.length, (index) => 0);
    await mainVariables.repoImpl.getInventoryCategory(query: {
      "stockType": mainVariables.inventoryVariables.selectedStockTypeId,
    }).onError((error, stackTrace) {
      emit(InventoryFailure(errorMessage: error.toString()));
      emit(const InventoryLoading());
    }).then((value) async {
      if (value != null) {
        GetInventoryCategoryModel getInventoryCategoryModel = GetInventoryCategoryModel.fromJson(value);
        if (getInventoryCategoryModel.status) {
          mainVariables.inventoryVariables.categoryDropDownList.clear();
          for (int i = 0; i < getInventoryCategoryModel.categories.length; i++) {
            mainVariables.inventoryVariables.categoryDropDownList.add(DropDownValueModel(
                name: getInventoryCategoryModel.categories[i].name, value: getInventoryCategoryModel.categories[i].id));
          }
          if (mainVariables.inventoryVariables.categoryDropDownList.isNotEmpty) {
            mainVariables.inventoryVariables.selectedChoiceChip = mainVariables.inventoryVariables.categoryDropDownList[0].obs;
            event.modelSetState(() {
              mainVariables.inventoryVariables.loader = true;
            });
            await mainVariables.repoImpl.getInventoryProductsList(query: {
              "stockType": mainVariables.inventoryVariables.selectedStockTypeId,
              "locationId": mainVariables.inventoryVariables.selectedLocationId,
              "categoryId": mainVariables.inventoryVariables.selectedChoiceChip.value.value,
              "searchQuery": "",
              "filter": mainVariables.inventoryVariables.selectedFilterType,
            }).onError((error, stackTrace) {
              emit(InventoryFailure(errorMessage: error.toString()));
              emit(const InventoryLoading());
            }).then((value) async {
              if (value != null) {
                InventoryProductListModel getInventoryProductsListResponse = InventoryProductListModel.fromJson(value);
                if (getInventoryProductsListResponse.status) {
                  if (getInventoryProductsListResponse.products.isEmpty) {
                    mainVariables.inventoryVariables.products.clear();
                    mainVariables.inventoryVariables.transitList.clear();
                    mainVariables.inventoryVariables.productDataList.clear();
                    mainVariables.inventoryVariables.shortageDataList.clear();
                    mainVariables.inventoryVariables.locationCount =
                        List.generate(mainVariables.stockMovementVariables.senderInfo.locationDropDownList.length, (index) => 0);
                  } else {
                    mainVariables.inventoryVariables.products.clear();
                    mainVariables.inventoryVariables.products = getInventoryProductsListResponse.products;
                    mainVariables.inventoryVariables.selectedProductId = mainVariables.inventoryVariables.products[0].productId;
                    mainVariables.inventoryVariables.selectedProductName = mainVariables.inventoryVariables.products[0].productName;
                    await mainVariables.repoImpl
                        .getProductTransitList(query: {
                          "stockType": mainVariables.inventoryVariables.selectedStockTypeId,
                          "locationId": mainVariables.inventoryVariables.selectedLocationId,
                          "categoryId": mainVariables.inventoryVariables.selectedChoiceChip.value.value,
                          "productId": mainVariables.inventoryVariables.products[0].productId
                        })
                        .onError((error, stackTrace) {})
                        .then((value) {
                          ProductTransitListModel productTransitListModel = ProductTransitListModel.fromJson(value);
                          if (productTransitListModel.status) {
                            if (productTransitListModel.stockMovements.isEmpty) {
                              mainVariables.inventoryVariables.transitList.clear();
                              mainVariables.inventoryVariables.transitList = [];
                            } else {
                              mainVariables.inventoryVariables.transitList.clear();
                              mainVariables.inventoryVariables.transitList = productTransitListModel.stockMovements;
                            }
                          } else {
                            mainVariables.inventoryVariables.transitList.clear();
                            mainVariables.inventoryVariables.transitList = [];
                          }
                        });
                    await mainVariables.repoImpl
                        .productCountByLocation(query: {
                          "stockType": mainVariables.inventoryVariables.selectedStockTypeId,
                          "locationId": mainVariables.inventoryVariables.selectedLocationId,
                          "categoryId": mainVariables.inventoryVariables.selectedChoiceChip.value.value,
                          "productId": mainVariables.inventoryVariables.products[0].productId,
                        })
                        .onError((error, stackTrace) {})
                        .then((value) {
                          ProductCountInventoryModel productCountByLocationModel = ProductCountInventoryModel.fromJson(value);
                          if (productCountByLocationModel.status) {
                            if (productCountByLocationModel.locations.isEmpty) {
                              mainVariables.inventoryVariables.locationCount = List.generate(
                                  mainVariables.stockMovementVariables.senderInfo.locationDropDownList.length, (index) => 0);
                            } else {
                              List<String> locationIdList = List.generate(
                                  mainVariables.stockMovementVariables.senderInfo.locationDropDownList.length,
                                  (index) => mainVariables.stockMovementVariables.senderInfo.locationDropDownList[index].value);
                              mainVariables.inventoryVariables.locationCount = List.generate(
                                  mainVariables.stockMovementVariables.senderInfo.locationDropDownList.length, (index) => 0);
                              for (int j = 0; j < productCountByLocationModel.locations.length; j++) {
                                if (locationIdList.contains(productCountByLocationModel.locations[j].locationId)) {
                                  mainVariables.inventoryVariables
                                          .locationCount[locationIdList.indexOf(productCountByLocationModel.locations[j].locationId)] =
                                      productCountByLocationModel.locations[j].totalQuantity;
                                }
                              }
                            }
                          } else {
                            mainVariables.inventoryVariables.locationCount = List.generate(
                                mainVariables.stockMovementVariables.senderInfo.locationDropDownList.length, (index) => 0);
                          }
                        });
                    await mainVariables.repoImpl
                        .productDetailsByProduct(query: {
                          "stockType": mainVariables.inventoryVariables.selectedStockTypeId,
                          "locationId": mainVariables.inventoryVariables.selectedLocationId,
                          "categoryId": mainVariables.inventoryVariables.selectedChoiceChip.value.value,
                          "productId": mainVariables.inventoryVariables.products[0].productId,
                        })
                        .onError((error, stackTrace) {})
                        .then((value) {
                          ProductDetailInventoryModel productDetailInventoryModel = ProductDetailInventoryModel.fromJson(value);
                          if (productDetailInventoryModel.status) {
                            mainVariables.inventoryVariables.minimumLevelCount = productDetailInventoryModel.minLevel;
                            if (productDetailInventoryModel.productDetails.isEmpty) {
                              mainVariables.inventoryVariables.productDataList.clear();
                              mainVariables.inventoryVariables.productDataList = [];
                            } else {
                              mainVariables.inventoryVariables.productDataList.clear();
                              for (int i = 0; i < productDetailInventoryModel.productDetails.length; i++) {
                                InventoryProductsChangeModel inventoryProductsChangeModel =
                                    InventoryProductsChangeModel.fromJson(productDetailInventoryModel.productDetails[i].toJson());
                                mainVariables.inventoryVariables.productDataList.add(
                                    inventoryProductsChangeModel.toJson().entries.map((entry) => (entry.value.toString())).toList());
                              }
                              if (updatedInventoryCartList.isNotEmpty) {
                                for (int i = 0; i < mainVariables.inventoryVariables.productDataList.length; i++) {
                                  if (updatedInventoryIdsList.contains(mainVariables.inventoryVariables.productDataList[i][5])) {
                                    int inventoryIndex = updatedInventoryCartList.indexWhere(
                                            (e) => e["inventoryId"] == mainVariables.inventoryVariables.productDataList[i][5]);
                                    mainVariables.inventoryVariables.productDataList[i][3] =
                                        (num.parse(mainVariables.inventoryVariables.productDataList[i][3]) -
                                            num.parse(updatedInventoryCartList[inventoryIndex]["quantityDelta"].toString()))
                                            .toString();
                                    mainVariables.inventoryVariables.productDataList[i][6] =
                                        (num.parse(mainVariables.inventoryVariables.productDataList[i][6]) +
                                            num.parse(updatedInventoryCartList[inventoryIndex]["quantityDelta"].toString()))
                                            .toString();
                                  }
                                }
                              }
                            }
                          } else {
                            mainVariables.inventoryVariables.productDataList.clear();
                            mainVariables.inventoryVariables.productDataList = [];
                          }
                        });
                    await mainVariables.repoImpl
                        .shortageDetailsByProduct(query: {
                          "stockType": mainVariables.inventoryVariables.selectedStockTypeId,
                          "locationId": mainVariables.inventoryVariables.selectedLocationId,
                          "categoryId": mainVariables.inventoryVariables.selectedChoiceChip.value.value,
                          "productId": mainVariables.inventoryVariables.products[0].productId,
                        })
                        .onError((error, stackTrace) {})
                        .then((value) {
                          ShortageDetailInventoryModel shortageDetailInventoryModel = ShortageDetailInventoryModel.fromJson(value);
                          if (shortageDetailInventoryModel.status) {
                            if (shortageDetailInventoryModel.disputes.isEmpty) {
                              mainVariables.inventoryVariables.shortageDataList.clear();
                              mainVariables.inventoryVariables.shortageDataList = [];
                            } else {
                              mainVariables.inventoryVariables.shortageDataList.clear();
                              for (int i = 0; i < shortageDetailInventoryModel.disputes.length; i++) {
                                InventoryShortageChangeModel inventoryShortageChangeModel =
                                    InventoryShortageChangeModel.fromJson(shortageDetailInventoryModel.disputes[i].toJson());
                                mainVariables.inventoryVariables.shortageDataList.add(
                                    inventoryShortageChangeModel.toJson().entries.map((entry) => (entry.value.toString())).toList());
                              }
                            }
                          } else {
                            mainVariables.inventoryVariables.shortageDataList.clear();
                            mainVariables.inventoryVariables.shortageDataList = [];
                          }
                        });
                    if (mainVariables.inventoryVariables.selectedLocationId != "") {
                      cartDetailsModel = CartDetailsModel.fromJson(await mainVariables.repoImpl
                          .getCart(query: {"locationId": mainVariables.inventoryVariables.selectedLocationId}));
                    }
                  }
                  event.modelSetState(() {});
                  emit(const InventoryDummy());
                  emit(const InventoryLoaded());
                } else {
                  emit(InventoryFailure(errorMessage: getInventoryProductsListResponse.message));
                  emit(const InventoryLoading());
                }
              }
            });
          }
        }
      }
    });
  }

  Map<String, Map<String, List<ProductList>>> groupProductsByStockAndCategory(List<ProductList> products) {
    final Map<String, Map<String, List<ProductList>>> grouped = {};
    for (var product in products) {
      final stockType = product.stockType;
      final categoryId = product.categoryId;
      grouped.putIfAbsent(stockType, () => {});
      grouped[stockType]!.putIfAbsent(categoryId, () => []);
      grouped[stockType]![categoryId]!.add(product);
    }
    return grouped;
  }

  FutureOr<void> inventoryUpdateDataFunction(InventoryUpdateDataEvent event, Emitter<InventoryState> emit) async {
    List<String> keysList = ["current_stock", "food_items_&_disposables", "unused_stock"];
    int indexValue = keysList.indexOf(searchGroupedList[stockTypeIndexSelected][categoryIndexSelected].stockType);
    mainVariables.inventoryVariables.tabControllerIndex = indexValue;
    mainVariables.inventoryVariables.tabsEnableList.clear();
    mainVariables.inventoryVariables.tabsEnableList = List.generate(3, (index) => false);
    mainVariables.inventoryVariables.tabsEnableList[indexValue] = true;
    mainVariables.inventoryVariables.selectedStockTypeId = searchGroupedList[stockTypeIndexSelected][categoryIndexSelected].stockType;
    mainVariables.inventoryVariables.tabPressed = true;
    await mainVariables.repoImpl.getInventoryCategory(query: {
      "stockType": mainVariables.inventoryVariables.selectedStockTypeId,
    }).onError((error, stackTrace) {
      emit(InventoryFailure(errorMessage: error.toString()));
      emit(const InventoryLoading());
    }).then((value) async {
      GetInventoryCategoryModel getInventoryCategoryModel = GetInventoryCategoryModel.fromJson(value);
      if (getInventoryCategoryModel.status) {
        mainVariables.inventoryVariables.categoryDropDownList.clear();
        for (int i = 0; i < getInventoryCategoryModel.categories.length; i++) {
          mainVariables.inventoryVariables.categoryDropDownList.add(DropDownValueModel(
              name: getInventoryCategoryModel.categories[i].name, value: getInventoryCategoryModel.categories[i].id));
        }
        if (mainVariables.inventoryVariables.categoryDropDownList.isNotEmpty) {
          mainVariables.inventoryVariables.selectedChoiceChip = mainVariables.inventoryVariables.categoryDropDownList
              .firstWhere((e) => e.value == searchGroupedList[stockTypeIndexSelected][categoryIndexSelected].categoryId)
              .obs;
          event.modelSetState(() {
            mainVariables.inventoryVariables.loader = true;
          });
          await mainVariables.repoImpl
              .getProductTransitList(query: {
                "stockType": mainVariables.inventoryVariables.selectedStockTypeId,
                "locationId": mainVariables.inventoryVariables.selectedLocationId,
                "categoryId": mainVariables.inventoryVariables.selectedChoiceChip.value.value,
                "productId": searchGroupedList[stockTypeIndexSelected][categoryIndexSelected].productId
              })
              .onError((error, stackTrace) {})
              .then((value) {
                ProductTransitListModel productTransitListModel = ProductTransitListModel.fromJson(value);
                if (productTransitListModel.status) {
                  if (productTransitListModel.stockMovements.isEmpty) {
                    mainVariables.inventoryVariables.transitList.clear();
                    mainVariables.inventoryVariables.transitList = [];
                  } else {
                    mainVariables.inventoryVariables.transitList.clear();
                    mainVariables.inventoryVariables.transitList = productTransitListModel.stockMovements;
                  }
                } else {
                  mainVariables.inventoryVariables.transitList.clear();
                  mainVariables.inventoryVariables.transitList = [];
                }
              });
          await mainVariables.repoImpl
              .productCountByLocation(query: {
                "stockType": mainVariables.inventoryVariables.selectedStockTypeId,
                "locationId": mainVariables.inventoryVariables.selectedLocationId,
                "categoryId": mainVariables.inventoryVariables.selectedChoiceChip.value.value,
                "productId": searchGroupedList[stockTypeIndexSelected][categoryIndexSelected].productId,
              })
              .onError((error, stackTrace) {})
              .then((value) {
                ProductCountInventoryModel productCountByLocationModel = ProductCountInventoryModel.fromJson(value);
                if (productCountByLocationModel.status) {
                  if (productCountByLocationModel.locations.isEmpty) {
                    mainVariables.inventoryVariables.locationCount =
                        List.generate(mainVariables.stockMovementVariables.senderInfo.locationDropDownList.length, (index) => 0);
                  } else {
                    List<String> locationIdList = List.generate(
                        mainVariables.stockMovementVariables.senderInfo.locationDropDownList.length,
                        (index) => mainVariables.stockMovementVariables.senderInfo.locationDropDownList[index].value);
                    mainVariables.inventoryVariables.locationCount =
                        List.generate(mainVariables.stockMovementVariables.senderInfo.locationDropDownList.length, (index) => 0);
                    for (int j = 0; j < productCountByLocationModel.locations.length; j++) {
                      if (locationIdList.contains(productCountByLocationModel.locations[j].locationId)) {
                        mainVariables.inventoryVariables
                                .locationCount[locationIdList.indexOf(productCountByLocationModel.locations[j].locationId)] =
                            productCountByLocationModel.locations[j].totalQuantity;
                      }
                    }
                  }
                } else {
                  mainVariables.inventoryVariables.locationCount =
                      List.generate(mainVariables.stockMovementVariables.senderInfo.locationDropDownList.length, (index) => 0);
                }
              });
          await mainVariables.repoImpl
              .productDetailsByProduct(query: {
                "stockType": mainVariables.inventoryVariables.selectedStockTypeId,
                "locationId": mainVariables.inventoryVariables.selectedLocationId,
                "categoryId": mainVariables.inventoryVariables.selectedChoiceChip.value.value,
                "productId": searchGroupedList[stockTypeIndexSelected][categoryIndexSelected].productId,
              })
              .onError((error, stackTrace) {})
              .then((value) {
                ProductDetailInventoryModel productDetailInventoryModel = ProductDetailInventoryModel.fromJson(value);
                if (productDetailInventoryModel.status) {
                  mainVariables.inventoryVariables.minimumLevelCount = productDetailInventoryModel.minLevel;
                  if (productDetailInventoryModel.productDetails.isEmpty) {
                    mainVariables.inventoryVariables.productDataList.clear();
                    mainVariables.inventoryVariables.productDataList = [];
                  } else {
                    mainVariables.inventoryVariables.productDataList.clear();
                    for (int i = 0; i < productDetailInventoryModel.productDetails.length; i++) {
                      InventoryProductsChangeModel inventoryProductsChangeModel =
                          InventoryProductsChangeModel.fromJson(productDetailInventoryModel.productDetails[i].toJson());
                      mainVariables.inventoryVariables.productDataList
                          .add(inventoryProductsChangeModel.toJson().entries.map((entry) => (entry.value.toString())).toList());
                    }
                    if (updatedInventoryCartList.isNotEmpty) {
                      for (int i = 0; i < mainVariables.inventoryVariables.productDataList.length; i++) {
                        if (updatedInventoryIdsList.contains(mainVariables.inventoryVariables.productDataList[i][5])) {
                          int inventoryIndex = updatedInventoryCartList.indexWhere(
                                  (e) => e["inventoryId"] == mainVariables.inventoryVariables.productDataList[i][5]);
                          mainVariables.inventoryVariables.productDataList[i][3] =
                              (num.parse(mainVariables.inventoryVariables.productDataList[i][3]) -
                                  num.parse(updatedInventoryCartList[inventoryIndex]["quantityDelta"].toString()))
                                  .toString();
                          mainVariables.inventoryVariables.productDataList[i][6] =
                              (num.parse(mainVariables.inventoryVariables.productDataList[i][6]) +
                                  num.parse(updatedInventoryCartList[inventoryIndex]["quantityDelta"].toString()))
                                  .toString();
                        }
                      }
                    }
                  }
                } else {
                  mainVariables.inventoryVariables.productDataList.clear();
                  mainVariables.inventoryVariables.productDataList = [];
                }
              });
          await mainVariables.repoImpl
              .shortageDetailsByProduct(query: {
                "stockType": mainVariables.inventoryVariables.selectedStockTypeId,
                "locationId": mainVariables.inventoryVariables.selectedLocationId,
                "categoryId": mainVariables.inventoryVariables.selectedChoiceChip.value.value,
                "productId": searchGroupedList[stockTypeIndexSelected][categoryIndexSelected].productId,
              })
              .onError((error, stackTrace) {})
              .then((value) {
                ShortageDetailInventoryModel shortageDetailInventoryModel = ShortageDetailInventoryModel.fromJson(value);
                if (shortageDetailInventoryModel.status) {
                  if (shortageDetailInventoryModel.disputes.isEmpty) {
                    mainVariables.inventoryVariables.shortageDataList.clear();
                    mainVariables.inventoryVariables.shortageDataList = [];
                  } else {
                    mainVariables.inventoryVariables.shortageDataList.clear();
                    for (int i = 0; i < shortageDetailInventoryModel.disputes.length; i++) {
                      InventoryShortageChangeModel inventoryShortageChangeModel =
                          InventoryShortageChangeModel.fromJson(shortageDetailInventoryModel.disputes[i].toJson());
                      mainVariables.inventoryVariables.shortageDataList
                          .add(inventoryShortageChangeModel.toJson().entries.map((entry) => (entry.value.toString())).toList());
                    }
                  }
                } else {
                  mainVariables.inventoryVariables.shortageDataList.clear();
                  mainVariables.inventoryVariables.shortageDataList = [];
                }
              });
          if (mainVariables.inventoryVariables.selectedLocationId != "") {
            cartDetailsModel = CartDetailsModel.fromJson(
                await mainVariables.repoImpl.getCart(query: {"locationId": mainVariables.inventoryVariables.selectedLocationId}));
          }
        }
      }
    });
    event.modelSetState(() {});
    emit(const InventoryDummy());
    emit(const InventoryLoaded());
  }

  /*Future<FutureOr<void>> getCartFunction(GetCartEvent event, Emitter<InventoryState> emit) async {
    emit(const InventoryCartLoading());
    await mainVariables.repoImpl
        .getCart(query: {"locationId": mainVariables.inventoryVariables.selectedLocationId}).onError((error, stackTrace) {
      emit(InventoryFailure(errorMessage: error.toString()));
      emit(const InventoryLoading());
    }).then((value) async {
      cartDetailsModel = CartDetailsModel.fromJson(value);
      emit(const InventoryCartLoaded());
    });
  }*/

  FutureOr<void> cartActionFunction(CartActionEvent event, Emitter<InventoryState> emit) async {
    await mainVariables.repoImpl
        .cartAction(query: {"cartId": event.cardId, "status": event.action, "remarks": event.remarks}).onError((error, stackTrace) {
      emit(InventoryFailure(errorMessage: error.toString()));
      emit(const InventoryLoaded());
    }).then((value) async {
      if(value!=null){
        if(value["status"]){
          cartPageEnabled = !cartPageEnabled;
          cartRemarksController = TextEditingController();
          switch(event.action){
            case "consumed":{
              mainWidgets.flushBarWidget(context: event.context, message: "This Items are successfully marked as consumed");
            }
            case "expired":{
              mainWidgets.flushBarWidget(context: event.context, message: "This Items are successfully marked as expired");
            }
            case "deleted":{
              mainWidgets.flushBarWidget(context: event.context, message: "This Items are successfully marked as deleted");
            }
            default:{mainWidgets.flushBarWidget(context: event.context, message: "This Items are successfully marked as consumed");}
          }
          await inventoryCartUpdateFunction();
          event.modelSetState((){});
        }
      }
    });
  }

  FutureOr<void> updateCartFunction(UpdateCartEvent event, Emitter<InventoryState> emit) async {
    await mainVariables.repoImpl.updateCart(query: {
      "locationId": mainVariables.inventoryVariables.selectedLocationId,
      "items": updatedInventoryCartList
    }).onError((error, stackTrace) {
      emit(InventoryFailure(errorMessage: error.toString()));
      emit(const InventoryLoading());
    }).then((value) async {
      if (value != null) {
        if(value["status"]){
          updatedInventoryCartList.clear();
          updatedInventoryIdsList.clear();
          mainWidgets.flushBarWidget(context: event.context, message: "Cart has updated successfully");
          await inventoryCartUpdateFunction();
          event.modelSetState((){});
        }
      }
    });
  }

  inventoryCartUpdateFunction()async{
    mainVariables.inventoryVariables.selectedListIndex = 0;
    await mainVariables.repoImpl.getInventoryCategory(query: {
      "stockType": mainVariables.inventoryVariables.selectedStockTypeId,
    }).then((value) async {
      if (value != null) {
        GetInventoryCategoryModel getInventoryCategoryModel = GetInventoryCategoryModel.fromJson(value);
        if (getInventoryCategoryModel.status) {
          mainVariables.inventoryVariables.categoryDropDownList.clear();
          for (int i = 0; i < getInventoryCategoryModel.categories.length; i++) {
            mainVariables.inventoryVariables.categoryDropDownList.add(DropDownValueModel(
                name: getInventoryCategoryModel.categories[i].name, value: getInventoryCategoryModel.categories[i].id));
          }
          if (mainVariables.inventoryVariables.categoryDropDownList.isNotEmpty) {
            if (mainVariables.inventoryVariables.tabPressed) {
              mainVariables.inventoryVariables.selectedChoiceChip.value = mainVariables.inventoryVariables.categoryDropDownList[0];
              mainVariables.inventoryVariables.tabPressed = false;
            }
            await mainVariables.repoImpl.getInventoryProductsList(query: {
              "stockType": mainVariables.inventoryVariables.selectedStockTypeId,
              "locationId": mainVariables.inventoryVariables.selectedLocationId,
              "categoryId": mainVariables.inventoryVariables.selectedChoiceChip.value.value,
              "searchQuery": mainVariables.inventoryVariables.searchBar.text,
              "filter": mainVariables.inventoryVariables.selectedFilterType,
            }).then((value) async {
              if (value != null) {
                InventoryProductListModel getInventoryProductsListResponse = InventoryProductListModel.fromJson(value);
                if (getInventoryProductsListResponse.status) {
                  if (getInventoryProductsListResponse.products.isEmpty) {
                    mainVariables.inventoryVariables.products.clear();
                    mainVariables.inventoryVariables.transitList.clear();
                    mainVariables.inventoryVariables.productDataList.clear();
                    mainVariables.inventoryVariables.shortageDataList.clear();
                    mainVariables.inventoryVariables.locationCount =
                        List.generate(mainVariables.stockMovementVariables.senderInfo.locationDropDownList.length, (index) => 0);
                  }
                  else {
                    mainVariables.inventoryVariables.products.clear();
                    mainVariables.inventoryVariables.products = getInventoryProductsListResponse.products;
                    mainVariables.inventoryVariables.selectedProductId = mainVariables.inventoryVariables.products[0].productId;
                    mainVariables.inventoryVariables.selectedProductName = mainVariables.inventoryVariables.products[0].productName;
                    mainVariables.inventoryVariables.selectedProductHasExpiry = mainVariables.inventoryVariables.products[0].hasExpiry;
                    await mainVariables.repoImpl
                        .getProductTransitList(query: {
                      "stockType": mainVariables.inventoryVariables.selectedStockTypeId,
                      "locationId": mainVariables.inventoryVariables.selectedLocationId,
                      "categoryId": mainVariables.inventoryVariables.selectedChoiceChip.value.value,
                      "productId": mainVariables.inventoryVariables.products[0].productId
                    })
                        .onError((error, stackTrace) {})
                        .then((value) {
                      ProductTransitListModel productTransitListModel = ProductTransitListModel.fromJson(value);
                      if (productTransitListModel.status) {
                        if (productTransitListModel.stockMovements.isEmpty) {
                          mainVariables.inventoryVariables.transitList.clear();
                          mainVariables.inventoryVariables.transitList = [];
                        } else {
                          mainVariables.inventoryVariables.transitList.clear();
                          mainVariables.inventoryVariables.transitList = productTransitListModel.stockMovements;
                        }
                      } else {
                        mainVariables.inventoryVariables.transitList.clear();
                        mainVariables.inventoryVariables.transitList = [];
                      }
                    });
                    await mainVariables.repoImpl
                        .productCountByLocation(query: {
                      "stockType": mainVariables.inventoryVariables.selectedStockTypeId,
                      "locationId": mainVariables.inventoryVariables.selectedLocationId,
                      "categoryId": mainVariables.inventoryVariables.selectedChoiceChip.value.value,
                      "productId": mainVariables.inventoryVariables.products[0].productId,
                    })
                        .onError((error, stackTrace) {})
                        .then((value) {
                      ProductCountInventoryModel productCountByLocationModel = ProductCountInventoryModel.fromJson(value);
                      if (productCountByLocationModel.status) {
                        List<String> locationIdList = List.generate(
                            mainVariables.stockMovementVariables.senderInfo.locationDropDownList.length,
                                (index) => mainVariables.stockMovementVariables.senderInfo.locationDropDownList[index].value);
                        mainVariables.inventoryVariables.locationCount = List.generate(
                            mainVariables.stockMovementVariables.senderInfo.locationDropDownList.length, (index) => 0);
                        if (productCountByLocationModel.locations.isEmpty) {
                          mainVariables.inventoryVariables.locationCount = List.generate(
                              mainVariables.stockMovementVariables.senderInfo.locationDropDownList.length, (index) => 0);
                        } else {
                          for (int j = 0; j < productCountByLocationModel.locations.length; j++) {
                            if (locationIdList.contains(productCountByLocationModel.locations[j].locationId)) {
                              mainVariables.inventoryVariables
                                  .locationCount[locationIdList.indexOf(productCountByLocationModel.locations[j].locationId)] =
                                  productCountByLocationModel.locations[j].totalQuantity;
                            }
                          }
                        }
                      } else {
                        mainVariables.inventoryVariables.locationCount = List.generate(
                            mainVariables.stockMovementVariables.senderInfo.locationDropDownList.length, (index) => 0);
                      }
                    });
                    await mainVariables.repoImpl
                        .productDetailsByProduct(query: {
                      "stockType": mainVariables.inventoryVariables.selectedStockTypeId,
                      "locationId": mainVariables.inventoryVariables.selectedLocationId,
                      "categoryId": mainVariables.inventoryVariables.selectedChoiceChip.value.value,
                      "productId": mainVariables.inventoryVariables.products[0].productId,
                    })
                        .onError((error, stackTrace) {})
                        .then((value) {
                      ProductDetailInventoryModel productDetailInventoryModel = ProductDetailInventoryModel.fromJson(value);
                      if (productDetailInventoryModel.status) {
                        mainVariables.inventoryVariables.minimumLevelCount = productDetailInventoryModel.minLevel;
                        if (productDetailInventoryModel.productDetails.isEmpty) {
                          mainVariables.inventoryVariables.productDataList.clear();
                          mainVariables.inventoryVariables.productDataList = [];
                        } else {
                          mainVariables.inventoryVariables.productDataList.clear();
                          for (int i = 0; i < productDetailInventoryModel.productDetails.length; i++) {
                            InventoryProductsChangeModel inventoryProductsChangeModel =
                            InventoryProductsChangeModel.fromJson(productDetailInventoryModel.productDetails[i].toJson());
                            mainVariables.inventoryVariables.productDataList.add(
                                inventoryProductsChangeModel.toJson().entries.map((entry) => (entry.value.toString())).toList());
                          }
                          if (updatedInventoryCartList.isNotEmpty) {
                            for (int i = 0; i < mainVariables.inventoryVariables.productDataList.length; i++) {
                              if (updatedInventoryIdsList.contains(mainVariables.inventoryVariables.productDataList[i][5])) {
                                int inventoryIndex = updatedInventoryCartList.indexWhere(
                                        (e) => e["inventoryId"] == mainVariables.inventoryVariables.productDataList[i][5]);
                                mainVariables.inventoryVariables.productDataList[i][3] =
                                    (num.parse(mainVariables.inventoryVariables.productDataList[i][3]) -
                                        num.parse(updatedInventoryCartList[inventoryIndex]["quantityDelta"].toString()))
                                        .toString();
                                mainVariables.inventoryVariables.productDataList[i][6] =
                                    (num.parse(mainVariables.inventoryVariables.productDataList[i][6]) +
                                        num.parse(updatedInventoryCartList[inventoryIndex]["quantityDelta"].toString()))
                                        .toString();
                              }
                            }
                          }
                        }
                      } else {
                        mainVariables.inventoryVariables.productDataList.clear();
                        mainVariables.inventoryVariables.productDataList = [];
                      }
                    });
                    await mainVariables.repoImpl
                        .shortageDetailsByProduct(query: {
                      "stockType": mainVariables.inventoryVariables.selectedStockTypeId,
                      "locationId": mainVariables.inventoryVariables.selectedLocationId,
                      "categoryId": mainVariables.inventoryVariables.selectedChoiceChip.value.value,
                      "productId": mainVariables.inventoryVariables.products[0].productId,
                    })
                        .onError((error, stackTrace) {})
                        .then((value) {
                      ShortageDetailInventoryModel shortageDetailInventoryModel = ShortageDetailInventoryModel.fromJson(value);
                      if (shortageDetailInventoryModel.status) {
                        if (shortageDetailInventoryModel.disputes.isEmpty) {
                          mainVariables.inventoryVariables.shortageDataList.clear();
                          mainVariables.inventoryVariables.shortageDataList = [];
                        } else {
                          mainVariables.inventoryVariables.shortageDataList.clear();
                          for (int i = 0; i < shortageDetailInventoryModel.disputes.length; i++) {
                            InventoryShortageChangeModel inventoryShortageChangeModel =
                            InventoryShortageChangeModel.fromJson(shortageDetailInventoryModel.disputes[i].toJson());
                            mainVariables.inventoryVariables.shortageDataList.add(
                                inventoryShortageChangeModel.toJson().entries.map((entry) => (entry.value.toString())).toList());
                          }
                        }
                      } else {
                        mainVariables.inventoryVariables.shortageDataList.clear();
                        mainVariables.inventoryVariables.shortageDataList = [];
                      }
                    });
                    if (mainVariables.inventoryVariables.selectedLocationId != "") {
                      cartDetailsModel = CartDetailsModel.fromJson(await mainVariables.repoImpl
                          .getCart(query: {"locationId": mainVariables.inventoryVariables.selectedLocationId}));
                    }
                  }
                }
              }
            });
          }
        }
      }
    });
  }
}
