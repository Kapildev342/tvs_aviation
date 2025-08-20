import 'dart:async';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tvsaviation/data/model/api_model/cabin_galley_reports_model.dart';
import 'package:tvsaviation/data/model/api_model/check_list_reports_api_model.dart';
import 'package:tvsaviation/data/model/api_model/dispute_reports_model.dart';
import 'package:tvsaviation/data/model/api_model/expiry_reports_model.dart';
import 'package:tvsaviation/data/model/api_model/low_stock_reports_model.dart';
import 'package:tvsaviation/data/model/api_model/overall_reports_model.dart';
import 'package:tvsaviation/data/model/api_model/transaction_history_model.dart';
import 'package:tvsaviation/data/model/variable_model/inventory_change_model.dart';
import 'package:tvsaviation/resources/constants.dart';

part 'reports_event.dart';
part 'reports_state.dart';

class ReportsBloc extends Bloc<ReportsEvent, ReportsState> {
  ReportsBloc() : super(const ReportsLoading()) {
    on<ReportsPageChangingEvent>(reportsPageChangingFunction);
    on<CalenderEnablingEvent>(calenderEnablingFunction);
    on<CalenderSelectionEvent>(calenderSelectionFunction);
    on<LocationSelectionAllEvent>(locationSelectionAllFunction);
    on<LocationSelectionSingleEvent>(locationSelectionSingleFunction);
    on<ReportsFilterEvent>(reportsFilterFunction);
    on<DownloadFileEvent>(downloadFileFunction);
  }

  Future<void> reportsPageChangingFunction(ReportsPageChangingEvent event, Emitter<ReportsState> emit) async {
    emit(const ReportsLoading());
    mainVariables.generalVariables.selectedTransId = "";
    mainVariables.reportsVariables.searchController.clear();
    mainVariables.reportsVariables.filterController.clear();
    mainVariables.reportsVariables.locationSelectEnabledList.clear();
    mainVariables.reportsVariables.selectedLocationsList.clear();
    mainVariables.reportsVariables.numberController = NumberPaginatorController();
    mainVariables.reportsVariables.numberController!.currentPage = mainVariables.reportsVariables.currentPage - 1;
    mainVariables.reportsVariables.filterSelectedStartDate = null;
    mainVariables.reportsVariables.filterSelectedEndDate = null;
    mainVariables.reportsVariables.sortInt = -1;
    mainVariables.reportsVariables.locationSelectEnabledList = List.generate(mainVariables.stockMovementVariables.senderInfo.locationDropDownList.length, (index) => true);
    mainVariables.reportsVariables.selectedCount = mainVariables.stockMovementVariables.senderInfo.locationDropDownList.length.toString().obs;
    mainVariables.reportsVariables.reportsSelectedIndex = event.index;
    switch (event.index) {
      case 0:
        {
          await mainVariables.repoImpl.overAllFunction(query: {
            "page": "1",
            "limit": "10",
            "location": [],
            "startDate": "",
            "endDate": "",
            "searchQuery": "",
            "sort": mainVariables.reportsVariables.sortInt,
          }).onError((error, stackTrace) {
            emit(ReportsFailure(errorMessage: error.toString()));
            emit(const ReportsLoaded());
          }).then((value) async {
            if (value != null) {
              OverallReportsModel overallReportsModel = OverallReportsModel.fromJson(value);
              if (overallReportsModel.status) {
                mainVariables.reportsVariables.overall.tableData.clear();
                mainVariables.reportsVariables.totalPages = overallReportsModel.totalPages == 0 ? 1 : overallReportsModel.totalPages;
                for (int i = 0; i < overallReportsModel.overallStockReports.length; i++) {
                  OverAllChangeModel overAllChangeModel = OverAllChangeModel.fromJson(overallReportsModel.overallStockReports[i].toJson());
                  mainVariables.reportsVariables.overall.tableData.add(overAllChangeModel.toJson().entries.map((entry) => (entry.value.toString())).toList());
                }
                emit(const ReportsDummy());
                emit(const ReportsLoaded());
              } else {
                emit(ReportsFailure(errorMessage: overallReportsModel.message));
                emit(const ReportsLoaded());
              }
            } else {
              emit(const ReportsFailure(errorMessage: "Something went wrong"));
              emit(const ReportsLoaded());
            }
          });
        }
      case 1:
        {
          await mainVariables.repoImpl.lowStockFunction(query: {
            "page": "1",
            "limit": "10",
            "location": [],
            "startDate": "",
            "endDate": "",
            "searchQuery": "",
            "sort": mainVariables.reportsVariables.sortInt,
          }).onError((error, stackTrace) {
            emit(ReportsFailure(errorMessage: error.toString()));
            emit(const ReportsLoaded());
          }).then((value) async {
            if (value != null) {
              LowStockReportsModel lowStockReportsModel = LowStockReportsModel.fromJson(value);
              if (lowStockReportsModel.status) {
                mainVariables.reportsVariables.lowStock.tableData.clear();
                mainVariables.reportsVariables.totalPages = lowStockReportsModel.totalPages == 0 ? 1 : lowStockReportsModel.totalPages;
                for (int i = 0; i < lowStockReportsModel.lowStockItems.length; i++) {
                  LowStockChangeModel lowStockChangeModel = LowStockChangeModel.fromJson(lowStockReportsModel.lowStockItems[i].toJson());
                  mainVariables.reportsVariables.lowStock.tableData.add(lowStockChangeModel.toJson().entries.map((entry) => (entry.value.toString())).toList());
                }
                emit(const ReportsDummy());
                emit(const ReportsLoaded());
              } else {
                emit(const ReportsFailure(errorMessage: "Something went wrong"));
                emit(const ReportsLoaded());
              }
            } else {
              emit(const ReportsFailure(errorMessage: "Something went wrong"));
              emit(const ReportsLoaded());
            }
          });
        }
      case 2:
        {
          await mainVariables.repoImpl.expiryFunction(query: {
            "page": "1",
            "limit": "10",
            "location": [],
            "startDate": "",
            "endDate": "",
            "searchQuery": "",
            "sort": mainVariables.reportsVariables.sortInt,
          }).onError((error, stackTrace) {
            emit(ReportsFailure(errorMessage: error.toString()));
            emit(const ReportsLoaded());
          }).then((value) async {
            if (value != null) {
              ExpiryReportsModel expiryReportsModel = ExpiryReportsModel.fromJson(value);
              if (expiryReportsModel.status) {
                mainVariables.reportsVariables.expiry.tableData.clear();
                mainVariables.reportsVariables.totalPages = expiryReportsModel.totalPages == 0 ? 1 : expiryReportsModel.totalPages;
                for (int i = 0; i < expiryReportsModel.expiryList.length; i++) {
                  ExpiryChangeModel expiryChangeModel = ExpiryChangeModel.fromJson(expiryReportsModel.expiryList[i].toJson());
                  mainVariables.reportsVariables.expiry.tableData.add(expiryChangeModel.toJson().entries.map((entry) => (entry.value.toString())).toList());
                }
                emit(const ReportsDummy());
                emit(const ReportsLoaded());
              } else {
                emit(const ReportsFailure(errorMessage: "Something went wrong"));
                emit(const ReportsLoaded());
              }
            } else {
              emit(const ReportsFailure(errorMessage: "Something went wrong"));
              emit(const ReportsLoaded());
            }
          });
        }
      case 3:
        {
          if (mainVariables.reportsVariables.addDisputePageChanged) {
            mainVariables.reportsVariables.numberController!.currentPage = mainVariables.reportsVariables.currentPage - 1;
            mainVariables.reportsVariables.addDisputePageChanged = false;
            emit(const ReportsDummy());
            emit(const ReportsLoaded());
          } else {
            await mainVariables.repoImpl.stockDisputeFunction(query: {
              "page": 1,
              "limit": 10,
              "location": [],
              "startDate": "",
              "endDate": "",
              "searchQuery": "",
              "sort": mainVariables.reportsVariables.sortInt,
            }).onError((error, stackTrace) {
              emit(ReportsFailure(errorMessage: error.toString()));
              emit(const ReportsLoaded());
            }).then((value) async {
              if (value != null) {
                DisputeReportsModel disputeReportsModel = DisputeReportsModel.fromJson(value);
                if (disputeReportsModel.status) {
                  mainVariables.reportsVariables.dispute.tableData.clear();
                  mainVariables.reportsVariables.totalPages = disputeReportsModel.totalPages == 0 ? 1 : disputeReportsModel.totalPages;
                  for (int i = 0; i < disputeReportsModel.stockDisputes.length; i++) {
                    DisputesChangeModel disputesChangeModel = DisputesChangeModel.fromJson(disputeReportsModel.stockDisputes[i].toJson());
                    mainVariables.reportsVariables.dispute.tableData.add(disputesChangeModel.toJson().entries.map((entry) => (entry.value.toString())).toList());
                  }
                  emit(const ReportsDummy());
                  emit(const ReportsLoaded());
                } else {
                  emit(const ReportsFailure(errorMessage: "Something went wrong"));
                  emit(const ReportsLoaded());
                }
              } else {
                emit(const ReportsFailure(errorMessage: "Something went wrong"));
                emit(const ReportsLoaded());
              }
            });
          }
        }
      case 4:
        {
          await mainVariables.repoImpl.transactionFunction(query: {
            "page": "1",
            "limit": "10",
            "location": [],
            "startDate": "",
            "endDate": "",
            "searchQuery": "",
          }).onError((error, stackTrace) {
            emit(ReportsFailure(errorMessage: error.toString()));
            emit(const ReportsLoaded());
          }).then((value) async {
            if (value != null) {
              TransactionHistoryModel transactionHistoryModel = TransactionHistoryModel.fromJson(value);
              if (transactionHistoryModel.status) {
                mainVariables.reportsVariables.transaction.tableData.clear();
                mainVariables.reportsVariables.totalPages = transactionHistoryModel.totalPages == 0 ? 1 : transactionHistoryModel.totalPages;
                for (int i = 0; i < transactionHistoryModel.transactionHistory.length; i++) {
                  TransactionHistoryChangeModel transactionInventoryChangeModel = TransactionHistoryChangeModel.fromJson(transactionHistoryModel.transactionHistory[i].toJson());
                  mainVariables.reportsVariables.transaction.tableData.add(transactionInventoryChangeModel.toJson().entries.map((entry) => (entry.value.toString())).toList());
                }
                emit(const ReportsDummy());
                emit(const ReportsLoaded());
              } else {
                emit(ReportsFailure(errorMessage: transactionHistoryModel.message));
                emit(const ReportsLoaded());
              }
            } else {
              emit(const ReportsFailure(errorMessage: "Something went wrong"));
              emit(const ReportsLoaded());
            }
          });
        }
      case 5:
        {
          await mainVariables.repoImpl.cabinGalleyFunction(query: {
            "page": "1",
            "limit": "10",
            "location": [],
            "startDate": "",
            "endDate": "",
            "searchQuery": "",
            "sort": mainVariables.reportsVariables.sortInt,
          }).onError((error, stackTrace) {
            emit(ReportsFailure(errorMessage: error.toString()));
            emit(const ReportsLoaded());
          }).then((value) async {
            if (value != null) {
              CabinGalleyReportModel cabinGalleyReportModel = CabinGalleyReportModel.fromJson(value);
              if (cabinGalleyReportModel.status) {
                mainVariables.reportsVariables.cabinGalley.tableData.clear();
                mainVariables.reportsVariables.totalPages = cabinGalleyReportModel.totalPages == 0 ? 1 : cabinGalleyReportModel.totalPages;
                for (int i = 0; i < cabinGalleyReportModel.cabinAndGalleyReports.length; i++) {
                  CabinGalleyChangeModel cabinGalleyChangeModel = CabinGalleyChangeModel.fromJson(cabinGalleyReportModel.cabinAndGalleyReports[i].toJson());
                  mainVariables.reportsVariables.cabinGalley.tableData.add(cabinGalleyChangeModel.toJson().entries.map((entry) => (entry.value.toString())).toList());
                }
                emit(const ReportsDummy());
                emit(const ReportsLoaded());
              } else {
                emit(const ReportsFailure(errorMessage: "Something went wrong"));
                emit(const ReportsLoaded());
              }
            } else {
              emit(const ReportsFailure(errorMessage: "Something went wrong"));
              emit(const ReportsLoaded());
            }
          });
        }
      case 6:
        {
          await mainVariables.repoImpl.checkListFunction(query: {
            "page": "1",
            "limit": "10",
            "location": [],
            "listName": "preflight",
            "startDate": "",
            "endDate": "",
            "searchQuery": "",
            "sort": mainVariables.reportsVariables.sortInt,
          }).onError((error, stackTrace) {
            emit(ReportsFailure(errorMessage: error.toString()));
            emit(const ReportsLoaded());
          }).then((value) async {
            if (value != null) {
              GetCheckListApiModel getCheckListApiModel = GetCheckListApiModel.fromJson(value);
              if (getCheckListApiModel.status) {
                mainVariables.reportsVariables.preflight.tableData.clear();
                mainVariables.reportsVariables.totalPages = getCheckListApiModel.totalPages == 0 ? 1 : getCheckListApiModel.totalPages;
                for (int i = 0; i < getCheckListApiModel.data.length; i++) {
                  PreFlightChangeModel preFlightChangeModel = PreFlightChangeModel.fromJson(getCheckListApiModel.data[i].toJson());
                  mainVariables.reportsVariables.preflight.tableData.add(preFlightChangeModel.toJson().entries.map((entry) => (entry.value.toString())).toList());
                }
                emit(const ReportsDummy());
                emit(const ReportsLoaded());
              } else {
                emit(const ReportsFailure(errorMessage: "Something went wrong"));
                emit(const ReportsLoaded());
              }
            } else {
              emit(const ReportsFailure(errorMessage: "Something went wrong"));
              emit(const ReportsLoaded());
            }
          });
        }
      case 7:
        {
          await mainVariables.repoImpl.checkListFunction(query: {
            "page": "1",
            "limit": "10",
            "location": [],
            "listName": "postflight",
            "startDate": "",
            "endDate": "",
            "searchQuery": "",
            "sort": mainVariables.reportsVariables.sortInt,
          }).onError((error, stackTrace) {
            emit(ReportsFailure(errorMessage: error.toString()));
            emit(const ReportsLoaded());
          }).then((value) async {
            if (value != null) {
              GetCheckListApiModel getCheckListApiModel = GetCheckListApiModel.fromJson(value);
              if (getCheckListApiModel.status) {
                mainVariables.reportsVariables.postFlight.tableData.clear();
                mainVariables.reportsVariables.totalPages = getCheckListApiModel.totalPages == 0 ? 1 : getCheckListApiModel.totalPages;
                for (int i = 0; i < getCheckListApiModel.data.length; i++) {
                  PostFlightChangeModel postFlightChangeModel = PostFlightChangeModel.fromJson(getCheckListApiModel.data[i].toJson());
                  mainVariables.reportsVariables.postFlight.tableData.add(postFlightChangeModel.toJson().entries.map((entry) => (entry.value.toString())).toList());
                }
                emit(const ReportsDummy());
                emit(const ReportsLoaded());
              } else {
                emit(const ReportsFailure(errorMessage: "Something went wrong"));
                emit(const ReportsLoaded());
              }
            } else {
              emit(const ReportsFailure(errorMessage: "Something went wrong"));
              emit(const ReportsLoaded());
            }
          });
        }
      case 8:
        {
          await mainVariables.repoImpl.checkListFunction(query: {
            "page": "1",
            "limit": "10",
            "location": [],
            "listName": "maintenance",
            "startDate": "",
            "endDate": "",
            "searchQuery": "",
            "sort": mainVariables.reportsVariables.sortInt,
          }).onError((error, stackTrace) {
            emit(ReportsFailure(errorMessage: error.toString()));
            emit(const ReportsLoaded());
          }).then((value) async {
            if (value != null) {
              GetCheckListApiModel getCheckListApiModel = GetCheckListApiModel.fromJson(value);
              if (getCheckListApiModel.status) {
                mainVariables.reportsVariables.maintenance.tableData.clear();
                mainVariables.reportsVariables.totalPages = getCheckListApiModel.totalPages == 0 ? 1 : getCheckListApiModel.totalPages;
                for (int i = 0; i < getCheckListApiModel.data.length; i++) {
                  MaintenanceChangeModel maintenanceChangeModel = MaintenanceChangeModel.fromJson(getCheckListApiModel.data[i].toJson());
                  mainVariables.reportsVariables.maintenance.tableData.add(maintenanceChangeModel.toJson().entries.map((entry) => (entry.value.toString())).toList());
                }
                emit(const ReportsDummy());
                emit(const ReportsLoaded());
              } else {
                emit(const ReportsFailure(errorMessage: "Something went wrong"));
                emit(const ReportsLoaded());
              }
            } else {
              emit(const ReportsFailure(errorMessage: "Something went wrong"));
              emit(const ReportsLoaded());
            }
          });
        }
      case 9:
        {
          await mainVariables.repoImpl.checkListFunction(query: {
            "page": "1",
            "limit": "10",
            "location": [],
            "listName": "safety",
            "startDate": "",
            "endDate": "",
            "searchQuery": "",
            "sort": mainVariables.reportsVariables.sortInt,
          }).onError((error, stackTrace) {
            emit(ReportsFailure(errorMessage: error.toString()));
            emit(const ReportsLoaded());
          }).then((value) async {
            if (value != null) {
              GetCheckListApiModel getCheckListApiModel = GetCheckListApiModel.fromJson(value);
              if (getCheckListApiModel.status) {
                mainVariables.reportsVariables.safety.tableData.clear();
                mainVariables.reportsVariables.totalPages = getCheckListApiModel.totalPages == 0 ? 1 : getCheckListApiModel.totalPages;
                for (int i = 0; i < getCheckListApiModel.data.length; i++) {
                  SafetyChangeModel safetyChangeModel = SafetyChangeModel.fromJson(getCheckListApiModel.data[i].toJson());
                  mainVariables.reportsVariables.safety.tableData.add(safetyChangeModel.toJson().entries.map((entry) => (entry.value.toString())).toList());
                }
                emit(const ReportsDummy());
                emit(const ReportsLoaded());
              } else {
                emit(const ReportsFailure(errorMessage: "Something went wrong"));
                emit(const ReportsLoaded());
              }
            } else {
              emit(const ReportsFailure(errorMessage: "Something went wrong"));
              emit(const ReportsLoaded());
            }
          });
        }
      default:
        {}
    }
    emit(const ReportsDummy());
    emit(const ReportsLoaded());
  }

  FutureOr<void> reportsFilterFunction(ReportsFilterEvent event, Emitter<ReportsState> emit) async {
    switch (mainVariables.reportsVariables.reportsSelectedIndex) {
      case 0:
        {
          await mainVariables.repoImpl.overAllFunction(query: {
            "searchQuery": mainVariables.reportsVariables.searchController.text,
            "location": mainVariables.reportsVariables.selectedLocationsList,
            "page": mainVariables.reportsVariables.currentPage.toString(),
            "limit": "10",
            "startDate": mainVariables.reportsVariables.filterSelectedStartDate == null ? "" : mainVariables.reportsVariables.filterSelectedStartDate.toString(),
            "endDate": mainVariables.reportsVariables.filterSelectedEndDate == null ? "" : (mainVariables.reportsVariables.filterSelectedEndDate!.add(const Duration(days: 1))).toString(),
            "sort": mainVariables.reportsVariables.sortInt,
          }).onError((error, stackTrace) {
            emit(ReportsFailure(errorMessage: error.toString()));
            emit(const ReportsLoaded());
          }).then((value) async {
            if (value != null) {
              OverallReportsModel overallReportsModel = OverallReportsModel.fromJson(value);
              if (overallReportsModel.status) {
                mainVariables.reportsVariables.overall.tableData.clear();
                mainVariables.reportsVariables.totalPages = overallReportsModel.totalPages == 0 ? 1 : overallReportsModel.totalPages;
                for (int i = 0; i < overallReportsModel.overallStockReports.length; i++) {
                  OverAllChangeModel overAllChangeModel = OverAllChangeModel.fromJson(overallReportsModel.overallStockReports[i].toJson());
                  mainVariables.reportsVariables.overall.tableData.add(overAllChangeModel.toJson().entries.map((entry) => (entry.value.toString())).toList());
                }
                emit(const ReportsDummy());
                emit(const ReportsLoaded());
              } else {
                emit(const ReportsFailure(errorMessage: "Something went wrong"));
                emit(const ReportsLoaded());
              }
            } else {
              emit(const ReportsFailure(errorMessage: "Something went wrong"));
              emit(const ReportsLoaded());
            }
          });
        }
      case 1:
        {
          await mainVariables.repoImpl.lowStockFunction(query: {
            "searchQuery": mainVariables.reportsVariables.searchController.text,
            "location": mainVariables.reportsVariables.selectedLocationsList,
            "page": mainVariables.reportsVariables.currentPage.toString(),
            "limit": "10",
            "startDate": mainVariables.reportsVariables.filterSelectedStartDate == null ? "" : mainVariables.reportsVariables.filterSelectedStartDate.toString(),
            "endDate": mainVariables.reportsVariables.filterSelectedEndDate == null ? "" : (mainVariables.reportsVariables.filterSelectedEndDate!.add(const Duration(days: 1))).toString(),
            "sort": mainVariables.reportsVariables.sortInt,
          }).onError((error, stackTrace) {
            emit(ReportsFailure(errorMessage: error.toString()));
            emit(const ReportsLoaded());
          }).then((value) async {
            if (value != null) {
              LowStockReportsModel lowStockReportsModel = LowStockReportsModel.fromJson(value);
              if (lowStockReportsModel.status) {
                mainVariables.reportsVariables.lowStock.tableData.clear();
                mainVariables.reportsVariables.totalPages = lowStockReportsModel.totalPages == 0 ? 1 : lowStockReportsModel.totalPages;
                for (int i = 0; i < lowStockReportsModel.lowStockItems.length; i++) {
                  LowStockChangeModel lowStockChangeModel = LowStockChangeModel.fromJson(lowStockReportsModel.lowStockItems[i].toJson());
                  mainVariables.reportsVariables.lowStock.tableData.add(lowStockChangeModel.toJson().entries.map((entry) => (entry.value.toString())).toList());
                }
                emit(const ReportsDummy());
                emit(const ReportsLoaded());
              } else {
                emit(const ReportsFailure(errorMessage: "Something went wrong"));
                emit(const ReportsLoaded());
              }
            } else {
              emit(const ReportsFailure(errorMessage: "Something went wrong"));
              emit(const ReportsLoaded());
            }
          });
        }
      case 2:
        {
          await mainVariables.repoImpl.expiryFunction(query: {
            "searchQuery": mainVariables.reportsVariables.searchController.text,
            "location": mainVariables.reportsVariables.selectedLocationsList,
            "page": mainVariables.reportsVariables.currentPage.toString(),
            "limit": "10",
            "startDate": mainVariables.reportsVariables.filterSelectedStartDate == null ? "" : mainVariables.reportsVariables.filterSelectedStartDate.toString(),
            "endDate": mainVariables.reportsVariables.filterSelectedEndDate == null ? "" : (mainVariables.reportsVariables.filterSelectedEndDate!.add(const Duration(days: 1))).toString(),
            "sort": mainVariables.reportsVariables.sortInt,
          }).onError((error, stackTrace) {
            emit(ReportsFailure(errorMessage: error.toString()));
            emit(const ReportsLoaded());
          }).then((value) async {
            if (value != null) {
              ExpiryReportsModel expiryReportsModel = ExpiryReportsModel.fromJson(value);
              if (expiryReportsModel.status) {
                mainVariables.reportsVariables.expiry.tableData.clear();
                mainVariables.reportsVariables.totalPages = expiryReportsModel.totalPages == 0 ? 1 : expiryReportsModel.totalPages;
                for (int i = 0; i < expiryReportsModel.expiryList.length; i++) {
                  ExpiryChangeModel expiryChangeModel = ExpiryChangeModel.fromJson(expiryReportsModel.expiryList[i].toJson());
                  mainVariables.reportsVariables.expiry.tableData.add(expiryChangeModel.toJson().entries.map((entry) => (entry.value.toString())).toList());
                }
                emit(const ReportsDummy());
                emit(const ReportsLoaded());
              } else {
                emit(const ReportsFailure(errorMessage: "Something went wrong"));
                emit(const ReportsLoaded());
              }
            }
          });
        }
      case 3:
        {
          if (mainVariables.reportsVariables.addDisputePageChanged) {
            mainVariables.reportsVariables.addDisputePageChanged = false;
            emit(const ReportsDummy());
            emit(const ReportsLoaded());
          } else {
            await mainVariables.repoImpl.stockDisputeFunction(query: {
              "searchQuery": mainVariables.reportsVariables.searchController.text,
              "location": mainVariables.reportsVariables.selectedLocationsList,
              "page": mainVariables.reportsVariables.currentPage,
              "limit": 10,
              "startDate": mainVariables.reportsVariables.filterSelectedStartDate == null ? "" : mainVariables.reportsVariables.filterSelectedStartDate.toString(),
              "endDate": mainVariables.reportsVariables.filterSelectedEndDate == null ? "" : (mainVariables.reportsVariables.filterSelectedEndDate!.add(const Duration(days: 1))).toString(),
              "sort": mainVariables.reportsVariables.sortInt,
            }).onError((error, stackTrace) {
              emit(ReportsFailure(errorMessage: error.toString()));
              emit(const ReportsLoaded());
            }).then((value) async {
              if (value != null) {
                DisputeReportsModel disputeReportsModel = DisputeReportsModel.fromJson(value);
                if (disputeReportsModel.status) {
                  mainVariables.reportsVariables.dispute.tableData.clear();
                  mainVariables.reportsVariables.totalPages = disputeReportsModel.totalPages == 0 ? 1 : disputeReportsModel.totalPages;
                  for (int i = 0; i < disputeReportsModel.stockDisputes.length; i++) {
                    DisputesChangeModel disputesChangeModel = DisputesChangeModel.fromJson(disputeReportsModel.stockDisputes[i].toJson());
                    mainVariables.reportsVariables.dispute.tableData.add(disputesChangeModel.toJson().entries.map((entry) => (entry.value.toString())).toList());
                  }
                  emit(const ReportsDummy());
                  emit(const ReportsLoaded());
                } else {
                  emit(const ReportsFailure(errorMessage: "Something went wrong"));
                  emit(const ReportsLoaded());
                }
              }
            });
          }
        }
      case 4:
        {
          await mainVariables.repoImpl.transactionFunction(query: {
            "searchQuery": mainVariables.reportsVariables.searchController.text,
            "location": mainVariables.reportsVariables.selectedLocationsList,
            "page": mainVariables.reportsVariables.currentPage.toString(),
            "limit": "10",
            "startDate": mainVariables.reportsVariables.filterSelectedStartDate == null ? "" : mainVariables.reportsVariables.filterSelectedStartDate.toString(),
            "endDate": mainVariables.reportsVariables.filterSelectedEndDate == null ? "" : (mainVariables.reportsVariables.filterSelectedEndDate!.add(const Duration(days: 1))).toString()
          }).onError((error, stackTrace) {
            emit(ReportsFailure(errorMessage: error.toString()));
            emit(const ReportsLoaded());
          }).then((value) async {
            if (value != null) {
              TransactionHistoryModel transactionHistoryModel = TransactionHistoryModel.fromJson(value);
              if (transactionHistoryModel.status) {
                mainVariables.reportsVariables.transaction.tableData.clear();
                mainVariables.reportsVariables.totalPages = transactionHistoryModel.totalPages == 0 ? 1 : transactionHistoryModel.totalPages;
                for (int i = 0; i < transactionHistoryModel.transactionHistory.length; i++) {
                  TransactionHistoryChangeModel transactionInventoryChangeModel = TransactionHistoryChangeModel.fromJson(transactionHistoryModel.transactionHistory[i].toJson());
                  mainVariables.reportsVariables.transaction.tableData.add(transactionInventoryChangeModel.toJson().entries.map((entry) => (entry.value.toString())).toList());
                }
                emit(const ReportsDummy());
                emit(const ReportsLoaded());
              } else {
                emit(ReportsFailure(errorMessage: transactionHistoryModel.message));
                emit(const ReportsLoaded());
              }
            } else {
              emit(const ReportsFailure(errorMessage: "Something went wrong"));
              emit(const ReportsLoaded());
            }
          });
        }
      case 5:
        {
          await mainVariables.repoImpl.cabinGalleyFunction(query: {
            "searchQuery": mainVariables.reportsVariables.searchController.text,
            "location": mainVariables.reportsVariables.selectedLocationsList,
            "page": mainVariables.reportsVariables.currentPage.toString(),
            "limit": "10",
            "startDate": mainVariables.reportsVariables.filterSelectedStartDate == null ? "" : mainVariables.reportsVariables.filterSelectedStartDate.toString(),
            "endDate": mainVariables.reportsVariables.filterSelectedEndDate == null ? "" : (mainVariables.reportsVariables.filterSelectedEndDate!.add(const Duration(days: 1))).toString(),
            "sort": mainVariables.reportsVariables.sortInt,
          }).onError((error, stackTrace) {
            emit(ReportsFailure(errorMessage: error.toString()));
            emit(const ReportsLoaded());
          }).then((value) async {
            if (value != null) {
              CabinGalleyReportModel cabinGalleyReportModel = CabinGalleyReportModel.fromJson(value);
              if (cabinGalleyReportModel.status) {
                mainVariables.reportsVariables.cabinGalley.tableData.clear();
                mainVariables.reportsVariables.totalPages = cabinGalleyReportModel.totalPages == 0 ? 1 : cabinGalleyReportModel.totalPages;
                for (int i = 0; i < cabinGalleyReportModel.cabinAndGalleyReports.length; i++) {
                  CabinGalleyChangeModel cabinGalleyChangeModel = CabinGalleyChangeModel.fromJson(cabinGalleyReportModel.cabinAndGalleyReports[i].toJson());
                  mainVariables.reportsVariables.cabinGalley.tableData.add(cabinGalleyChangeModel.toJson().entries.map((entry) => (entry.value.toString())).toList());
                }
                emit(const ReportsDummy());
                emit(const ReportsLoaded());
              } else {
                emit(const ReportsFailure(errorMessage: "Something went wrong"));
                emit(const ReportsLoaded());
              }
            } else {
              emit(const ReportsFailure(errorMessage: "Something went wrong"));
              emit(const ReportsLoaded());
            }
          });
        }
      case 6:
        {
          await mainVariables.repoImpl.checkListFunction(query: {
            "searchQuery": mainVariables.reportsVariables.searchController.text,
            "location": mainVariables.reportsVariables.selectedLocationsList,
            "page": mainVariables.reportsVariables.currentPage.toString(),
            "limit": "10",
            "listName": "preflight",
            "startDate": mainVariables.reportsVariables.filterSelectedStartDate == null ? "" : mainVariables.reportsVariables.filterSelectedStartDate.toString(),
            "endDate": mainVariables.reportsVariables.filterSelectedEndDate == null ? "" : (mainVariables.reportsVariables.filterSelectedEndDate!.add(const Duration(days: 1))).toString(),
            "sort": mainVariables.reportsVariables.sortInt,
          }).onError((error, stackTrace) {
            emit(ReportsFailure(errorMessage: error.toString()));
            emit(const ReportsLoaded());
          }).then((value) async {
            if (value != null) {
              GetCheckListApiModel getCheckListApiModel = GetCheckListApiModel.fromJson(value);
              if (getCheckListApiModel.status) {
                mainVariables.reportsVariables.preflight.tableData.clear();
                mainVariables.reportsVariables.totalPages = getCheckListApiModel.totalPages == 0 ? 1 : getCheckListApiModel.totalPages;
                for (int i = 0; i < getCheckListApiModel.data.length; i++) {
                  PreFlightChangeModel preFlightChangeModel = PreFlightChangeModel.fromJson(getCheckListApiModel.data[i].toJson());
                  mainVariables.reportsVariables.preflight.tableData.add(preFlightChangeModel.toJson().entries.map((entry) => (entry.value.toString())).toList());
                }
                emit(const ReportsDummy());
                emit(const ReportsLoaded());
              } else {
                emit(const ReportsFailure(errorMessage: "Something went wrong"));
                emit(const ReportsLoaded());
              }
            } else {
              emit(const ReportsFailure(errorMessage: "Something went wrong"));
              emit(const ReportsLoaded());
            }
          });
        }
      case 7:
        {
          await mainVariables.repoImpl.checkListFunction(query: {
            "searchQuery": mainVariables.reportsVariables.searchController.text,
            "location": mainVariables.reportsVariables.selectedLocationsList,
            "page": mainVariables.reportsVariables.currentPage.toString(),
            "limit": "10",
            "listName": "postflight",
            "startDate": mainVariables.reportsVariables.filterSelectedStartDate == null ? "" : mainVariables.reportsVariables.filterSelectedStartDate.toString(),
            "endDate": mainVariables.reportsVariables.filterSelectedEndDate == null ? "" : (mainVariables.reportsVariables.filterSelectedEndDate!.add(const Duration(days: 1))).toString(),
            "sort": mainVariables.reportsVariables.sortInt,
          }).onError((error, stackTrace) {
            emit(ReportsFailure(errorMessage: error.toString()));
            emit(const ReportsLoaded());
          }).then((value) async {
            if (value != null) {
              GetCheckListApiModel getCheckListApiModel = GetCheckListApiModel.fromJson(value);
              if (getCheckListApiModel.status) {
                mainVariables.reportsVariables.postFlight.tableData.clear();
                mainVariables.reportsVariables.totalPages = getCheckListApiModel.totalPages == 0 ? 1 : getCheckListApiModel.totalPages;
                for (int i = 0; i < getCheckListApiModel.data.length; i++) {
                  PostFlightChangeModel postFlightChangeModel = PostFlightChangeModel.fromJson(getCheckListApiModel.data[i].toJson());
                  mainVariables.reportsVariables.postFlight.tableData.add(postFlightChangeModel.toJson().entries.map((entry) => (entry.value.toString())).toList());
                }
                emit(const ReportsDummy());
                emit(const ReportsLoaded());
              } else {
                emit(const ReportsFailure(errorMessage: "Something went wrong"));
                emit(const ReportsLoaded());
              }
            } else {
              emit(const ReportsFailure(errorMessage: "Something went wrong"));
              emit(const ReportsLoaded());
            }
          });
        }
      case 8:
        {
          await mainVariables.repoImpl.checkListFunction(query: {
            "searchQuery": mainVariables.reportsVariables.searchController.text,
            "location": mainVariables.reportsVariables.selectedLocationsList,
            "page": mainVariables.reportsVariables.currentPage.toString(),
            "limit": "10",
            "listName": "maintenance",
            "startDate": mainVariables.reportsVariables.filterSelectedStartDate == null ? "" : mainVariables.reportsVariables.filterSelectedStartDate.toString(),
            "endDate": mainVariables.reportsVariables.filterSelectedEndDate == null ? "" : (mainVariables.reportsVariables.filterSelectedEndDate!.add(const Duration(days: 1))).toString(),
            "sort": mainVariables.reportsVariables.sortInt,
          }).onError((error, stackTrace) {
            emit(ReportsFailure(errorMessage: error.toString()));
            emit(const ReportsLoaded());
          }).then((value) async {
            if (value != null) {
              GetCheckListApiModel getCheckListApiModel = GetCheckListApiModel.fromJson(value);
              if (getCheckListApiModel.status) {
                mainVariables.reportsVariables.maintenance.tableData.clear();
                mainVariables.reportsVariables.totalPages = getCheckListApiModel.totalPages == 0 ? 1 : getCheckListApiModel.totalPages;
                for (int i = 0; i < getCheckListApiModel.data.length; i++) {
                  MaintenanceChangeModel maintenanceChangeModel = MaintenanceChangeModel.fromJson(getCheckListApiModel.data[i].toJson());
                  mainVariables.reportsVariables.maintenance.tableData.add(maintenanceChangeModel.toJson().entries.map((entry) => (entry.value.toString())).toList());
                }
                emit(const ReportsDummy());
                emit(const ReportsLoaded());
              } else {
                emit(const ReportsFailure(errorMessage: "Something went wrong"));
                emit(const ReportsLoaded());
              }
            } else {
              emit(const ReportsFailure(errorMessage: "Something went wrong"));
              emit(const ReportsLoaded());
            }
          });
        }
      case 9:
        {
          await mainVariables.repoImpl.checkListFunction(query: {
            "searchQuery": mainVariables.reportsVariables.searchController.text,
            "location": mainVariables.reportsVariables.selectedLocationsList,
            "page": mainVariables.reportsVariables.currentPage.toString(),
            "limit": "10",
            "listName": "safety",
            "startDate": mainVariables.reportsVariables.filterSelectedStartDate == null ? "" : mainVariables.reportsVariables.filterSelectedStartDate.toString(),
            "endDate": mainVariables.reportsVariables.filterSelectedEndDate == null ? "" : (mainVariables.reportsVariables.filterSelectedEndDate!.add(const Duration(days: 1))).toString(),
            "sort": mainVariables.reportsVariables.sortInt,
          }).onError((error, stackTrace) {
            emit(ReportsFailure(errorMessage: error.toString()));
            emit(const ReportsLoaded());
          }).then((value) async {
            if (value != null) {
              GetCheckListApiModel getCheckListApiModel = GetCheckListApiModel.fromJson(value);
              if (getCheckListApiModel.status) {
                mainVariables.reportsVariables.safety.tableData.clear();
                mainVariables.reportsVariables.totalPages = getCheckListApiModel.totalPages == 0 ? 1 : getCheckListApiModel.totalPages;
                for (int i = 0; i < getCheckListApiModel.data.length; i++) {
                  SafetyChangeModel safetyChangeModel = SafetyChangeModel.fromJson(getCheckListApiModel.data[i].toJson());
                  mainVariables.reportsVariables.safety.tableData.add(safetyChangeModel.toJson().entries.map((entry) => (entry.value.toString())).toList());
                }
                emit(const ReportsDummy());
                emit(const ReportsLoaded());
              } else {
                emit(const ReportsFailure(errorMessage: "Something went wrong"));
                emit(const ReportsLoaded());
              }
            } else {
              emit(const ReportsFailure(errorMessage: "Something went wrong"));
              emit(const ReportsLoaded());
            }
          });
        }
      default:
        {}
    }
    emit(const ReportsDummy());
    emit(const ReportsLoaded());
  }

  Future<void> calenderEnablingFunction(CalenderEnablingEvent event, Emitter<ReportsState> emit) async {
    mainVariables.reportsVariables.filterCalenderEnabled = !mainVariables.reportsVariables.filterCalenderEnabled;
    mainFunctions.countFilters();
    emit(const ReportsDummy());
    emit(const ReportsLoaded());
  }

  Future<void> calenderSelectionFunction(CalenderSelectionEvent event, Emitter<ReportsState> emit) async {
    if (event.endDate == null) {
      if (event.startDate == null) {
        mainVariables.reportsVariables.filterController.clear();
        mainVariables.reportsVariables.filterSelectedStartDate = event.startDate;
        mainVariables.reportsVariables.filterSelectedEndDate = event.endDate;
      } else {
        mainVariables.reportsVariables.filterController.text = event.startDate.toString().substring(0, 10);
        mainVariables.reportsVariables.filterSelectedStartDate = event.startDate;
        mainVariables.reportsVariables.filterSelectedEndDate = event.endDate;
      }
    } else if (event.endDate == event.startDate) {
      mainVariables.reportsVariables.filterController.text = event.startDate.toString().substring(0, 10);
      mainVariables.reportsVariables.filterSelectedStartDate = event.startDate;
      mainVariables.reportsVariables.filterSelectedEndDate = null;
    } else {
      mainVariables.reportsVariables.filterController.text = ("${event.startDate.toString().substring(0, 10)} to ${event.endDate.toString().substring(0, 10)}");
      mainVariables.reportsVariables.filterSelectedStartDate = event.startDate;
      mainVariables.reportsVariables.filterSelectedEndDate = event.endDate;
    }
    mainFunctions.countFilters();
    emit(const ReportsDummy());
    emit(const ReportsLoaded());
  }

  Future<void> locationSelectionAllFunction(LocationSelectionAllEvent event, Emitter<ReportsState> emit) async {
    if (event.isAllCheck) {
      mainVariables.reportsVariables.selectAllEnabled = true;
      mainVariables.reportsVariables.locationSelectEnabledList.clear();
      mainVariables.reportsVariables.locationSelectEnabledList = List.generate(mainVariables.stockMovementVariables.senderInfo.locationDropDownList.length, (index) => true);
    } else {
      mainVariables.reportsVariables.selectAllEnabled = false;
      mainVariables.reportsVariables.locationSelectEnabledList.clear();
      mainVariables.reportsVariables.locationSelectEnabledList = List.generate(mainVariables.stockMovementVariables.senderInfo.locationDropDownList.length, (index) => false);
    }
    mainVariables.reportsVariables.selectedLocationsList.clear();
    mainFunctions.countFilters();
    emit(const ReportsDummy());
    emit(const ReportsLoaded());
  }

  Future<void> locationSelectionSingleFunction(LocationSelectionSingleEvent event, Emitter<ReportsState> emit) async {
    if (event.selectedIndexValue) {
      if (mainVariables.reportsVariables.selectAllEnabled) {
        mainVariables.reportsVariables.locationSelectEnabledList[event.selectedIndex] = event.selectedIndexValue;
      } else {
        mainVariables.reportsVariables.locationSelectEnabledList[event.selectedIndex] = event.selectedIndexValue;
        mainVariables.reportsVariables.selectAllEnabled = mainVariables.reportsVariables.locationSelectEnabledList.contains(false) == false;
      }
    } else {
      if (mainVariables.reportsVariables.selectAllEnabled) {
        mainVariables.reportsVariables.selectAllEnabled = false;
        mainVariables.reportsVariables.locationSelectEnabledList.clear();
        mainVariables.reportsVariables.locationSelectEnabledList = List.generate(mainVariables.stockMovementVariables.senderInfo.locationDropDownList.length, (index) => true);
        mainVariables.reportsVariables.locationSelectEnabledList[event.selectedIndex] = event.selectedIndexValue;
      } else {
        mainVariables.reportsVariables.locationSelectEnabledList[event.selectedIndex] = event.selectedIndexValue;
      }
    }
    mainVariables.reportsVariables.selectedLocationsList.clear();
    for (int i = 0; i < mainVariables.reportsVariables.locationSelectEnabledList.length; i++) {
      if (mainVariables.reportsVariables.locationSelectEnabledList[i]) {
        mainVariables.reportsVariables.selectedLocationsList.add(mainVariables.stockMovementVariables.senderInfo.locationDropDownList[i].value);
      }
    }
    mainFunctions.countFilters();
    emit(const ReportsDummy());
    emit(const ReportsLoaded());
  }

  FutureOr<void> downloadFileFunction(DownloadFileEvent event, Emitter<ReportsState> emit) async {
    try {
      if (await Permission.storage.request().isGranted) {
        Directory? downloadsDir = await mainFunctions.getDownloadsDirectory();
        if (downloadsDir != null) {
          String savePath = "${downloadsDir.path}/reports_${mainFunctions.dateTimeFormatFileName(date: DateTime.now().toString())}_downloaded_file.csv";
          switch (mainVariables.reportsVariables.reportsSelectedIndex) {
            case 0:
              {
                await mainVariables.repoImpl.fileReportsOverallDownload(query: {
                  "searchQuery": mainVariables.reportsVariables.searchController.text,
                  "location": mainVariables.reportsVariables.selectedLocationsList,
                  "startDate": mainVariables.reportsVariables.filterSelectedStartDate == null ? "" : mainVariables.reportsVariables.filterSelectedStartDate.toString(),
                  "endDate": mainVariables.reportsVariables.filterSelectedEndDate == null ? "" : (mainVariables.reportsVariables.filterSelectedEndDate!.add(const Duration(days: 1))).toString()
                }).onError((error, stackTrace) {
                  emit(ReportsFailure(errorMessage: error.toString()));
                  emit(const ReportsLoaded());
                }).then((value) async {
                  if (value != null) {
                    File file = File(savePath);
                    await file.writeAsBytes(value);
                    emit(ReportsSuccess(message: 'File downloaded successfully to ${file.path}'));
                    emit(const ReportsLoaded());
                  }
                });
              }
            case 1:
              {
                await mainVariables.repoImpl.fileReportsLowStockDownload(query: {
                  "searchQuery": mainVariables.reportsVariables.searchController.text,
                  "location": mainVariables.reportsVariables.selectedLocationsList,
                  "startDate": mainVariables.reportsVariables.filterSelectedStartDate == null ? "" : mainVariables.reportsVariables.filterSelectedStartDate.toString(),
                  "endDate": mainVariables.reportsVariables.filterSelectedEndDate == null ? "" : (mainVariables.reportsVariables.filterSelectedEndDate!.add(const Duration(days: 1))).toString()
                }).onError((error, stackTrace) {
                  emit(ReportsFailure(errorMessage: error.toString()));
                  emit(const ReportsLoaded());
                }).then((value) async {
                  if (value != null) {
                    File file = File(savePath);
                    await file.writeAsBytes(value);
                    emit(ReportsSuccess(message: 'File downloaded successfully to ${file.path}'));
                    emit(const ReportsLoaded());
                  }
                });
              }
            case 2:
              {
                await mainVariables.repoImpl.fileReportsExpiryDownload(query: {
                  "searchQuery": mainVariables.reportsVariables.searchController.text,
                  "location": mainVariables.reportsVariables.selectedLocationsList,
                  "startDate": mainVariables.reportsVariables.filterSelectedStartDate == null ? "" : mainVariables.reportsVariables.filterSelectedStartDate.toString(),
                  "endDate": mainVariables.reportsVariables.filterSelectedEndDate == null ? "" : (mainVariables.reportsVariables.filterSelectedEndDate!.add(const Duration(days: 1))).toString()
                }).onError((error, stackTrace) {
                  emit(ReportsFailure(errorMessage: error.toString()));
                  emit(const ReportsLoaded());
                }).then((value) async {
                  if (value != null) {
                    File file = File(savePath);
                    await file.writeAsBytes(value);
                    emit(ReportsSuccess(message: 'File downloaded successfully to ${file.path}'));
                    emit(const ReportsLoaded());
                  }
                });
              }
            case 3:
              {
                await mainVariables.repoImpl.fileReportsStockDisputeDownload(query: {
                  "searchQuery": mainVariables.reportsVariables.searchController.text,
                  "location": mainVariables.reportsVariables.selectedLocationsList,
                  "startDate": mainVariables.reportsVariables.filterSelectedStartDate == null ? "" : mainVariables.reportsVariables.filterSelectedStartDate.toString(),
                  "endDate": mainVariables.reportsVariables.filterSelectedEndDate == null ? "" : (mainVariables.reportsVariables.filterSelectedEndDate!.add(const Duration(days: 1))).toString()
                }).onError((error, stackTrace) {
                  emit(ReportsFailure(errorMessage: error.toString()));
                  emit(const ReportsLoaded());
                }).then((value) async {
                  if (value != null) {
                    File file = File(savePath);
                    await file.writeAsBytes(value);
                    emit(ReportsSuccess(message: 'File downloaded successfully to ${file.path}'));
                    emit(const ReportsLoaded());
                  }
                });
              }
            case 4:
              {
                await mainVariables.repoImpl.fileReportsTransactionDownload(query: {
                  "searchQuery": mainVariables.reportsVariables.searchController.text,
                  "location": mainVariables.reportsVariables.selectedLocationsList,
                  "startDate": mainVariables.reportsVariables.filterSelectedStartDate == null ? "" : mainVariables.reportsVariables.filterSelectedStartDate.toString(),
                  "endDate": mainVariables.reportsVariables.filterSelectedEndDate == null ? "" : (mainVariables.reportsVariables.filterSelectedEndDate!.add(const Duration(days: 1))).toString()
                }).onError((error, stackTrace) {
                  emit(ReportsFailure(errorMessage: error.toString()));
                  emit(const ReportsLoaded());
                }).then((value) async {
                  if (value != null) {
                    File file = File(savePath);
                    await file.writeAsBytes(value);
                    emit(ReportsSuccess(message: 'File downloaded successfully to ${file.path}'));
                    emit(const ReportsLoaded());
                  }
                });
              }
            case 5:
              {
                await mainVariables.repoImpl.fileReportsCabinGalleyDownload(query: {
                  "searchQuery": mainVariables.reportsVariables.searchController.text,
                  "location": mainVariables.reportsVariables.selectedLocationsList,
                  "startDate": mainVariables.reportsVariables.filterSelectedStartDate == null ? "" : mainVariables.reportsVariables.filterSelectedStartDate.toString(),
                  "endDate": mainVariables.reportsVariables.filterSelectedEndDate == null ? "" : (mainVariables.reportsVariables.filterSelectedEndDate!.add(const Duration(days: 1))).toString()
                }).onError((error, stackTrace) {
                  emit(ReportsFailure(errorMessage: error.toString()));
                  emit(const ReportsLoaded());
                }).then((value) async {
                  if (value != null) {
                    File file = File(savePath);
                    await file.writeAsBytes(value);
                    emit(ReportsSuccess(message: 'File downloaded successfully to ${file.path}'));
                    emit(const ReportsLoaded());
                  }
                });
              }
            case 6:
              {
                await mainVariables.repoImpl.fileReportsCheckListDownload(query: {
                  "searchQuery": mainVariables.reportsVariables.searchController.text,
                  "location": mainVariables.reportsVariables.selectedLocationsList,
                  "startDate": mainVariables.reportsVariables.filterSelectedStartDate == null ? "" : mainVariables.reportsVariables.filterSelectedStartDate.toString(),
                  "endDate": mainVariables.reportsVariables.filterSelectedEndDate == null ? "" : (mainVariables.reportsVariables.filterSelectedEndDate!.add(const Duration(days: 1))).toString(),
                  "listName": "preflight",
                }).onError((error, stackTrace) {
                  emit(ReportsFailure(errorMessage: error.toString()));
                  emit(const ReportsLoaded());
                }).then((value) async {
                  if (value != null) {
                    File file = File(savePath);
                    await file.writeAsBytes(value);
                    emit(ReportsSuccess(message: 'File downloaded successfully to ${file.path}'));
                    emit(const ReportsLoaded());
                  }
                });
              }
            case 7:
              {
                await mainVariables.repoImpl.fileReportsCheckListDownload(query: {
                  "searchQuery": mainVariables.reportsVariables.searchController.text,
                  "location": mainVariables.reportsVariables.selectedLocationsList,
                  "startDate": mainVariables.reportsVariables.filterSelectedStartDate == null ? "" : mainVariables.reportsVariables.filterSelectedStartDate.toString(),
                  "endDate": mainVariables.reportsVariables.filterSelectedEndDate == null ? "" : (mainVariables.reportsVariables.filterSelectedEndDate!.add(const Duration(days: 1))).toString(),
                  "listName": "postflight",
                }).onError((error, stackTrace) {
                  emit(ReportsFailure(errorMessage: error.toString()));
                  emit(const ReportsLoaded());
                }).then((value) async {
                  if (value != null) {
                    File file = File(savePath);
                    await file.writeAsBytes(value);
                    emit(ReportsSuccess(message: 'File downloaded successfully to ${file.path}'));
                    emit(const ReportsLoaded());
                  }
                });
              }
            case 8:
              {
                await mainVariables.repoImpl.fileReportsCheckListDownload(query: {
                  "searchQuery": mainVariables.reportsVariables.searchController.text,
                  "location": mainVariables.reportsVariables.selectedLocationsList,
                  "startDate": mainVariables.reportsVariables.filterSelectedStartDate == null ? "" : mainVariables.reportsVariables.filterSelectedStartDate.toString(),
                  "endDate": mainVariables.reportsVariables.filterSelectedEndDate == null ? "" : (mainVariables.reportsVariables.filterSelectedEndDate!.add(const Duration(days: 1))).toString(),
                  "listName": "maintenance",
                }).onError((error, stackTrace) {
                  emit(ReportsFailure(errorMessage: error.toString()));
                  emit(const ReportsLoaded());
                }).then((value) async {
                  if (value != null) {
                    File file = File(savePath);
                    await file.writeAsBytes(value);
                    emit(ReportsSuccess(message: 'File downloaded successfully to ${file.path}'));
                    emit(const ReportsLoaded());
                  }
                });
              }
            case 9:
              {
                await mainVariables.repoImpl.fileReportsCheckListDownload(query: {
                  "searchQuery": mainVariables.reportsVariables.searchController.text,
                  "location": mainVariables.reportsVariables.selectedLocationsList,
                  "startDate": mainVariables.reportsVariables.filterSelectedStartDate == null ? "" : mainVariables.reportsVariables.filterSelectedStartDate.toString(),
                  "endDate": mainVariables.reportsVariables.filterSelectedEndDate == null ? "" : (mainVariables.reportsVariables.filterSelectedEndDate!.add(const Duration(days: 1))).toString(),
                  "listName": "safety",
                }).onError((error, stackTrace) {
                  emit(ReportsFailure(errorMessage: error.toString()));
                  emit(const ReportsLoaded());
                }).then((value) async {
                  if (value != null) {
                    File file = File(savePath);
                    await file.writeAsBytes(value);
                    emit(ReportsSuccess(message: 'File downloaded successfully to ${file.path}'));
                    emit(const ReportsLoaded());
                  }
                });
              }
            default:
              {}
          }
        } else {
          emit(const ReportsFailure(errorMessage: 'Failed to get downloads directory'));
          emit(const ReportsLoaded());
        }
      } else {
        emit(const ReportsFailure(errorMessage: 'Permission denied to access storage'));
        emit(const ReportsLoaded());
      }
    } catch (e) {
      emit(ReportsFailure(errorMessage: 'Error downloading file: $e'));
      emit(const ReportsLoaded());
    }
  }
}
