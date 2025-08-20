import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvsaviation/data/model/api_model/get_single_transit_model.dart';
import 'package:tvsaviation/data/model/variable_model/inventory_change_model.dart';
import 'package:tvsaviation/data/model/variable_model/stock_dispute_variables.dart';
import 'package:tvsaviation/resources/constants.dart';
import 'package:tvsaviation/resources/drop_down_lib/dropdown_textfield.dart';

part 'received_stocks_event.dart';
part 'received_stocks_state.dart';

class ReceivedStocksBloc extends Bloc<ReceivedStocksEvent, ReceivedStocksState> {
  ReceivedStocksBloc() : super(const ReceivedStocksLoading()) {
    on<ReceivedStocksInitial>(receivedStocksInitialFunction);
    on<ReceivedStocksConfirm>(receivedStocksConfirmFunction);
  }

  FutureOr<void> receivedStocksInitialFunction(ReceivedStocksInitial event, Emitter<ReceivedStocksState> emit) async {
    emit(const ReceivedStocksLoading());
    if (mainVariables.receivedStocksVariables.disputePageOpened) {
      mainVariables.receivedStocksVariables.disputePageOpened = false;
      mainVariables.stockDisputeVariables = StockDisputeVariables.fromJson({});
      emit(const ReceivedStocksDummy());
      emit(const ReceivedStocksLoaded());
    } else {
      await mainVariables.repoImpl.getSingleTransit(query: {"transId": mainVariables.generalVariables.selectedTransId}).onError((error, stackTrace) {
        emit(ReceivedStocksFailure(errorMessage: error.toString()));
        emit(const ReceivedStocksLoading());
      }).then((value) async {
        if (value != null) {
          GetSingleTransitModel getSingleTransitResponse = GetSingleTransitModel.fromJson(value);
          mainVariables.receivedStocksVariables.receivedStocksInventory.tableData.clear();
          mainVariables.receivedStocksVariables.receivedStocksDisputes.tableData.clear();
          if (getSingleTransitResponse.status) {
            mainVariables.receivedStocksVariables.tempTransId = getSingleTransitResponse.stockMovement.id;
            if (mainVariables.receivedStocksVariables.pageState == "reports") {
              mainVariables.receivedStocksVariables.senderInfo.crewHandlerController.text = getSingleTransitResponse.stockMovement.crewType;
              mainVariables.receivedStocksVariables.senderInfo.crewHandlerNameController.text = getSingleTransitResponse.stockMovement.receiverName;
              mainVariables.receivedStocksVariables.senderInfo.locationController.text = getSingleTransitResponse.stockMovement.crewType == "Handler" ? "-" : getSingleTransitResponse.stockMovement.receiverLocation;
              mainVariables.receivedStocksVariables.senderInfo.stockTypeController.text = getSingleTransitResponse.stockMovement.crewType == "Handler" ? "-" : getSingleTransitResponse.stockMovement.receiverStockType;
              mainVariables.receivedStocksVariables.senderInfo.handlerNameController.text = getSingleTransitResponse.stockMovement.handlerName == "" ? "N/A" : getSingleTransitResponse.stockMovement.handlerName;
              mainVariables.receivedStocksVariables.senderInfo.handlerNumberController.text = getSingleTransitResponse.stockMovement.handlerNumber == "" ? "N/A" : getSingleTransitResponse.stockMovement.handlerNumber;
              mainVariables.receivedStocksVariables.receiverInfo.crewHandlerController.text = getSingleTransitResponse.stockMovement.senderName;
              mainVariables.receivedStocksVariables.receiverInfo.locationController.text = getSingleTransitResponse.stockMovement.senderType == "Handler" ? "-" : getSingleTransitResponse.stockMovement.senderLocation;
              mainVariables.receivedStocksVariables.receiverInfo.stockTypeController.text = getSingleTransitResponse.stockMovement.senderType == "Handler" ? "-" : getSingleTransitResponse.stockMovement.senderStockType;
              mainVariables.receivedStocksVariables.receiverRemarksController.text = getSingleTransitResponse.stockMovement.receiverRemarks == "" ? "No Remarks Added" : getSingleTransitResponse.stockMovement.receiverRemarks;
            } else {
              mainVariables.receivedStocksVariables.senderInfo.crewHandlerController.text = getSingleTransitResponse.stockMovement.senderType;
              mainVariables.receivedStocksVariables.senderInfo.crewHandlerNameController.text = getSingleTransitResponse.stockMovement.senderName;
              mainVariables.receivedStocksVariables.senderInfo.locationController.text = getSingleTransitResponse.stockMovement.senderType == "Handler" ? "-" : getSingleTransitResponse.stockMovement.senderLocation;
              mainVariables.receivedStocksVariables.senderInfo.stockTypeController.text = getSingleTransitResponse.stockMovement.senderType == "Handler" ? "-" : getSingleTransitResponse.stockMovement.senderStockType;
              mainVariables.receivedStocksVariables.senderInfo.handlerNameController.text = getSingleTransitResponse.stockMovement.handlerName == "" ? "N/A" : getSingleTransitResponse.stockMovement.handlerName;
              mainVariables.receivedStocksVariables.senderInfo.handlerNumberController.text = getSingleTransitResponse.stockMovement.handlerName == "" ? "N/A" : getSingleTransitResponse.stockMovement.handlerNumber;

              mainVariables.receivedStocksVariables.receiverInfo.crewHandlerController.text = "${mainVariables.generalVariables.userData.firstName} ${mainVariables.generalVariables.userData.lastName}";
              mainVariables.receivedStocksVariables.receiverInfo.locationController.text = getSingleTransitResponse.stockMovement.receiverLocation;
              mainVariables.receivedStocksVariables.receiverInfo.stockTypeController.text = getSingleTransitResponse.stockMovement.receiverStockType;
              mainVariables.receivedStocksVariables.receiverRemarksController.text = getSingleTransitResponse.stockMovement.receiverRemarks == "" ? "" : getSingleTransitResponse.stockMovement.receiverRemarks;
              mainVariables.receivedStocksVariables.receiverInfo.receiverLocationChoose = DropDownValueModel(
                name: getSingleTransitResponse.stockMovement.receiverLocation,
                value: getSingleTransitResponse.stockMovement.receiverLocationId,
              );
            }
            mainVariables.receivedStocksVariables.receiverInfo.fromSectorController.text = getSingleTransitResponse.stockMovement.sectorFrom == "" ? "N/A" : getSingleTransitResponse.stockMovement.sectorFrom;
            mainVariables.receivedStocksVariables.receiverInfo.toSectorController.text = getSingleTransitResponse.stockMovement.sectorTo == "" ? "N/A" : getSingleTransitResponse.stockMovement.sectorTo;
            mainVariables.receivedStocksVariables.totalQuantity = getSingleTransitResponse.inventorySummary.totalQty.toString();
            mainVariables.receivedStocksVariables.totalProducts = getSingleTransitResponse.inventorySummary.totalProducts.toString();
            mainVariables.receivedStocksVariables.totalDisputeQuantity = getSingleTransitResponse.disputeSummary.totalQty.toString();
            mainVariables.receivedStocksVariables.totalDisputeProducts = getSingleTransitResponse.disputeSummary.totalProducts.toString();
            mainVariables.receivedStocksVariables.isAllowToReceive = getSingleTransitResponse.stockMovement.access;
            mainVariables.receivedStocksVariables.senderRemarksController.text = getSingleTransitResponse.stockMovement.senderRemarks == "" ? "No Remarks Added" : getSingleTransitResponse.stockMovement.senderRemarks;
            mainVariables.receivedStocksVariables.senderInfo.image1 = getSingleTransitResponse.stockMovement.handlerSignImage;
            mainVariables.receivedStocksVariables.senderInfo.image2 = getSingleTransitResponse.stockMovement.crewSignImage;
            for (int i = 0; i < getSingleTransitResponse.stockMovement.inventories.length; i++) {
              TransitInventoryChangeModel transitInventoryChangeModel = TransitInventoryChangeModel.fromJson(getSingleTransitResponse.stockMovement.inventories[i].toJson());
              mainVariables.receivedStocksVariables.receivedStocksInventory.tableData.add(transitInventoryChangeModel.toJson().entries.map((entry) => (entry.value.toString())).toList());
              if (getSingleTransitResponse.stockMovement.inventories[i].stockDispute) {
                TransitDisputeChangeModel transitDisputeChangeModel = TransitDisputeChangeModel.fromJson(getSingleTransitResponse.stockMovement.inventories[i].toJson());
                mainVariables.receivedStocksVariables.receivedStocksDisputes.tableData.add(transitDisputeChangeModel.toJson().entries.map((entry) => (entry.value.toString())).toList());
              }
            }
            mainVariables.receivedStocksVariables.totalDisputeProducts = (mainVariables.receivedStocksVariables.receivedStocksDisputes.tableData.length).toString();
            for (int i = 0; i < mainVariables.receivedStocksVariables.receivedStocksDisputes.tableData.length; i++) {
              mainVariables.receivedStocksVariables.totalDisputeQuantity = (int.parse(mainVariables.receivedStocksVariables.totalDisputeQuantity) + int.parse(mainVariables.receivedStocksVariables.receivedStocksDisputes.tableData[i][6])).toString();
            }
            emit(const ReceivedStocksDummy());
            emit(const ReceivedStocksLoaded());
          } else {
            emit(const ReceivedStocksFailure(errorMessage: ""));
            emit(const ReceivedStocksLoading());
          }
        }
      });
    }
  }

  FutureOr<void> receivedStocksConfirmFunction(ReceivedStocksConfirm event, Emitter<ReceivedStocksState> emit) async {
    mainVariables.receivedStocksVariables.continueLoader = true;
    await mainVariables.repoImpl.confirmStockMovement(query: {
      "TransId": mainVariables.generalVariables.selectedTransId,
      "receiverLocation": mainVariables.receivedStocksVariables.receiverInfo.receiverLocationChoose.value,
      "receiverRemarks": mainVariables.receivedStocksVariables.receiverRemarksController.text,
    }).onError((error, stackTrace) {
      emit(ReceivedStocksFailure(errorMessage: error.toString()));
      emit(const ReceivedStocksLoaded());
    }).then((value) async {
      if (value != null) {
        if (value["status"]) {
          mainVariables.transitVariables.currentPage = 1;
          emit(ReceivedStocksSuccess(message: value["message"] ?? "Received stock Successfully"));
          emit(const ReceivedStocksLoaded());
        } else {
          emit(ReceivedStocksFailure(errorMessage: value["message"] ?? "Something went wrong, please check & submit"));
          emit(const ReceivedStocksLoaded());
        }
      }
    });
  }
}
