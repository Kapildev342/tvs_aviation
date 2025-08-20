import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvsaviation/data/model/api_model/get_dispute_details.dart';
import 'package:tvsaviation/data/model/variable_model/inventory_change_model.dart';
import 'package:tvsaviation/resources/constants.dart';

part 'add_dispute_event.dart';
part 'add_dispute_state.dart';

class AddDisputeBloc extends Bloc<AddDisputeEvent, AddDisputeState> {
  AddDisputeBloc() : super(const AddDisputeLoading()) {
    on<AddDisputeInitialEvent>(addDisputeInitialFunction);
    on<AddDisputeCreateEvent>(addDisputeCreateFunction);
    on<AddDisputeDetailsEvent>(addDisputeDetailsFunction);
    on<AddDisputeAdminCommentsEvent>(addDisputeAdminCommentsFunction);
  }

  FutureOr<void> addDisputeInitialFunction(AddDisputeInitialEvent event, Emitter<AddDisputeState> emit) async {
    emit(const AddDisputeDummy());
    emit(const AddDisputeLoaded());
  }

  FutureOr<void> addDisputeCreateFunction(AddDisputeCreateEvent event, Emitter<AddDisputeState> emit) async {
    int disputeTotalQuantity = 0;
    for (int i = 0; i < mainVariables.stockDisputeVariables.sendData.products.length; i++) {
      disputeTotalQuantity = disputeTotalQuantity + mainVariables.stockDisputeVariables.sendData.products[i].quantity;
    }
    if (disputeTotalQuantity == 0) {
      emit(const AddDisputeFailure(errorMessage: "Dispute quantity cant be zero, please add the quantity count"));
      emit(const AddDisputeLoaded());
    } else {
      await mainVariables.repoImpl.addDispute(query: mainVariables.stockDisputeVariables.sendData.toJson()).onError((error, stackTrace) {
        emit(AddDisputeFailure(errorMessage: error.toString()));
        emit(const AddDisputeLoaded());
      }).then((value) async {
        if (value != null) {
          if (value["status"]) {
            emit(AddDisputeSuccess(message: value["message"]));
            emit(const AddDisputeLoaded());
          } else {
            emit(AddDisputeFailure(errorMessage: value["message"]));
            emit(const AddDisputeLoaded());
          }
        }
      });
    }
  }

  FutureOr<void> addDisputeDetailsFunction(AddDisputeDetailsEvent event, Emitter<AddDisputeState> emit) async {
    emit(const AddDisputeLoading());
    await mainVariables.repoImpl.getDisputeDetails(query: {"id": mainVariables.generalVariables.selectedDisputeId}).onError((error, stackTrace) {
      emit(AddDisputeFailure(errorMessage: error.toString()));
      emit(const AddDisputeLoaded());
    }).then((value) async {
      if (value != null) {
        GetDisputeDetails getDisputeDetails = GetDisputeDetails.fromJson(value);
        if (getDisputeDetails.status) {
          mainVariables.addDisputeVariables.stockDisputeInventory.tableData.clear();
          mainVariables.generalVariables.selectedTransTempId = getDisputeDetails.stockDispute.id;
          mainVariables.addDisputeVariables.crewName = getDisputeDetails.stockDispute.crew;
          mainVariables.addDisputeVariables.disputeId = getDisputeDetails.stockDispute.stockDisputeId;
          mainVariables.addDisputeVariables.location = getDisputeDetails.stockDispute.location;
          mainVariables.addDisputeVariables.disputeReason = getDisputeDetails.stockDispute.disputeReason;
          mainVariables.addDisputeVariables.commentsBar.text = getDisputeDetails.stockDispute.comments;
          mainVariables.addDisputeVariables.adminCommentsBar.text = getDisputeDetails.stockDispute.adminComments;
          mainVariables.addDisputeVariables.totalProducts = getDisputeDetails.stockDispute.totalProducts;
          mainVariables.addDisputeVariables.totalQuantity = getDisputeDetails.stockDispute.totalQuantity;
          mainVariables.addDisputeVariables.isResolved = getDisputeDetails.stockDispute.resolve;
          for (int i = 0; i < getDisputeDetails.products.length; i++) {
            ResolutionDisputeChangeModel resolutionDisputeChangeModel = ResolutionDisputeChangeModel.fromJson(getDisputeDetails.products[i].toJson());
            mainVariables.addDisputeVariables.stockDisputeInventory.tableData.add(resolutionDisputeChangeModel.toJson().entries.map((entry) => (entry.value.toString())).toList());
          }
          emit(const AddDisputeDummy());
          emit(const AddDisputeLoaded());
        } else {
          emit(AddDisputeFailure(errorMessage: value["message"] ?? ""));
          emit(const AddDisputeLoaded());
        }
      }
    });
  }

  FutureOr<void> addDisputeAdminCommentsFunction(AddDisputeAdminCommentsEvent event, Emitter<AddDisputeState> emit) async {
    if (mainVariables.addDisputeVariables.adminCommentsBar.text == "") {
      mainVariables.reportsVariables.dispute.tableData[mainVariables.reportsVariables.selectedResolutionIndex][5] = "false";
      emit(const AddDisputeFailure(errorMessage: "Admin comments is Empty, Please Add"));
      emit(const AddDisputeLoaded());
    } else {
      await mainVariables.repoImpl.disputeAdminComment(query: {"id": mainVariables.generalVariables.selectedTransTempId, "adminComments": mainVariables.addDisputeVariables.adminCommentsBar.text}).onError((error, stackTrace) {
        emit(AddDisputeFailure(errorMessage: error.toString()));
        emit(const AddDisputeLoaded());
      }).then((value) async {
        if (value != null) {
          if (value["status"]) {
            if (mainVariables.generalVariables.currentPage.value != "inventory") {
              mainVariables.reportsVariables.dispute.tableData[mainVariables.reportsVariables.selectedResolutionIndex][5] = "true";
            }
            emit(AddDisputeSuccess(message: value["message"]));
            emit(const AddDisputeLoaded());
          } else {
            mainVariables.reportsVariables.dispute.tableData[mainVariables.reportsVariables.selectedResolutionIndex][5] = "false";
            emit(AddDisputeFailure(errorMessage: value["message"]));
            emit(const AddDisputeLoaded());
          }
        }
      });
    }
  }
}
