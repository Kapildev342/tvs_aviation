import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvsaviation/data/model/api_model/get_all_check_list_model.dart';
import 'package:tvsaviation/data/model/api_model/get_check_list_value_model.dart';
import 'package:tvsaviation/data/model/variable_model/inventory_change_model.dart';
import 'package:tvsaviation/resources/constants.dart';
import 'package:tvsaviation/resources/drop_down_lib/dropdown_textfield.dart';

part 'check_list_event.dart';
part 'check_list_state.dart';

class CheckListBloc extends Bloc<CheckListEvent, CheckListState> {
  CheckListBloc() : super(const CheckListLoading()) {
    on<CheckListPageInitialEvent>(checkListPageInitialFunction);
    on<CheckListPageChangingEvent>(checkListPageChangingFunction);
    on<CheckListAddEvent>(checkListAddFunction);
  }

  FutureOr<void> checkListPageInitialFunction(CheckListPageInitialEvent event, Emitter<CheckListState> emit) async {
    emit(const CheckListLoading());
    await mainVariables.repoImpl.getSingleCheckListDetail(query: {
      "orderId": mainVariables.generalVariables.selectedCheckListId,
    }).onError((error, stackTrace) {
      emit(CheckListFailure(errorMessage: error.toString()));
      emit(const CheckListLoading());
    }).then((value) async {
      if (value != null) {
        mainVariables.checkListVariables.getValue = GetCheckListValueModel.fromJson(value);
        if (mainVariables.checkListVariables.getValue.status) {
          for (int i = 0; i < mainVariables.checkListVariables.getValue.data.checklistsSingle.length; i++) {
            mainVariables.checkListVariables.getValue.data.checklistsSingle[i].checks.removeWhere((item) => item.name == '');
          }
          mainVariables.checkListVariables.senderLocationChoose = DropDownValueModel(name: mainVariables.checkListVariables.getValue.data.locationName, value: mainVariables.checkListVariables.getValue.data.locationId);
          mainVariables.checkListVariables.senderFromSectorChoose = DropDownValueModel(name: mainVariables.checkListVariables.getValue.data.sectorFrom, value: mainVariables.checkListVariables.getValue.data.sectorFromId);
          mainVariables.checkListVariables.senderToSectorChoose = DropDownValueModel(name: mainVariables.checkListVariables.getValue.data.sectorTo, value: mainVariables.checkListVariables.getValue.data.sectorToId);
          for (int i = 0; i < mainVariables.checkListVariables.getValue.data.checklistsSingle.length; i++) {
            List<bool> checksBoolList = [];
            for (int j = 0; j < mainVariables.checkListVariables.getValue.data.checklistsSingle[i].checks.length; j++) {
              checksBoolList.add(mainVariables.checkListVariables.getValue.data.checklistsSingle[i].checks[j].status);
            }
            mainVariables.checkListVariables.getValue.data.checklistsSingle[i].status = checksBoolList.contains(false) == false;
          }
          List<bool> headingBoolList = List.generate(mainVariables.checkListVariables.getValue.data.checklistsSingle.length, (index) => mainVariables.checkListVariables.getValue.data.checklistsSingle[index].status);
          mainVariables.checkListVariables.getValue.selectAllStatus = headingBoolList.contains(false) == false;
          List<bool> othersBoolList = List.generate(mainVariables.checkListVariables.getValue.data.otherLists.checks.length, (index) => mainVariables.checkListVariables.getValue.data.otherLists.checks[index].status);
          mainVariables.checkListVariables.getValue.data.otherLists.status = othersBoolList.contains(false) == false;
          emit(const CheckListDummy());
          emit(const CheckListLoaded());
        } else {
          emit(CheckListFailure(errorMessage: value["message"]));
          emit(const CheckListLoading());
        }
      } else {
        emit(const CheckListFailure(errorMessage: "Something went wrong"));
        emit(const CheckListLoaded());
      }
    });
  }

  FutureOr<void> checkListPageChangingFunction(CheckListPageChangingEvent event, Emitter<CheckListState> emit) async {
    emit(const CheckListLoading());
    Map<String, dynamic> queryData = {};
    switch (mainVariables.checkListVariables.checkListSelectedIndex) {
      case 0:
        {
          mainVariables.checkListVariables.listName = "preflight";
          queryData = {"listName": "preflight"};
        }
      case 1:
        {
          mainVariables.checkListVariables.listName = "postflight";
          queryData = {"listName": "postflight"};
        }
      case 2:
        {
          mainVariables.checkListVariables.listName = "maintenance";
          queryData = {"listName": "maintenance"};
        }
      default:
        {
          mainVariables.checkListVariables.listName = "preflight";
          queryData = {"listName": "preflight"};
        }
    }
    await mainVariables.repoImpl.getCheckList(query: queryData).onError((error, stackTrace) {
      emit(CheckListFailure(errorMessage: error.toString()));
      emit(const CheckListLoading());
    }).then((value) async {
      if (value != null) {
        GetCheckListModel getCheckListModel = GetCheckListModel.fromJson(value);
        if (getCheckListModel.status) {
          mainVariables.checkListVariables.listName = getCheckListModel.data.listName;
          for (int i = 0; i < getCheckListModel.data.checklists.length; i++) {
            getCheckListModel.data.checklists[i].checks.removeWhere((item) => item.name == '');
          }
          mainVariables.checkListVariables.checklists = getCheckListModel.data.checklists;
          mainVariables.checkListVariables.otherList = getCheckListModel.data.otherList;
          for (int i = 0; i < getCheckListModel.data.checklists.length; i++) {
            for (int j = 0; j < getCheckListModel.data.checklists[i].checks.length; j++) {
              getCheckListModel.data.checklists[i].checks[j].isAdded = true;
            }
            if (getCheckListModel.data.checklists[i].checks.isNotEmpty) {
              mainVariables.checkListVariables.checklists[i].activeButtonsEnabled = true;
            } else {
              mainVariables.checkListVariables.checklists[i].activeButtonsEnabled = false;
            }
          }
          emit(const CheckListDummy());
          emit(const CheckListLoaded());
        } else {
          emit(CheckListFailure(errorMessage: value["message"]));
          emit(const CheckListLoading());
        }
      } else {
        emit(const CheckListFailure(errorMessage: "Something went wrong"));
        emit(const CheckListLoaded());
      }
    });
  }

  FutureOr<void> checkListAddFunction(CheckListAddEvent event, Emitter<CheckListState> emit) async {
    mainVariables.checkListVariables.loader = true;
    emit(const CheckListDummy());
    emit(const CheckListLoaded());
    CheckListAddFormatChangeModel checkListAddFormatChangeModel = CheckListAddFormatChangeModel.fromJson({});
    checkListAddFormatChangeModel.listName = mainVariables.checkListVariables.listName;
    checkListAddFormatChangeModel.userId = mainVariables.generalVariables.userData.id;
    checkListAddFormatChangeModel.date = DateTime.now().toString();
    checkListAddFormatChangeModel.locationId = mainVariables.checkListVariables.senderLocationChoose.value;
    checkListAddFormatChangeModel.sectorFrom = mainVariables.checkListVariables.senderFromSectorChoose.value;
    checkListAddFormatChangeModel.sectorTo = mainVariables.checkListVariables.senderToSectorChoose.value;
    checkListAddFormatChangeModel.otherLists.fieldName = "${mainVariables.checkListVariables.otherList.fieldName[0]} ${mainVariables.checkListVariables.otherList.fieldName[1]}";
    checkListAddFormatChangeModel.otherLists.remarks = mainVariables.checkListVariables.otherList.remarksController.text;
    for (int i = 0; i < mainVariables.checkListVariables.checklists.length; i++) {
      mainVariables.checkListVariables.checklists[i].checks.removeWhere((item) => item.name == '');
      ChecklistValue checkValue = ChecklistValue.fromJson(mainVariables.checkListVariables.checklists[i].toJson());
      checkValue.remarks = mainVariables.checkListVariables.checklists[i].remarksController.text;
      checkListAddFormatChangeModel.checklists.add(checkValue);
    }
    for (int j = 0; j < mainVariables.checkListVariables.otherList.checks.length; j++) {
      Check check = Check.fromJson(mainVariables.checkListVariables.otherList.checks[j].toJson());
      checkListAddFormatChangeModel.otherLists.checks.add(check);
    }
    await mainVariables.repoImpl.addCheckList(query: checkListAddFormatChangeModel.toJson()).onError((error, stackTrace) {
      mainVariables.checkListVariables.loader = false;
      emit(CheckListFailure(errorMessage: error.toString()));
      emit(const CheckListLoaded());
    }).then((value) async {
      if (value != null) {
        if (value["status"]) {
          mainVariables.checkListVariables.loader = false;
          emit(CheckListSuccess(message: value["message"]));
          emit(const CheckListLoaded());
        } else {
          mainVariables.checkListVariables.loader = false;
          emit(CheckListFailure(errorMessage: value["message"]));
          emit(const CheckListLoaded());
        }
      } else {
        mainVariables.checkListVariables.loader = false;
        emit(const CheckListFailure(errorMessage: "Something went wrong"));
        emit(const CheckListLoaded());
      }
    });
  }
}
