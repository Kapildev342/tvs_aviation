import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvsaviation/bloc/check_list/check_list_bloc.dart';
import 'package:tvsaviation/bloc/rail_navigation/rail_navigation_bloc.dart';
import 'package:tvsaviation/data/model/api_model/get_all_check_list_model.dart';
import 'package:tvsaviation/resources/constants.dart';
import 'package:tvsaviation/resources/drop_down_lib/dropdown_textfield.dart';
import 'package:tvsaviation/resources/widgets.dart';

class CheckListScreen extends StatefulWidget {
  static const String id = "check_list";
  const CheckListScreen({super.key});

  @override
  State<CheckListScreen> createState() => CheckListScreenState();
}

class CheckListScreenState extends State<CheckListScreen> {
  GlobalKey<DropDownTextFieldState> key13 = GlobalKey<DropDownTextFieldState>();
  GlobalKey<DropDownTextFieldState> key14 = GlobalKey<DropDownTextFieldState>();
  GlobalKey<DropDownTextFieldState> key15 = GlobalKey<DropDownTextFieldState>();
  @override
  void initState() {
    if (key13.currentState != null) {
      key13.currentState!.searchCnt.clear();
      key13.currentState!.newDropDownList.clear();
      key13.currentState!.searchFocusNode.unfocus();
      key13.currentState!.textFieldFocusNode.unfocus();
    }
    if (key14.currentState != null) {
      key14.currentState!.searchCnt.clear();
      key14.currentState!.newDropDownList.clear();
      key14.currentState!.searchFocusNode.unfocus();
      key14.currentState!.textFieldFocusNode.unfocus();
    }
    if (key15.currentState != null) {
      key15.currentState!.searchCnt.clear();
      key15.currentState!.newDropDownList.clear();
      key15.currentState!.searchFocusNode.unfocus();
      key15.currentState!.textFieldFocusNode.unfocus();
    }
    super.initState();
  }

  @override
  void dispose() {
    if (key13.currentState != null) {
      key13.currentState!.searchCnt.clear();
      key13.currentState!.newDropDownList.clear();
      key13.currentState!.searchFocusNode.unfocus();
      key13.currentState!.textFieldFocusNode.unfocus();
    }
    if (key14.currentState != null) {
      key14.currentState!.searchCnt.clear();
      key14.currentState!.newDropDownList.clear();
      key14.currentState!.searchFocusNode.unfocus();
      key14.currentState!.textFieldFocusNode.unfocus();
    }
    if (key15.currentState != null) {
      key15.currentState!.searchCnt.clear();
      key15.currentState!.newDropDownList.clear();
      key15.currentState!.searchFocusNode.unfocus();
      key15.currentState!.textFieldFocusNode.unfocus();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvoked: (value) {
          if (mainVariables.generalVariables.currentPage.value == "view_check_list") {
            mainVariables.generalVariables.selectedCheckListId = "";
            mainVariables.generalVariables.railNavigateBackIndex = mainVariables.generalVariables.railNavigateIndex;
            mainVariables.generalVariables.railNavigateIndex = 4;
            mainVariables.generalVariables.currentPage.value = "";
            context.read<RailNavigationBloc>().add(const RailNavigationSelectedWidgetEvent());
          } else {
            mainVariables.generalVariables.railNavigateBackIndex = mainVariables.generalVariables.railNavigateIndex;
            mainVariables.generalVariables.railNavigateIndex = 0;
            mainVariables.generalVariables.currentPage.value = "";
            mainVariables.railNavigationVariables.mainSelectedIndex = 0;
            mainVariables.homeVariables.homeLocationSelectedIndex = -1;
            mainVariables.homeVariables.quickLinksEnabled = false;
            mainVariables.inventoryVariables.tabControllerIndex = 0;
            mainVariables.inventoryVariables.tabsEnableList.clear();
            mainVariables.inventoryVariables.tabsEnableList = List.generate(3, (index) => false);
            mainVariables.inventoryVariables.tabsEnableList[0] = true;
            mainVariables.homeVariables.quickLinksEnabled = false;
            mainVariables.reportsVariables.reportsSelectedIndex = 0;
            mainVariables.manageVariables.manageSelectedIndex = 0;
            mainVariables.checkListVariables.checkListSelectedIndex = 0;
            context.read<RailNavigationBloc>().add(const RailNavigationSelectedWidgetEvent());
          }
        },
        child: bodyWidget());
  }

  Widget bodyWidget() {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: mainFunctions.getWidgetHeight(height: 20),
        horizontal: mainFunctions.getWidgetWidth(width: 20),
      ),
      decoration: BoxDecoration(
        color: mainColors.whiteColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            blurRadius: 4.0,
            spreadRadius: 10.0,
            color: Colors.grey.shade200,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: mainFunctions.getWidgetHeight(height: 16),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: mainFunctions.getWidgetWidth(width: 20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    if (mainVariables.generalVariables.currentPage.value == "view_check_list") {
                      mainVariables.generalVariables.selectedCheckListId = "";
                      mainVariables.generalVariables.railNavigateBackIndex = mainVariables.generalVariables.railNavigateIndex;
                      mainVariables.generalVariables.railNavigateIndex = 4;
                      mainVariables.generalVariables.currentPage.value = "";
                      context.read<RailNavigationBloc>().add(const RailNavigationSelectedWidgetEvent());
                    } else {
                      mainVariables.generalVariables.railNavigateBackIndex = mainVariables.generalVariables.railNavigateIndex;
                      mainVariables.generalVariables.railNavigateIndex = 0;
                      mainVariables.generalVariables.currentPage.value = "";
                      mainVariables.railNavigationVariables.mainSelectedIndex = 0;
                      mainVariables.homeVariables.homeLocationSelectedIndex = -1;
                      mainVariables.homeVariables.quickLinksEnabled = false;
                      mainVariables.inventoryVariables.tabControllerIndex = 0;
                      mainVariables.inventoryVariables.tabsEnableList.clear();
                      mainVariables.inventoryVariables.tabsEnableList = List.generate(3, (index) => false);
                      mainVariables.inventoryVariables.tabsEnableList[0] = true;
                      mainVariables.homeVariables.quickLinksEnabled = false;
                      mainVariables.reportsVariables.reportsSelectedIndex = 0;
                      mainVariables.manageVariables.manageSelectedIndex = 0;
                      mainVariables.checkListVariables.checkListSelectedIndex = 0;
                      context.read<RailNavigationBloc>().add(const RailNavigationSelectedWidgetEvent());
                    }
                  },
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: Color(0xff0C3788),
                  ),
                ),
                BlocBuilder<CheckListBloc, CheckListState>(
                  builder: (BuildContext context, CheckListState reports) {
                    return headerTextWidget();
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: mainFunctions.getWidgetHeight(height: 16),
          ),
          const Divider(
            height: 0,
            thickness: 1,
            color: Color(0xffD0D0D0),
          ),
          SizedBox(
            height: mainFunctions.getWidgetHeight(height: 20),
          ),
          bodyContentWidget(),
        ],
      ),
    );
  }

  Widget headerTextWidget() {
    switch (mainVariables.checkListVariables.checkListSelectedIndex) {
      case 0:
        return Text(
          "Pre Flight Check List",
          style: mainTextStyle.normalTextStyle.copyWith(color: mainColors.headingBlueColor, fontWeight: FontWeight.w600),
        );
      case 1:
        return Text(
          "Post Flight Check List",
          style: mainTextStyle.normalTextStyle.copyWith(color: mainColors.headingBlueColor, fontWeight: FontWeight.w600),
        );
      case 2:
        return Text(
          "Maintenance Check List",
          style: mainTextStyle.normalTextStyle.copyWith(color: mainColors.headingBlueColor, fontWeight: FontWeight.w600),
        );
      default:
        return Container();
    }
  }

  Widget bodyContentWidget() {
    return Expanded(
      child: SingleChildScrollView(
        child: BlocConsumer<CheckListBloc, CheckListState>(
          listenWhen: (previous, current) {
            return previous != current;
          },
          buildWhen: (previous, current) {
            return previous != current;
          },
          listener: (BuildContext context, CheckListState checkList) {
            if (checkList is CheckListSuccess) {
              mainVariables.checkListVariables.loader = false;
              mainVariables.generalVariables.railNavigateBackIndex = mainVariables.generalVariables.railNavigateIndex;
              mainVariables.generalVariables.railNavigateIndex = 0;
              mainVariables.generalVariables.currentPage.value = "";
              mainVariables.railNavigationVariables.mainSelectedIndex = 0;
              mainVariables.homeVariables.homeLocationSelectedIndex = -1;
              mainVariables.homeVariables.quickLinksEnabled = false;
              mainVariables.inventoryVariables.tabControllerIndex = 0;
              mainVariables.inventoryVariables.tabsEnableList.clear();
              mainVariables.inventoryVariables.tabsEnableList = List.generate(3, (index) => false);
              mainVariables.inventoryVariables.tabsEnableList[0] = true;
              mainVariables.homeVariables.quickLinksEnabled = false;
              mainVariables.reportsVariables.reportsSelectedIndex = 0;
              mainVariables.manageVariables.manageSelectedIndex = 0;
              mainVariables.checkListVariables.checkListSelectedIndex = 0;
              context.read<RailNavigationBloc>().add(const RailNavigationSelectedWidgetEvent());
              mainWidgets.flushBarWidget(context: context, message: checkList.message);
            } else if (checkList is CheckListFailure) {
              mainVariables.checkListVariables.loader = false;
              mainWidgets.flushBarWidget(context: context, message: checkList.errorMessage);
            }
          },
          builder: (BuildContext context, CheckListState checkList) {
            if (checkList is CheckListLoaded) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: mainFunctions.getWidgetHeight(height: 198),
                    width: mainFunctions.getWidgetWidth(width: 832),
                    padding: EdgeInsets.symmetric(
                      horizontal: mainFunctions.getWidgetWidth(width: 20),
                      vertical: mainFunctions.getWidgetHeight(height: 18),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: mainFunctions.getWidgetHeight(height: 72),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "Crew name",
                                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: mainFunctions.getTextSize(fontSize: 15), color: const Color(0xff111111)),
                                    ),
                                    SizedBox(
                                      height: mainFunctions.getWidgetHeight(height: 5),
                                    ),
                                    SizedBox(
                                      height: mainFunctions.getWidgetHeight(height: 44),
                                      child: TextFormField(
                                        initialValue: mainVariables.generalVariables.currentPage.value == "view_check_list" ? mainVariables.checkListVariables.getValue.data.userFullName : "${mainVariables.generalVariables.userData.firstName} ${mainVariables.generalVariables.userData.lastName}",
                                        readOnly: true,
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: const Color(0xffF7F7F7),
                                          contentPadding: EdgeInsets.only(left: mainFunctions.getWidgetWidth(width: 15)),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8),
                                            borderSide: const BorderSide(color: Color(0xffDAD8E5), width: 1),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8),
                                            borderSide: const BorderSide(color: Color(0xffDAD8E5), width: 1),
                                          ),
                                          disabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8),
                                            borderSide: const BorderSide(color: Color(0xffDAD8E5), width: 1),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8),
                                            borderSide: const BorderSide(color: Color(0xffDAD8E5), width: 1),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8),
                                            borderSide: const BorderSide(color: Color(0xffDAD8E5), width: 1),
                                          ),
                                        ),
                                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: mainFunctions.getTextSize(fontSize: 15)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: mainFunctions.getWidgetWidth(width: 71)),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      mainVariables.generalVariables.currentPage.value == "view_check_list" ? "Checklist Id" : "Date",
                                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: mainFunctions.getTextSize(fontSize: 15), color: const Color(0xff111111)),
                                    ),
                                    SizedBox(
                                      height: mainFunctions.getWidgetHeight(height: 5),
                                    ),
                                    SizedBox(
                                      height: mainFunctions.getWidgetHeight(height: 43),
                                      child: TextFormField(
                                        initialValue: mainVariables.generalVariables.currentPage.value == "view_check_list" ? mainVariables.generalVariables.selectedCheckListId : mainFunctions.dateFormat(date: DateTime.now().toString()),
                                        keyboardType: TextInputType.number,
                                        readOnly: true,
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: const Color(0xffF7F7F7),
                                          contentPadding: EdgeInsets.only(left: mainFunctions.getWidgetWidth(width: 15)),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8),
                                            borderSide: const BorderSide(color: Color(0xffDAD8E5), width: 1),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8),
                                            borderSide: const BorderSide(color: Color(0xffDAD8E5), width: 1),
                                          ),
                                          disabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8),
                                            borderSide: const BorderSide(color: Color(0xffDAD8E5), width: 1),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8),
                                            borderSide: const BorderSide(color: Color(0xffDAD8E5), width: 1),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8),
                                            borderSide: const BorderSide(color: Color(0xffDAD8E5), width: 1),
                                          ),
                                        ),
                                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: mainFunctions.getTextSize(fontSize: 15)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: mainFunctions.getWidgetHeight(height: 18),
                        ),
                        SizedBox(
                          height: mainFunctions.getWidgetHeight(height: 72),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: mainFunctions.getWidgetHeight(height: 60),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "Location",
                                        style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 14), fontWeight: FontWeight.w600, color: const Color(0xff111111)),
                                      ),
                                      SizedBox(
                                        height: mainFunctions.getWidgetHeight(height: 38),
                                        child: DropDownTextField(
                                          key: key13,
                                          key13: key13,
                                          key14: key14,
                                          key15: key15,
                                          initialValue: mainVariables.checkListVariables.senderLocationChoose,
                                          textStyle: TextStyle(
                                            fontSize: mainFunctions.getTextSize(fontSize: 13),
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xff111111),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          listTextStyle: TextStyle(
                                            fontSize: mainFunctions.getTextSize(fontSize: 13),
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xff111111),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          enabled: (mainVariables.generalVariables.currentPage.value == "view_check_list") == false,
                                          keyboardType: TextInputType.text,
                                          dropDownItemCount: 3,
                                          hintText: "Select location",
                                          dropDownList: mainVariables.stockMovementVariables.senderInfo.locationDropDownList,
                                          onChanged: (val) {
                                            mainVariables.checkListVariables.senderLocationChoose = val;
                                          },
                                          onFieldChanged: () {
                                            mainVariables.checkListVariables.senderLocationChoose = DropDownValueModel.fromJson(const {});
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(width: mainFunctions.getWidgetWidth(width: 71)),
                              Expanded(
                                child: SizedBox(
                                  height: mainFunctions.getWidgetHeight(height: 60),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              "From Sector ",
                                              style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 12), fontWeight: FontWeight.w600, color: const Color(0xff111111)),
                                            ),
                                            SizedBox(
                                              height: mainFunctions.getWidgetHeight(height: 38),
                                              child: DropDownTextField(
                                                key: key14,
                                                key13: key13,
                                                key14: key14,
                                                key15: key15,
                                                initialValue: mainVariables.checkListVariables.senderFromSectorChoose,
                                                enabled: (mainVariables.generalVariables.currentPage.value == "view_check_list") == false,
                                                textStyle: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 12), fontWeight: FontWeight.w600, color: const Color(0xff111111), overflow: TextOverflow.ellipsis),
                                                listTextStyle: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 11), fontWeight: FontWeight.w600, color: const Color(0xff111111), overflow: TextOverflow.ellipsis),
                                                keyboardType: TextInputType.text,
                                                dropDownItemCount: 3,
                                                isSector: true,
                                                isSectorRight: false,
                                                hintText: "Select sector",
                                                dropDownList: mainVariables.stockMovementVariables.senderInfo.sectorDropDownList,
                                                suffixIconConstraints: const BoxConstraints(minWidth: 25, minHeight: 25),
                                                onChanged: (val) {
                                                  mainVariables.checkListVariables.senderFromSectorChoose = val;
                                                },
                                                onFieldChanged: (val) {
                                                  mainVariables.checkListVariables.senderFromSectorChoose = DropDownValueModel.fromJson(const {});
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: mainFunctions.getWidgetWidth(width: 16),
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              "To Sector ",
                                              style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 14), fontWeight: FontWeight.w600, color: const Color(0xff111111)),
                                            ),
                                            SizedBox(
                                              height: mainFunctions.getWidgetHeight(height: 38),
                                              child: DropDownTextField(
                                                key: key15,
                                                key13: key13,
                                                key14: key14,
                                                key15: key15,
                                                initialValue: mainVariables.checkListVariables.senderToSectorChoose,
                                                enabled: (mainVariables.generalVariables.currentPage.value == "view_check_list") == false,
                                                textStyle: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 12), fontWeight: FontWeight.w600, color: const Color(0xff111111), overflow: TextOverflow.ellipsis),
                                                listTextStyle: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 11), fontWeight: FontWeight.w600, color: const Color(0xff111111), overflow: TextOverflow.ellipsis),
                                                keyboardType: TextInputType.text,
                                                dropDownItemCount: 3,
                                                hintText: "Select sector",
                                                isSector: true,
                                                isSectorRight: true,
                                                dropDownList: mainVariables.stockMovementVariables.senderInfo.sectorDropDownList,
                                                suffixIconConstraints: const BoxConstraints(minWidth: 25, minHeight: 25),
                                                onChanged: (val) {
                                                  mainVariables.checkListVariables.senderToSectorChoose = val;
                                                },
                                                onFieldChanged: (val) {
                                                  mainVariables.checkListVariables.senderToSectorChoose = DropDownValueModel.fromJson(const {});
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: mainFunctions.getWidgetHeight(height: 50)),
                  mainVariables.generalVariables.currentPage.value == "view_check_list"
                      ? const SizedBox()
                      : Container(
                          height: mainFunctions.getWidgetHeight(height: 50),
                          margin: EdgeInsets.symmetric(horizontal: mainFunctions.getWidgetWidth(width: 1)),
                          padding: EdgeInsets.symmetric(horizontal: mainFunctions.getWidgetWidth(width: 12)),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                            color: Color(0xffF5F5F5),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Checkbox(
                                value: mainVariables.checkListVariables.isAllChecksSelected,
                                onChanged: (value) {
                                  setState(() {
                                    mainVariables.checkListVariables.isAllChecksSelected = value!;
                                    for (int i = 0; i < mainVariables.checkListVariables.checklists.length; i++) {
                                      mainVariables.checkListVariables.checklists[i].isTopicSelected = value;
                                      for (int j = 0; j < mainVariables.checkListVariables.checklists[i].checks.length; j++) {
                                        mainVariables.checkListVariables.checklists[i].checks[j].isCheckSelected = value;
                                      }
                                    }
                                  });
                                },
                                activeColor: const Color(0xff0C3788),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              Text(
                                "Select All",
                                style: TextStyle(fontWeight: FontWeight.w600, fontSize: mainFunctions.getTextSize(fontSize: 14)),
                              ),
                            ],
                          ),
                        ),
                  SizedBox(height: mainFunctions.getWidgetHeight(height: 8)),
                  mainVariables.generalVariables.currentPage.value == "view_check_list"
                      ? ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: mainVariables.checkListVariables.getValue.data.checklistsSingle.length,
                          itemBuilder: (BuildContext context, int index) {
                            return mainVariables.checkListVariables.getValue.data.checklistsSingle[index].checks.isEmpty
                                ? const SizedBox()
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        height: mainFunctions.getWidgetHeight(height: mainVariables.checkListVariables.getValue.data.checklistsSingle[index].fieldName.length < 50 ? 46 : 55),
                                        width: mainFunctions.getWidgetWidth(width: 1132),
                                        margin: EdgeInsets.symmetric(horizontal: mainFunctions.getWidgetWidth(width: 1)),
                                        padding: EdgeInsets.symmetric(horizontal: mainFunctions.getWidgetWidth(width: 12)),
                                        color: const Color(0xffE9F0FF),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Checkbox(
                                              value: mainVariables.checkListVariables.getValue.data.checklistsSingle[index].status,
                                              onChanged: (value) {},
                                              activeColor: const Color(0xff0C3788),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(5),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                mainVariables.checkListVariables.getValue.data.checklistsSingle[index].fieldName,
                                                maxLines: 2,
                                                style: TextStyle(fontWeight: FontWeight.w600, fontSize: mainFunctions.getTextSize(fontSize: 14), overflow: TextOverflow.ellipsis),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: mainFunctions.getWidgetWidth(width: 1132),
                                        margin: EdgeInsets.symmetric(horizontal: mainFunctions.getWidgetWidth(width: 1)),
                                        padding: EdgeInsets.symmetric(horizontal: mainFunctions.getWidgetWidth(width: 12)),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10),
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 4,
                                              spreadRadius: 0,
                                              color: Colors.grey.shade300,
                                            ),
                                          ],
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: ListView.builder(
                                                  padding: EdgeInsets.symmetric(vertical: mainFunctions.getWidgetHeight(height: 15)),
                                                  physics: const NeverScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  itemCount: mainVariables.checkListVariables.getValue.data.checklistsSingle[index].checks.length,
                                                  itemBuilder: (BuildContext context, int index1) {
                                                    return Container(
                                                      height: mainFunctions.getWidgetHeight(height: 56),
                                                      decoration: const BoxDecoration(
                                                        border: Border(right: BorderSide(width: 1, color: Colors.black)),
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          Checkbox(
                                                            value: mainVariables.checkListVariables.getValue.data.checklistsSingle[index].checks[index1].status,
                                                            onChanged: (value) {},
                                                            activeColor: const Color(0xff0C3788),
                                                            shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(5),
                                                            ),
                                                          ),
                                                          Expanded(
                                                              child: Text(
                                                            mainVariables.checkListVariables.getValue.data.checklistsSingle[index].checks[index1].name,
                                                            maxLines: 2,
                                                            style: TextStyle(fontWeight: FontWeight.w600, fontSize: mainFunctions.getTextSize(fontSize: 14), overflow: TextOverflow.ellipsis),
                                                          )),
                                                        ],
                                                      ),
                                                    );
                                                  }),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(horizontal: mainFunctions.getWidgetWidth(width: 20), vertical: mainFunctions.getWidgetHeight(height: 5)),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Remarks",
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: mainFunctions.getTextSize(fontSize: 15),
                                                      ),
                                                    ),
                                                    SizedBox(height: mainFunctions.getWidgetHeight(height: 6)),
                                                    Padding(
                                                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                                      child: TextFormField(
                                                        maxLines: mainVariables.checkListVariables.getValue.data.checklistsSingle[index].checks.isEmpty ? 1 : mainVariables.checkListVariables.getValue.data.checklistsSingle[index].checks.length,
                                                        initialValue: mainVariables.checkListVariables.getValue.data.checklistsSingle[index].remarks,
                                                        cursorColor: Colors.green,
                                                        style: TextStyle(
                                                          fontSize: mainFunctions.getTextSize(fontSize: mainFunctions.getTextSize(fontSize: 15)),
                                                        ),
                                                        readOnly: (mainVariables.generalVariables.currentPage.value == "view_check_list"),
                                                        keyboardType: TextInputType.text,
                                                        onChanged: (value) async {},
                                                        decoration: InputDecoration(
                                                          contentPadding: EdgeInsets.symmetric(
                                                            horizontal: mainFunctions.getWidgetWidth(width: 12),
                                                            vertical: mainFunctions.getWidgetHeight(height: 12),
                                                          ),
                                                          focusedBorder: OutlineInputBorder(
                                                            borderSide: const BorderSide(color: Color(0xFFCBCBCB), width: 1),
                                                            borderRadius: BorderRadius.circular(7),
                                                          ),
                                                          enabledBorder: OutlineInputBorder(
                                                            borderSide: const BorderSide(color: Color(0xFFCBCBCB), width: 1),
                                                            borderRadius: BorderRadius.circular(7),
                                                          ),
                                                          border: OutlineInputBorder(
                                                            borderSide: const BorderSide(color: Color(0xFFCBCBCB), width: 1),
                                                            borderRadius: BorderRadius.circular(7),
                                                          ),
                                                          hintStyle: TextStyle(color: const Color(0XFF838195), fontSize: mainFunctions.getTextSize(fontSize: 13), fontWeight: FontWeight.w400),
                                                          fillColor: mainColors.whiteColor,
                                                          filled: true,
                                                          hintText: 'Type here',
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: mainFunctions.getWidgetHeight(height: 12),
                                      )
                                    ],
                                  );
                          })
                      : ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: mainVariables.checkListVariables.checklists.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  height: mainFunctions.getWidgetHeight(height: mainVariables.checkListVariables.checklists[index].fieldName.length < 50 ? 46 : 55),
                                  width: mainFunctions.getWidgetWidth(width: 1132),
                                  margin: EdgeInsets.symmetric(horizontal: mainFunctions.getWidgetWidth(width: 1)),
                                  padding: EdgeInsets.symmetric(horizontal: mainFunctions.getWidgetWidth(width: 12)),
                                  color: const Color(0xffE9F0FF),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Checkbox(
                                        value: mainVariables.checkListVariables.checklists[index].isTopicSelected,
                                        onChanged: (value) {
                                          setState(() {
                                            mainVariables.checkListVariables.checklists[index].isTopicSelected = value!;
                                            for (int i = 0; i < mainVariables.checkListVariables.checklists[index].checks.length; i++) {
                                              mainVariables.checkListVariables.checklists[index].checks[i].isCheckSelected = value;
                                            }
                                            List<bool> sectionsAllBoolList = [];
                                            for (int j = 0; j < mainVariables.checkListVariables.checklists.length; j++) {
                                              sectionsAllBoolList.add(mainVariables.checkListVariables.checklists[j].isTopicSelected);
                                            }
                                            if (sectionsAllBoolList.contains(false)) {
                                              mainVariables.checkListVariables.isAllChecksSelected = false;
                                            } else {
                                              mainVariables.checkListVariables.isAllChecksSelected = true;
                                            }
                                          });
                                        },
                                        activeColor: const Color(0xff0C3788),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          mainVariables.checkListVariables.checklists[index].fieldName,
                                          maxLines: 2,
                                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: mainFunctions.getTextSize(fontSize: 14), overflow: TextOverflow.ellipsis),
                                        ),
                                      ),
                                      /*mainVariables.checkListVariables.checklists[index].activeButtonsEnabled && mainVariables.checkListVariables.checklists[index].checks.isNotEmpty
                                          ? SizedBox(
                                              width: 150,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        mainVariables.checkListVariables.checklists[index].isRemarksDisabled = !mainVariables.checkListVariables.checklists[index].isRemarksDisabled;
                                                        for (int i = 0; i < mainVariables.checkListVariables.checklists[index].checks.length; i++) {
                                                          mainVariables.checkListVariables.checklists[index].checks[i].isDeleteEnabled = !mainVariables.checkListVariables.checklists[index].isRemarksDisabled;
                                                        }
                                                      });
                                                    },
                                                    child: mainVariables.checkListVariables.checklists[index].isRemarksDisabled
                                                        ? const Icon(Icons.check_circle, size: 24, color: Colors.green)
                                                        : Image.asset(
                                                            "assets/others/bin.png",
                                                            height: mainFunctions.getWidgetHeight(height: 24),
                                                            width: mainFunctions.getWidgetWidth(width: 24),
                                                            fit: BoxFit.fill,
                                                          ),
                                                  ),
                                                  SizedBox(
                                                    width: mainFunctions.getWidgetWidth(width: 15),
                                                  ),
                                                  mainVariables.checkListVariables.checklists[index].isRemarksDisabled
                                                      ? const SizedBox()
                                                      : LoadingButton(
                                                          status: false,
                                                          onTap: () {
                                                            setState(() {
                                                              mainVariables.checkListVariables.checklists[index].checks.add(ChecklistCheck.fromJson({}));
                                                              mainVariables.checkListVariables.checklists[index].isRemarksDisabled = true;
                                                              mainVariables.checkListVariables.checklists[index].activeButtonsEnabled = false;
                                                            });
                                                          },
                                                          text: "Add",
                                                          extraWidget: const Icon(
                                                            Icons.add,
                                                            color: Colors.white,
                                                            size: 20,
                                                          ),
                                                          height: 32,
                                                          width: 82,
                                                          fontSize: mainFunctions.getTextSize(fontSize: 14),
                                                        ),
                                                ],
                                              ),
                                            )
                                          : const SizedBox()*/
                                    ],
                                  ),
                                ),
                                Container(
                                  width: mainFunctions.getWidgetWidth(width: 1132),
                                  margin: EdgeInsets.symmetric(horizontal: mainFunctions.getWidgetWidth(width: 1)),
                                  padding: EdgeInsets.symmetric(horizontal: mainFunctions.getWidgetWidth(width: 12)),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 4,
                                        spreadRadius: 0,
                                        color: Colors.grey.shade300,
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: mainVariables.checkListVariables.checklists[index].checks.isEmpty
                                            ? Container(
                                                height: mainFunctions.getWidgetHeight(height: 46),
                                                padding: EdgeInsets.symmetric(horizontal: mainFunctions.getWidgetWidth(width: 12)),
                                                child: InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      mainVariables.checkListVariables.checklists[index].checks.add(ChecklistCheck.fromJson({}));
                                                      mainVariables.checkListVariables.checklists[index].isRemarksDisabled = true;
                                                    });
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      const Icon(
                                                        Icons.add,
                                                        color: Color(0xff0C3788),
                                                      ),
                                                      Text(
                                                        "Add",
                                                        style: TextStyle(color: const Color(0xff0C3788), fontSize: mainFunctions.getTextSize(fontSize: 15)),
                                                      )
                                                    ],
                                                  ),
                                                ))
                                            : ListView.builder(
                                                padding: EdgeInsets.symmetric(vertical: mainFunctions.getWidgetHeight(height: 15)),
                                                physics: const NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount: mainVariables.checkListVariables.checklists[index].checks.length,
                                                itemBuilder: (BuildContext context, int index1) {
                                                  return Container(
                                                    height: mainFunctions.getWidgetHeight(height: 56),
                                                    decoration: BoxDecoration(
                                                      border: Border(right: BorderSide(width: 1, color: mainVariables.checkListVariables.checklists[index].isRemarksDisabled ? Colors.transparent : Colors.black)),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Checkbox(
                                                          value: mainVariables.checkListVariables.checklists[index].checks[index1].isCheckSelected,
                                                          onChanged: (value) {
                                                            setState(() {
                                                              if (value!) {
                                                                mainVariables.checkListVariables.checklists[index].checks[index1].isCheckSelected = value;
                                                                List<bool> sectionBoolList = [];
                                                                List<bool> sectionsAllBoolList = [];
                                                                for (int i = 0; i < mainVariables.checkListVariables.checklists[index].checks.length; i++) {
                                                                  sectionBoolList.add(mainVariables.checkListVariables.checklists[index].checks[i].isCheckSelected);
                                                                }
                                                                if (sectionBoolList.contains(false)) {
                                                                  mainVariables.checkListVariables.checklists[index].isTopicSelected = false;
                                                                } else {
                                                                  mainVariables.checkListVariables.checklists[index].isTopicSelected = true;
                                                                }
                                                                for (int j = 0; j < mainVariables.checkListVariables.checklists.length; j++) {
                                                                  sectionsAllBoolList.add(mainVariables.checkListVariables.checklists[j].isTopicSelected);
                                                                }
                                                                if (sectionsAllBoolList.contains(false)) {
                                                                  mainVariables.checkListVariables.isAllChecksSelected = false;
                                                                } else {
                                                                  mainVariables.checkListVariables.isAllChecksSelected = true;
                                                                }
                                                              } else {
                                                                mainVariables.checkListVariables.checklists[index].checks[index1].isCheckSelected = value;
                                                                mainVariables.checkListVariables.checklists[index].isTopicSelected = value;
                                                                mainVariables.checkListVariables.isAllChecksSelected = value;
                                                              }
                                                            });
                                                          },
                                                          activeColor: const Color(0xff0C3788),
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(5),
                                                          ),
                                                        ),
                                                        mainVariables.checkListVariables.checklists[index].checks[index1].isAdded
                                                            ? Expanded(
                                                                child: Text(
                                                                mainVariables.checkListVariables.checklists[index].checks[index1].name,
                                                                maxLines: 2,
                                                                style: TextStyle(fontWeight: FontWeight.w600, fontSize: mainFunctions.getTextSize(fontSize: 14), overflow: TextOverflow.ellipsis),
                                                              ))
                                                            : Expanded(
                                                                child: Padding(
                                                                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, right: 25.0),
                                                                  child: TextFormField(
                                                                    maxLines: 1,
                                                                    controller: mainVariables.checkListVariables.checklists[index].checks[index1].addController,
                                                                    cursorColor: Colors.green,
                                                                    style: TextStyle(
                                                                      fontSize: mainFunctions.getTextSize(fontSize: mainFunctions.getTextSize(fontSize: 15)),
                                                                    ),
                                                                    keyboardType: TextInputType.text,
                                                                    onChanged: (value) async {},
                                                                    decoration: InputDecoration(
                                                                      contentPadding: EdgeInsets.symmetric(
                                                                        horizontal: mainFunctions.getWidgetWidth(width: 12),
                                                                        vertical: mainFunctions.getWidgetHeight(height: 12),
                                                                      ),
                                                                      focusedBorder: OutlineInputBorder(
                                                                        borderSide: const BorderSide(color: Color(0xFFCBCBCB), width: 1),
                                                                        borderRadius: BorderRadius.circular(7),
                                                                      ),
                                                                      enabledBorder: OutlineInputBorder(
                                                                        borderSide: const BorderSide(color: Color(0xFFCBCBCB), width: 1),
                                                                        borderRadius: BorderRadius.circular(7),
                                                                      ),
                                                                      border: OutlineInputBorder(
                                                                        borderSide: const BorderSide(color: Color(0xFFCBCBCB), width: 1),
                                                                        borderRadius: BorderRadius.circular(7),
                                                                      ),
                                                                      hintStyle: TextStyle(color: const Color(0XFF838195), fontSize: mainFunctions.getTextSize(fontSize: 13), fontWeight: FontWeight.w400),
                                                                      fillColor: mainColors.whiteColor,
                                                                      filled: true,
                                                                      hintText: 'add title',
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                        mainVariables.checkListVariables.checklists[index].checks[index1].isAdded
                                                            ? const SizedBox()
                                                            : LoadingButton(
                                                                status: false,
                                                                onTap: () {
                                                                  setState(() {
                                                                    if (mainVariables.checkListVariables.checklists[index].checks[index1].addController.text.isEmpty) {
                                                                      mainWidgets.flushBarWidget(context: context, message: "Please enter text in the field to add");
                                                                    } else {
                                                                      mainVariables.checkListVariables.checklists[index].checks[index1].isAdded = true;
                                                                      mainVariables.checkListVariables.checklists[index].checks[index1].isCheckSelected = true;
                                                                      mainVariables.checkListVariables.checklists[index].isRemarksDisabled = false;
                                                                      mainVariables.checkListVariables.checklists[index].activeButtonsEnabled = true;
                                                                      mainVariables.checkListVariables.checklists[index].checks[index1].name = mainVariables.checkListVariables.checklists[index].checks[index1].addController.text;
                                                                      List<bool> selectedListBool = [];
                                                                      for (int i = 0; i < mainVariables.checkListVariables.checklists[index].checks.length; i++) {
                                                                        selectedListBool.add(mainVariables.checkListVariables.checklists[index].checks[i].isCheckSelected);
                                                                      }
                                                                      if (selectedListBool.contains(false)) {
                                                                        mainVariables.checkListVariables.checklists[index].isTopicSelected = false;
                                                                      } else {
                                                                        mainVariables.checkListVariables.checklists[index].isTopicSelected = true;
                                                                      }
                                                                    }
                                                                  });
                                                                },
                                                                text: "Add",
                                                                extraWidget: const Icon(
                                                                  Icons.add,
                                                                  color: Colors.white,
                                                                  size: 20,
                                                                ),
                                                                height: 32,
                                                                width: 82,
                                                                fontSize: mainFunctions.getTextSize(fontSize: 14),
                                                              ),
                                                        mainVariables.checkListVariables.checklists[index].checks[index1].isAdded
                                                            ? const SizedBox()
                                                            : IconButton(
                                                                onPressed: () {
                                                                  setState(() {
                                                                    mainVariables.checkListVariables.checklists[index].checks.removeAt(index1);
                                                                    mainVariables.checkListVariables.checklists[index].activeButtonsEnabled = true;
                                                                    mainVariables.checkListVariables.checklists[index].isRemarksDisabled = false;
                                                                  });
                                                                },
                                                                icon: const Icon(Icons.highlight_remove, size: 24, color: Colors.red)),
                                                        mainVariables.checkListVariables.checklists[index].checks[index1].isDeleteEnabled
                                                            ? const SizedBox()
                                                            : IconButton(
                                                                onPressed: () {
                                                                  setState(() {
                                                                    mainVariables.checkListVariables.checklists[index].checks.removeAt(index1);
                                                                    if (mainVariables.checkListVariables.checklists[index].checks.isEmpty) {
                                                                      mainVariables.checkListVariables.checklists[index].activeButtonsEnabled = false;
                                                                    } else {
                                                                      mainVariables.checkListVariables.checklists[index].activeButtonsEnabled = true;
                                                                    }
                                                                  });
                                                                },
                                                                icon: const Icon(
                                                                  Icons.remove_circle_outlined,
                                                                  color: Colors.red,
                                                                  size: 24,
                                                                )),
                                                      ],
                                                    ),
                                                  );
                                                }),
                                      ),
                                      mainVariables.checkListVariables.checklists[index].isRemarksDisabled
                                          ? const SizedBox()
                                          : mainVariables.checkListVariables.checklists[index].checks.isEmpty
                                              ? const SizedBox()
                                              : Expanded(
                                                  child: Padding(
                                                    padding: EdgeInsets.symmetric(horizontal: mainFunctions.getWidgetWidth(width: 20), vertical: mainFunctions.getWidgetHeight(height: 5)),
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          "Remarks",
                                                          style: TextStyle(
                                                            fontWeight: FontWeight.w600,
                                                            fontSize: mainFunctions.getTextSize(fontSize: 15),
                                                          ),
                                                        ),
                                                        SizedBox(height: mainFunctions.getWidgetHeight(height: 6)),
                                                        Padding(
                                                          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                                          child: TextFormField(
                                                            maxLines: mainVariables.checkListVariables.checklists[index].checks.isEmpty ? 1 : mainVariables.checkListVariables.checklists[index].checks.length,
                                                            controller: mainVariables.checkListVariables.checklists[index].remarksController,
                                                            cursorColor: Colors.green,
                                                            style: TextStyle(
                                                              fontSize: mainFunctions.getTextSize(fontSize: mainFunctions.getTextSize(fontSize: 15)),
                                                            ),
                                                            readOnly: (mainVariables.generalVariables.currentPage.value == "view_check_list"),
                                                            keyboardType: TextInputType.text,
                                                            onChanged: (value) async {},
                                                            decoration: InputDecoration(
                                                              contentPadding: EdgeInsets.symmetric(
                                                                horizontal: mainFunctions.getWidgetWidth(width: 12),
                                                                vertical: mainFunctions.getWidgetHeight(height: 12),
                                                              ),
                                                              focusedBorder: OutlineInputBorder(
                                                                borderSide: const BorderSide(color: Color(0xFFCBCBCB), width: 1),
                                                                borderRadius: BorderRadius.circular(7),
                                                              ),
                                                              enabledBorder: OutlineInputBorder(
                                                                borderSide: const BorderSide(color: Color(0xFFCBCBCB), width: 1),
                                                                borderRadius: BorderRadius.circular(7),
                                                              ),
                                                              border: OutlineInputBorder(
                                                                borderSide: const BorderSide(color: Color(0xFFCBCBCB), width: 1),
                                                                borderRadius: BorderRadius.circular(7),
                                                              ),
                                                              hintStyle: TextStyle(color: const Color(0XFF838195), fontSize: mainFunctions.getTextSize(fontSize: 13), fontWeight: FontWeight.w400),
                                                              fillColor: mainColors.whiteColor,
                                                              filled: true,
                                                              hintText: 'Type here',
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: mainFunctions.getWidgetHeight(height: 12),
                                )
                              ],
                            );
                          }),
                  mainVariables.generalVariables.currentPage.value == "view_check_list"
                      ? mainVariables.checkListVariables.getValue.data.otherLists.checks.isEmpty
                          ? const SizedBox()
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  height: mainFunctions.getWidgetHeight(height: 46),
                                  width: mainFunctions.getWidgetWidth(width: 1132),
                                  margin: EdgeInsets.symmetric(horizontal: mainFunctions.getWidgetWidth(width: 1)),
                                  padding: EdgeInsets.symmetric(horizontal: mainFunctions.getWidgetWidth(width: 12)),
                                  color: const Color(0xffE9F0FF),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Checkbox(
                                        value: mainVariables.checkListVariables.getValue.data.otherLists.status,
                                        onChanged: (value) {},
                                        activeColor: const Color(0xff0C3788),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                      ),
                                      Expanded(
                                        child: RichText(
                                          textAlign: TextAlign.start,
                                          text: TextSpan(children: <TextSpan>[
                                            TextSpan(
                                              text: mainVariables.checkListVariables.otherList.fieldName[0],
                                              style: TextStyle(fontWeight: FontWeight.w600, fontSize: mainFunctions.getTextSize(fontSize: 14), overflow: TextOverflow.ellipsis, color: Colors.black),
                                            ),
                                            TextSpan(
                                              text: mainVariables.checkListVariables.otherList.fieldName[1],
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: mainFunctions.getTextSize(fontSize: 14),
                                                overflow: TextOverflow.ellipsis,
                                                color: const Color(0xff808080),
                                              ),
                                            ),
                                          ]),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: mainFunctions.getWidgetWidth(width: 1132),
                                  margin: EdgeInsets.symmetric(horizontal: mainFunctions.getWidgetWidth(width: 1)),
                                  padding: EdgeInsets.symmetric(horizontal: mainFunctions.getWidgetWidth(width: 12)),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 4,
                                        spreadRadius: 0,
                                        color: Colors.grey.shade300,
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: ListView.builder(
                                            padding: EdgeInsets.symmetric(vertical: mainFunctions.getWidgetHeight(height: 15)),
                                            physics: const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: mainVariables.checkListVariables.getValue.data.otherLists.checks.length,
                                            itemBuilder: (BuildContext context, int index1) {
                                              return Container(
                                                height: mainFunctions.getWidgetHeight(height: 55),
                                                decoration: const BoxDecoration(
                                                  border: Border(right: BorderSide(width: 1, color: Colors.black)),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Checkbox(
                                                      value: mainVariables.checkListVariables.getValue.data.otherLists.checks[index1].status,
                                                      onChanged: (value) {},
                                                      activeColor: const Color(0xff0C3788),
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(5),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        mainVariables.checkListVariables.getValue.data.otherLists.checks[index1].name,
                                                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: mainFunctions.getTextSize(fontSize: 14)),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(horizontal: mainFunctions.getWidgetWidth(width: 20), vertical: mainFunctions.getWidgetHeight(height: 5)),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Remarks",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: mainFunctions.getTextSize(fontSize: 15),
                                                ),
                                              ),
                                              SizedBox(height: mainFunctions.getWidgetHeight(height: 6)),
                                              Padding(
                                                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                                child: TextFormField(
                                                  maxLines: mainVariables.checkListVariables.getValue.data.otherLists.checks.length,
                                                  initialValue: mainVariables.checkListVariables.getValue.data.otherLists.remarks,
                                                  cursorColor: Colors.green,
                                                  style: TextStyle(
                                                    fontSize: mainFunctions.getTextSize(fontSize: mainFunctions.getTextSize(fontSize: 15)),
                                                  ),
                                                  keyboardType: TextInputType.text,
                                                  readOnly: (mainVariables.generalVariables.currentPage.value == "view_check_list"),
                                                  onChanged: (value) async {},
                                                  decoration: InputDecoration(
                                                    contentPadding: EdgeInsets.symmetric(
                                                      horizontal: mainFunctions.getWidgetWidth(width: 12),
                                                      vertical: mainFunctions.getWidgetHeight(height: 12),
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                      borderSide: const BorderSide(color: Color(0xFFCBCBCB), width: 1),
                                                      borderRadius: BorderRadius.circular(7),
                                                    ),
                                                    enabledBorder: OutlineInputBorder(
                                                      borderSide: const BorderSide(color: Color(0xFFCBCBCB), width: 1),
                                                      borderRadius: BorderRadius.circular(7),
                                                    ),
                                                    border: OutlineInputBorder(
                                                      borderSide: const BorderSide(color: Color(0xFFCBCBCB), width: 1),
                                                      borderRadius: BorderRadius.circular(7),
                                                    ),
                                                    hintStyle: TextStyle(color: const Color(0XFF838195), fontSize: mainFunctions.getTextSize(fontSize: 13), fontWeight: FontWeight.w400),
                                                    fillColor: mainColors.whiteColor,
                                                    filled: true,
                                                    hintText: 'Type here',
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: mainFunctions.getWidgetHeight(height: 12),
                                )
                              ],
                            )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: mainFunctions.getWidgetHeight(height: 46),
                              width: mainFunctions.getWidgetWidth(width: 1132),
                              margin: EdgeInsets.symmetric(horizontal: mainFunctions.getWidgetWidth(width: 1)),
                              padding: EdgeInsets.symmetric(horizontal: mainFunctions.getWidgetWidth(width: 12)),
                              color: const Color(0xffE9F0FF),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Checkbox(
                                    value: mainVariables.checkListVariables.otherList.isTopicSelected,
                                    onChanged: (value) {
                                      setState(() {
                                        mainVariables.checkListVariables.otherList.isTopicSelected = value!;
                                        for (int i = 0; i < mainVariables.checkListVariables.otherList.checks.length; i++) {
                                          mainVariables.checkListVariables.otherList.checks[i].isCheckSelected = value;
                                        }
                                      });
                                    },
                                    activeColor: const Color(0xff0C3788),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                  Expanded(
                                    child: RichText(
                                      textAlign: TextAlign.start,
                                      text: TextSpan(children: <TextSpan>[
                                        TextSpan(
                                          text: mainVariables.checkListVariables.otherList.fieldName[0],
                                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: mainFunctions.getTextSize(fontSize: 14), overflow: TextOverflow.ellipsis, color: Colors.black),
                                        ),
                                        TextSpan(
                                          text: mainVariables.checkListVariables.otherList.fieldName[1],
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: mainFunctions.getTextSize(fontSize: 14),
                                            overflow: TextOverflow.ellipsis,
                                            color: const Color(0xff808080),
                                          ),
                                        ),
                                      ]),
                                    ),
                                  ),
                                  mainVariables.checkListVariables.otherList.activeButtonsEnabled
                                      ? SizedBox(
                                          width: 150,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              mainVariables.checkListVariables.otherList.checks.isEmpty
                                                  ? const SizedBox()
                                                  : InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          mainVariables.checkListVariables.otherList.isRemarkEnabled = !mainVariables.checkListVariables.otherList.isRemarkEnabled;
                                                          for (int i = 0; i < mainVariables.checkListVariables.otherList.checks.length; i++) {
                                                            mainVariables.checkListVariables.otherList.checks[i].isDeleteEnabled = !mainVariables.checkListVariables.otherList.isRemarkEnabled;
                                                          }
                                                        });
                                                      },
                                                      child: mainVariables.checkListVariables.otherList.isRemarkEnabled
                                                          ? Image.asset(
                                                              "assets/others/bin.png",
                                                              height: mainFunctions.getWidgetHeight(height: 24),
                                                              width: mainFunctions.getWidgetWidth(width: 24),
                                                              fit: BoxFit.fill,
                                                            )
                                                          : const Icon(Icons.check_circle, size: 24, color: Colors.green),
                                                    ),
                                              SizedBox(
                                                width: mainFunctions.getWidgetWidth(width: 15),
                                              ),
                                              mainVariables.checkListVariables.otherList.checks.isEmpty
                                                  ? const SizedBox()
                                                  : mainVariables.checkListVariables.otherList.isRemarkEnabled
                                                      ? LoadingButton(
                                                          status: false,
                                                          onTap: () {
                                                            setState(() {
                                                              mainVariables.checkListVariables.otherList.checks.add(OtherListCheck.fromJson({}));
                                                              mainVariables.checkListVariables.otherList.isRemarkEnabled = false;
                                                              mainVariables.checkListVariables.otherList.activeButtonsEnabled = false;
                                                            });
                                                          },
                                                          text: "Add",
                                                          extraWidget: const Icon(
                                                            Icons.add,
                                                            color: Colors.white,
                                                            size: 20,
                                                          ),
                                                          height: 32,
                                                          width: 82,
                                                          fontSize: mainFunctions.getTextSize(fontSize: 14),
                                                        )
                                                      : const SizedBox(),
                                            ],
                                          ),
                                        )
                                      : const SizedBox(),
                                ],
                              ),
                            ),
                            Container(
                              width: mainFunctions.getWidgetWidth(width: 1132),
                              margin: EdgeInsets.symmetric(horizontal: mainFunctions.getWidgetWidth(width: 1)),
                              padding: EdgeInsets.symmetric(horizontal: mainFunctions.getWidgetWidth(width: 12)),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 4,
                                    spreadRadius: 0,
                                    color: Colors.grey.shade300,
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: mainVariables.checkListVariables.otherList.checks.isEmpty
                                        ? Container(
                                            height: mainFunctions.getWidgetHeight(height: 46),
                                            padding: EdgeInsets.symmetric(horizontal: mainFunctions.getWidgetWidth(width: 12)),
                                            child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  mainVariables.checkListVariables.otherList.checks.add(OtherListCheck.fromJson({}));
                                                  mainVariables.checkListVariables.otherList.isRemarkEnabled = false;
                                                });
                                              },
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  const Icon(
                                                    Icons.add,
                                                    color: Color(0xff0C3788),
                                                  ),
                                                  Text(
                                                    "Add",
                                                    style: TextStyle(color: const Color(0xff0C3788), fontSize: mainFunctions.getTextSize(fontSize: 15)),
                                                  )
                                                ],
                                              ),
                                            ))
                                        : ListView.builder(
                                            padding: EdgeInsets.symmetric(vertical: mainFunctions.getWidgetHeight(height: 15)),
                                            physics: const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: mainVariables.checkListVariables.otherList.checks.length,
                                            itemBuilder: (BuildContext context, int index1) {
                                              return Container(
                                                height: mainFunctions.getWidgetHeight(height: 55),
                                                decoration: BoxDecoration(
                                                  border: Border(right: BorderSide(width: 1, color: mainVariables.checkListVariables.otherList.isRemarkEnabled ? Colors.black : Colors.transparent)),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Checkbox(
                                                      value: mainVariables.checkListVariables.otherList.checks[index1].isCheckSelected,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          mainVariables.checkListVariables.otherList.checks[index1].isCheckSelected = value!;
                                                          List<bool> selectedListBool = [];
                                                          for (int i = 0; i < mainVariables.checkListVariables.otherList.checks.length; i++) {
                                                            selectedListBool.add(mainVariables.checkListVariables.otherList.checks[i].isCheckSelected);
                                                          }
                                                          if (selectedListBool.contains(false)) {
                                                            mainVariables.checkListVariables.otherList.isTopicSelected = false;
                                                          } else {
                                                            mainVariables.checkListVariables.otherList.isTopicSelected = true;
                                                          }
                                                        });
                                                      },
                                                      activeColor: const Color(0xff0C3788),
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(5),
                                                      ),
                                                    ),
                                                    mainVariables.checkListVariables.otherList.checks[index1].isAdded
                                                        ? Expanded(
                                                            child: Text(
                                                            mainVariables.checkListVariables.otherList.checks[index1].addController.text,
                                                            style: TextStyle(fontWeight: FontWeight.w600, fontSize: mainFunctions.getTextSize(fontSize: 14)),
                                                          ))
                                                        : Expanded(
                                                            child: Padding(
                                                              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, right: 25.0),
                                                              child: TextFormField(
                                                                maxLines: 1,
                                                                controller: mainVariables.checkListVariables.otherList.checks[index1].addController,
                                                                cursorColor: Colors.green,
                                                                style: TextStyle(
                                                                  fontSize: mainFunctions.getTextSize(fontSize: mainFunctions.getTextSize(fontSize: 15)),
                                                                ),
                                                                keyboardType: TextInputType.text,
                                                                onChanged: (value) async {},
                                                                decoration: InputDecoration(
                                                                  contentPadding: EdgeInsets.symmetric(
                                                                    horizontal: mainFunctions.getWidgetWidth(width: 12),
                                                                    vertical: mainFunctions.getWidgetHeight(height: 12),
                                                                  ),
                                                                  focusedBorder: OutlineInputBorder(
                                                                    borderSide: const BorderSide(color: Color(0xFFCBCBCB), width: 1),
                                                                    borderRadius: BorderRadius.circular(7),
                                                                  ),
                                                                  enabledBorder: OutlineInputBorder(
                                                                    borderSide: const BorderSide(color: Color(0xFFCBCBCB), width: 1),
                                                                    borderRadius: BorderRadius.circular(7),
                                                                  ),
                                                                  border: OutlineInputBorder(
                                                                    borderSide: const BorderSide(color: Color(0xFFCBCBCB), width: 1),
                                                                    borderRadius: BorderRadius.circular(7),
                                                                  ),
                                                                  hintStyle: TextStyle(color: const Color(0XFF838195), fontSize: mainFunctions.getTextSize(fontSize: 13), fontWeight: FontWeight.w400),
                                                                  fillColor: mainColors.whiteColor,
                                                                  filled: true,
                                                                  hintText: 'add title',
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                    mainVariables.checkListVariables.otherList.checks[index1].isAdded
                                                        ? const SizedBox()
                                                        : LoadingButton(
                                                            status: false,
                                                            onTap: () {
                                                              setState(() {
                                                                if (mainVariables.checkListVariables.otherList.checks[index1].addController.text.isEmpty) {
                                                                  mainWidgets.flushBarWidget(context: context, message: "Please enter text in the field to add");
                                                                } else {
                                                                  mainVariables.checkListVariables.otherList.checks[index1].isAdded = true;
                                                                  mainVariables.checkListVariables.otherList.checks[index1].isCheckSelected = true;
                                                                  mainVariables.checkListVariables.otherList.isRemarkEnabled = true;
                                                                  mainVariables.checkListVariables.otherList.activeButtonsEnabled = true;
                                                                  mainVariables.checkListVariables.otherList.checks[index1].name = mainVariables.checkListVariables.otherList.checks[index1].addController.text;
                                                                  List<bool> selectedListBool = [];
                                                                  for (int i = 0; i < mainVariables.checkListVariables.otherList.checks.length; i++) {
                                                                    selectedListBool.add(mainVariables.checkListVariables.otherList.checks[i].isCheckSelected);
                                                                  }
                                                                  if (selectedListBool.contains(false)) {
                                                                    mainVariables.checkListVariables.otherList.isTopicSelected = false;
                                                                  } else {
                                                                    mainVariables.checkListVariables.otherList.isTopicSelected = true;
                                                                  }
                                                                }
                                                              });
                                                            },
                                                            text: "Add",
                                                            extraWidget: const Icon(
                                                              Icons.add,
                                                              color: Colors.white,
                                                              size: 20,
                                                            ),
                                                            height: 32,
                                                            width: 82,
                                                            fontSize: mainFunctions.getTextSize(fontSize: 14),
                                                          ),
                                                    mainVariables.checkListVariables.otherList.checks[index1].isAdded
                                                        ? const SizedBox()
                                                        : IconButton(
                                                            onPressed: () {
                                                              setState(() {
                                                                mainVariables.checkListVariables.otherList.checks.removeAt(index1);
                                                                mainVariables.checkListVariables.otherList.activeButtonsEnabled = false;
                                                                mainVariables.checkListVariables.otherList.isRemarkEnabled = true;
                                                              });
                                                            },
                                                            icon: const Icon(Icons.highlight_remove, size: 24, color: Colors.red)),
                                                    mainVariables.checkListVariables.otherList.checks[index1].isDeleteEnabled
                                                        ? IconButton(
                                                            onPressed: () {
                                                              setState(() {
                                                                mainVariables.checkListVariables.otherList.checks.removeAt(index1);
                                                              });
                                                            },
                                                            icon: const Icon(Icons.remove_circle_outlined, size: 24, color: Colors.red))
                                                        : const SizedBox()
                                                  ],
                                                ),
                                              );
                                            }),
                                  ),
                                  mainVariables.checkListVariables.otherList.isRemarkEnabled
                                      ? Expanded(
                                          child: mainVariables.checkListVariables.otherList.checks.isEmpty
                                              ? const SizedBox()
                                              : Padding(
                                                  padding: EdgeInsets.symmetric(horizontal: mainFunctions.getWidgetWidth(width: 20), vertical: mainFunctions.getWidgetHeight(height: 5)),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        "Remarks",
                                                        style: TextStyle(
                                                          fontWeight: FontWeight.w600,
                                                          fontSize: mainFunctions.getTextSize(fontSize: 15),
                                                        ),
                                                      ),
                                                      SizedBox(height: mainFunctions.getWidgetHeight(height: 6)),
                                                      Padding(
                                                        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                                        child: TextFormField(
                                                          maxLines: mainVariables.checkListVariables.otherList.checks.isEmpty ? 1 : mainVariables.checkListVariables.otherList.checks.length,
                                                          controller: mainVariables.checkListVariables.otherList.remarksController,
                                                          cursorColor: Colors.green,
                                                          style: TextStyle(
                                                            fontSize: mainFunctions.getTextSize(fontSize: mainFunctions.getTextSize(fontSize: 15)),
                                                          ),
                                                          keyboardType: TextInputType.text,
                                                          onChanged: (value) async {},
                                                          decoration: InputDecoration(
                                                            contentPadding: EdgeInsets.symmetric(
                                                              horizontal: mainFunctions.getWidgetWidth(width: 12),
                                                              vertical: mainFunctions.getWidgetHeight(height: 12),
                                                            ),
                                                            focusedBorder: OutlineInputBorder(
                                                              borderSide: const BorderSide(color: Color(0xFFCBCBCB), width: 1),
                                                              borderRadius: BorderRadius.circular(7),
                                                            ),
                                                            enabledBorder: OutlineInputBorder(
                                                              borderSide: const BorderSide(color: Color(0xFFCBCBCB), width: 1),
                                                              borderRadius: BorderRadius.circular(7),
                                                            ),
                                                            border: OutlineInputBorder(
                                                              borderSide: const BorderSide(color: Color(0xFFCBCBCB), width: 1),
                                                              borderRadius: BorderRadius.circular(7),
                                                            ),
                                                            hintStyle: TextStyle(color: const Color(0XFF838195), fontSize: mainFunctions.getTextSize(fontSize: 13), fontWeight: FontWeight.w400),
                                                            fillColor: mainColors.whiteColor,
                                                            filled: true,
                                                            hintText: 'Type here',
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                        )
                                      : const SizedBox(),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: mainFunctions.getWidgetHeight(height: 12),
                            )
                          ],
                        ),
                  mainVariables.generalVariables.currentPage.value == "view_check_list"
                      ? const SizedBox()
                      : SizedBox(
                          height: mainFunctions.getWidgetHeight(height: 30),
                        ),
                  mainVariables.generalVariables.currentPage.value == "view_check_list"
                      ? const SizedBox()
                      : LoadingButton(
                          status: mainVariables.checkListVariables.loader,
                          onTap: () {
                            context.read<CheckListBloc>().add(const CheckListAddEvent());
                          },
                          text: "Submit",
                          height: 35,
                          width: 100,
                          fontSize: mainFunctions.getTextSize(fontSize: 15),
                        ),
                  SizedBox(height: mainFunctions.getWidgetHeight(height: 20)),
                ],
              );
            } else if (checkList is CheckListLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
