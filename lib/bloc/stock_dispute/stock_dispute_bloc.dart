import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:tvsaviation/data/model/api_model/get_inventory_model.dart';
import 'package:tvsaviation/data/model/variable_model/inventory_change_model.dart';
import 'package:tvsaviation/resources/constants.dart';

part 'stock_dispute_event.dart';
part 'stock_dispute_state.dart';

class StockDisputeBloc extends Bloc<StockDisputeEvent, StockDisputeState> {
  StockDisputeBloc() : super(const StockDisputeLoading()) {
    on<StockDisputeInitialEvent>(initialFunction);
    on<StockDisputeTableChangingEvent>(tableChangingFunction);
    on<StockDisputeCreateEvent>(stockDisputeCreateFunction);
  }

  FutureOr<void> initialFunction(StockDisputeInitialEvent event, Emitter<StockDisputeState> emit) async {
    emit(const StockDisputeLoading());
    if (mainVariables.receivedStocksVariables.pageState == "transit") {
      emit(const StockDisputeDummy());
      emit(const StockDisputeLoaded());
    } else {
      if (mainVariables.stockDisputeVariables.stockDisputeExit == false) {
        mainVariables.stockDisputeVariables.selectedProductsList.clear();
        mainVariables.stockDisputeVariables.selectedProductsIdList.clear();
        mainVariables.stockDisputeVariables.selectedQuantityList.clear();
        mainVariables.addDisputeVariables.stockDisputeInventory.tableData.clear();
        mainVariables.stockDisputeVariables.stockDisputeExit = true;
        mainVariables.stockDisputeVariables.numberController = NumberPaginatorController();
        mainVariables.stockDisputeVariables.numberController!.currentPage = 0;
        await mainVariables.repoImpl.getInventory(query: {
          "query": "",
          "locationId": "",
          "stockType": "",
          "page": "1",
          "limit": "10",
        }).onError((error, stackTrace) {
          emit(StockDisputeFailure(errorMessage: error.toString()));
          emit(const StockDisputeLoading());
        }).then((value) async {
          if (value != null) {
            GetInventoryModel getInventoryResponse = GetInventoryModel.fromJson(value);
            mainVariables.stockDisputeVariables.stockDisputeInventory.tableData.clear();
            if (getInventoryResponse.status) {
              emit(const StockDisputeDummy());
              emit(const StockDisputeLoaded());
            } else {
              emit(StockDisputeFailure(errorMessage: getInventoryResponse.message));
              emit(const StockDisputeLoading());
            }
          }
        });
      } else {
        mainVariables.stockDisputeVariables.numberController!.currentPage = mainVariables.stockDisputeVariables.currentPage - 1;
        emit(const StockDisputeLoaded());
      }
    }
  }

  FutureOr<void> tableChangingFunction(StockDisputeTableChangingEvent event, Emitter<StockDisputeState> emit) async {
    await mainVariables.repoImpl.getInventory(query: {
      "query": mainVariables.stockDisputeVariables.searchBar.text,
      "locationId": mainVariables.stockDisputeVariables.senderLocationChoose.value,
      "stockType": "",
      "page": mainVariables.stockDisputeVariables.currentPage.toString(),
      "limit": "10",
    }).onError((error, stackTrace) {
      emit(StockDisputeFailure(errorMessage: error.toString()));
      emit(const StockDisputeLoading());
    }).then((value) async {
      if (value != null) {
        GetInventoryModel getInventoryResponse = GetInventoryModel.fromJson(value);
        mainVariables.stockDisputeVariables.stockDisputeInventory.tableData.clear();
        if (getInventoryResponse.status) {
          mainVariables.stockDisputeVariables.totalPages = getInventoryResponse.totalPages == 0 ? 1 : getInventoryResponse.totalPages;
          for (int i = 0; i < getInventoryResponse.inventory.length; i++) {
            InventoryChangeModel inventoryChangeModel = InventoryChangeModel.fromJson(getInventoryResponse.inventory[i].toJson());
            mainVariables.stockDisputeVariables.stockDisputeInventory.tableData.add(inventoryChangeModel.toJson().entries.map((entry) => (entry.value.toString())).toList());
          }
          emit(const StockDisputeDummy());
          emit(const StockDisputeLoaded());
        } else {
          emit(StockDisputeFailure(errorMessage: getInventoryResponse.message));
          emit(const StockDisputeLoading());
        }
      }
    });
  }

  FutureOr<void> stockDisputeCreateFunction(StockDisputeCreateEvent event, Emitter<StockDisputeState> emit) async {
    if (mainVariables.stockDisputeVariables.sendData.products[0].quantity == 0) {
      emit(const StockDisputeFailure(errorMessage: "Dispute quantity cant be zero, please add the quantity count"));
      emit(const StockDisputeLoaded());
    } else {
      await mainVariables.repoImpl.addDispute(query: mainVariables.stockDisputeVariables.sendData.toJson()).onError((error, stackTrace) {
        emit(StockDisputeFailure(errorMessage: error.toString()));
        emit(const StockDisputeLoaded());
      }).then((value) async {
        if (value != null) {
          if (value["status"]) {
            mainVariables.receivedStocksVariables.receivedStocksInventory.tableData[mainVariables.generalVariables.selectedProductIndexForDispute][9] = "yes";
            List<String> dataList = List.generate(mainVariables.receivedStocksVariables.receivedStocksInventory.tableData[mainVariables.generalVariables.selectedProductIndexForDispute].length,
                (index) => mainVariables.receivedStocksVariables.receivedStocksInventory.tableData[mainVariables.generalVariables.selectedProductIndexForDispute][index]);
            mainVariables.receivedStocksVariables.receivedStocksDisputes.tableData.add(dataList);
            mainVariables.receivedStocksVariables.receivedStocksInventory.tableData[mainVariables.generalVariables.selectedProductIndexForDispute][6] =
                (int.parse(mainVariables.receivedStocksVariables.receivedStocksInventory.tableData[mainVariables.generalVariables.selectedProductIndexForDispute][6]) - mainVariables.stockDisputeVariables.sendData.products[0].quantity).toString();
            mainVariables.receivedStocksVariables.receivedStocksDisputes.tableData[mainVariables.receivedStocksVariables.receivedStocksDisputes.tableData.length - 1][6] = mainVariables.stockDisputeVariables.sendData.products[0].quantity.toString();
            mainVariables.receivedStocksVariables.totalQuantity = (int.parse(mainVariables.receivedStocksVariables.totalQuantity) - mainVariables.stockDisputeVariables.sendData.products[0].quantity).toString();
            mainVariables.receivedStocksVariables.totalDisputeProducts = (int.parse(mainVariables.receivedStocksVariables.totalDisputeProducts) + 1).toString();
            mainVariables.receivedStocksVariables.totalDisputeQuantity = (int.parse(mainVariables.receivedStocksVariables.totalDisputeQuantity) + mainVariables.stockDisputeVariables.selectedProductsList[0].quantity).toString();
            mainVariables.receivedStocksVariables.receivedStocksDisputes.tableData[mainVariables.receivedStocksVariables.receivedStocksDisputes.tableData.length - 1][1] = value["stockId"] ?? "123456789";
            emit(StockDisputeSuccess(message: value["message"]));
            emit(const StockDisputeLoaded());
          } else {
            emit(StockDisputeFailure(errorMessage: value["message"]));
            emit(const StockDisputeLoaded());
          }
        }
      });
    }
  }
}
