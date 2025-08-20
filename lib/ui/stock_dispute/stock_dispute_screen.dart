import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:table_sticky_headers/table_sticky_headers.dart';
import 'package:tvsaviation/bloc/rail_navigation/rail_navigation_bloc.dart';
import 'package:tvsaviation/bloc/stock_dispute/stock_dispute_bloc.dart';
import 'package:tvsaviation/data/model/variable_model/stock_dispute_variables.dart';
import 'package:tvsaviation/resources/constants.dart';
import 'package:tvsaviation/resources/drop_down_lib/dropdown_textfield.dart';
import 'package:tvsaviation/resources/widgets.dart';

class StockDisputeScreen extends StatefulWidget {
  static const String id = "stock_dispute";
  const StockDisputeScreen({super.key});

  @override
  State<StockDisputeScreen> createState() => StockDisputeScreenState();
}

class StockDisputeScreenState extends State<StockDisputeScreen> {
  Timer? timer;
  GlobalKey<DropDownTextFieldState> key11 = GlobalKey<DropDownTextFieldState>();
  GlobalKey<DropDownTextFieldState> key12 = GlobalKey<DropDownTextFieldState>();
  @override
  void initState() {
    if (key11.currentState != null) {
      key11.currentState!.searchCnt.clear();
      key11.currentState!.newDropDownList.clear();
      key11.currentState!.searchFocusNode.unfocus();
      key11.currentState!.textFieldFocusNode.unfocus();
    }
    if (key12.currentState != null) {
      key12.currentState!.searchCnt.clear();
      key12.currentState!.newDropDownList.clear();
      key12.currentState!.searchFocusNode.unfocus();
      key12.currentState!.textFieldFocusNode.unfocus();
    }
    mainVariables.stockDisputeVariables.sendData.crew = mainVariables.generalVariables.userData.id;
    mainVariables.stockDisputeVariables.selectedProductsList = mainVariables.stockDisputeVariables.sendData.products;
    context.read<StockDisputeBloc>().add(const StockDisputeInitialEvent());
    super.initState();
  }

  @override
  void dispose() {
    if (key11.currentState != null) {
      key11.currentState!.searchCnt.clear();
      key11.currentState!.newDropDownList.clear();
      key11.currentState!.searchFocusNode.unfocus();
      key11.currentState!.textFieldFocusNode.unfocus();
    }
    if (key12.currentState != null) {
      key12.currentState!.searchCnt.clear();
      key12.currentState!.newDropDownList.clear();
      key12.currentState!.searchFocusNode.unfocus();
      key12.currentState!.textFieldFocusNode.unfocus();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvoked: (value) {
          if (mainVariables.receivedStocksVariables.pageState == "transit") {
            mainVariables.railNavigationVariables.mainSelectedIndex = 0;
            mainVariables.generalVariables.railNavigateIndex = mainVariables.generalVariables.railNavigateBackIndex;
            context.read<RailNavigationBloc>().add(const RailNavigationBackWidgetEvent());
          } else {
            mainVariables.stockDisputeVariables.stockDisputeExit = false;
            mainVariables.generalVariables.currentPage.value = "";
            mainVariables.generalVariables.railNavigateBackIndex = mainVariables.generalVariables.railNavigateIndex;
            mainVariables.generalVariables.railNavigateIndex = 0;
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
      margin: EdgeInsets.symmetric(vertical: mainFunctions.getWidgetHeight(height: 20), horizontal: mainFunctions.getWidgetWidth(width: 20)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 4.0,
            spreadRadius: 10.0,
            color: Colors.grey.shade200,
          ),
        ],
      ),
      child: ListView(
        children: [
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
              color: Colors.white,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: mainFunctions.getWidgetHeight(height: 16),
                ),
                InkWell(
                  onTap: () {
                    if (mainVariables.receivedStocksVariables.pageState == "transit") {
                      mainVariables.railNavigationVariables.mainSelectedIndex = 0;
                      mainVariables.generalVariables.railNavigateIndex = mainVariables.generalVariables.railNavigateBackIndex;
                      context.read<RailNavigationBloc>().add(const RailNavigationBackWidgetEvent());
                    } else {
                      mainVariables.stockDisputeVariables.stockDisputeExit = false;
                      mainVariables.generalVariables.currentPage.value = "";
                      mainVariables.generalVariables.railNavigateBackIndex = mainVariables.generalVariables.railNavigateIndex;
                      mainVariables.generalVariables.railNavigateIndex = 0;
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
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: mainFunctions.getWidgetWidth(width: 20)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.arrow_back_ios,
                          color: Color(0xff0C3788),
                        ),
                        Text(
                          "Stock disputes",
                          style: mainTextStyle.normalTextStyle.copyWith(color: mainColors.headingBlueColor, fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
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
              ],
            ),
          ),
          bodyContentWidget(),
        ],
      ),
    );
  }

  Widget bodyContentWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: mainFunctions.getWidgetHeight(height: mainVariables.receivedStocksVariables.pageState == "transit" ? 355 : 198),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(15),
              bottomLeft: Radius.circular(15),
            ),
          ),
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
                              initialValue: mainVariables.generalVariables.userData.firstName + mainVariables.generalVariables.userData.lastName,
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
                            mainVariables.receivedStocksVariables.pageState == "transit" ? "Transit Id" : "Date",
                            style: TextStyle(fontWeight: FontWeight.w600, fontSize: mainFunctions.getTextSize(fontSize: 15), color: const Color(0xff111111)),
                          ),
                          SizedBox(
                            height: mainFunctions.getWidgetHeight(height: 5),
                          ),
                          SizedBox(
                            height: mainFunctions.getWidgetHeight(height: 43),
                            child: TextFormField(
                              initialValue: mainVariables.receivedStocksVariables.pageState == "transit"
                                  ? mainVariables.generalVariables.selectedTransId
                                  : mainFunctions.dateFormat(date: DateTime.now().toString()),
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
                                key: key11,
                                key11: key11,
                                key12: key12,
                                initialValue: mainVariables.stockDisputeVariables.senderLocationChoose,
                                textStyle: TextStyle(
                                  fontSize: mainFunctions.getTextSize(fontSize: 13),
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xff111111),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                enabled: mainVariables.receivedStocksVariables.pageState == "transit" ? false : true,
                                listTextStyle: TextStyle(
                                  fontSize: mainFunctions.getTextSize(fontSize: 13),
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xff111111),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                keyboardType: TextInputType.text,
                                dropDownItemCount: 3,
                                hintText: "Select location",
                                dropDownList: mainVariables.stockMovementVariables.senderInfo.locationDropDownList,
                                onChanged: (val) {
                                  mainVariables.stockDisputeVariables.selectedProductsIdList.clear();
                                  mainVariables.stockDisputeVariables.selectedQuantityList.clear();
                                  mainVariables.stockDisputeVariables.selectedProductsList.clear();
                                  mainVariables.stockDisputeVariables.currentPage = 1;
                                  mainVariables.stockDisputeVariables.senderLocationChoose = val;
                                  mainVariables.stockDisputeVariables.sendData.location = mainVariables.stockDisputeVariables.senderLocationChoose.value;
                                  context.read<StockDisputeBloc>().add(const StockDisputeTableChangingEvent());
                                  setState(() {});
                                },
                                onFieldChanged: () {
                                  mainVariables.stockDisputeVariables.currentPage = 1;
                                  mainVariables.stockDisputeVariables.senderLocationChoose = DropDownValueModel.fromJson(const {});
                                  mainVariables.stockDisputeVariables.sendData.location = mainVariables.stockDisputeVariables.senderLocationChoose.value;
                                  context.read<StockDisputeBloc>().add(const StockDisputeTableChangingEvent());
                                  setState(() {});
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
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Dispute Reason",
                              style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 14), fontWeight: FontWeight.w600, color: const Color(0xff111111)),
                            ),
                            SizedBox(
                              height: mainFunctions.getWidgetHeight(height: 38),
                              child: DropDownTextField(
                                key: key12,
                                key11: key11,
                                key12: key12,
                                initialValue: mainVariables.stockDisputeVariables.senderDisputeChoose,
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
                                keyboardType: TextInputType.text,
                                dropDownItemCount: 3,
                                hintText: "Select or Add Dispute Reason",
                                dropDownList: mainVariables.stockDisputeVariables.disputeDropDownList,
                                onChanged: (val) {
                                  mainVariables.stockDisputeVariables.senderDisputeChoose = val;
                                  mainVariables.stockDisputeVariables.sendData.disputeReason = mainVariables.stockDisputeVariables.senderDisputeChoose.value;
                                },
                                onFieldChanged: () {
                                  mainVariables.stockDisputeVariables.senderDisputeChoose = DropDownValueModel.fromJson(const {});
                                  mainVariables.stockDisputeVariables.sendData.disputeReason = mainVariables.stockDisputeVariables.senderDisputeChoose.value;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              mainVariables.receivedStocksVariables.pageState == "transit"
                  ? SizedBox(
                      height: mainFunctions.getWidgetHeight(height: 23),
                    )
                  : const SizedBox(),
              mainVariables.receivedStocksVariables.pageState == "transit"
                  ? SizedBox(
                      height: mainFunctions.getWidgetHeight(height: 130),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Comments",
                                  style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 14), fontWeight: FontWeight.w600, color: const Color(0xff111111)),
                                ),
                                TextFormField(
                                  controller: mainVariables.stockDisputeVariables.commentsBar,
                                  style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 13), fontWeight: FontWeight.w600, color: const Color(0xff111111), overflow: TextOverflow.ellipsis),
                                  maxLines: 4,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    fillColor: const Color(0xffFFFFFF),
                                    filled: true,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: mainFunctions.getWidgetWidth(width: 12),
                                      vertical: mainFunctions.getWidgetHeight(height: 12),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    disabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    hintText: "Type here",
                                    hintStyle: TextStyle(
                                      fontSize: mainFunctions.getTextSize(fontSize: 13),
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xff838195),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          mainVariables.generalVariables.currentPage.value == "resolution" ? SizedBox(width: mainFunctions.getWidgetWidth(width: 71)) : const SizedBox(),
                          mainVariables.generalVariables.currentPage.value == "resolution"
                              ? Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "Admin Comments",
                                        style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 14), fontWeight: FontWeight.w600, color: const Color(0xff111111)),
                                      ),
                                      TextFormField(
                                        controller: mainVariables.addDisputeVariables.adminCommentsBar,
                                        style:
                                            TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 13), fontWeight: FontWeight.w600, color: const Color(0xff111111), overflow: TextOverflow.ellipsis),
                                        maxLines: 4,
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                          fillColor: const Color(0xffFFFFFF),
                                          filled: true,
                                          contentPadding: EdgeInsets.symmetric(
                                            horizontal: mainFunctions.getWidgetWidth(width: 12),
                                            vertical: mainFunctions.getWidgetHeight(height: 12),
                                          ),
                                          border: OutlineInputBorder(
                                            borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                          disabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                          hintText: "Type here",
                                          hintStyle: TextStyle(
                                            fontSize: mainFunctions.getTextSize(fontSize: 13),
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xff838195),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : const SizedBox(),
                        ],
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
        SizedBox(height: mainFunctions.getWidgetHeight(height: 30)),
        mainVariables.stockDisputeVariables.senderLocationChoose.value == ""
            ? const SizedBox()
            : Container(
                height: mainFunctions.getWidgetHeight(height: 675),
                padding: EdgeInsets.symmetric(
                  horizontal: mainFunctions.getWidgetHeight(height: 12),
                  vertical: mainFunctions.getWidgetWidth(width: 12),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 4.0,
                      spreadRadius: 0.0,
                      color: Colors.black.withOpacity(0.05),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: mainFunctions.getWidgetHeight(height: 52),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Inventory",
                            style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 20), color: mainColors.headingBlueColor, fontWeight: FontWeight.w600),
                          ),
                          mainVariables.receivedStocksVariables.pageState == "transit"
                              ? const SizedBox()
                              : SizedBox(
                                  width: mainFunctions.getWidgetWidth(width: 280),
                                  height: mainFunctions.getWidgetHeight(height: 36),
                                  child: TextFormField(
                                    controller: mainVariables.stockDisputeVariables.searchBar,
                                    style: TextStyle(
                                      fontSize: mainFunctions.getTextSize(fontSize: 16),
                                      fontWeight: FontWeight.w500,
                                    ),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.zero,
                                      fillColor: const Color(0xFFEDEDED),
                                      filled: true,
                                      prefixIcon: const Icon(
                                        Icons.search,
                                        size: 22,
                                      ),
                                      suffixIcon: InkWell(
                                        onTap: () async {
                                          mainVariables.stockDisputeVariables.searchBar.text = await mainFunctions.barCodeScan(context: context);
                                          mainVariables.stockDisputeVariables.currentPage = 1;
                                          if (mounted) {
                                            context.read<StockDisputeBloc>().add(const StockDisputeTableChangingEvent());
                                          }
                                        },
                                        child: Image.asset(
                                          "assets/home/barcode.png",
                                          height: mainFunctions.getWidgetHeight(height: 22),
                                          width: mainFunctions.getWidgetWidth(width: 22),
                                        ),
                                      ),
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: const BorderSide(color: Color(0XFFEDEDED))),
                                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: const BorderSide(color: Color(0XFFEDEDED))),
                                      disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: const BorderSide(color: Color(0XFFEDEDED))),
                                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: const BorderSide(color: Color(0XFFEDEDED))),
                                      focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: const BorderSide(color: Color(0XFFEDEDED))),
                                      errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: const BorderSide(color: Color(0XFFEDEDED))),
                                      hintText: "Search",
                                      hintStyle: TextStyle(color: const Color(0XFF686868), fontSize: mainFunctions.getTextSize(fontSize: 16), fontWeight: FontWeight.w400),
                                    ),
                                    onChanged: (value) {
                                      mainVariables.stockDisputeVariables.currentPage = 1;
                                      context.read<StockDisputeBloc>().add(const StockDisputeTableChangingEvent());
                                    },
                                  ),
                                ),
                        ],
                      ),
                    ),
                    const Divider(
                      color: Color(0xffD9D9D9),
                      thickness: 1.0,
                      height: 0,
                    ),
                    BlocConsumer<StockDisputeBloc, StockDisputeState>(
                      listenWhen: (previous, current) {
                        return previous != current;
                      },
                      buildWhen: (previous, current) {
                        return previous != current;
                      },
                      listener: (BuildContext context, StockDisputeState stock) {
                        if (stock is StockDisputeFailure) {
                          mainWidgets.flushBarWidget(context: context, message: stock.errorMessage);
                          setState(() {
                            mainVariables.stockDisputeVariables.loader = false;
                          });
                        } else if (stock is StockDisputeSuccess) {
                          mainVariables.generalVariables.railNavigateBackIndex = mainVariables.generalVariables.railNavigateIndex;
                          mainVariables.railNavigationVariables.mainSelectedIndex = 0;
                          mainVariables.generalVariables.railNavigateIndex = 9;
                          context.read<RailNavigationBloc>().add(const RailNavigationSelectedWidgetEvent());
                          mainWidgets.flushBarWidget(context: context, message: stock.message);
                          mainVariables.stockDisputeVariables.sendData.transitId = "";
                          setState(() {
                            mainVariables.stockDisputeVariables.loader = false;
                          });
                        }
                      },
                      builder: (BuildContext context, StockDisputeState stock) {
                        if (stock is StockDisputeLoaded) {
                          return SizedBox(
                            height: mainFunctions.getWidgetHeight(height: 500),
                            child: mainVariables.stockDisputeVariables.stockDisputeInventory.tableData.isEmpty
                                ? Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          "assets/inventory/no_message.png",
                                          height: mainFunctions.getWidgetHeight(height: 100),
                                          width: mainFunctions.getWidgetWidth(width: 100),
                                          fit: BoxFit.fill,
                                          color: Colors.grey.shade200,
                                        ),
                                        SizedBox(
                                          height: mainFunctions.getWidgetHeight(height: 15),
                                        ),
                                        const Text(
                                          "Products not found for the selected type",
                                        ),
                                      ],
                                    ),
                                  )
                                : StickyHeadersTable(
                                    columnsLength: mainVariables.stockDisputeVariables.stockDisputeInventory.tableHeading.length,
                                    rowsLength: mainVariables.stockDisputeVariables.stockDisputeInventory.tableData.length,
                                    columnsTitleBuilder: (int columnIndex) {
                                      return Center(
                                        child: Text(
                                          mainVariables.stockDisputeVariables.stockDisputeInventory.tableHeading[columnIndex],
                                          maxLines: 2,
                                          style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 12), overflow: TextOverflow.ellipsis, fontWeight: FontWeight.w600),
                                          textAlign: TextAlign.center,
                                        ),
                                      );
                                    },
                                    rowsTitleBuilder: (int rowIndex) {
                                      return Center(
                                        child: Text(
                                          ((mainVariables.stockDisputeVariables.currentPage - 1) * 6) + (rowIndex + 1) < 10
                                              ? "0${((mainVariables.stockDisputeVariables.currentPage - 1) * 6) + (rowIndex + 1)}"
                                              : "${((mainVariables.stockDisputeVariables.currentPage - 1) * 6) + (rowIndex + 1)}",
                                          maxLines: 2,
                                          style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 12), overflow: TextOverflow.ellipsis, fontWeight: FontWeight.normal),
                                        ),
                                      );
                                    },
                                    contentCellBuilder: (int columnIndex, int rowIndex) {
                                      return columnIndex == 0
                                          ? const SizedBox()
                                          : columnIndex == 7
                                              ? Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        int sendQuantity = int.parse(mainVariables.stockDisputeVariables.stockDisputeInventory.tableData[rowIndex][columnIndex]);
                                                        if (sendQuantity > 0) {
                                                          setState(() {
                                                            sendQuantity--;
                                                            mainVariables.stockDisputeVariables.stockDisputeInventory.tableData[rowIndex][columnIndex] = sendQuantity.toString();
                                                          });
                                                        }
                                                        if (sendQuantity == 0 &&
                                                            mainVariables.stockDisputeVariables.selectedProductsIdList
                                                                .contains(mainVariables.stockDisputeVariables.stockDisputeInventory.tableData[rowIndex][columnIndex + 2])) {
                                                          mainVariables.stockDisputeVariables.selectedQuantityList.removeAt(mainVariables.stockDisputeVariables.selectedProductsIdList
                                                              .indexOf(mainVariables.stockDisputeVariables.stockDisputeInventory.tableData[rowIndex][columnIndex + 2]));
                                                          mainVariables.addDisputeVariables.stockDisputeInventory.tableData.removeAt(mainVariables.stockDisputeVariables.selectedProductsIdList
                                                              .indexOf(mainVariables.stockDisputeVariables.stockDisputeInventory.tableData[rowIndex][columnIndex + 2]));
                                                          mainVariables.stockDisputeVariables.selectedProductsIdList
                                                              .remove(mainVariables.stockDisputeVariables.stockDisputeInventory.tableData[rowIndex][columnIndex + 2]);
                                                        } else {
                                                          mainVariables.stockDisputeVariables.selectedQuantityList[mainVariables.stockDisputeVariables.selectedProductsIdList
                                                              .indexOf(mainVariables.stockDisputeVariables.stockDisputeInventory.tableData[rowIndex][columnIndex + 2])] = sendQuantity;
                                                        }
                                                        if (mainVariables.addDisputeVariables.stockDisputeInventory.tableData.isNotEmpty) {
                                                          for (int i = 0; i < mainVariables.addDisputeVariables.stockDisputeInventory.tableData.length; i++) {
                                                            if (mainVariables.addDisputeVariables.stockDisputeInventory.tableData[i][8] ==
                                                                mainVariables.stockDisputeVariables.stockDisputeInventory.tableData[rowIndex][columnIndex + 1]) {
                                                              mainVariables.addDisputeVariables.stockDisputeInventory.tableData[i][7] = sendQuantity.toString();
                                                            }
                                                          }
                                                        }
                                                      },
                                                      onTapDown: (val) {
                                                        int sendQuantity = int.parse(mainVariables.stockDisputeVariables.stockDisputeInventory.tableData[rowIndex][columnIndex]);
                                                        timer = Timer.periodic(const Duration(milliseconds: 25), (Timer t) {
                                                          if (sendQuantity > 0) {
                                                            setState(() {
                                                              sendQuantity--;
                                                              mainVariables.stockDisputeVariables.stockDisputeInventory.tableData[rowIndex][columnIndex] = sendQuantity.toString();
                                                            });
                                                          }
                                                          if (sendQuantity == 0 &&
                                                              mainVariables.stockDisputeVariables.selectedProductsIdList
                                                                  .contains(mainVariables.stockDisputeVariables.stockDisputeInventory.tableData[rowIndex][columnIndex + 2])) {
                                                            mainVariables.stockDisputeVariables.selectedQuantityList.removeAt(mainVariables.stockDisputeVariables.selectedProductsIdList
                                                                .indexOf(mainVariables.stockDisputeVariables.stockDisputeInventory.tableData[rowIndex][columnIndex + 2]));
                                                            mainVariables.addDisputeVariables.stockDisputeInventory.tableData.removeAt(mainVariables.stockDisputeVariables.selectedProductsIdList
                                                                .indexOf(mainVariables.stockDisputeVariables.stockDisputeInventory.tableData[rowIndex][columnIndex + 2]));
                                                            mainVariables.stockDisputeVariables.selectedProductsIdList
                                                                .remove(mainVariables.stockDisputeVariables.stockDisputeInventory.tableData[rowIndex][columnIndex + 2]);
                                                          } else {
                                                            mainVariables.stockDisputeVariables.selectedQuantityList[mainVariables.stockDisputeVariables.selectedProductsIdList
                                                                .indexOf(mainVariables.stockDisputeVariables.stockDisputeInventory.tableData[rowIndex][columnIndex + 2])] = sendQuantity;
                                                          }
                                                          if (mainVariables.addDisputeVariables.stockDisputeInventory.tableData.isNotEmpty) {
                                                            for (int i = 0; i < mainVariables.addDisputeVariables.stockDisputeInventory.tableData.length; i++) {
                                                              if (mainVariables.addDisputeVariables.stockDisputeInventory.tableData[i][8] ==
                                                                  mainVariables.stockDisputeVariables.stockDisputeInventory.tableData[rowIndex][columnIndex + 1]) {
                                                                mainVariables.addDisputeVariables.stockDisputeInventory.tableData[i][7] = sendQuantity.toString();
                                                              }
                                                            }
                                                          }
                                                        });
                                                      },
                                                      onTapUp: (val) {
                                                        timer!.cancel();
                                                      },
                                                      child: Container(
                                                        height: mainFunctions.getWidgetHeight(height: 20),
                                                        width: mainFunctions.getWidgetWidth(width: 20),
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(4),
                                                          color: const Color(0xffE7E7E7),
                                                        ),
                                                        child: const Center(
                                                          child: Icon(
                                                            Icons.remove,
                                                            size: 15,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Text(
                                                      mainVariables.stockDisputeVariables.selectedProductsIdList.isNotEmpty &&
                                                              mainVariables.stockDisputeVariables.selectedProductsIdList
                                                                  .contains(mainVariables.stockDisputeVariables.stockDisputeInventory.tableData[rowIndex][columnIndex + 2])
                                                          ? mainVariables
                                                              .stockDisputeVariables
                                                              .selectedQuantityList[mainVariables.stockDisputeVariables.selectedProductsIdList
                                                                  .indexOf(mainVariables.stockDisputeVariables.stockDisputeInventory.tableData[rowIndex][columnIndex + 2])]
                                                              .toString()
                                                          : mainVariables.stockDisputeVariables.stockDisputeInventory.tableData[rowIndex][columnIndex],
                                                      maxLines: 1,
                                                      style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 12), overflow: TextOverflow.ellipsis, fontWeight: FontWeight.normal),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        int sendQuantity = int.parse(mainVariables.stockDisputeVariables.stockDisputeInventory.tableData[rowIndex][columnIndex]);
                                                        if (sendQuantity < int.parse(mainVariables.stockDisputeVariables.stockDisputeInventory.tableData[rowIndex][columnIndex - 1])) {
                                                          setState(() {
                                                            sendQuantity++;
                                                            mainVariables.stockDisputeVariables.stockDisputeInventory.tableData[rowIndex][columnIndex] = sendQuantity.toString();
                                                          });
                                                          if (mainVariables.stockDisputeVariables.selectedProductsIdList
                                                              .contains(mainVariables.stockDisputeVariables.stockDisputeInventory.tableData[rowIndex][columnIndex + 2])) {
                                                            mainVariables.stockDisputeVariables.selectedQuantityList[mainVariables.stockDisputeVariables.selectedProductsIdList
                                                                .indexOf(mainVariables.stockDisputeVariables.stockDisputeInventory.tableData[rowIndex][columnIndex + 2])] = sendQuantity;
                                                          } else {
                                                            mainVariables.stockDisputeVariables.selectedProductsIdList
                                                                .add(mainVariables.stockDisputeVariables.stockDisputeInventory.tableData[rowIndex][columnIndex + 2]);
                                                            mainVariables.stockDisputeVariables.selectedQuantityList.add(sendQuantity);
                                                            mainVariables.addDisputeVariables.stockDisputeInventory.tableData
                                                                .add(mainVariables.stockDisputeVariables.stockDisputeInventory.tableData[rowIndex]);
                                                          }
                                                          for (int i = 0; i < mainVariables.addDisputeVariables.stockDisputeInventory.tableData.length; i++) {
                                                            if (mainVariables.addDisputeVariables.stockDisputeInventory.tableData[i][8] ==
                                                                mainVariables.stockDisputeVariables.stockDisputeInventory.tableData[rowIndex][columnIndex + 1]) {
                                                              mainVariables.addDisputeVariables.stockDisputeInventory.tableData[i][7] = sendQuantity.toString();
                                                            }
                                                          }
                                                        }
                                                      },
                                                      onTapDown: (val) {
                                                        int sendQuantity = int.parse(mainVariables.stockDisputeVariables.stockDisputeInventory.tableData[rowIndex][columnIndex]);
                                                        timer = Timer.periodic(const Duration(milliseconds: 25), (Timer t) {
                                                          if (sendQuantity < int.parse(mainVariables.stockDisputeVariables.stockDisputeInventory.tableData[rowIndex][columnIndex - 1])) {
                                                            setState(() {
                                                              sendQuantity++;
                                                              mainVariables.stockDisputeVariables.stockDisputeInventory.tableData[rowIndex][columnIndex] = sendQuantity.toString();
                                                            });
                                                            if (mainVariables.stockDisputeVariables.selectedProductsIdList
                                                                .contains(mainVariables.stockDisputeVariables.stockDisputeInventory.tableData[rowIndex][columnIndex + 2])) {
                                                              mainVariables.stockDisputeVariables.selectedQuantityList[mainVariables.stockDisputeVariables.selectedProductsIdList
                                                                  .indexOf(mainVariables.stockDisputeVariables.stockDisputeInventory.tableData[rowIndex][columnIndex + 2])] = sendQuantity;
                                                            } else {
                                                              mainVariables.stockDisputeVariables.selectedProductsIdList
                                                                  .add(mainVariables.stockDisputeVariables.stockDisputeInventory.tableData[rowIndex][columnIndex + 2]);
                                                              mainVariables.stockDisputeVariables.selectedQuantityList.add(sendQuantity);
                                                              mainVariables.addDisputeVariables.stockDisputeInventory.tableData
                                                                  .add(mainVariables.stockDisputeVariables.stockDisputeInventory.tableData[rowIndex]);
                                                            }
                                                            for (int i = 0; i < mainVariables.addDisputeVariables.stockDisputeInventory.tableData.length; i++) {
                                                              if (mainVariables.addDisputeVariables.stockDisputeInventory.tableData[i][8] ==
                                                                  mainVariables.stockDisputeVariables.stockDisputeInventory.tableData[rowIndex][columnIndex + 1]) {
                                                                mainVariables.addDisputeVariables.stockDisputeInventory.tableData[i][7] = sendQuantity.toString();
                                                              }
                                                            }
                                                          }
                                                        });
                                                      },
                                                      onTapUp: (val) {
                                                        timer!.cancel();
                                                      },
                                                      child: Container(
                                                        height: mainFunctions.getWidgetHeight(height: 20),
                                                        width: mainFunctions.getWidgetWidth(width: 20),
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(4),
                                                          color: const Color(0xff0C3788),
                                                        ),
                                                        child: const Center(
                                                          child: Icon(
                                                            Icons.add,
                                                            color: Colors.white,
                                                            size: 15,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              : Center(
                                                  child: Text(
                                                    mainVariables.stockDisputeVariables.stockDisputeInventory.tableData[rowIndex][columnIndex],
                                                    maxLines: 2,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 12), overflow: TextOverflow.ellipsis, fontWeight: FontWeight.normal),
                                                  ),
                                                );
                                    },
                                    legendCell: Text(
                                      "S.No",
                                      maxLines: 1,
                                      style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 12), overflow: TextOverflow.ellipsis, fontWeight: FontWeight.w600),
                                    ),
                                    cellAlignments: const CellAlignments.fixed(
                                      contentCellAlignment: Alignment.center,
                                      stickyColumnAlignment: Alignment.center,
                                      stickyRowAlignment: Alignment.center,
                                      stickyLegendAlignment: Alignment.center,
                                    ),
                                    cellDimensions: CellDimensions.variableColumnWidth(
                                      columnWidths: MediaQuery.of(context).orientation == Orientation.portrait
                                          ? [
                                              mainFunctions.getWidgetWidth(width: 0),
                                              mainFunctions.getWidgetWidth(width: 0),
                                              mainFunctions.getWidgetWidth(width: 110),
                                              mainFunctions.getWidgetWidth(width: 110),
                                              mainFunctions.getWidgetWidth(width: 100),
                                              mainFunctions.getWidgetWidth(width: 100),
                                              mainFunctions.getWidgetWidth(width: 80),
                                              mainFunctions.getWidgetWidth(width: 100),
                                            ]
                                          : [
                                              mainFunctions.getWidgetHeight(height: 0),
                                              mainFunctions.getWidgetHeight(height: 0),
                                              mainFunctions.getWidgetHeight(height: 164),
                                              mainFunctions.getWidgetHeight(height: 164),
                                              mainFunctions.getWidgetHeight(height: 164),
                                              mainFunctions.getWidgetHeight(height: 164),
                                              mainFunctions.getWidgetHeight(height: 90),
                                              mainFunctions.getWidgetHeight(height: 144),
                                            ],
                                      contentCellHeight: 40,
                                      stickyLegendWidth: 40,
                                      stickyLegendHeight: 40,
                                    ),
                                  ),
                          );
                        } else if (stock is StockDisputeLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return const SizedBox();
                        }
                      },
                    ),
                    SizedBox(
                      height: mainFunctions.getWidgetHeight(height: 12),
                    ),
                    BlocBuilder<StockDisputeBloc, StockDisputeState>(
                      builder: (BuildContext context, StockDisputeState stock) {
                        if (stock is StockDisputeLoaded) {
                          return mainVariables.stockDisputeVariables.stockDisputeInventory.tableData.isEmpty
                              ? const SizedBox()
                              : Center(
                                  child: SizedBox(
                                    width: mainFunctions.getWidgetWidth(width: 450),
                                    child: NumberPaginator(
                                      controller: mainVariables.stockDisputeVariables.numberController,
                                      numberPages: mainVariables.stockDisputeVariables.totalPages,
                                      onPageChange: mainVariables.stockDisputeVariables.totalPages <= 1
                                          ? (int index) {}
                                          : (int index) {
                                              mainVariables.stockDisputeVariables.currentPage = index + 1;
                                              context.read<StockDisputeBloc>().add(const StockDisputeTableChangingEvent());
                                            },
                                      config: NumberPaginatorUIConfig(
                                        buttonShape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
                                          side: const BorderSide(
                                            color: Color(0xffF1F1F1),
                                            width: 1,
                                          ),
                                        ),
                                        buttonSelectedForegroundColor: Colors.white,
                                        buttonUnselectedForegroundColor: const Color(0xff333333),
                                        buttonUnselectedBackgroundColor: Colors.white,
                                        buttonSelectedBackgroundColor: const Color(0xff0C3788),
                                      ),
                                    ),
                                  ),
                                );
                        } else if (stock is StockDisputeLoading) {
                          return mainVariables.stockDisputeVariables.stockDisputeInventory.tableData.isEmpty
                              ? const SizedBox()
                              : const Center(
                                  child: CircularProgressIndicator(),
                                );
                        } else {
                          return mainVariables.stockDisputeVariables.stockDisputeInventory.tableData.isEmpty ? const SizedBox() : const SizedBox();
                        }
                      },
                    ),
                  ],
                ),
              ),
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 15),
        ),
        LoadingButton(
          status: mainVariables.stockDisputeVariables.loader,
          onTap: () {
            if (mainVariables.receivedStocksVariables.pageState == "transit") {
              setState(() {
                mainVariables.stockDisputeVariables.loader = true;
              });
              if (mainVariables.stockDisputeVariables.senderLocationChoose.name == "" ||
                  mainVariables.stockDisputeVariables.commentsBar.text == "" ||
                  mainVariables.stockDisputeVariables.senderDisputeChoose.name == "") {
                if (mainVariables.stockDisputeVariables.senderLocationChoose.name == "") {
                  mainWidgets.flushBarWidget(context: context, message: "Location not chosen, Kindly select the Location");
                  setState(() {
                    mainVariables.stockDisputeVariables.loader = false;
                  });
                } else if (mainVariables.stockDisputeVariables.commentsBar.text == "") {
                  mainWidgets.flushBarWidget(context: context, message: "comments not Added, Kindly add the comments");
                  setState(() {
                    mainVariables.stockDisputeVariables.loader = false;
                  });
                } else if (mainVariables.stockDisputeVariables.senderDisputeChoose.name == "") {
                  mainWidgets.flushBarWidget(context: context, message: "Dispute reason not Added, Kindly add the reason");
                  setState(() {
                    mainVariables.stockDisputeVariables.loader = false;
                  });
                }
              } else {
                mainVariables.stockDisputeVariables.sendData.products.clear();
                int totalQuantity = 0;
                mainVariables.stockDisputeVariables.sendData.crew = mainVariables.generalVariables.userData.id;
                mainVariables.stockDisputeVariables.sendData.location = mainVariables.stockDisputeVariables.senderLocationChoose.value;
                mainVariables.stockDisputeVariables.sendData.disputeReason = mainVariables.stockDisputeVariables.senderDisputeChoose.value;
                mainVariables.stockDisputeVariables.sendData.comments = mainVariables.stockDisputeVariables.commentsBar.text;
                mainVariables.stockDisputeVariables.sendData.transitId = mainVariables.generalVariables.selectedTransTempId;
                for (int i = 0; i < mainVariables.stockDisputeVariables.stockDisputeInventory.tableData.length; i++) {
                  Map<String, dynamic> selectedMap = {
                    "inventory": mainVariables.stockDisputeVariables.stockDisputeInventory.tableData[0][10],
                    "quantity": int.parse(mainVariables.stockDisputeVariables.stockDisputeInventory.tableData[0][7])
                  };
                  mainVariables.stockDisputeVariables.sendData.products.add(ProductValueModel.fromJson(selectedMap));
                  totalQuantity = totalQuantity + mainVariables.stockDisputeVariables.sendData.products[i].quantity;
                }
                if (totalQuantity == 0) {
                  mainWidgets.flushBarWidget(context: context, message: "no of products should not be zero, please increase product count");
                  setState(() {
                    mainVariables.stockDisputeVariables.loader = false;
                  });
                } else {
                  context.read<StockDisputeBloc>().add(const StockDisputeCreateEvent());
                }
              }
            } else {
              if (mainVariables.stockDisputeVariables.senderLocationChoose.name == "" ||
                  mainVariables.stockDisputeVariables.senderDisputeChoose.name == "" ||
                  mainVariables.stockDisputeVariables.selectedProductsIdList.length != 1) {
                if (mainVariables.stockDisputeVariables.senderLocationChoose.name == "") {
                  mainWidgets.flushBarWidget(context: context, message: "Location not chosen, Kindly select the Location");
                  setState(() {
                    mainVariables.stockDisputeVariables.loader = false;
                  });
                } else if (mainVariables.stockDisputeVariables.senderDisputeChoose.name == "") {
                  mainWidgets.flushBarWidget(context: context, message: "Dispute reason not Added, Kindly add the reason");
                  setState(() {
                    mainVariables.stockDisputeVariables.loader = false;
                  });
                } else if (mainVariables.stockDisputeVariables.selectedProductsIdList.length != 1) {
                  mainWidgets.flushBarWidget(context: context, message: "We cannot add dispute for multiple products on same time, select only one product at a time");
                  setState(() {
                    mainVariables.stockDisputeVariables.loader = false;
                  });
                }
              } else {
                mainVariables.stockDisputeVariables.sendData.products.clear();
                int totalQuantity = 0;
                for (int i = 0; i < mainVariables.stockDisputeVariables.selectedProductsIdList.length; i++) {
                  Map<String, dynamic> selectedMap = {
                    "inventory": mainVariables.stockDisputeVariables.selectedProductsIdList[i],
                    "quantity": mainVariables.stockDisputeVariables.selectedQuantityList[i]
                  };
                  mainVariables.stockDisputeVariables.selectedProductsList.add(ProductValueModel.fromJson(selectedMap));
                  totalQuantity = totalQuantity + mainVariables.stockDisputeVariables.sendData.products[i].quantity;
                }
                if (totalQuantity == 0) {
                  mainWidgets.flushBarWidget(context: context, message: "no of products should not be zero, please increase product count");
                } else {
                  mainVariables.stockDisputeVariables.sendData.transitId = "";
                  mainVariables.stockDisputeVariables.sendData.products = mainVariables.stockDisputeVariables.selectedProductsList;
                  mainVariables.generalVariables.railNavigateBackIndex = mainVariables.generalVariables.railNavigateIndex;
                  mainVariables.generalVariables.railNavigateIndex = 13;
                  context.read<RailNavigationBloc>().add(const RailNavigationSelectedWidgetEvent());
                }
              }
            }
          },
          text: "Continue",
          height: 42,
          width: 132,
          fontSize: mainFunctions.getTextSize(fontSize: 16),
        ),
        SizedBox(height: mainFunctions.getWidgetHeight(height: 20)),
      ],
    );
  }
}
