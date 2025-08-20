import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:tvsaviation/data/model/api_model/get_inventory_model.dart';
import 'package:tvsaviation/data/model/variable_model/inventory_change_model.dart';
import 'package:tvsaviation/resources/constants.dart';
import 'package:tvsaviation/resources/drop_down_lib/dropdown_textfield.dart';

part 'stock_movement_event.dart';
part 'stock_movement_state.dart';

class StockMovementBloc extends Bloc<StockMovementEvent, StockMovementState> {
  StockMovementBloc() : super(const StockMovementLoading()) {
    on<StockMovementInitialEvent>(initialFunction);
    on<StockMovementTableChangingEvent>(tableChangingFunction);
  }

  FutureOr<void> initialFunction(StockMovementInitialEvent event, Emitter<StockMovementState> emit) async {
    emit(const StockMovementLoading());
    mainVariables.stockMovementVariables.selectedProductsList = mainVariables.stockMovementVariables.sendData.inventories.isEmpty ? [] : mainVariables.stockMovementVariables.sendData.inventories;
    mainVariables.stockMovementVariables.senderInfo.senderStockTypeChoose =
        mainVariables.stockMovementVariables.senderInfo.senderStockTypeChoose.value == "" ? mainVariables.stockMovementVariables.senderInfo.stockTypeDropDownList[0] : mainVariables.stockMovementVariables.senderInfo.senderStockTypeChoose;
    mainVariables.stockMovementVariables.sendData.senderStockType = mainVariables.stockMovementVariables.senderInfo.senderStockTypeChoose.value;
    mainVariables.stockMovementVariables.receiverInfo.receiverType = mainVariables.stockMovementVariables.receiverInfo.receiverType == "Crew" ? "Crew" : "Handler";
    mainVariables.stockMovementVariables.sendData.receiverType = mainVariables.stockMovementVariables.receiverInfo.receiverType;
    if (mainVariables.stockMovementVariables.sendData.receiverType == "Crew") {
      mainVariables.stockMovementVariables.receiverInfo.crewChoose = const DropDownValueModel(name: "N/A", value: "");
      mainVariables.stockMovementVariables.sendData.receiverName = mainVariables.stockMovementVariables.receiverInfo.crewChoose.value;
      mainVariables.stockMovementVariables.receiverInfo.receiverStockTypeChoose =
          mainVariables.stockMovementVariables.receiverInfo.receiverStockTypeChoose.value == "" ? mainVariables.stockMovementVariables.senderInfo.stockTypeDropDownList[0] : mainVariables.stockMovementVariables.receiverInfo.receiverStockTypeChoose;
      mainVariables.stockMovementVariables.sendData.receiverStockType = mainVariables.stockMovementVariables.receiverInfo.receiverStockTypeChoose.value;
    } else {
      mainVariables.stockMovementVariables.receiverInfo.handlerChoose = mainVariables.stockMovementVariables.receiverInfo.handlerChoose.value == "" ? DropDownValueModel.fromJson(const {}) : mainVariables.stockMovementVariables.receiverInfo.handlerChoose;
      mainVariables.stockMovementVariables.sendData.receiverName = mainVariables.stockMovementVariables.receiverInfo.handlerChoose.value;
    }
    mainVariables.stockMovementVariables.senderInfo.senderFromSectorChoose = mainVariables.stockMovementVariables.sendData.sectorFrom == "" ? DropDownValueModel.fromJson(const {}) : mainVariables.stockMovementVariables.senderInfo.senderFromSectorChoose;
    mainVariables.stockMovementVariables.senderInfo.senderToSectorChoose = mainVariables.stockMovementVariables.sendData.sectorTo == "" ? DropDownValueModel.fromJson(const {}) : mainVariables.stockMovementVariables.senderInfo.senderToSectorChoose;
    mainVariables.stockMovementVariables.onTappedRegion = false.obs;
    if (mainVariables.stockMovementVariables.stockMovementExit == false) {
      mainVariables.stockMovementVariables.selectedProductsList.clear();
      mainVariables.stockMovementVariables.searchBar.clear();
      mainVariables.stockMovementVariables.selectedProductsIdList.clear();
      mainVariables.stockMovementVariables.selectedQuantityList.clear();
      mainVariables.confirmMovementVariables.stockMovementInventory.tableData.clear();
      mainVariables.stockMovementVariables.stockMovementExit = true;
      mainVariables.stockMovementVariables.currentPage = 1;
      await mainVariables.repoImpl.getInventory(query: {
        "query": "",
        "locationId": mainVariables.stockMovementVariables.senderInfo.senderLocationChoose.value,
        "stockType": mainVariables.stockMovementVariables.senderInfo.senderStockTypeChoose.value,
        "page": "1",
        "limit": "9",
      }).onError((error, stackTrace) {
        emit(StockMovementFailure(errorMessage: error.toString()));
        emit(const StockMovementLoading());
      }).then((value) async {
        if (value != null) {
          GetInventoryModel getInventoryResponse = GetInventoryModel.fromJson(value);
          mainVariables.stockMovementVariables.stockMovementInventory.tableData.clear();
          if (getInventoryResponse.status) {
            emit(const StockMovementDummy());
            emit(const StockMovementLoaded());
          } else {
            emit(StockMovementFailure(errorMessage: getInventoryResponse.message));
            emit(const StockMovementLoading());
          }
        }
      });
    } else {
      emit(const StockMovementDummy());
      emit(const StockMovementLoaded());
    }
  }

  FutureOr<void> tableChangingFunction(StockMovementTableChangingEvent event, Emitter<StockMovementState> emit) async {
    await mainVariables.repoImpl.getInventory(query: {
      "query": mainVariables.stockMovementVariables.searchBar.text,
      "locationId": mainVariables.stockMovementVariables.senderInfo.senderLocationChoose.value,
      "stockType": mainVariables.stockMovementVariables.senderInfo.senderStockTypeChoose.value,
      "page": mainVariables.stockMovementVariables.currentPage.toString(),
      "limit": "9",
    }).onError((error, stackTrace) {
      emit(StockMovementFailure(errorMessage: error.toString()));
      emit(const StockMovementLoading());
    }).then((value) async {
      if (value != null) {
        GetInventoryModel getInventoryResponse = GetInventoryModel.fromJson(value);
        mainVariables.stockMovementVariables.stockMovementInventory.tableData.clear();
        if (getInventoryResponse.status) {
          mainVariables.stockMovementVariables.totalPages = getInventoryResponse.totalPages;
          if (mainVariables.stockMovementVariables.selectedProductsIdList.isEmpty) {
            for (int i = 0; i < getInventoryResponse.inventory.length; i++) {
              InventoryChangeModel inventoryChangeModel = InventoryChangeModel.fromJson(getInventoryResponse.inventory[i].toJson());
              mainVariables.stockMovementVariables.stockMovementInventory.tableData.add(inventoryChangeModel.toJson().entries.map((entry) => (entry.value.toString())).toList());
            }
          } else {
            for (int i = 0; i < getInventoryResponse.inventory.length; i++) {
              InventoryChangeModel inventoryChangeModel = InventoryChangeModel.fromJson(getInventoryResponse.inventory[i].toJson());
              for (int j = 0; j < mainVariables.stockMovementVariables.selectedProductsIdList.length; j++) {
                if (getInventoryResponse.inventory[i].id == mainVariables.stockMovementVariables.selectedProductsIdList[j]) {
                  inventoryChangeModel.addQuantity = mainVariables.stockMovementVariables.selectedQuantityList[mainVariables.stockMovementVariables.selectedProductsIdList.indexOf(getInventoryResponse.inventory[i].id)];
                }
              }
              mainVariables.stockMovementVariables.stockMovementInventory.tableData.add(inventoryChangeModel.toJson().entries.map((entry) => (entry.value.toString())).toList());
            }
          }
          emit(const StockMovementDummy());
          emit(const StockMovementLoaded());
        } else {
          emit(StockMovementFailure(errorMessage: getInventoryResponse.message));
          emit(const StockMovementLoading());
        }
      }
    });
  }
}
