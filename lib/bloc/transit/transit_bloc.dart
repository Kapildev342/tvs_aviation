import 'dart:async';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tvsaviation/data/model/api_model/get_transit_model.dart';
import 'package:tvsaviation/data/model/variable_model/inventory_change_model.dart';
import 'package:tvsaviation/resources/constants.dart';

part 'transit_event.dart';
part 'transit_state.dart';

class TransitBloc extends Bloc<TransitEvent, TransitState> {
  TransitBloc() : super(const TransitLoading()) {
    on<TransitInitialEvent>(initialFunction);
    on<TransitFilterEvent>(filterFunction);
    on<DownloadFileEvent>(downloadFileFunction);
    on<CalenderEnablingTransitEvent>(calenderEnablingFunction);
    on<CalenderSelectionTransitEvent>(calenderSelectionFunction);
    on<LocationSelectionAllTransitEvent>(locationSelectionAllFunction);
    on<LocationSelectionSingleTransitEvent>(locationSelectionSingleFunction);
  }

  FutureOr<void> initialFunction(TransitInitialEvent event, Emitter<TransitState> emit) async {
    emit(const TransitLoading());
    if (mainVariables.transitVariables.receivedPageOpened) {
      mainVariables.transitVariables.receivedPageOpened = false;
      emit(const TransitDummy());
      emit(const TransitLoaded());
    } else {
      mainVariables.generalVariables.currentPage.value = "transit";
      mainVariables.generalVariables.selectedTransId = "";
      mainVariables.transitVariables.searchController.clear();
      mainVariables.transitVariables.filterController.clear();
      mainVariables.transitVariables.locationSelectEnabledList.clear();
      mainVariables.transitVariables.selectedLocationsList.clear();
      mainVariables.transitVariables.filterSelectedStartDate = null;
      mainVariables.transitVariables.filterSelectedEndDate = null;
      mainVariables.transitVariables.currentPage = 1;
      mainVariables.transitVariables.locationSelectEnabledList = List.generate(mainVariables.stockMovementVariables.senderInfo.locationDropDownList.length, (index) => true);
      mainVariables.transitVariables.selectedCount = mainVariables.stockMovementVariables.senderInfo.locationDropDownList.length.toString().obs;
      await mainVariables.repoImpl.getAllTransit(query: {
        "searchQuery": "",
        "location": [],
        "page": "1",
        "limit": "10",
        "senderstockType": "",
        "receivertockType": "",
        "startDate": "",
        "endDate": "",
      }).onError((error, stackTrace) {
        emit(TransitFailure(errorMessage: error.toString()));
        emit(const TransitLoading());
      }).then((value) async {
        if (value != null) {
          TransitModel getTransitResponse = TransitModel.fromJson(value);
          mainVariables.transitVariables.overallTransit.tableData.clear();
          if (getTransitResponse.status) {
            mainVariables.transitVariables.totalPages = getTransitResponse.totalPages;
            for (int i = 0; i < getTransitResponse.stockMovements.length; i++) {
              TransitChangeModel transitChangeModel = TransitChangeModel.fromJson(getTransitResponse.stockMovements[i].toJson());
              mainVariables.transitVariables.overallTransit.tableData.add(transitChangeModel.toJson().entries.map((entry) => (entry.value.toString())).toList());
            }
            emit(const TransitDummy());
            emit(const TransitLoaded());
          } else {
            emit(const TransitFailure(errorMessage: ""));
            emit(const TransitLoading());
          }
        }
      });
    }
  }

  FutureOr<void> filterFunction(TransitFilterEvent event, Emitter<TransitState> emit) async {
    await mainVariables.repoImpl.getAllTransit(query: {
      "searchQuery": mainVariables.transitVariables.searchController.text,
      "location": mainVariables.transitVariables.selectedLocationsList,
      "page": mainVariables.transitVariables.currentPage.toString(),
      "limit": "10",
      "senderstockType": "",
      "receivertockType": "",
      "startDate": mainVariables.transitVariables.filterSelectedStartDate == null ? "" : mainVariables.transitVariables.filterSelectedStartDate.toString(),
      "endDate": mainVariables.transitVariables.filterSelectedEndDate == null ? "" : (mainVariables.transitVariables.filterSelectedEndDate!.add(const Duration(days: 1))).toString()
    }).onError((error, stackTrace) {
      emit(TransitFailure(errorMessage: error.toString()));
      emit(const TransitLoading());
    }).then((value) async {
      if (value != null) {
        TransitModel getTransitResponse = TransitModel.fromJson(value);
        mainVariables.transitVariables.overallTransit.tableData.clear();
        if (getTransitResponse.status) {
          mainVariables.transitVariables.totalPages = getTransitResponse.totalPages;
          for (int i = 0; i < getTransitResponse.stockMovements.length; i++) {
            TransitChangeModel transitChangeModel = TransitChangeModel.fromJson(getTransitResponse.stockMovements[i].toJson());
            mainVariables.transitVariables.overallTransit.tableData.add(transitChangeModel.toJson().entries.map((entry) => (entry.value.toString())).toList());
          }
          emit(const TransitDummy());
          emit(const TransitLoaded());
        } else {
          emit(const TransitFailure(errorMessage: ""));
          emit(const TransitLoading());
        }
      }
    });
  }

  FutureOr<void> downloadFileFunction(DownloadFileEvent event, Emitter<TransitState> emit) async {
    try {
      if (await Permission.storage.request().isGranted) {
        Directory? downloadsDir = await mainFunctions.getDownloadsDirectory();
        if (downloadsDir != null) {
          String savePath = "${downloadsDir.path}/transit_${mainFunctions.dateTimeFormatFileName(date: DateTime.now().toString())}_downloaded_file.csv";
          await mainVariables.repoImpl.fileDownload(query: {
            "searchQuery": mainVariables.transitVariables.searchController.text,
            "location": mainVariables.transitVariables.selectedLocationsList,
            "startDate": mainVariables.transitVariables.filterSelectedStartDate == null ? "" : mainVariables.transitVariables.filterSelectedStartDate.toString(),
            "endDate": mainVariables.transitVariables.filterSelectedEndDate == null ? "" : (mainVariables.transitVariables.filterSelectedEndDate!.add(const Duration(days: 1))).toString(),
          }).onError((error, stackTrace) {
            emit(TransitFailure(errorMessage: error.toString()));
            emit(const TransitLoaded());
          }).then((value) async {
            if (value != null) {
              File file = File(savePath);
              await file.writeAsBytes(value);
              emit(TransitSuccess(message: 'File downloaded successfully to ${file.path}'));
              emit(const TransitLoaded());
            }
          });
        } else {
          emit(const TransitFailure(errorMessage: 'Failed to get downloads directory'));
          emit(const TransitLoaded());
        }
      } else {
        emit(const TransitFailure(errorMessage: 'Permission denied to access storage'));
        emit(const TransitLoaded());
      }
    } catch (e) {
      emit(TransitFailure(errorMessage: 'Error downloading file: $e'));
      emit(const TransitLoaded());
    }
  }

  Future<void> calenderEnablingFunction(CalenderEnablingTransitEvent event, Emitter<TransitState> emit) async {
    mainVariables.transitVariables.filterCalenderEnabled = !mainVariables.transitVariables.filterCalenderEnabled;
    mainFunctions.countFiltersTransit();
    emit(const TransitDummy());
    emit(const TransitLoaded());
  }

  Future<void> calenderSelectionFunction(CalenderSelectionTransitEvent event, Emitter<TransitState> emit) async {
    if (event.endDate == null) {
      if (event.startDate == null) {
        mainVariables.transitVariables.filterController.clear();
        mainVariables.transitVariables.filterSelectedStartDate = event.startDate;
        mainVariables.transitVariables.filterSelectedEndDate = event.endDate;
      } else {
        mainVariables.transitVariables.filterController.text = event.startDate.toString().substring(0, 10);
        mainVariables.transitVariables.filterSelectedStartDate = event.startDate;
        mainVariables.transitVariables.filterSelectedEndDate = event.endDate;
      }
    } else if (event.endDate == event.startDate) {
      mainVariables.transitVariables.filterController.text = event.startDate.toString().substring(0, 10);
      mainVariables.transitVariables.filterSelectedStartDate = event.startDate;
      mainVariables.transitVariables.filterSelectedEndDate = null;
    } else {
      mainVariables.transitVariables.filterController.text = ("${event.startDate.toString().substring(0, 10)} to ${event.endDate.toString().substring(0, 10)}");
      mainVariables.transitVariables.filterSelectedStartDate = event.startDate;
      mainVariables.transitVariables.filterSelectedEndDate = event.endDate;
    }
    mainFunctions.countFiltersTransit();
    emit(const TransitDummy());
    emit(const TransitLoaded());
  }

  Future<void> locationSelectionAllFunction(LocationSelectionAllTransitEvent event, Emitter<TransitState> emit) async {
    if (event.isAllCheck) {
      mainVariables.transitVariables.selectAllEnabled = true;
      mainVariables.transitVariables.locationSelectEnabledList.clear();
      mainVariables.transitVariables.locationSelectEnabledList = List.generate(mainVariables.stockMovementVariables.senderInfo.locationDropDownList.length, (index) => true);
    } else {
      mainVariables.transitVariables.selectAllEnabled = false;
      mainVariables.transitVariables.locationSelectEnabledList.clear();
      mainVariables.transitVariables.locationSelectEnabledList = List.generate(mainVariables.stockMovementVariables.senderInfo.locationDropDownList.length, (index) => false);
    }
    mainVariables.transitVariables.selectedLocationsList.clear();
    mainFunctions.countFiltersTransit();
    emit(const TransitDummy());
    emit(const TransitLoaded());
  }

  Future<void> locationSelectionSingleFunction(LocationSelectionSingleTransitEvent event, Emitter<TransitState> emit) async {
    if (event.selectedIndexValue) {
      if (mainVariables.transitVariables.selectAllEnabled) {
        mainVariables.transitVariables.locationSelectEnabledList[event.selectedIndex] = event.selectedIndexValue;
      } else {
        mainVariables.transitVariables.locationSelectEnabledList[event.selectedIndex] = event.selectedIndexValue;
        mainVariables.transitVariables.selectAllEnabled = mainVariables.transitVariables.locationSelectEnabledList.contains(false) == false;
      }
    } else {
      if (mainVariables.transitVariables.selectAllEnabled) {
        mainVariables.transitVariables.selectAllEnabled = false;
        mainVariables.transitVariables.locationSelectEnabledList.clear();
        mainVariables.transitVariables.locationSelectEnabledList = List.generate(mainVariables.stockMovementVariables.senderInfo.locationDropDownList.length, (index) => true);
        mainVariables.transitVariables.locationSelectEnabledList[event.selectedIndex] = event.selectedIndexValue;
      } else {
        mainVariables.transitVariables.locationSelectEnabledList[event.selectedIndex] = event.selectedIndexValue;
      }
    }
    mainVariables.transitVariables.selectedLocationsList.clear();
    for (int i = 0; i < mainVariables.transitVariables.locationSelectEnabledList.length; i++) {
      if (mainVariables.transitVariables.locationSelectEnabledList[i]) {
        mainVariables.transitVariables.selectedLocationsList.add(mainVariables.stockMovementVariables.senderInfo.locationDropDownList[i].value);
      }
    }
    mainFunctions.countFiltersTransit();
    emit(const TransitDummy());
    emit(const TransitLoaded());
  }
}
