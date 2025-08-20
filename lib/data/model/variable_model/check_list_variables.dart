import 'dart:convert';

import 'package:tvsaviation/data/model/api_model/get_all_check_list_model.dart';
import 'package:tvsaviation/data/model/api_model/get_check_list_value_model.dart';
import 'package:tvsaviation/resources/drop_down_lib/dropdown_textfield.dart';

CheckListVariables checkListVariablesFromJson(String str) => CheckListVariables.fromJson(json.decode(str));

String checkListVariablesToJson(CheckListVariables data) => json.encode(data.toJson());

class CheckListVariables {
  bool loader;
  int checkListSelectedIndex;
  DropDownValueModel senderLocationChoose;
  DropDownValueModel senderFromSectorChoose;
  DropDownValueModel senderToSectorChoose;
  OtherList otherList;
  String listName;
  List<Checklist> checklists;
  bool isAllChecksSelected;
  GetCheckListValueModel getValue;

  CheckListVariables({
    required this.loader,
    required this.checkListSelectedIndex,
    required this.senderLocationChoose,
    required this.senderFromSectorChoose,
    required this.senderToSectorChoose,
    required this.otherList,
    required this.listName,
    required this.checklists,
    required this.isAllChecksSelected,
    required this.getValue,
  });

  factory CheckListVariables.fromJson(Map<String, dynamic> json) => CheckListVariables(
        loader: json["loader"] ?? false,
        checkListSelectedIndex: json["checklist_selected_index"] ?? 0,
        senderLocationChoose: DropDownValueModel.fromJson(json["sender_location_choose"] ?? {}),
        senderFromSectorChoose: DropDownValueModel.fromJson(json["sender_from_sector_choose"] ?? {}),
        senderToSectorChoose: DropDownValueModel.fromJson(json["sender_to_sector_choose"] ?? {}),
        otherList: OtherList.fromJson(json["otherlist"] ?? {}),
        listName: json["listName"] ?? "",
        checklists: List<Checklist>.from((json["checklists"] ?? []).map((x) => Checklist.fromJson(x))),
        isAllChecksSelected: json["is_all_checks_selected"] ?? false,
        getValue: GetCheckListValueModel.fromJson(json["get_value"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "loader": loader,
        "checklist_selected_index": checkListSelectedIndex,
        "sender_location_choose": senderLocationChoose,
        "sender_from_sector_choose": senderFromSectorChoose,
        "sender_to_sector_choose": senderToSectorChoose,
        "otherlist": otherList.toJson(),
        "listName": listName,
        "checklists": List<dynamic>.from(checklists.map((x) => x.toJson())),
        "is_all_checks_selected": isAllChecksSelected,
        "get_value": getValue,
      };
}
