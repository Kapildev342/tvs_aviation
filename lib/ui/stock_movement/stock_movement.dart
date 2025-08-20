import 'dart:async';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:shimmer/shimmer.dart';
import 'package:table_sticky_headers/table_sticky_headers.dart';
import 'package:tvsaviation/bloc/rail_navigation/rail_navigation_bloc.dart';
import 'package:tvsaviation/bloc/stock_movement/stock_movement_bloc.dart';
import 'package:tvsaviation/data/model/variable_model/stock_movement_variables.dart';
import 'package:tvsaviation/resources/constants.dart';
import 'package:tvsaviation/resources/drop_down_lib/dropdown_textfield.dart';
import 'package:tvsaviation/resources/widgets.dart';

class StockMovementScreen extends StatefulWidget {
  static const String id = "stock_movement";
  const StockMovementScreen({
    super.key,
  });

  @override
  State<StockMovementScreen> createState() => StockMovementScreenState();
}

class StockMovementScreenState extends State<StockMovementScreen> {
  Timer? timer;
  GlobalKey<DropDownTextFieldState> key1 = GlobalKey<DropDownTextFieldState>();
  GlobalKey<DropDownTextFieldState> key2 = GlobalKey<DropDownTextFieldState>();
  GlobalKey<DropDownTextFieldState> key3 = GlobalKey<DropDownTextFieldState>();
  GlobalKey<DropDownTextFieldState> key4 = GlobalKey<DropDownTextFieldState>();
  GlobalKey<DropDownTextFieldState> key5 = GlobalKey<DropDownTextFieldState>();
  GlobalKey<DropDownTextFieldState> key6 = GlobalKey<DropDownTextFieldState>();
  GlobalKey<DropDownTextFieldState> key7 = GlobalKey<DropDownTextFieldState>();
  GlobalKey<DropDownTextFieldState> key8 = GlobalKey<DropDownTextFieldState>();
  GlobalKey<DropDownTextFieldState> key9 = GlobalKey<DropDownTextFieldState>();
  GlobalKey<DropDownTextFieldState> key10 = GlobalKey<DropDownTextFieldState>();

  @override
  void initState() {
    context.read<StockMovementBloc>().add(const StockMovementInitialEvent());
    super.initState();
  }

/*  @override
  void dispose() {
    print("disposed");
    if (key1.currentState != null) {
      key1.currentState!.searchCnt.clear();
      key1.currentState!.newDropDownList.clear();
      key1.currentState!.searchFocusNode.unfocus();
      key1.currentState!.textFieldFocusNode.unfocus();
    }
    if (key2.currentState != null) {
      key2.currentState!.searchCnt.clear();
      key2.currentState!.newDropDownList.clear();
      key2.currentState!.searchFocusNode.unfocus();
      key2.currentState!.textFieldFocusNode.unfocus();
    }
    if (key3.currentState != null) {
      key3.currentState!.searchCnt.clear();
      key3.currentState!.newDropDownList.clear();
      key3.currentState!.searchFocusNode.unfocus();
      key3.currentState!.textFieldFocusNode.unfocus();
    }
    if (key4.currentState != null) {
      key4.currentState!.searchCnt.clear();
      key4.currentState!.newDropDownList.clear();
      key4.currentState!.searchFocusNode.unfocus();
      key4.currentState!.textFieldFocusNode.unfocus();
    }
    if (key5.currentState != null) {
      key5.currentState!.searchCnt.clear();
      key5.currentState!.newDropDownList.clear();
      key5.currentState!.searchFocusNode.unfocus();
      key5.currentState!.textFieldFocusNode.unfocus();
    }
    if (key6.currentState != null) {
      key6.currentState!.searchCnt.clear();
      key6.currentState!.newDropDownList.clear();
      key6.currentState!.searchFocusNode.unfocus();
      key6.currentState!.textFieldFocusNode.unfocus();
    }
    if (key7.currentState != null) {
      key7.currentState!.searchCnt.clear();
      key7.currentState!.newDropDownList.clear();
      key7.currentState!.searchFocusNode.unfocus();
      key7.currentState!.textFieldFocusNode.unfocus();
    }
    if (key8.currentState != null) {
      key8.currentState!.searchCnt.clear();
      key8.currentState!.newDropDownList.clear();
      key8.currentState!.searchFocusNode.unfocus();
      key8.currentState!.textFieldFocusNode.unfocus();
    }
    if (key9.currentState != null) {
      key9.currentState!.searchCnt.clear();
      key9.currentState!.newDropDownList.clear();
      key9.currentState!.searchFocusNode.unfocus();
      key9.currentState!.textFieldFocusNode.unfocus();
    }
    if (key10.currentState != null) {
      key10.currentState!.searchCnt.clear();
      key10.currentState!.newDropDownList.clear();
      key10.currentState!.searchFocusNode.unfocus();
      key10.currentState!.textFieldFocusNode.unfocus();
    }
    super.dispose();
  }*/

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvoked: (value) {
          mainVariables.stockMovementVariables.stockMovementExit = false;
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
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            blurRadius: 4.0,
            spreadRadius: 10.0,
            color: Colors.grey.shade200,
          ),
        ],
      ),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        controller: mainVariables.stockMovementVariables.scrollController,
        children: [
          Container(
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
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: mainFunctions.getWidgetHeight(height: 16),
                ),
                InkWell(
                  onTap: () {
                    mainVariables.stockMovementVariables.stockMovementExit = false;
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
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: mainFunctions.getWidgetWidth(width: 20)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.arrow_back_ios,
                        ),
                        Text(
                          "Stock movement",
                          style: mainTextStyle.normalTextStyle.copyWith(color: mainColors.headingBlueColor, fontWeight: FontWeight.w600),
                        ),
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
                SizedBox(
                  height: mainFunctions.getWidgetHeight(height: 20),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: mainFunctions.getWidgetWidth(width: 28)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          height: mainFunctions.getWidgetHeight(height: 302),
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
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: mainFunctions.getWidgetHeight(height: 40),
                                width: mainFunctions.getWidgetWidth(width: 600),
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                  ),
                                  color: Color(0xff0C3788),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    left: mainFunctions.getWidgetWidth(width: 15),
                                    top: mainFunctions.getWidgetHeight(height: 7),
                                  ),
                                  child: Text(
                                    "Sender Info",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: mainFunctions.getTextSize(fontSize: 17),
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: mainFunctions.getWidgetWidth(width: 10),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      height: mainFunctions.getWidgetHeight(height: 60),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            "Crew Name ",
                                            style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 14), fontWeight: FontWeight.w600, color: const Color(0xff111111)),
                                          ),
                                          BlocBuilder<StockMovementBloc, StockMovementState>(
                                            builder: (BuildContext context, StockMovementState stock) {
                                              if (stock is StockMovementLoading) {
                                                return Shimmer.fromColors(
                                                  baseColor: Colors.grey.shade200,
                                                  highlightColor: Colors.white,
                                                  child: Container(
                                                    height: mainFunctions.getWidgetHeight(height: 38),
                                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: mainColors.whiteColor),
                                                    padding: EdgeInsets.only(left: mainFunctions.getWidgetWidth(width: 20), top: mainFunctions.getWidgetHeight(height: 16), right: mainFunctions.getWidgetWidth(width: 20)),
                                                  ),
                                                );
                                              } else {
                                                return SizedBox(
                                                  height: mainFunctions.getWidgetHeight(height: 38),
                                                  child: TextFormField(
                                                    readOnly: true,
                                                    controller: mainVariables.stockMovementVariables.senderInfo.crewHandlerController,
                                                    style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 13), fontWeight: FontWeight.w600, color: const Color(0xff111111), overflow: TextOverflow.ellipsis),
                                                    maxLines: 1,
                                                    decoration: InputDecoration(
                                                      fillColor: const Color(0xffF7F7F7),
                                                      filled: true,
                                                      contentPadding: EdgeInsets.only(left: mainFunctions.getWidgetWidth(width: 12)),
                                                      border: OutlineInputBorder(
                                                        borderSide: const BorderSide(color: Color(0xffDAD8E5), width: 1),
                                                        borderRadius: BorderRadius.circular(6),
                                                      ),
                                                      focusedBorder: OutlineInputBorder(
                                                        borderSide: const BorderSide(color: Color(0xffDAD8E5), width: 1),
                                                        borderRadius: BorderRadius.circular(6),
                                                      ),
                                                      enabledBorder: OutlineInputBorder(
                                                        borderSide: const BorderSide(color: Color(0xffDAD8E5), width: 1),
                                                        borderRadius: BorderRadius.circular(6),
                                                      ),
                                                      disabledBorder: OutlineInputBorder(
                                                        borderSide: const BorderSide(color: Color(0xffDAD8E5), width: 1),
                                                        borderRadius: BorderRadius.circular(6),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: mainFunctions.getWidgetHeight(height: 5),
                                    ),
                                    SizedBox(
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
                                          BlocBuilder<StockMovementBloc, StockMovementState>(
                                            builder: (BuildContext context, StockMovementState stock) {
                                              if (stock is StockMovementLoading) {
                                                return Shimmer.fromColors(
                                                  baseColor: Colors.grey.shade200,
                                                  highlightColor: Colors.white,
                                                  child: Container(
                                                    height: mainFunctions.getWidgetHeight(height: 38),
                                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: mainColors.whiteColor),
                                                    padding: EdgeInsets.only(left: mainFunctions.getWidgetWidth(width: 20), top: mainFunctions.getWidgetHeight(height: 16), right: mainFunctions.getWidgetWidth(width: 20)),
                                                  ),
                                                );
                                              } else {
                                                return SizedBox(
                                                  height: mainFunctions.getWidgetHeight(height: 38),
                                                  child: DropDownTextField(
                                                    key: key1,
                                                    key1: key1,
                                                    key2: key2,
                                                    key3: key3,
                                                    key4: key4,
                                                    key5: key5,
                                                    key6: key6,
                                                    key7: key7,
                                                    key8: key8,
                                                    key9: key9,
                                                    key10: key10,
                                                    initialValue: mainVariables.stockMovementVariables.senderInfo.senderLocationChoose,
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
                                                    hintText: "Select location",
                                                    dropDownList: mainVariables.stockMovementVariables.senderInfo.locationDropDownList.toSet().toList(),
                                                    onChanged: (val) {
                                                      mainVariables.stockMovementVariables.selectedProductsIdList.clear();
                                                      mainVariables.stockMovementVariables.selectedQuantityList.clear();
                                                      mainVariables.stockMovementVariables.selectedProductsList.clear();
                                                      mainVariables.stockMovementVariables.sendData.inventories.clear();
                                                      mainVariables.stockMovementVariables.searchBar.clear();
                                                      mainVariables.confirmMovementVariables.stockMovementInventory.tableData.clear();
                                                      mainVariables.stockMovementVariables.senderInfo.senderLocationChoose = val;
                                                      mainVariables.stockMovementVariables.sendData.senderLocation = mainVariables.stockMovementVariables.senderInfo.senderLocationChoose.value;
                                                      mainVariables.stockMovementVariables.currentPage = 1;
                                                      context.read<StockMovementBloc>().add(const StockMovementTableChangingEvent());
                                                      if (mainVariables.stockMovementVariables.receiverInfo.receiverLocationChoose.value.isNotEmpty) {
                                                        if (mainVariables.stockMovementVariables.receiverInfo.receiverLocationChoose.value == mainVariables.stockMovementVariables.senderInfo.senderLocationChoose.value) {
                                                          if (mainVariables.stockMovementVariables.receiverInfo.receiverStockTypeChoose.value == mainVariables.stockMovementVariables.senderInfo.senderStockTypeChoose.value) {
                                                            mainWidgets.flushBarWidget(context: context, message: "You are trying to create a stock movement between the same location. Please change receiver location");
                                                          }
                                                        }
                                                      }
                                                      setState(() {});
                                                    },
                                                    onFieldChanged: () {
                                                      mainVariables.stockMovementVariables.selectedProductsIdList.clear();
                                                      mainVariables.stockMovementVariables.selectedQuantityList.clear();
                                                      mainVariables.stockMovementVariables.selectedProductsList.clear();
                                                      mainVariables.stockMovementVariables.sendData.inventories.clear();
                                                      mainVariables.stockMovementVariables.senderInfo.senderLocationChoose = DropDownValueModel.fromJson(const {});
                                                      mainVariables.stockMovementVariables.sendData.senderLocation = mainVariables.stockMovementVariables.senderInfo.senderLocationChoose.value;
                                                      mainVariables.stockMovementVariables.currentPage = 1;
                                                      context.read<StockMovementBloc>().add(const StockMovementTableChangingEvent());
                                                      setState(() {});
                                                    },
                                                  ),
                                                );
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: mainFunctions.getWidgetHeight(height: 5),
                                    ),
                                    SizedBox(
                                      height: mainFunctions.getWidgetHeight(height: 60),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            "Stock Type",
                                            style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 14), fontWeight: FontWeight.w600, color: const Color(0xff111111)),
                                          ),
                                          BlocBuilder<StockMovementBloc, StockMovementState>(
                                            builder: (BuildContext context, StockMovementState stock) {
                                              if (stock is StockMovementLoading) {
                                                return Shimmer.fromColors(
                                                  baseColor: Colors.grey.shade200,
                                                  highlightColor: Colors.white,
                                                  child: Container(
                                                    height: mainFunctions.getWidgetHeight(height: 38),
                                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: mainColors.whiteColor),
                                                    padding: EdgeInsets.only(left: mainFunctions.getWidgetWidth(width: 20), top: mainFunctions.getWidgetHeight(height: 16), right: mainFunctions.getWidgetWidth(width: 20)),
                                                  ),
                                                );
                                              } else {
                                                return SizedBox(
                                                  height: mainFunctions.getWidgetHeight(height: 38),
                                                  child: DropDownTextField(
                                                    key: key2,
                                                    key1: key1,
                                                    key2: key2,
                                                    key3: key3,
                                                    key4: key4,
                                                    key5: key5,
                                                    key6: key6,
                                                    key7: key7,
                                                    key8: key8,
                                                    key9: key9,
                                                    key10: key10,
                                                    initialValue: mainVariables.stockMovementVariables.senderInfo.senderStockTypeChoose,
                                                    textStyle: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 13), fontWeight: FontWeight.w600, color: const Color(0xff111111), overflow: TextOverflow.ellipsis),
                                                    listTextStyle: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 13), fontWeight: FontWeight.w600, color: const Color(0xff111111), overflow: TextOverflow.ellipsis),
                                                    keyboardType: TextInputType.text,
                                                    dropDownItemCount: 3,
                                                    hintText: "Select stock type",
                                                    dropDownList: mainVariables.stockMovementVariables.senderInfo.stockTypeDropDownList.toSet().toList(),
                                                    onChanged: (val) {
                                                      mainVariables.stockMovementVariables.selectedProductsIdList.clear();
                                                      mainVariables.stockMovementVariables.selectedQuantityList.clear();
                                                      mainVariables.stockMovementVariables.selectedProductsList.clear();
                                                      mainVariables.stockMovementVariables.sendData.inventories.clear();
                                                      mainVariables.confirmMovementVariables.stockMovementInventory.tableData.clear();
                                                      mainVariables.stockMovementVariables.senderInfo.senderStockTypeChoose = val;
                                                      mainVariables.stockMovementVariables.sendData.senderStockType = mainVariables.stockMovementVariables.senderInfo.senderStockTypeChoose.value;
                                                      mainVariables.stockMovementVariables.currentPage = 1;
                                                      context.read<StockMovementBloc>().add(const StockMovementTableChangingEvent());
                                                      if (mainVariables.stockMovementVariables.senderInfo.senderLocationChoose.value.isNotEmpty && mainVariables.stockMovementVariables.receiverInfo.receiverLocationChoose.value.isNotEmpty) {
                                                        if (mainVariables.stockMovementVariables.receiverInfo.receiverLocationChoose.value == mainVariables.stockMovementVariables.senderInfo.senderLocationChoose.value) {
                                                          if (mainVariables.stockMovementVariables.receiverInfo.receiverStockTypeChoose.value == mainVariables.stockMovementVariables.senderInfo.senderStockTypeChoose.value) {
                                                            mainWidgets.flushBarWidget(context: context, message: "You are trying to create a stock movement between the same location. Please change receiver location");
                                                          }
                                                        }
                                                      }
                                                      setState(() {});
                                                    },
                                                    onFieldChanged: () {
                                                      mainVariables.stockMovementVariables.selectedProductsIdList.clear();
                                                      mainVariables.stockMovementVariables.selectedQuantityList.clear();
                                                      mainVariables.stockMovementVariables.selectedProductsList.clear();
                                                      mainVariables.stockMovementVariables.sendData.inventories.clear();
                                                      mainVariables.stockMovementVariables.senderInfo.senderStockTypeChoose = DropDownValueModel.fromJson(const {});
                                                      mainVariables.stockMovementVariables.sendData.senderStockType = mainVariables.stockMovementVariables.senderInfo.senderStockTypeChoose.value;
                                                      mainVariables.stockMovementVariables.currentPage = 1;
                                                      context.read<StockMovementBloc>().add(const StockMovementTableChangingEvent());
                                                      setState(() {});
                                                    },
                                                  ),
                                                );
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: mainFunctions.getWidgetHeight(height: 5),
                                    ),
                                    SizedBox(
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
                                                BlocBuilder<StockMovementBloc, StockMovementState>(
                                                  builder: (BuildContext context, StockMovementState stock) {
                                                    if (stock is StockMovementLoading) {
                                                      return Shimmer.fromColors(
                                                        baseColor: Colors.grey.shade200,
                                                        highlightColor: Colors.white,
                                                        child: Container(
                                                          height: mainFunctions.getWidgetHeight(height: 38),
                                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: mainColors.whiteColor),
                                                          padding: EdgeInsets.only(left: mainFunctions.getWidgetWidth(width: 20), top: mainFunctions.getWidgetHeight(height: 16), right: mainFunctions.getWidgetWidth(width: 20)),
                                                        ),
                                                      );
                                                    } else {
                                                      return SizedBox(
                                                        height: mainFunctions.getWidgetHeight(height: 38),
                                                        child: DropDownTextField(
                                                          key: key3,
                                                          key1: key1,
                                                          key2: key2,
                                                          key3: key3,
                                                          key4: key4,
                                                          key5: key5,
                                                          key6: key6,
                                                          key7: key7,
                                                          key8: key8,
                                                          key9: key9,
                                                          key10: key10,
                                                          initialValue: mainVariables.stockMovementVariables.senderInfo.senderFromSectorChoose,
                                                          textStyle: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 12), fontWeight: FontWeight.w600, color: const Color(0xff111111), overflow: TextOverflow.ellipsis),
                                                          listTextStyle: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 11), fontWeight: FontWeight.w600, color: const Color(0xff111111), overflow: TextOverflow.ellipsis),
                                                          keyboardType: TextInputType.text,
                                                          dropDownItemCount: 3,
                                                          isSector: true,
                                                          isSectorRight: false,
                                                          hintText: "Select sector",
                                                          dropDownList: mainVariables.stockMovementVariables.senderInfo.sectorDropDownList.toSet().toList(),
                                                          suffixIconConstraints: const BoxConstraints(minWidth: 25, minHeight: 25),
                                                          onChanged: (val) {
                                                            mainVariables.stockMovementVariables.senderInfo.senderFromSectorChoose = val;
                                                            mainVariables.stockMovementVariables.sendData.sectorFrom = mainVariables.stockMovementVariables.senderInfo.senderFromSectorChoose.value;
                                                            if (mainVariables.stockMovementVariables.senderInfo.senderToSectorChoose.value.isNotEmpty) {
                                                              if (mainVariables.stockMovementVariables.senderInfo.senderToSectorChoose.value == mainVariables.stockMovementVariables.senderInfo.senderFromSectorChoose.value) {
                                                                mainWidgets.flushBarWidget(context: context, message: "Both sector from & to should not be same");
                                                              }
                                                            }
                                                          },
                                                          onFieldChanged: () {
                                                            mainVariables.stockMovementVariables.senderInfo.senderFromSectorChoose = DropDownValueModel.fromJson(const {});
                                                            mainVariables.stockMovementVariables.sendData.sectorFrom = "";
                                                            setState(() {});
                                                          },
                                                        ),
                                                      );
                                                    }
                                                  },
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
                                                BlocBuilder<StockMovementBloc, StockMovementState>(
                                                  builder: (BuildContext context, StockMovementState stock) {
                                                    if (stock is StockMovementLoading) {
                                                      return Shimmer.fromColors(
                                                        baseColor: Colors.grey.shade200,
                                                        highlightColor: Colors.white,
                                                        child: Container(
                                                          height: mainFunctions.getWidgetHeight(height: 38),
                                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: mainColors.whiteColor),
                                                          padding: EdgeInsets.only(left: mainFunctions.getWidgetWidth(width: 20), top: mainFunctions.getWidgetHeight(height: 16), right: mainFunctions.getWidgetWidth(width: 20)),
                                                        ),
                                                      );
                                                    } else {
                                                      return SizedBox(
                                                        height: mainFunctions.getWidgetHeight(height: 38),
                                                        child: DropDownTextField(
                                                          key: key4,
                                                          key1: key1,
                                                          key2: key2,
                                                          key3: key3,
                                                          key4: key4,
                                                          key5: key5,
                                                          key6: key6,
                                                          key7: key7,
                                                          key8: key8,
                                                          key9: key9,
                                                          key10: key10,
                                                          initialValue: mainVariables.stockMovementVariables.senderInfo.senderToSectorChoose,
                                                          textStyle: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 12), fontWeight: FontWeight.w600, color: const Color(0xff111111), overflow: TextOverflow.ellipsis),
                                                          listTextStyle: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 11), fontWeight: FontWeight.w600, color: const Color(0xff111111), overflow: TextOverflow.ellipsis),
                                                          keyboardType: TextInputType.text,
                                                          dropDownItemCount: 3,
                                                          isSector: true,
                                                          isSectorRight: true,
                                                          hintText: "Select sector",
                                                          dropDownList: mainVariables.stockMovementVariables.senderInfo.sectorDropDownList.toSet().toList(),
                                                          suffixIconConstraints: const BoxConstraints(minWidth: 25, minHeight: 25),
                                                          onChanged: (val) {
                                                            mainVariables.stockMovementVariables.senderInfo.senderToSectorChoose = val;
                                                            mainVariables.stockMovementVariables.sendData.sectorTo = mainVariables.stockMovementVariables.senderInfo.senderToSectorChoose.value;
                                                            if (mainVariables.stockMovementVariables.senderInfo.senderFromSectorChoose.value.isNotEmpty) {
                                                              if (mainVariables.stockMovementVariables.senderInfo.senderFromSectorChoose.value == mainVariables.stockMovementVariables.senderInfo.senderToSectorChoose.value) {
                                                                mainWidgets.flushBarWidget(context: context, message: "Both sector from & to should not be same");
                                                              }
                                                            }
                                                          },
                                                          onFieldChanged: () {
                                                            mainVariables.stockMovementVariables.senderInfo.senderToSectorChoose = DropDownValueModel.fromJson(const {});
                                                            mainVariables.stockMovementVariables.sendData.sectorTo = "";
                                                            setState(() {});
                                                          },
                                                        ),
                                                      );
                                                    }
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: mainFunctions.getWidgetWidth(width: 28),
                      ),
                      Expanded(
                          child: Container(
                        height: mainFunctions.getWidgetHeight(height: 302),
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: mainFunctions.getWidgetHeight(height: 40),
                              width: mainFunctions.getWidgetWidth(width: 600),
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15),
                                ),
                                color: Color(0xff377DFF),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: mainFunctions.getWidgetWidth(width: 15),
                                  top: mainFunctions.getWidgetHeight(height: 8),
                                ),
                                child: Text(
                                  "Receiver Info",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: mainFunctions.getTextSize(fontSize: 17),
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: mainFunctions.getWidgetWidth(width: 10),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    height: mainFunctions.getWidgetHeight(height: 60),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          "Crew / Handler ",
                                          style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 14), fontWeight: FontWeight.w600, color: const Color(0xff111111)),
                                        ),
                                        BlocBuilder<StockMovementBloc, StockMovementState>(
                                          builder: (BuildContext context, StockMovementState stock) {
                                            if (stock is StockMovementLoading) {
                                              return Shimmer.fromColors(
                                                baseColor: Colors.grey.shade200,
                                                highlightColor: Colors.white,
                                                child: Container(
                                                  height: mainFunctions.getWidgetHeight(height: 38),
                                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: mainColors.whiteColor),
                                                  padding: EdgeInsets.only(left: mainFunctions.getWidgetWidth(width: 20), top: mainFunctions.getWidgetHeight(height: 16), right: mainFunctions.getWidgetWidth(width: 20)),
                                                ),
                                              );
                                            } else {
                                              return SizedBox(
                                                height: mainFunctions.getWidgetHeight(height: 38),
                                                child: Form(
                                                  child: FormField<String>(
                                                    builder: (FormFieldState<String> state) {
                                                      return InputDecorator(
                                                        decoration: InputDecoration(
                                                          fillColor: const Color(0xffFFFFFF),
                                                          filled: true,
                                                          contentPadding: EdgeInsets.only(right: mainFunctions.getWidgetWidth(width: 12)),
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
                                                          hintText: "Select type",
                                                          hintStyle: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 13), fontWeight: FontWeight.w600, color: const Color(0xff111111), overflow: TextOverflow.ellipsis),
                                                        ),
                                                        child: DropdownButtonHideUnderline(
                                                          child: DropdownButton2<String>(
                                                            style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 13), fontWeight: FontWeight.w600, color: const Color(0xff111111), overflow: TextOverflow.ellipsis),
                                                            items: mainVariables.receivedStocksVariables.receiverInfo.receiverTypeList.map<DropdownMenuItem<String>>((String value) {
                                                              return DropdownMenuItem(
                                                                value: value,
                                                                child: Text(
                                                                  value,
                                                                  style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 13), fontWeight: FontWeight.w500, color: const Color(0xff111111), overflow: TextOverflow.ellipsis),
                                                                ),
                                                              );
                                                            }).toList(),
                                                            isExpanded: true,
                                                            isDense: true,
                                                            onChanged: (String? type) {
                                                              mainVariables.stockMovementVariables.receiverInfo.receiverType = type!;
                                                              mainVariables.stockMovementVariables.sendData.receiverType = type;
                                                              mainVariables.stockMovementVariables.sendData.receiverName = "";
                                                              mainVariables.stockMovementVariables.sendData.receiverLocation = "";
                                                              mainVariables.stockMovementVariables.sendData.receiverStockType = "";
                                                              mainVariables.stockMovementVariables.receiverInfo.crewChoose = const DropDownValueModel(name: "N/A", value: "");
                                                              mainVariables.stockMovementVariables.receiverInfo.handlerChoose = DropDownValueModel.fromJson(const {});
                                                              if (type == "Crew") {
                                                                mainVariables.stockMovementVariables.receiverInfo.receiverStockTypeChoose = mainVariables.stockMovementVariables.senderInfo.stockTypeDropDownList[0];
                                                                mainVariables.stockMovementVariables.sendData.receiverStockType = mainVariables.stockMovementVariables.senderInfo.stockTypeDropDownList[0].value;
                                                                mainVariables.stockMovementVariables.receiverInfo.receiverLocationChoose = DropDownValueModel.fromJson(const {});
                                                              } else {
                                                                mainVariables.stockMovementVariables.receiverInfo.receiverStockTypeChoose = const DropDownValueModel(name: "N/A", value: "");
                                                                mainVariables.stockMovementVariables.receiverInfo.receiverLocationChoose = const DropDownValueModel(name: "N/A", value: "");
                                                              }

                                                              setState(() {});
                                                            },
                                                            value: mainVariables.stockMovementVariables.receiverInfo.receiverType,
                                                            dropdownStyleData: DropdownStyleData(
                                                              decoration: BoxDecoration(
                                                                color: Colors.white,
                                                                borderRadius: BorderRadius.circular(12),
                                                              ),
                                                              offset: const Offset(0, -10),
                                                            ),
                                                            iconStyleData: const IconStyleData(
                                                              icon: Icon(
                                                                Icons.keyboard_arrow_down,
                                                                color: Colors.black,
                                                                size: 20,
                                                              ),
                                                              iconSize: 20,
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              );
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: mainFunctions.getWidgetHeight(height: 5),
                                  ),
                                  SizedBox(
                                    height: mainFunctions.getWidgetHeight(height: 60),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          mainVariables.stockMovementVariables.receiverInfo.receiverType == "Crew" ? "Crew Name" : "Handler Name",
                                          style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 14), fontWeight: FontWeight.w600, color: const Color(0xff111111)),
                                        ),
                                        BlocBuilder<StockMovementBloc, StockMovementState>(
                                          builder: (BuildContext context, StockMovementState stock) {
                                            if (stock is StockMovementLoading) {
                                              return Shimmer.fromColors(
                                                baseColor: Colors.grey.shade200,
                                                highlightColor: Colors.white,
                                                child: Container(
                                                  height: mainFunctions.getWidgetHeight(height: 38),
                                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: mainColors.whiteColor),
                                                  padding: EdgeInsets.only(left: mainFunctions.getWidgetWidth(width: 20), top: mainFunctions.getWidgetHeight(height: 16), right: mainFunctions.getWidgetWidth(width: 20)),
                                                ),
                                              );
                                            } else {
                                              return AnimatedCrossFade(
                                                  firstChild: SizedBox(
                                                      height: mainFunctions.getWidgetHeight(height: 38),
                                                      child: DropDownTextField(
                                                        key: key5,
                                                        key1: key1,
                                                        key2: key2,
                                                        key3: key3,
                                                        key4: key4,
                                                        key5: key5,
                                                        key6: key6,
                                                        key7: key7,
                                                        key8: key8,
                                                        key9: key9,
                                                        key10: key10,
                                                        initialValue: DropDownValueModel.fromJson(const {}),
                                                        enabled: false,
                                                        textStyle: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 13), fontWeight: FontWeight.w600, color: const Color(0xff111111), overflow: TextOverflow.ellipsis),
                                                        listTextStyle: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 13), fontWeight: FontWeight.w600, color: const Color(0xff111111), overflow: TextOverflow.ellipsis),
                                                        keyboardType: TextInputType.text,
                                                        dropDownItemCount: 3,
                                                        dropDownList: <DropDownValueModel>{}.toList(),
                                                        hintText: "Crew name is not required",
                                                      )),
                                                  secondChild: SizedBox(
                                                    height: mainFunctions.getWidgetHeight(height: 38),
                                                    child: DropDownTextField(
                                                      key: key6,
                                                      key1: key1,
                                                      key2: key2,
                                                      key3: key3,
                                                      key4: key4,
                                                      key5: key5,
                                                      key6: key6,
                                                      key7: key7,
                                                      key8: key8,
                                                      key9: key9,
                                                      key10: key10,
                                                      initialValue: mainVariables.stockMovementVariables.receiverInfo.handlerChoose,
                                                      textStyle: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 13), fontWeight: FontWeight.w600, color: const Color(0xff111111), overflow: TextOverflow.ellipsis),
                                                      listTextStyle: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 13), fontWeight: FontWeight.w600, color: const Color(0xff111111), overflow: TextOverflow.ellipsis),
                                                      keyboardType: TextInputType.text,
                                                      dropDownItemCount: 3,
                                                      dropDownList: mainVariables.stockMovementVariables.receiverInfo.handlerDropDownList.toSet().toList(),
                                                      hintText: "Select handler",
                                                      onChanged: (val) {
                                                        mainVariables.stockMovementVariables.receiverInfo.handlerChoose = val;
                                                        mainVariables.stockMovementVariables.sendData.receiverName = mainVariables.stockMovementVariables.receiverInfo.handlerChoose.value;
                                                      },
                                                      onFieldChanged: () {
                                                        mainVariables.stockMovementVariables.receiverInfo.crewChoose = const DropDownValueModel(name: "N/A", value: "");
                                                        mainVariables.stockMovementVariables.receiverInfo.handlerChoose = DropDownValueModel.fromJson(const {});
                                                        mainVariables.stockMovementVariables.sendData.receiverName = "";
                                                        setState(() {});
                                                      },
                                                    ),
                                                  ),
                                                  crossFadeState: mainVariables.stockMovementVariables.receiverInfo.receiverType == "Crew" ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                                                  duration: const Duration(milliseconds: 100));
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: mainFunctions.getWidgetHeight(height: 5),
                                  ),
                                  SizedBox(
                                    height: mainFunctions.getWidgetHeight(height: 60),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          "Stock type ",
                                          style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 14), fontWeight: FontWeight.w600, color: const Color(0xff111111)),
                                        ),
                                        BlocBuilder<StockMovementBloc, StockMovementState>(
                                          builder: (BuildContext context, StockMovementState stock) {
                                            if (stock is StockMovementLoading) {
                                              return Shimmer.fromColors(
                                                baseColor: Colors.grey.shade200,
                                                highlightColor: Colors.white,
                                                child: Container(
                                                  height: mainFunctions.getWidgetHeight(height: 38),
                                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: mainColors.whiteColor),
                                                  padding: EdgeInsets.only(left: mainFunctions.getWidgetWidth(width: 20), top: mainFunctions.getWidgetHeight(height: 16), right: mainFunctions.getWidgetWidth(width: 20)),
                                                ),
                                              );
                                            } else {
                                              return AnimatedCrossFade(
                                                  firstChild: SizedBox(
                                                    height: mainFunctions.getWidgetHeight(height: 38),
                                                    child: DropDownTextField(
                                                      key: key7,
                                                      key1: key1,
                                                      key2: key2,
                                                      key3: key3,
                                                      key4: key4,
                                                      key5: key5,
                                                      key6: key6,
                                                      key7: key7,
                                                      key8: key8,
                                                      key9: key9,
                                                      key10: key10,
                                                      initialValue: DropDownValueModel.fromJson(const {}),
                                                      enabled: false,
                                                      textStyle: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 13), fontWeight: FontWeight.w600, color: const Color(0xff111111), overflow: TextOverflow.ellipsis),
                                                      listTextStyle: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 13), fontWeight: FontWeight.w600, color: const Color(0xff111111), overflow: TextOverflow.ellipsis),
                                                      keyboardType: TextInputType.text,
                                                      dropDownItemCount: 3,
                                                      dropDownList: const [],
                                                      hintText: "Stock type not required",
                                                    ),
                                                  ),
                                                  secondChild: SizedBox(
                                                    height: mainFunctions.getWidgetHeight(height: 38),
                                                    child: DropDownTextField(
                                                      key: key8,
                                                      key1: key1,
                                                      key2: key2,
                                                      key3: key3,
                                                      key4: key4,
                                                      key5: key5,
                                                      key6: key6,
                                                      key7: key7,
                                                      key8: key8,
                                                      key9: key9,
                                                      key10: key10,
                                                      initialValue: mainVariables.stockMovementVariables.receiverInfo.receiverStockTypeChoose,
                                                      textStyle: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 13), fontWeight: FontWeight.w600, color: const Color(0xff111111), overflow: TextOverflow.ellipsis),
                                                      listTextStyle: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 13), fontWeight: FontWeight.w600, color: const Color(0xff111111), overflow: TextOverflow.ellipsis),
                                                      keyboardType: TextInputType.text,
                                                      dropDownItemCount: 3,
                                                      dropDownList: mainVariables.stockMovementVariables.senderInfo.stockTypeDropDownList.toSet().toList(),
                                                      hintText: "Select stock type",
                                                      onChanged: (val) {
                                                        mainVariables.stockMovementVariables.receiverInfo.receiverStockTypeChoose = val;
                                                        mainVariables.stockMovementVariables.sendData.receiverStockType = mainVariables.stockMovementVariables.receiverInfo.receiverStockTypeChoose.value;
                                                        if (mainVariables.stockMovementVariables.senderInfo.senderLocationChoose.value.isNotEmpty && mainVariables.stockMovementVariables.receiverInfo.receiverLocationChoose.value.isNotEmpty) {
                                                          if (mainVariables.stockMovementVariables.receiverInfo.receiverLocationChoose.value == mainVariables.stockMovementVariables.senderInfo.senderLocationChoose.value) {
                                                            if (mainVariables.stockMovementVariables.receiverInfo.receiverStockTypeChoose.value == mainVariables.stockMovementVariables.senderInfo.senderStockTypeChoose.value) {
                                                              mainWidgets.flushBarWidget(context: context, message: "You are trying to create a stock movement between the same location. Please change receiver location");
                                                            }
                                                          }
                                                        }
                                                      },
                                                      onFieldChanged: () {
                                                        mainVariables.stockMovementVariables.receiverInfo.receiverLocationChoose = DropDownValueModel.fromJson(const {});
                                                        mainVariables.stockMovementVariables.sendData.receiverStockType = "";
                                                        setState(() {});
                                                      },
                                                    ),
                                                  ),
                                                  crossFadeState: mainVariables.stockMovementVariables.receiverInfo.receiverType != "Crew" ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                                                  duration: const Duration(milliseconds: 100));
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: mainFunctions.getWidgetHeight(height: 5),
                                  ),
                                  SizedBox(
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
                                        BlocBuilder<StockMovementBloc, StockMovementState>(
                                          builder: (BuildContext context, StockMovementState stock) {
                                            if (stock is StockMovementLoading) {
                                              return Shimmer.fromColors(
                                                baseColor: Colors.grey.shade200,
                                                highlightColor: Colors.white,
                                                child: Container(
                                                  height: mainFunctions.getWidgetHeight(height: 38),
                                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: mainColors.whiteColor),
                                                  padding: EdgeInsets.only(left: mainFunctions.getWidgetWidth(width: 20), top: mainFunctions.getWidgetHeight(height: 16), right: mainFunctions.getWidgetWidth(width: 20)),
                                                ),
                                              );
                                            } else {
                                              return AnimatedCrossFade(
                                                  firstChild: SizedBox(
                                                    height: mainFunctions.getWidgetHeight(height: 38),
                                                    child: DropDownTextField(
                                                      key: key9,
                                                      key1: key1,
                                                      key2: key2,
                                                      key3: key3,
                                                      key4: key4,
                                                      key5: key5,
                                                      key6: key6,
                                                      key7: key7,
                                                      key8: key8,
                                                      key9: key9,
                                                      key10: key10,
                                                      initialValue: DropDownValueModel.fromJson(const {}),
                                                      enabled: false,
                                                      textStyle: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 13), fontWeight: FontWeight.w600, color: const Color(0xff111111), overflow: TextOverflow.ellipsis),
                                                      listTextStyle: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 13), fontWeight: FontWeight.w600, color: const Color(0xff111111), overflow: TextOverflow.ellipsis),
                                                      keyboardType: TextInputType.text,
                                                      dropDownItemCount: 3,
                                                      dropDownList: <DropDownValueModel>{}.toList(),
                                                      hintText: "Location not required",
                                                    ),
                                                  ),
                                                  secondChild: SizedBox(
                                                    height: mainFunctions.getWidgetHeight(height: 38),
                                                    child: DropDownTextField(
                                                      key: key10,
                                                      key1: key1,
                                                      key2: key2,
                                                      key3: key3,
                                                      key4: key4,
                                                      key5: key5,
                                                      key6: key6,
                                                      key7: key7,
                                                      key8: key8,
                                                      key9: key9,
                                                      key10: key10,
                                                      initialValue: mainVariables.stockMovementVariables.receiverInfo.receiverLocationChoose,
                                                      textStyle: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 13), fontWeight: FontWeight.w600, color: const Color(0xff111111), overflow: TextOverflow.ellipsis),
                                                      listTextStyle: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 13), fontWeight: FontWeight.w600, color: const Color(0xff111111), overflow: TextOverflow.ellipsis),
                                                      keyboardType: TextInputType.text,
                                                      dropDownItemCount: 3,
                                                      dropDownList: mainVariables.stockMovementVariables.senderInfo.locationDropDownList.toSet().toList(),
                                                      hintText: "Select location",
                                                      onChanged: (val) {
                                                        mainVariables.stockMovementVariables.receiverInfo.receiverLocationChoose = val;
                                                        mainVariables.stockMovementVariables.sendData.receiverLocation = mainVariables.stockMovementVariables.receiverInfo.receiverLocationChoose.value;
                                                        if (mainVariables.stockMovementVariables.senderInfo.senderLocationChoose.value.isNotEmpty) {
                                                          if (mainVariables.stockMovementVariables.receiverInfo.receiverLocationChoose.value == mainVariables.stockMovementVariables.senderInfo.senderLocationChoose.value) {
                                                            if (mainVariables.stockMovementVariables.receiverInfo.receiverStockTypeChoose.value == mainVariables.stockMovementVariables.senderInfo.senderStockTypeChoose.value) {
                                                              mainWidgets.flushBarWidget(context: context, message: "You are trying to create a stock movement between the same location. Please change receiver location");
                                                            }
                                                          }
                                                        }
                                                      },
                                                      onFieldChanged: () {
                                                        mainVariables.stockMovementVariables.receiverInfo.receiverLocationChoose = DropDownValueModel.fromJson(const {});
                                                        mainVariables.stockMovementVariables.sendData.receiverLocation = "";
                                                        setState(() {});
                                                      },
                                                    ),
                                                  ),
                                                  crossFadeState: mainVariables.stockMovementVariables.receiverInfo.receiverType != "Crew" ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                                                  duration: const Duration(milliseconds: 100));
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: mainFunctions.getWidgetHeight(height: 8),
          ),
          mainVariables.stockMovementVariables.senderInfo.senderLocationChoose.value == "" || mainVariables.stockMovementVariables.senderInfo.senderStockTypeChoose.value == ""
              ? const SizedBox()
              : Container(
                  height: mainFunctions.getWidgetHeight(height: 575),
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
                            SizedBox(
                              width: mainFunctions.getWidgetWidth(width: 280),
                              height: mainFunctions.getWidgetHeight(height: 36),
                              child: TextFormField(
                                controller: mainVariables.stockMovementVariables.searchBar,
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
                                      mainVariables.stockMovementVariables.searchBar.text = await mainFunctions.barCodeScan(context: context);
                                      mainVariables.stockMovementVariables.currentPage = 1;
                                      if (mounted) {
                                        context.read<StockMovementBloc>().add(const StockMovementTableChangingEvent());
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
                                  mainVariables.stockMovementVariables.currentPage = 1;
                                  context.read<StockMovementBloc>().add(const StockMovementTableChangingEvent());
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
                      BlocConsumer<StockMovementBloc, StockMovementState>(
                        listenWhen: (previous, current) {
                          return previous != current;
                        },
                        buildWhen: (previous, current) {
                          return previous != current;
                        },
                        listener: (BuildContext context, StockMovementState stock) {
                          if (stock is StockMovementFailure) {
                            mainWidgets.flushBarWidget(context: context, message: stock.errorMessage);
                          }
                        },
                        builder: (BuildContext context, StockMovementState stock) {
                          if (stock is StockMovementLoaded) {
                            return Expanded(
                              child: mainVariables.stockMovementVariables.stockMovementInventory.tableData.isEmpty
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
                                      columnsLength: mainVariables.stockMovementVariables.stockMovementInventory.tableHeading.length,
                                      rowsLength: mainVariables.stockMovementVariables.stockMovementInventory.tableData.length,
                                      columnsTitleBuilder: (int columnIndex) {
                                        return Center(
                                          child: Text(
                                            mainVariables.stockMovementVariables.stockMovementInventory.tableHeading[columnIndex],
                                            maxLines: 2,
                                            style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 12), overflow: TextOverflow.ellipsis, fontWeight: FontWeight.w600),
                                            textAlign: TextAlign.center,
                                          ),
                                        );
                                      },
                                      rowsTitleBuilder: (int rowIndex) {
                                        return Center(
                                          child: Text(
                                            ((mainVariables.stockMovementVariables.currentPage - 1) * 6) + (rowIndex + 1) < 10 ? "0${((mainVariables.stockMovementVariables.currentPage - 1) * 6) + (rowIndex + 1)}" : "${((mainVariables.stockMovementVariables.currentPage - 1) * 6) + (rowIndex + 1)}",
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
                                                          int sendQuantity = int.parse(mainVariables.stockMovementVariables.stockMovementInventory.tableData[rowIndex][columnIndex]);
                                                          if (sendQuantity > 0) {
                                                            setState(() {
                                                              sendQuantity--;
                                                              mainVariables.stockMovementVariables.stockMovementInventory.tableData[rowIndex][columnIndex] = sendQuantity.toString();
                                                            });
                                                          }
                                                          if (sendQuantity == 0 && mainVariables.stockMovementVariables.selectedProductsIdList.contains(mainVariables.stockMovementVariables.stockMovementInventory.tableData[rowIndex][columnIndex + 2])) {
                                                            mainVariables.stockMovementVariables.selectedQuantityList.removeAt(mainVariables.stockMovementVariables.selectedProductsIdList.indexOf(mainVariables.stockMovementVariables.stockMovementInventory.tableData[rowIndex][columnIndex + 2]));
                                                            mainVariables.confirmMovementVariables.stockMovementInventory.tableData
                                                                .removeAt(mainVariables.stockMovementVariables.selectedProductsIdList.indexOf(mainVariables.stockMovementVariables.stockMovementInventory.tableData[rowIndex][columnIndex + 2]));
                                                            mainVariables.stockMovementVariables.selectedProductsIdList.remove(mainVariables.stockMovementVariables.stockMovementInventory.tableData[rowIndex][columnIndex + 2]);
                                                          } else {
                                                            mainVariables.stockMovementVariables.selectedQuantityList[mainVariables.stockMovementVariables.selectedProductsIdList.indexOf(mainVariables.stockMovementVariables.stockMovementInventory.tableData[rowIndex][columnIndex + 2])] = sendQuantity;
                                                          }
                                                          if (mainVariables.confirmMovementVariables.stockMovementInventory.tableData.isNotEmpty) {
                                                            for (int i = 0; i < mainVariables.confirmMovementVariables.stockMovementInventory.tableData.length; i++) {
                                                              if (mainVariables.confirmMovementVariables.stockMovementInventory.tableData[i][9] == mainVariables.stockMovementVariables.stockMovementInventory.tableData[rowIndex][columnIndex + 2]) {
                                                                mainVariables.confirmMovementVariables.stockMovementInventory.tableData[i][7] = sendQuantity.toString();
                                                              }
                                                            }
                                                          }
                                                        },
                                                        onTapDown: (val) {
                                                          int sendQuantity = int.parse(mainVariables.stockMovementVariables.stockMovementInventory.tableData[rowIndex][columnIndex]);
                                                          timer = Timer.periodic(const Duration(milliseconds: 25), (Timer t) {
                                                            if (sendQuantity > 0) {
                                                              setState(() {
                                                                sendQuantity--;
                                                                mainVariables.stockMovementVariables.stockMovementInventory.tableData[rowIndex][columnIndex] = sendQuantity.toString();
                                                              });
                                                            }
                                                            if (sendQuantity == 0 && mainVariables.stockMovementVariables.selectedProductsIdList.contains(mainVariables.stockMovementVariables.stockMovementInventory.tableData[rowIndex][columnIndex + 2])) {
                                                              mainVariables.stockMovementVariables.selectedQuantityList.removeAt(mainVariables.stockMovementVariables.selectedProductsIdList.indexOf(mainVariables.stockMovementVariables.stockMovementInventory.tableData[rowIndex][columnIndex + 2]));
                                                              mainVariables.confirmMovementVariables.stockMovementInventory.tableData
                                                                  .removeAt(mainVariables.stockMovementVariables.selectedProductsIdList.indexOf(mainVariables.stockMovementVariables.stockMovementInventory.tableData[rowIndex][columnIndex + 2]));
                                                              mainVariables.stockMovementVariables.selectedProductsIdList.remove(mainVariables.stockMovementVariables.stockMovementInventory.tableData[rowIndex][columnIndex + 2]);
                                                            } else {
                                                              mainVariables.stockMovementVariables.selectedQuantityList[mainVariables.stockMovementVariables.selectedProductsIdList.indexOf(mainVariables.stockMovementVariables.stockMovementInventory.tableData[rowIndex][columnIndex + 2])] =
                                                                  sendQuantity;
                                                            }
                                                            if (mainVariables.confirmMovementVariables.stockMovementInventory.tableData.isNotEmpty) {
                                                              for (int i = 0; i < mainVariables.confirmMovementVariables.stockMovementInventory.tableData.length; i++) {
                                                                if (mainVariables.confirmMovementVariables.stockMovementInventory.tableData[i][9] == mainVariables.stockMovementVariables.stockMovementInventory.tableData[rowIndex][columnIndex + 2]) {
                                                                  mainVariables.confirmMovementVariables.stockMovementInventory.tableData[i][7] = sendQuantity.toString();
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
                                                        mainVariables.stockMovementVariables.selectedProductsIdList.isNotEmpty && mainVariables.stockMovementVariables.selectedProductsIdList.contains(mainVariables.stockMovementVariables.stockMovementInventory.tableData[rowIndex][columnIndex + 2])
                                                            ? mainVariables.stockMovementVariables.selectedQuantityList[mainVariables.stockMovementVariables.selectedProductsIdList.indexOf(mainVariables.stockMovementVariables.stockMovementInventory.tableData[rowIndex][columnIndex + 2])].toString()
                                                            : mainVariables.stockMovementVariables.stockMovementInventory.tableData[rowIndex][columnIndex],
                                                        maxLines: 1,
                                                        style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 12), overflow: TextOverflow.ellipsis, fontWeight: FontWeight.normal),
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          int sendQuantity = int.parse(mainVariables.stockMovementVariables.stockMovementInventory.tableData[rowIndex][columnIndex]);
                                                          if (sendQuantity < int.parse(mainVariables.stockMovementVariables.stockMovementInventory.tableData[rowIndex][columnIndex - 1])) {
                                                            setState(() {
                                                              sendQuantity++;
                                                              mainVariables.stockMovementVariables.stockMovementInventory.tableData[rowIndex][columnIndex] = sendQuantity.toString();
                                                            });
                                                            if (mainVariables.stockMovementVariables.selectedProductsIdList.contains(mainVariables.stockMovementVariables.stockMovementInventory.tableData[rowIndex][columnIndex + 2])) {
                                                              mainVariables.stockMovementVariables.selectedQuantityList[mainVariables.stockMovementVariables.selectedProductsIdList.indexOf(mainVariables.stockMovementVariables.stockMovementInventory.tableData[rowIndex][columnIndex + 2])] =
                                                                  sendQuantity;
                                                            } else {
                                                              mainVariables.stockMovementVariables.selectedProductsIdList.add(mainVariables.stockMovementVariables.stockMovementInventory.tableData[rowIndex][columnIndex + 2]);
                                                              mainVariables.stockMovementVariables.selectedQuantityList.add(sendQuantity);
                                                              mainVariables.confirmMovementVariables.stockMovementInventory.tableData.add(mainVariables.stockMovementVariables.stockMovementInventory.tableData[rowIndex]);
                                                            }
                                                            for (int i = 0; i < mainVariables.confirmMovementVariables.stockMovementInventory.tableData.length; i++) {
                                                              if (mainVariables.confirmMovementVariables.stockMovementInventory.tableData[i][9] == mainVariables.stockMovementVariables.stockMovementInventory.tableData[rowIndex][columnIndex + 2]) {
                                                                mainVariables.confirmMovementVariables.stockMovementInventory.tableData[i][7] = sendQuantity.toString();
                                                              }
                                                            }
                                                          }
                                                        },
                                                        onTapDown: (val) {
                                                          int sendQuantity = int.parse(mainVariables.stockMovementVariables.stockMovementInventory.tableData[rowIndex][columnIndex]);
                                                          timer = Timer.periodic(const Duration(milliseconds: 25), (Timer t) {
                                                            if (sendQuantity < int.parse(mainVariables.stockMovementVariables.stockMovementInventory.tableData[rowIndex][columnIndex - 1])) {
                                                              setState(() {
                                                                sendQuantity++;
                                                                mainVariables.stockMovementVariables.stockMovementInventory.tableData[rowIndex][columnIndex] = sendQuantity.toString();
                                                              });
                                                              if (mainVariables.stockMovementVariables.selectedProductsIdList.contains(mainVariables.stockMovementVariables.stockMovementInventory.tableData[rowIndex][columnIndex + 2])) {
                                                                mainVariables.stockMovementVariables.selectedQuantityList[mainVariables.stockMovementVariables.selectedProductsIdList.indexOf(mainVariables.stockMovementVariables.stockMovementInventory.tableData[rowIndex][columnIndex + 2])] =
                                                                    sendQuantity;
                                                              } else {
                                                                mainVariables.stockMovementVariables.selectedProductsIdList.add(mainVariables.stockMovementVariables.stockMovementInventory.tableData[rowIndex][columnIndex + 2]);
                                                                mainVariables.stockMovementVariables.selectedQuantityList.add(sendQuantity);
                                                                mainVariables.confirmMovementVariables.stockMovementInventory.tableData.add(mainVariables.stockMovementVariables.stockMovementInventory.tableData[rowIndex]);
                                                              }
                                                              for (int i = 0; i < mainVariables.confirmMovementVariables.stockMovementInventory.tableData.length; i++) {
                                                                if (mainVariables.confirmMovementVariables.stockMovementInventory.tableData[i][9] == mainVariables.stockMovementVariables.stockMovementInventory.tableData[rowIndex][columnIndex + 2]) {
                                                                  mainVariables.confirmMovementVariables.stockMovementInventory.tableData[i][7] = sendQuantity.toString();
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
                                                      mainVariables.stockMovementVariables.stockMovementInventory.tableData[rowIndex][columnIndex],
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
                                                  mainFunctions.getWidgetHeight(height: 160),
                                                  mainFunctions.getWidgetHeight(height: 160),
                                                  mainFunctions.getWidgetHeight(height: 160),
                                                  mainFunctions.getWidgetHeight(height: 160),
                                                  mainFunctions.getWidgetHeight(height: 115),
                                                  mainFunctions.getWidgetHeight(height: 115),
                                                ],
                                          contentCellHeight: 40,
                                          stickyLegendWidth: 40,
                                          stickyLegendHeight: 40),
                                    ),
                            );
                          } else if (stock is StockMovementLoading) {
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
                      BlocBuilder<StockMovementBloc, StockMovementState>(
                        builder: (BuildContext context, StockMovementState stock) {
                          if (stock is StockMovementLoaded) {
                            return mainVariables.stockMovementVariables.stockMovementInventory.tableData.isEmpty
                                ? const SizedBox()
                                : Center(
                                    child: SizedBox(
                                      width: mainFunctions.getWidgetWidth(width: 450),
                                      child: NumberPaginator(
                                        initialPage: mainVariables.stockMovementVariables.currentPage - 1,
                                        numberPages: mainVariables.stockMovementVariables.totalPages,
                                        onPageChange: (int index) {
                                          mainVariables.stockMovementVariables.currentPage = index + 1;
                                          context.read<StockMovementBloc>().add(const StockMovementTableChangingEvent());
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
                          } else {
                            return const SizedBox();
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
            status: false,
            height: 42,
            onTap: () {
              if (mainVariables.stockMovementVariables.senderInfo.senderLocationChoose.name == "" || mainVariables.stockMovementVariables.senderInfo.senderStockTypeChoose.name == "") {
                if (mainVariables.stockMovementVariables.senderInfo.senderLocationChoose.name == "") {
                  mainWidgets.flushBarWidget(context: context, message: "Sender location field is empty, please select location");
                } else if (mainVariables.stockMovementVariables.senderInfo.senderStockTypeChoose.name == "") {
                  mainWidgets.flushBarWidget(context: context, message: "Sender stock type field is empty, please select stock type");
                }
              }
              else {
                if (mainVariables.stockMovementVariables.sendData.receiverType == "Crew") {
                  if (mainVariables.stockMovementVariables.receiverInfo.receiverLocationChoose.name == "" || mainVariables.stockMovementVariables.receiverInfo.receiverStockTypeChoose.name == "") {
                    if (mainVariables.stockMovementVariables.receiverInfo.receiverLocationChoose.name == "") {
                      mainWidgets.flushBarWidget(context: context, message: "Receiver location field is empty, please select location");
                    }
                    else if (mainVariables.stockMovementVariables.receiverInfo.receiverStockTypeChoose.name == "") {
                      mainWidgets.flushBarWidget(context: context, message: "Receiver stock type field is empty, please select stock type");
                    }
                  }
                  else {
                    if (mainVariables.stockMovementVariables.receiverInfo.receiverLocationChoose.value == mainVariables.stockMovementVariables.senderInfo.senderLocationChoose.value) {
                      if (mainVariables.stockMovementVariables.receiverInfo.receiverStockTypeChoose.value == mainVariables.stockMovementVariables.senderInfo.senderStockTypeChoose.value) {
                        mainWidgets.flushBarWidget(context: context, message: "You are trying to create a stock movement between the same location. Please change receiver location");
                      }
                      else {
                        if (mainVariables.stockMovementVariables.senderInfo.senderFromSectorChoose.name != "" && mainVariables.stockMovementVariables.senderInfo.senderToSectorChoose.name != "") {
                          if (mainVariables.stockMovementVariables.senderInfo.senderFromSectorChoose.value == mainVariables.stockMovementVariables.senderInfo.senderToSectorChoose.value) {
                            mainWidgets.flushBarWidget(context: context, message: "You selected both sector from & to are same, please choose different sectors");
                          }
                          else {
                            mainVariables.stockMovementVariables.sendData.inventories.clear();
                            int totalList = 0;
                            for (int i = 0; i < mainVariables.stockMovementVariables.selectedProductsIdList.length; i++) {
                              Map<String, dynamic> selectedMap = {
                                "inventory": mainVariables.stockMovementVariables.selectedProductsIdList[i],
                                "quantity": mainVariables.stockMovementVariables.selectedQuantityList[i],
                              };
                              mainVariables.stockMovementVariables.selectedProductsList.add(AddProductsList.fromJson(selectedMap));
                              totalList = totalList + mainVariables.stockMovementVariables.selectedProductsList[i].quantity;
                            }
                            if (totalList == 0) {
                              mainWidgets.flushBarWidget(context: context, message: "Please add the no of products to transit");
                            } else {
                              mainVariables.stockMovementVariables.sendData.inventories = mainVariables.stockMovementVariables.selectedProductsList;
                              mainVariables.generalVariables.railNavigateBackIndex = mainVariables.generalVariables.railNavigateIndex;
                              mainVariables.generalVariables.railNavigateIndex = 12;
                              context.read<RailNavigationBloc>().add(const RailNavigationSelectedWidgetEvent());
                            }
                          }
                        } else {
                          mainVariables.stockMovementVariables.sendData.inventories.clear();
                          int totalList = 0;
                          for (int i = 0; i < mainVariables.stockMovementVariables.selectedProductsIdList.length; i++) {
                            Map<String, dynamic> selectedMap = {
                              "inventory": mainVariables.stockMovementVariables.selectedProductsIdList[i],
                              "quantity": mainVariables.stockMovementVariables.selectedQuantityList[i],
                            };
                            mainVariables.stockMovementVariables.selectedProductsList.add(AddProductsList.fromJson(selectedMap));
                            totalList = totalList + mainVariables.stockMovementVariables.selectedProductsList[i].quantity;
                          }
                          if (totalList == 0) {
                            mainWidgets.flushBarWidget(context: context, message: "Please add the no of products to transit");
                          } else {
                            mainVariables.stockMovementVariables.sendData.inventories = mainVariables.stockMovementVariables.selectedProductsList;
                            mainVariables.generalVariables.railNavigateBackIndex = mainVariables.generalVariables.railNavigateIndex;
                            mainVariables.generalVariables.railNavigateIndex = 12;
                            context.read<RailNavigationBloc>().add(const RailNavigationSelectedWidgetEvent());
                          }
                        }
                      }
                    } else {
                      if (mainVariables.stockMovementVariables.senderInfo.senderFromSectorChoose.name != "" && mainVariables.stockMovementVariables.senderInfo.senderToSectorChoose.name != "") {
                        if (mainVariables.stockMovementVariables.senderInfo.senderFromSectorChoose.value == mainVariables.stockMovementVariables.senderInfo.senderToSectorChoose.value) {
                          mainWidgets.flushBarWidget(context: context, message: "You selected both sector from & to are same, please choose different sectors");
                        } else {
                          mainVariables.stockMovementVariables.sendData.inventories.clear();
                          int totalList = 0;
                          for (int i = 0; i < mainVariables.stockMovementVariables.selectedProductsIdList.length; i++) {
                            Map<String, dynamic> selectedMap = {
                              "inventory": mainVariables.stockMovementVariables.selectedProductsIdList[i],
                              "quantity": mainVariables.stockMovementVariables.selectedQuantityList[i],
                            };
                            mainVariables.stockMovementVariables.selectedProductsList.add(AddProductsList.fromJson(selectedMap));
                            totalList = totalList + mainVariables.stockMovementVariables.selectedProductsList[i].quantity;
                          }
                          if (totalList == 0) {
                            mainWidgets.flushBarWidget(context: context, message: "Please add the no of products to transit");
                          } else {
                            mainVariables.stockMovementVariables.sendData.inventories = mainVariables.stockMovementVariables.selectedProductsList;
                            mainVariables.generalVariables.railNavigateBackIndex = mainVariables.generalVariables.railNavigateIndex;
                            mainVariables.generalVariables.railNavigateIndex = 12;
                            context.read<RailNavigationBloc>().add(const RailNavigationSelectedWidgetEvent());
                          }
                        }
                      }
                      else {
                        mainVariables.stockMovementVariables.sendData.inventories.clear();
                        int totalList = 0;
                        for (int i = 0; i < mainVariables.stockMovementVariables.selectedProductsIdList.length; i++) {
                          Map<String, dynamic> selectedMap = {
                            "inventory": mainVariables.stockMovementVariables.selectedProductsIdList[i],
                            "quantity": mainVariables.stockMovementVariables.selectedQuantityList[i],
                          };
                          mainVariables.stockMovementVariables.selectedProductsList.add(AddProductsList.fromJson(selectedMap));
                          totalList = totalList + mainVariables.stockMovementVariables.selectedProductsList[i].quantity;
                        }
                        if (totalList == 0) {
                          mainWidgets.flushBarWidget(context: context, message: "Please add the no of products to transit");
                        } else {
                          mainVariables.stockMovementVariables.sendData.inventories = mainVariables.stockMovementVariables.selectedProductsList;
                          mainVariables.generalVariables.railNavigateBackIndex = mainVariables.generalVariables.railNavigateIndex;
                          mainVariables.generalVariables.railNavigateIndex = 12;
                          context.read<RailNavigationBloc>().add(const RailNavigationSelectedWidgetEvent());
                        }
                      }
                    }
                  }
                }
                else {
                  if (mainVariables.stockMovementVariables.receiverInfo.receiverLocationChoose.value == mainVariables.stockMovementVariables.senderInfo.senderLocationChoose.value) {
                    if (mainVariables.stockMovementVariables.receiverInfo.receiverStockTypeChoose.value == mainVariables.stockMovementVariables.senderInfo.senderStockTypeChoose.value) {
                      mainWidgets.flushBarWidget(context: context, message: "You are trying to create a stock movement between the same location. Please change receiver location");
                    } else {
                      if (mainVariables.stockMovementVariables.senderInfo.senderFromSectorChoose.name != "" && mainVariables.stockMovementVariables.senderInfo.senderToSectorChoose.name != "") {
                        if (mainVariables.stockMovementVariables.senderInfo.senderFromSectorChoose.value == mainVariables.stockMovementVariables.senderInfo.senderToSectorChoose.value) {
                          mainWidgets.flushBarWidget(context: context, message: "You selected both sector from & to are same, please choose different sectors");
                        } else {
                          if (mainVariables.stockMovementVariables.receiverInfo.handlerChoose.value == "") {
                            mainWidgets.flushBarWidget(context: context, message: "Please select the Handler Name");
                          } else {
                            mainVariables.stockMovementVariables.sendData.inventories.clear();
                            int totalList = 0;
                            for (int i = 0; i < mainVariables.stockMovementVariables.selectedProductsIdList.length; i++) {
                              Map<String, dynamic> selectedMap = {
                                "inventory": mainVariables.stockMovementVariables.selectedProductsIdList[i],
                                "quantity": mainVariables.stockMovementVariables.selectedQuantityList[i],
                              };
                              mainVariables.stockMovementVariables.selectedProductsList.add(AddProductsList.fromJson(selectedMap));
                              totalList = totalList + mainVariables.stockMovementVariables.selectedProductsList[i].quantity;
                            }
                            if (totalList == 0) {
                              mainWidgets.flushBarWidget(context: context, message: "Please add the no of products to transit");
                            } else {
                              mainVariables.stockMovementVariables.sendData.inventories = mainVariables.stockMovementVariables.selectedProductsList;
                              mainVariables.generalVariables.railNavigateBackIndex = mainVariables.generalVariables.railNavigateIndex;
                              mainVariables.generalVariables.railNavigateIndex = 12;
                              context.read<RailNavigationBloc>().add(const RailNavigationSelectedWidgetEvent());
                            }
                          }
                        }
                      } else {
                        if (mainVariables.stockMovementVariables.receiverInfo.handlerChoose.value == "") {
                          mainWidgets.flushBarWidget(context: context, message: "Please select the Handler Name");
                        } else {
                          mainVariables.stockMovementVariables.sendData.inventories.clear();
                          int totalList = 0;
                          for (int i = 0; i < mainVariables.stockMovementVariables.selectedProductsIdList.length; i++) {
                            Map<String, dynamic> selectedMap = {
                              "inventory": mainVariables.stockMovementVariables.selectedProductsIdList[i],
                              "quantity": mainVariables.stockMovementVariables.selectedQuantityList[i],
                            };
                            mainVariables.stockMovementVariables.selectedProductsList.add(AddProductsList.fromJson(selectedMap));
                            totalList = totalList + mainVariables.stockMovementVariables.selectedProductsList[i].quantity;
                          }
                          if (totalList == 0) {
                            mainWidgets.flushBarWidget(context: context, message: "Please add the no of products to transit");
                          } else {
                            mainVariables.stockMovementVariables.sendData.inventories = mainVariables.stockMovementVariables.selectedProductsList;
                            mainVariables.generalVariables.railNavigateBackIndex = mainVariables.generalVariables.railNavigateIndex;
                            mainVariables.generalVariables.railNavigateIndex = 12;
                            context.read<RailNavigationBloc>().add(const RailNavigationSelectedWidgetEvent());
                          }
                        }
                      }
                    }
                  } else {
                    if (mainVariables.stockMovementVariables.senderInfo.senderFromSectorChoose.name != "" && mainVariables.stockMovementVariables.senderInfo.senderToSectorChoose.name != "") {
                      if (mainVariables.stockMovementVariables.senderInfo.senderFromSectorChoose.value == mainVariables.stockMovementVariables.senderInfo.senderToSectorChoose.value) {
                        mainWidgets.flushBarWidget(context: context, message: "You selected both sector from & to are same, please choose different sectors");
                      } else {
                        if (mainVariables.stockMovementVariables.receiverInfo.handlerChoose.value == "") {
                          mainWidgets.flushBarWidget(context: context, message: "Please select the Handler Name");
                        } else {
                          mainVariables.stockMovementVariables.sendData.inventories.clear();
                          int totalList = 0;
                          for (int i = 0; i < mainVariables.stockMovementVariables.selectedProductsIdList.length; i++) {
                            Map<String, dynamic> selectedMap = {
                              "inventory": mainVariables.stockMovementVariables.selectedProductsIdList[i],
                              "quantity": mainVariables.stockMovementVariables.selectedQuantityList[i],
                            };
                            mainVariables.stockMovementVariables.selectedProductsList.add(AddProductsList.fromJson(selectedMap));
                            totalList = totalList + mainVariables.stockMovementVariables.selectedProductsList[i].quantity;
                          }
                          if (totalList == 0) {
                            mainWidgets.flushBarWidget(context: context, message: "Please add the no of products to transit");
                          } else {
                            mainVariables.stockMovementVariables.sendData.inventories = mainVariables.stockMovementVariables.selectedProductsList;
                            mainVariables.generalVariables.railNavigateBackIndex = mainVariables.generalVariables.railNavigateIndex;
                            mainVariables.generalVariables.railNavigateIndex = 12;
                            context.read<RailNavigationBloc>().add(const RailNavigationSelectedWidgetEvent());
                          }
                        }
                      }
                    } else {
                      if (mainVariables.stockMovementVariables.receiverInfo.handlerChoose.value == "") {
                        mainWidgets.flushBarWidget(context: context, message: "Please select the Handler Name");
                      } else {
                        mainVariables.stockMovementVariables.sendData.inventories.clear();
                        int totalList = 0;
                        for (int i = 0; i < mainVariables.stockMovementVariables.selectedProductsIdList.length; i++) {
                          Map<String, dynamic> selectedMap = {
                            "inventory": mainVariables.stockMovementVariables.selectedProductsIdList[i],
                            "quantity": mainVariables.stockMovementVariables.selectedQuantityList[i],
                          };
                          mainVariables.stockMovementVariables.selectedProductsList.add(AddProductsList.fromJson(selectedMap));
                          totalList = totalList + mainVariables.stockMovementVariables.selectedProductsList[i].quantity;
                        }
                        if (totalList == 0) {
                          mainWidgets.flushBarWidget(context: context, message: "Please add the no of products to transit");
                        } else {
                          mainVariables.stockMovementVariables.sendData.inventories = mainVariables.stockMovementVariables.selectedProductsList;
                          mainVariables.generalVariables.railNavigateBackIndex = mainVariables.generalVariables.railNavigateIndex;
                          mainVariables.generalVariables.railNavigateIndex = 12;
                          context.read<RailNavigationBloc>().add(const RailNavigationSelectedWidgetEvent());
                        }
                      }
                    }
                  }
                }
              }
            },
            text: 'Continue',
            fontSize: 16,
            width: mainFunctions.getWidgetWidth(width: 132),
          ),
          MediaQuery.of(context).orientation == Orientation.portrait
              ? const SizedBox()
              : Obx(
                  () => mainVariables.stockMovementVariables.onTappedRegion.value
                      ? SizedBox(
                          height: mainFunctions.getWidgetHeight(height: 100),
                        )
                      : const SizedBox(),
                ),
        ],
      ),
    );
  }
}
