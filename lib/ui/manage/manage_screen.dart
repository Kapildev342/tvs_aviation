import 'dart:async';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:table_sticky_headers/table_sticky_headers.dart';
import 'package:tvsaviation/bloc/manage/manage_bloc.dart';
import 'package:tvsaviation/bloc/rail_navigation/rail_navigation_bloc.dart';
import 'package:tvsaviation/resources/constants.dart';
import 'package:tvsaviation/resources/easy_auto_complete_lib/easy_autocomplete.dart';
import 'package:tvsaviation/resources/widgets.dart';

class ManageScreen extends StatefulWidget {
  static const String id = "manage";
  const ManageScreen({super.key});

  @override
  State<ManageScreen> createState() => _ManageScreenState();
}

class _ManageScreenState extends State<ManageScreen> {
  GlobalKey<EasyAutocompleteState> key1 = GlobalKey<EasyAutocompleteState>();
  GlobalKey<EasyAutocompleteState> key2 = GlobalKey<EasyAutocompleteState>();
  GlobalKey<EasyAutocompleteState> key3 = GlobalKey<EasyAutocompleteState>();
  GlobalKey<EasyAutocompleteState> key4 = GlobalKey<EasyAutocompleteState>();
  GlobalKey<EasyAutocompleteState> key5 = GlobalKey<EasyAutocompleteState>();
  GlobalKey<EasyAutocompleteState> key6 = GlobalKey<EasyAutocompleteState>();
  GlobalKey<EasyAutocompleteState> key7 = GlobalKey<EasyAutocompleteState>();

  @override
  void dispose() {
    mainVariables.manageVariables.csvUploadFileLoader = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvoked: (value) {
          if (mainVariables.manageVariables.addProduct.isCreate) {
            if (mainVariables.manageVariables.manageSelectedWithinScreen == "within") {
              context.read<ManageBloc>().add(ManagePageChangingEvent(index: mainVariables.manageVariables.manageSelectedBackIndex));
              mainVariables.generalVariables.railNavigateBackIndex = mainVariables.generalVariables.railNavigateIndex;
              mainVariables.generalVariables.railNavigateIndex = 6;
              mainVariables.railNavigationVariables.mainSelectedIndex = 6;
              context.read<RailNavigationBloc>().add(const RailNavigationSelectedWidgetEvent());
            } else if (mainVariables.manageVariables.manageSelectedWithinScreen == "inventory") {
              mainVariables.generalVariables.railNavigateBackIndex = mainVariables.generalVariables.railNavigateIndex;
              mainVariables.generalVariables.railNavigateIndex = 1;
              mainVariables.railNavigationVariables.mainSelectedIndex = 1;
              context.read<RailNavigationBloc>().add(const RailNavigationSelectedWidgetEvent());
            } else {
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
          } else {
            setState(() {
              mainVariables.manageVariables.addProduct.isEdit = false;
              mainVariables.manageVariables.addProduct.isCreate = true;
            });
          }
        },
        child: bodyWidget());
  }

  Widget bodyWidget() {
    return BlocConsumer<ManageBloc, ManageState>(
      listener: (BuildContext context, ManageState manage) {
        if (manage is ManageSuccess) {
          Navigator.pop(context);
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
          mainVariables.manageVariables.selectedFile = null;
          mainVariables.manageVariables.selectedFileName = "";
          setState(() {
            mainVariables.manageVariables.loader = false;
          });
          context.read<RailNavigationBloc>().add(const RailNavigationSelectedWidgetEvent());
          mainWidgets.flushBarWidget(context: context, message: manage.message);
        } else if (manage is ManageSuccess2) {
          setState(() {
            mainVariables.manageVariables.loader = false;
          });
          mainWidgets.flushBarWidget(context: context, message: manage.message);
        } else if (manage is ManageFailure) {
          setState(() {
            mainVariables.manageVariables.loader = false;
          });
          mainWidgets.flushBarWidget(context: context, message: manage.errorMessage);
        }
      },
      builder: (BuildContext context, ManageState manage) {
        if (manage is ManageLoaded) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: mainFunctions.getWidgetHeight(height: 20), horizontal: mainFunctions.getWidgetWidth(width: 20)),
            padding: EdgeInsets.symmetric(vertical: mainFunctions.getWidgetHeight(height: 20), horizontal: mainFunctions.getWidgetWidth(width: 20)),
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
            child: ListView(
              children: [
                SizedBox(
                  height: mainFunctions.getWidgetHeight(height: 16),
                ),
                Padding(
                  padding: EdgeInsets.only(right: mainFunctions.getWidgetWidth(width: 20)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (mainVariables.manageVariables.addProduct.isCreate) {
                                if (mainVariables.manageVariables.manageSelectedWithinScreen == 'within') {
                                  context.read<ManageBloc>().add(ManagePageChangingEvent(index: mainVariables.manageVariables.manageSelectedBackIndex));
                                  mainVariables.generalVariables.railNavigateBackIndex = mainVariables.generalVariables.railNavigateIndex;
                                  mainVariables.generalVariables.railNavigateIndex = 6;
                                  mainVariables.railNavigationVariables.mainSelectedIndex = 6;
                                  context.read<RailNavigationBloc>().add(const RailNavigationSelectedWidgetEvent());
                                } else if (mainVariables.manageVariables.manageSelectedWithinScreen == "inventory") {
                                  context.read<ManageBloc>().add(const ManagePageChangingEvent(index: 0));
                                  mainVariables.generalVariables.railNavigateBackIndex = mainVariables.generalVariables.railNavigateIndex;
                                  mainVariables.generalVariables.railNavigateIndex = 1;
                                  mainVariables.railNavigationVariables.mainSelectedIndex = 1;
                                  context.read<RailNavigationBloc>().add(const RailNavigationSelectedWidgetEvent());
                                } else {
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
                              } else {
                                setState(() {
                                  mainVariables.manageVariables.addProduct.isEdit = false;
                                  mainVariables.manageVariables.addProduct.isCreate = true;
                                });
                              }
                            },
                            child: const Icon(
                              Icons.arrow_back_ios,
                            ),
                          ),
                          headerTextWidget(),
                        ],
                      ),
                      mainVariables.manageVariables.manageSelectedIndex == 0
                          ? InkWell(
                              onTap: () {
                                mainWidgets.showAnimatedDialog(
                                  context: context,
                                  height: 371,
                                  width: 410,
                                  child: dialogContent(),
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ShaderMask(
                                    blendMode: BlendMode.srcIn,
                                    shaderCallback: (Rect bounds) {
                                      return const LinearGradient(
                                        colors: [
                                          Color(0xff0C3788),
                                          Color(0xffBC0044),
                                        ],
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                      ).createShader(bounds);
                                    },
                                    child: Container(
                                      height: mainFunctions.getWidgetHeight(height: 24),
                                      width: mainFunctions.getWidgetWidth(width: 24),
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage("assets/reports/download.png"),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: mainFunctions.getWidgetWidth(width: 5)),
                                  ShaderMask(
                                    blendMode: BlendMode.srcIn,
                                    shaderCallback: (Rect bounds) {
                                      return const LinearGradient(
                                        colors: [
                                          Color(0xff0C3788),
                                          Color(0xffBC0044),
                                        ],
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                      ).createShader(bounds);
                                    },
                                    child: Text(
                                      'Import',
                                      style: TextStyle(
                                        fontSize: mainFunctions.getTextSize(fontSize: 11.0),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox(),
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
                  height: mainFunctions.getWidgetHeight(height: 16),
                ),
                bodyContentWidget(),
              ],
            ),
          );
        } else if (manage is ManageLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Widget headerTextWidget() {
    switch (mainVariables.manageVariables.manageSelectedIndex) {
      case 0:
        return Text(
          "Add Inventory",
          style: mainTextStyle.normalTextStyle.copyWith(color: mainColors.headingBlueColor, fontWeight: FontWeight.w600),
        );
      case 1:
        return Text(
          "Manage Product",
          style: mainTextStyle.normalTextStyle.copyWith(color: mainColors.headingBlueColor, fontWeight: FontWeight.w600),
        );
      case 2:
        return Text(
          "Manage Brand/Type",
          style: mainTextStyle.normalTextStyle.copyWith(color: mainColors.headingBlueColor, fontWeight: FontWeight.w600),
        );
      case 3:
        return Text(
          "Manage Category",
          style: mainTextStyle.normalTextStyle.copyWith(color: mainColors.headingBlueColor, fontWeight: FontWeight.w600),
        );
      case 4:
        return Text(
          "Manage Crew",
          style: mainTextStyle.normalTextStyle.copyWith(color: mainColors.headingBlueColor, fontWeight: FontWeight.w600),
        );
      case 5:
        return Text(
          "Manage Handler",
          style: mainTextStyle.normalTextStyle.copyWith(color: mainColors.headingBlueColor, fontWeight: FontWeight.w600),
        );
      case 6:
        return Text(
          "Manage Warehouse",
          style: mainTextStyle.normalTextStyle.copyWith(color: mainColors.headingBlueColor, fontWeight: FontWeight.w600),
        );
      case 7:
        return Text(
          "Manage Aircraft",
          style: mainTextStyle.normalTextStyle.copyWith(color: mainColors.headingBlueColor, fontWeight: FontWeight.w600),
        );
      case 8:
        return Text(
          "Manage Sector",
          style: mainTextStyle.normalTextStyle.copyWith(color: mainColors.headingBlueColor, fontWeight: FontWeight.w600),
        );
      default:
        return Container();
    }
  }

  Widget bodyContentWidget() {
    switch (mainVariables.manageVariables.manageSelectedIndex) {
      case 0:
        return inventoryAddWidget();
      case 1:
        return mainVariables.manageVariables.addProduct.isCreate ? productAddWidget() : editProductContent();
      case 2:
        return brandAddWidget();
      case 3:
        return categoryAddWidget();
      case 4:
        return crewAddWidget();
      case 5:
        return handlerAddWidget();
      case 6:
        return wareHouseAddWidget();
      case 7:
        return airCraftAddWidget();
      case 8:
        return sectorAddWidget();
      default:
        return Container();
    }
  }

  Widget inventoryAddWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 80),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: EasyAutocomplete(
                  key: key1,
                  inputTextStyle: TextStyle(
                    fontSize: mainFunctions.getTextSize(fontSize: 12),
                  ),
                  labelText: "Location",
                  hintText: "select or add location",
                  focusNode: mainVariables.manageVariables.addInventory.locationControllerFocusNode,
                  textFieldHeight: mainFunctions.getWidgetHeight(height: 44),
                  textFieldWidth: mainFunctions.getWidgetWidth(width: MediaQuery.of(context).orientation == Orientation.portrait ? mainFunctions.getWidgetWidth(width: 280) : mainFunctions.getWidgetWidth(width: 400)),
                  suggestions: mainVariables.stockMovementVariables.senderInfo.locationDropDownList,
                  onChanged: (value) {
                    mainVariables.manageVariables.addInventory.locationId = value;
                    mainVariables.manageVariables.addInventory.purchaseMonthController.text = "";
                    if (mainVariables.manageVariables.addInventory.productId != "") {
                      context.read<ManageBloc>().add(const ProductMiniLevelExpiryEvent());
                    } else {
                      mainVariables.manageVariables.addInventory.optimumController.text = "0";
                      mainVariables.manageVariables.addInventory.isChecked = false;
                    }
                    setState(() {});
                  },
                  onSubmitted: (value) {
                    mainVariables.manageVariables.addInventory.locationId = value;
                    mainVariables.manageVariables.addInventory.purchaseMonthController.text = "";
                    if (mainVariables.manageVariables.addInventory.productId != "") {
                      context.read<ManageBloc>().add(const ProductMiniLevelExpiryEvent());
                    } else {
                      mainVariables.manageVariables.addInventory.optimumController.text = "0";
                      mainVariables.manageVariables.addInventory.isChecked = false;
                    }
                    setState(() {});
                  },
                  suggestionBackgroundColor: Colors.white,
                  buttonString: "Manage Location",
                  selectedIndex: 6,
                ),
              ),
              SizedBox(width: mainFunctions.getWidgetWidth(width: 15)),
              Expanded(
                child: EasyAutocomplete(
                  key: key2,
                  inputTextStyle: TextStyle(
                    fontSize: mainFunctions.getTextSize(fontSize: 12),
                  ),
                  labelText: "Product & Brand/ Type",
                  hintText: "select or Add Product/brand",
                  focusNode: mainVariables.manageVariables.addInventory.productBrandControllerFocusNode,
                  textFieldHeight: mainFunctions.getWidgetHeight(height: 44),
                  textFieldWidth: mainFunctions.getWidgetWidth(width: MediaQuery.of(context).orientation == Orientation.portrait ? mainFunctions.getWidgetWidth(width: 280) : mainFunctions.getWidgetWidth(width: 400)),
                  suggestions: mainVariables.manageVariables.productBrandTypeSuggestionList,
                  onChanged: (value) {
                    if (value.length == 24) {
                      mainVariables.manageVariables.addInventory.productId = value;
                      mainVariables.manageVariables.addInventory.purchaseMonthController.text = "";
                      if (mainVariables.manageVariables.addInventory.locationId != "") {
                        context.read<ManageBloc>().add(const ProductMiniLevelExpiryEvent());
                      } else {
                        mainVariables.manageVariables.addInventory.optimumController.text = "0";
                        mainVariables.manageVariables.addInventory.isChecked = false;
                      }
                      context.read<ManageBloc>().add(const GetProductDetailsEvent());
                    }
                  },
                  onSubmitted: (value) {
                    mainVariables.manageVariables.addInventory.productId = value;
                    mainVariables.manageVariables.addInventory.purchaseMonthController.text = "";
                    mainVariables.manageVariables.addInventory.categoryController.text = "";
                    mainVariables.manageVariables.addInventory.categoryId = "";
                    if (mainVariables.manageVariables.addInventory.locationId != "") {
                      context.read<ManageBloc>().add(const ProductMiniLevelExpiryEvent());
                    } else {
                      mainVariables.manageVariables.addInventory.optimumController.text = "0";
                      mainVariables.manageVariables.addInventory.isChecked = false;
                    }
                  },
                  suggestionBackgroundColor: Colors.white,
                  buttonString: "Manage Product",
                  selectedIndex: 1,
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 22),
        ),
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 80),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: EasyAutocomplete(
                  key: key3,
                  inputTextStyle: TextStyle(
                    fontSize: mainFunctions.getTextSize(fontSize: 12),
                  ),
                  labelText: "Stock Type",
                  hintText: "select or Add Stock type",
                  focusNode: mainVariables.manageVariables.addInventory.stockTypeControllerFocusNode,
                  textFieldHeight: mainFunctions.getWidgetHeight(height: 44),
                  textFieldWidth: mainFunctions.getWidgetWidth(width: MediaQuery.of(context).orientation == Orientation.portrait ? mainFunctions.getWidgetWidth(width: 280) : mainFunctions.getWidgetWidth(width: 400)),
                  suggestions: mainVariables.manageVariables.addInventory.stockTypeDropDownList,
                  onChanged: (value) {
                    if (mainVariables.manageVariables.addInventory.productId != "" && mainVariables.manageVariables.addInventory.locationId != "") {
                      context.read<ManageBloc>().add(const ProductMiniLevelExpiryEvent());
                    }
                    mainVariables.manageVariables.addInventory.stockTypeId = value;
                    setState(() {});
                  },
                  onSubmitted: (value) {
                    if (mainVariables.manageVariables.addInventory.productId != "" && mainVariables.manageVariables.addInventory.locationId != "") {
                      context.read<ManageBloc>().add(const ProductMiniLevelExpiryEvent());
                    }
                    mainVariables.manageVariables.addInventory.stockTypeId = value;
                    setState(() {});
                  },
                  suggestionBackgroundColor: Colors.white,
                ),
              ),
              SizedBox(width: mainFunctions.getWidgetWidth(width: 15)),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Category",
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: mainFunctions.getTextSize(fontSize: 15), color: const Color(0xff111111)),
                    ),
                    SizedBox(
                      height: mainFunctions.getWidgetHeight(height: 10),
                    ),
                    SizedBox(
                      height: mainFunctions.getWidgetHeight(height: 44),
                      width: mainFunctions.getWidgetWidth(width: MediaQuery.of(context).orientation == Orientation.portrait ? mainFunctions.getWidgetWidth(width: 280) : mainFunctions.getWidgetWidth(width: 400)),
                      child: TextFormField(
                        controller: mainVariables.manageVariables.addInventory.categoryController,
                        keyboardType: TextInputType.text,
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: "Add Category",
                          hintStyle: TextStyle(
                            fontSize: mainFunctions.getTextSize(fontSize: 13),
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff838195),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                          ),
                        ),
                        style: TextStyle(
                          fontSize: mainFunctions.getTextSize(fontSize: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 22),
        ),
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 80),
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
                      mainVariables.manageVariables.addInventory.isChecked ? "Expiry date" : "Month of Purchase",
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: mainFunctions.getTextSize(fontSize: 15), color: const Color(0xff111111)),
                    ),
                    SizedBox(
                      height: mainFunctions.getWidgetHeight(height: 10),
                    ),
                    SizedBox(
                      height: mainFunctions.getWidgetHeight(height: 44),
                      width: mainFunctions.getWidgetWidth(width: MediaQuery.of(context).orientation == Orientation.portrait ? mainFunctions.getWidgetWidth(width: 280) : mainFunctions.getWidgetWidth(width: 400)),
                      child: TextFormField(
                        controller: mainVariables.manageVariables.addInventory.purchaseMonthController,
                        readOnly: true,
                        onTap: () {
                          context.read<ManageBloc>().add(const ManageCalenderEnablingEvent());
                        },
                        decoration: InputDecoration(
                          hintText: "DD-MM-YYYY",
                          hintStyle: TextStyle(
                            fontSize: mainFunctions.getTextSize(fontSize: 13),
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff838195),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                          ),
                        ),
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: mainFunctions.getTextSize(fontSize: 15)),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: mainFunctions.getWidgetWidth(width: 15)),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Quantity",
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: mainFunctions.getTextSize(fontSize: 15), color: const Color(0xff111111)),
                    ),
                    SizedBox(
                      height: mainFunctions.getWidgetHeight(height: 10),
                    ),
                    SizedBox(
                      height: mainFunctions.getWidgetHeight(height: 44),
                      width: mainFunctions.getWidgetWidth(width: MediaQuery.of(context).orientation == Orientation.portrait ? mainFunctions.getWidgetWidth(width: 280) : mainFunctions.getWidgetWidth(width: 400)),
                      child: TextFormField(
                        controller: mainVariables.manageVariables.addInventory.quantityController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "Add Quantity",
                          hintStyle: TextStyle(
                            fontSize: mainFunctions.getTextSize(fontSize: 13),
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff838195),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
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
        AnimatedCrossFade(
          firstChild: Container(
            width: mainFunctions.getWidgetWidth(width: 300),
            margin: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  blurRadius: 4,
                  spreadRadius: 0,
                  color: Colors.black.withOpacity(0.3),
                ),
              ],
            ),
            clipBehavior: Clip.hardEdge,
            child: SfDateRangePicker(
              selectionMode: DateRangePickerSelectionMode.single,
              controller: mainVariables.manageVariables.addInventory.dateController,
              initialSelectedDate: DateTime.now(),
              backgroundColor: Colors.white,
              toggleDaySelection: true,
              showNavigationArrow: true,
              headerHeight: 50,
              showActionButtons: true,
              headerStyle: DateRangePickerHeaderStyle(textAlign: TextAlign.center, backgroundColor: mainColors.headingBlueColor, textStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14)),
              onCancel: () {
                context.read<ManageBloc>().add(const ManageCalenderEnablingEvent());
              },
              onSubmit: (value) {
                context.read<ManageBloc>().add(const ManageCalenderEnablingEvent());
              },
              onSelectionChanged: (value) {
                DateTime selectedDate = value.value;
                setState(() {
                  mainVariables.manageVariables.addInventory.purchaseMonthController.text = selectedDate.toString().substring(0, 10);
                });
              },
              showTodayButton: false,
              monthFormat: "MMMM",
              monthViewSettings: const DateRangePickerMonthViewSettings(
                firstDayOfWeek: 1,
                dayFormat: "EE",
                viewHeaderHeight: 50,
              ),
              view: DateRangePickerView.month,
              // maxDate: mainVariables.manageVariables.addInventory.isChecked ? DateTime(1900) : DateTime.now(),
              // minDate: mainVariables.manageVariables.addInventory.isChecked ? DateTime.now() : DateTime(2100),
              minDate: mainVariables.manageVariables.addInventory.isChecked ? DateTime.now() : DateTime(1800),
              maxDate: mainVariables.manageVariables.addInventory.isChecked ? DateTime(2200) : DateTime.now(),

            ),
          ),
          secondChild: const SizedBox(),
          crossFadeState: mainVariables.manageVariables.addInventory.filterCalenderEnabled ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          duration: const Duration(milliseconds: 500),
        ),
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 22),
        ),
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 80),
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
                      "Optimum level",
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: mainFunctions.getTextSize(fontSize: 15), color: const Color(0xff111111)),
                    ),
                    SizedBox(
                      height: mainFunctions.getWidgetHeight(height: 10),
                    ),
                    SizedBox(
                      height: mainFunctions.getWidgetHeight(height: 44),
                      width: mainFunctions.getWidgetWidth(width: MediaQuery.of(context).orientation == Orientation.portrait ? mainFunctions.getWidgetWidth(width: 280) : mainFunctions.getWidgetWidth(width: 400)),
                      child: TextFormField(
                        controller: mainVariables.manageVariables.addInventory.optimumController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "Add Minimum Level",
                          hintStyle: TextStyle(
                            fontSize: mainFunctions.getTextSize(fontSize: 13),
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff838195),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                          ),
                        ),
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: mainFunctions.getTextSize(fontSize: 15)),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: mainFunctions.getWidgetWidth(width: 15)),
              const Expanded(child: SizedBox()),
            ],
          ),
        ),
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 30),
        ),
        Center(
          child: mainVariables.manageVariables.addInventory.isScanning
              ? SizedBox(
                  width: mainFunctions.getWidgetWidth(width: 280),
                  height: mainFunctions.getWidgetHeight(height: 50),
                  child: TextFormField(
                    controller: mainVariables.manageVariables.addInventory.barCodeController,
                    style: TextStyle(
                      fontSize: mainFunctions.getTextSize(fontSize: 16),
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: mainFunctions.getWidgetWidth(width: 20)),
                      fillColor: const Color(0xFFFFFFFF),
                      filled: true,
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            mainVariables.manageVariables.addInventory.isScanning = false;
                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: mainFunctions.getWidgetWidth(width: 12),
                            vertical: mainFunctions.getWidgetHeight(height: 12),
                          ),
                          child: Image.asset(
                            "assets/home/barcode.png",
                            height: mainFunctions.getWidgetHeight(height: 22),
                            width: mainFunctions.getWidgetWidth(width: 22),
                          ),
                        ),
                      ),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0XFFEDEDED), width: 2)),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0XFFEDEDED), width: 2)),
                      disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0XFFEDEDED), width: 2)),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0XFFEDEDED), width: 2)),
                      focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0XFFEDEDED), width: 2)),
                      errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0XFFEDEDED), width: 2)),
                      hintText: "Enter Barcode",
                      hintStyle: TextStyle(color: const Color(0XFF686868), fontSize: mainFunctions.getTextSize(fontSize: 14), fontWeight: FontWeight.w400),
                    ),
                    onChanged: (value) {},
                  ),
                )
              : InkWell(
                  onTap: () async {
                    String response = await mainFunctions.barCodeScan(context: context);
                    mainVariables.manageVariables.addInventory.barCodeController.text = response;
                    mainVariables.manageVariables.addInventory.isScanning = true;
                    setState(() {});
                  },
                  child: DottedBorder(
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(8),
                    dashPattern: const [5, 5],
                    color: const Color(0xffD6D6D6),
                    strokeWidth: 1,
                    child: Container(
                      height: mainFunctions.getWidgetHeight(height: 137),
                      width: mainFunctions.getWidgetWidth(width: 377),
                      padding: EdgeInsets.symmetric(vertical: mainFunctions.getWidgetHeight(height: 15)),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/home/bar_code.png",
                            height: mainFunctions.getWidgetHeight(height: 35),
                            width: mainFunctions.getWidgetWidth(width: 35),
                          ),
                          Text(
                            "Scan barcode",
                            style: TextStyle(
                              color: const Color(0xff6C7184),
                              fontWeight: FontWeight.w400,
                              fontSize: mainFunctions.getTextSize(fontSize: 13),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                mainVariables.manageVariables.addInventory.isScanning = true;
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  "assets/home/info.png",
                                  height: mainFunctions.getWidgetHeight(height: 12),
                                  width: mainFunctions.getWidgetWidth(width: 12),
                                ),
                                SizedBox(
                                  width: mainFunctions.getWidgetWidth(width: 5),
                                ),
                                Text(
                                  "Add custom data?",
                                  style: TextStyle(
                                    color: const Color(0xff0C3788),
                                    fontWeight: FontWeight.w500,
                                    fontSize: mainFunctions.getTextSize(fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        ),
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 40),
        ),
        LoadingButton(
          status: mainVariables.manageVariables.loader,
          onTap: () {
            setState(() {
              mainVariables.manageVariables.loader = true;
            });
            context.read<ManageBloc>().add(AddInventoryEvent(key1: key1, key2: key2, key3: key3));
          },
          text: "Add",
          height: mainFunctions.getWidgetHeight(height: 42),
          width: mainFunctions.getWidgetWidth(width: 132),
          fontSize: 16,
          extraWidget: Icon(
            Icons.add,
            color: mainColors.whiteColor,
            size: 20,
          ),
        )
      ],
    );
  }

  Widget productAddWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 80),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: EasyAutocomplete(
                  key: key4,
                  labelText: "Category",
                  hintText: "select or add category",
                  focusNode: mainVariables.manageVariables.addProduct.categoryControllerFocusNode,
                  textFieldHeight: mainFunctions.getWidgetHeight(height: 44),
                  textFieldWidth: mainFunctions.getWidgetWidth(width: MediaQuery.of(context).orientation == Orientation.portrait ? mainFunctions.getWidgetWidth(width: 280) : mainFunctions.getWidgetWidth(width: 400)),
                  suggestions: mainVariables.manageVariables.categorySuggestionList,
                  onChanged: (value) {
                    mainVariables.manageVariables.addProduct.categoryId = value;
                    setState(() {});
                  },
                  onSubmitted: (value) {
                    mainVariables.manageVariables.addProduct.categoryId = value;
                    setState(() {});
                  },
                  suggestionBackgroundColor: Colors.white,
                  buttonString: "Manage Category",
                  selectedIndex: 3,
                ),
              ),
              SizedBox(width: mainFunctions.getWidgetWidth(width: 15)),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Product",
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: mainFunctions.getTextSize(fontSize: 15), color: const Color(0xff111111)),
                    ),
                    SizedBox(
                      height: mainFunctions.getWidgetHeight(height: 10),
                    ),
                    SizedBox(
                      height: mainFunctions.getWidgetHeight(height: 44),
                      width: mainFunctions.getWidgetWidth(
                        width: MediaQuery.of(context).orientation == Orientation.portrait ? mainFunctions.getWidgetWidth(width: 280) : mainFunctions.getWidgetWidth(width: 400),
                      ),
                      child: TextFormField(
                        controller: mainVariables.manageVariables.addProduct.productController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: mainFunctions.getWidgetWidth(width: 15)),
                          hintText: "Add Product",
                          hintStyle: TextStyle(
                            fontSize: mainFunctions.getTextSize(fontSize: 13),
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff838195),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                          ),
                        ),
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: mainFunctions.getTextSize(fontSize: 15),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 22),
        ),
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 80),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: EasyAutocomplete(
                  key: key5,
                  labelText: "Brand/ Type",
                  hintText: "select or add brand/Type",
                  focusNode: mainVariables.manageVariables.addProduct.brandControllerFocusNode,
                  textFieldHeight: mainFunctions.getWidgetHeight(height: 44),
                  textFieldWidth: mainFunctions.getWidgetWidth(width: MediaQuery.of(context).orientation == Orientation.portrait ? mainFunctions.getWidgetWidth(width: 280) : mainFunctions.getWidgetWidth(width: 400)),
                  suggestions: mainVariables.manageVariables.brandTypeSuggestionList,
                  onChanged: (value) {
                    mainVariables.manageVariables.addProduct.brandId = value;
                    setState(() {});
                  },
                  onSubmitted: (value) {
                    mainVariables.manageVariables.addProduct.brandId = value;
                    setState(() {});
                  },
                  suggestionBackgroundColor: Colors.white,
                  buttonString: "Manage Brand Type",
                  selectedIndex: 2,
                ),
              ),
              SizedBox(width: mainFunctions.getWidgetWidth(width: 15)),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Days until expiry",
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: mainFunctions.getTextSize(fontSize: 15), color: const Color(0xff111111)),
                    ),
                    SizedBox(
                      height: mainFunctions.getWidgetHeight(height: 10),
                    ),
                    SizedBox(
                      height: mainFunctions.getWidgetHeight(height: 44),
                      width: mainFunctions.getWidgetWidth(
                        width: MediaQuery.of(context).orientation == Orientation.portrait ? mainFunctions.getWidgetWidth(width: 280) : mainFunctions.getWidgetWidth(width: 400),
                      ),
                      child: TextFormField(
                        controller: mainVariables.manageVariables.addProduct.daysUntilController,
                        keyboardType: TextInputType.number,
                        enabled: mainVariables.manageVariables.addProduct.isChecked,
                        inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.deny(RegExp('[.]')), UpperCaseTextFormatter()],
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: mainVariables.manageVariables.addProduct.isChecked ? Colors.white : const Color(0xffF7F7F7),
                          hintText: "Add days until expiry",
                          hintStyle: TextStyle(
                            fontSize: mainFunctions.getTextSize(fontSize: 13),
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff838195),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                          ),
                        ),
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: mainFunctions.getTextSize(fontSize: 15),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        CheckboxListTile(
          contentPadding: EdgeInsets.zero,
          controlAffinity: ListTileControlAffinity.leading,
          checkboxShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          value: mainVariables.manageVariables.addProduct.isChecked,
          onChanged: (value) {
            setState(() {
              mainVariables.manageVariables.addProduct.isChecked = !mainVariables.manageVariables.addProduct.isChecked;
            });
          },
          tristate: true,
          dense: true,
          title: Text(
            "Does this product has expiry?",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: mainFunctions.getTextSize(fontSize: 13),
              color: const Color(0xff007BFE),
            ),
          ),
        ),
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 50),
        ),
        LoadingButton(
          status: mainVariables.manageVariables.loader,
          onTap: () {
            setState(() {
              mainVariables.manageVariables.loader = true;
            });
            context.read<ManageBloc>().add(AddProductEvent(key4: key4, key5: key5));
            Future.delayed(const Duration(seconds: 1), () {
              setState(() {
                mainVariables.manageVariables.addProduct.selectedImage = null;
                FocusManager.instance.primaryFocus?.unfocus();
              });
            });
          },
          text: "Add",
          height: mainFunctions.getWidgetHeight(height: 42),
          width: mainFunctions.getWidgetWidth(width: 132),
          fontSize: 16,
          extraWidget: Icon(
            Icons.add,
            color: mainColors.whiteColor,
            size: 20,
          ),
        ),
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 28),
        ),
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 52),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Products List",
                style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 20), color: mainColors.headingBlueColor, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                width: mainFunctions.getWidgetWidth(width: 200),
                height: mainFunctions.getWidgetHeight(height: 36),
                child: TextFormField(
                  controller: mainVariables.manageVariables.addProduct.searchBar,
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
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: const Color(0XFF767680).withOpacity(0.12))),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: const Color(0XFF767680).withOpacity(0.12))),
                    disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: const Color(0XFF767680).withOpacity(0.12))),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: const Color(0XFF767680).withOpacity(0.12))),
                    focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: const Color(0XFF767680).withOpacity(0.12))),
                    errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: const Color(0XFF767680).withOpacity(0.12))),
                    hintText: "Search",
                    hintStyle: TextStyle(color: const Color(0XFF686868), fontSize: mainFunctions.getTextSize(fontSize: 16), fontWeight: FontWeight.w400),
                  ),
                  onChanged: (value) {
                    mainVariables.manageVariables.currentPage = 1;
                    context.read<ManageBloc>().add(const ManagePageFilterEvent());
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
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 28),
        ),
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 350),
          child: mainVariables.manageVariables.addProduct.tableData.isEmpty
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
                      const Text("Products List is Empty"),
                    ],
                  ),
                )
              : StickyHeadersTable(
                  columnsLength: mainVariables.manageVariables.addProduct.tableHeading.length,
                  rowsLength: mainVariables.manageVariables.addProduct.tableData.length,
                  showHorizontalScrollbar: false,
                  showVerticalScrollbar: false,
                  columnsTitleBuilder: (int columnIndex) {
                    return Center(
                      child: Text(
                        mainVariables.manageVariables.addProduct.tableHeading[columnIndex],
                        maxLines: 2,
                        style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 12), overflow: TextOverflow.ellipsis, fontWeight: FontWeight.w600),
                      ),
                    );
                  },
                  rowsTitleBuilder: (int rowIndex) {
                    return Center(
                      child: Text(
                        ((mainVariables.manageVariables.currentPage - 1) * 7) + (rowIndex + 1) < 10
                            ? "0${((mainVariables.manageVariables.currentPage - 1) * 7) + (rowIndex + 1)}"
                            : "${((mainVariables.manageVariables.currentPage - 1) * 7) + (rowIndex + 1)}",
                        maxLines: 2,
                        style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 12), overflow: TextOverflow.ellipsis, fontWeight: FontWeight.normal),
                      ),
                    );
                  },
                  contentCellBuilder: (int columnIndex, int rowIndex) {
                    return columnIndex == 0
                        ? Center(
                            child: mainVariables.manageVariables.addProduct.tableData[rowIndex][columnIndex] == ""
                                ? Image.asset(
                                    "assets/home/user.png",
                                    height: mainFunctions.getWidgetHeight(height: 22),
                                    width: mainFunctions.getWidgetWidth(width: 22),
                                  )
                                : Container(
                                    height: mainFunctions.getWidgetHeight(height: 22),
                                    width: mainFunctions.getWidgetWidth(width: 22),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.black,
                                      image: DecorationImage(
                                        image: NetworkImage(mainVariables.manageVariables.addProduct.tableData[rowIndex][columnIndex]),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                          )
                        : Center(
                            child: columnIndex == 4
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            mainVariables.manageVariables.addProduct.editSelectedIndex = rowIndex;
                                            mainVariables.manageVariables.addProduct.categoryEditId = mainVariables.manageVariables.addProduct.tableData[rowIndex][8];
                                            mainVariables.manageVariables.addProduct.brandEditId = mainVariables.manageVariables.addProduct.tableData[rowIndex][9];
                                            mainVariables.manageVariables.addProduct.productEditController.text = mainVariables.manageVariables.addProduct.tableData[rowIndex][6];
                                            mainVariables.manageVariables.addProduct.daysUntilEditController.text = mainVariables.manageVariables.addProduct.tableData[rowIndex][10];
                                            mainVariables.manageVariables.addProduct.isEdit = false;
                                            mainVariables.manageVariables.addProduct.isCreate = false;
                                          });
                                        },
                                        child: Container(
                                          height: mainFunctions.getWidgetHeight(height: 22),
                                          width: mainFunctions.getWidgetWidth(width: 22),
                                          decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/home/view.png"), fit: BoxFit.fill)),
                                        ),
                                      ),
                                      SizedBox(
                                        width: mainFunctions.getWidgetWidth(width: 8),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            mainVariables.manageVariables.addProduct.editSelectedIndex = rowIndex;
                                            mainVariables.manageVariables.addProduct.categoryEditId = mainVariables.manageVariables.addProduct.tableData[rowIndex][8];
                                            mainVariables.manageVariables.addProduct.brandEditId = mainVariables.manageVariables.addProduct.tableData[rowIndex][9];
                                            mainVariables.manageVariables.addProduct.productEditController.text = mainVariables.manageVariables.addProduct.tableData[rowIndex][6];
                                            mainVariables.manageVariables.addProduct.daysUntilEditController.text = mainVariables.manageVariables.addProduct.tableData[rowIndex][10];
                                            mainVariables.manageVariables.addProduct.isEdit = true;
                                            mainVariables.manageVariables.addProduct.isCreate = false;
                                          });
                                        },
                                        child: Container(
                                          height: mainFunctions.getWidgetHeight(height: 22),
                                          width: mainFunctions.getWidgetWidth(width: 22),
                                          decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/home/edit.png"), fit: BoxFit.fill)),
                                        ),
                                      ),
                                      SizedBox(
                                        width: mainFunctions.getWidgetWidth(width: 8),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          mainWidgets.showAnimatedDialog(
                                            context: context,
                                            height: 170,
                                            width: 274,
                                            child: deleteProductContent(data: mainVariables.manageVariables.addProduct.tableData[rowIndex], index: rowIndex),
                                          );
                                        },
                                        child: Container(
                                          height: mainFunctions.getWidgetHeight(height: 22),
                                          width: mainFunctions.getWidgetWidth(width: 22),
                                          decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/home/delete.png"), fit: BoxFit.fill)),
                                        ),
                                      ),
                                    ],
                                  )
                                : columnIndex == 3
                                    ? InkWell(
                                        onTap: () {
                                          if (mainVariables.manageVariables.addProduct.tableData[rowIndex][columnIndex] == "active") {
                                            context.read<ManageBloc>().add(ProductDeactivateEvent(index: rowIndex));
                                          } else {
                                            context.read<ManageBloc>().add(ProductActivateEvent(index: rowIndex));
                                          }
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: mainFunctions.getWidgetWidth(width: 5),
                                            vertical: mainFunctions.getWidgetHeight(height: 5),
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(16),
                                            color: mainVariables.manageVariables.addProduct.tableData[rowIndex][columnIndex] == "active" ? const Color(0xffECFDF3) : const Color(0xffF1F1F1),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                height: mainFunctions.getWidgetHeight(height: 6),
                                                width: mainFunctions.getWidgetWidth(width: 6),
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: mainVariables.manageVariables.addProduct.tableData[rowIndex][columnIndex] == "active" ? const Color(0xff037847) : const Color(0xff4B4B4B),
                                                ),
                                              ),
                                              SizedBox(
                                                width: mainFunctions.getWidgetWidth(width: 5),
                                              ),
                                              Text(
                                                mainVariables.manageVariables.addProduct.tableData[rowIndex][columnIndex] == "active" ? "Active" : "In Active",
                                                maxLines: 1,
                                                style: TextStyle(
                                                    fontSize: mainFunctions.getTextSize(fontSize: 12),
                                                    overflow: TextOverflow.ellipsis,
                                                    fontWeight: FontWeight.normal,
                                                    color: mainVariables.manageVariables.addProduct.tableData[rowIndex][columnIndex] == "active" ? const Color(0xff037847) : const Color(0xff4B4B4B)),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    : Text(
                                        mainVariables.manageVariables.addProduct.tableData[rowIndex][columnIndex],
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
                            mainFunctions.getWidgetWidth(width: 168),
                            mainFunctions.getWidgetWidth(width: 148),
                            mainFunctions.getWidgetWidth(width: 148),
                            mainFunctions.getWidgetWidth(width: 145),
                          ]
                        : [
                            mainFunctions.getWidgetHeight(height: 0),
                            mainFunctions.getWidgetHeight(height: 230),
                            mainFunctions.getWidgetHeight(height: 230),
                            mainFunctions.getWidgetHeight(height: 230),
                            mainFunctions.getWidgetHeight(height: 220),
                          ],
                    contentCellHeight: 40,
                    stickyLegendWidth: 40,
                    stickyLegendHeight: 40,
                  ),
                ),
        ),
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 40),
        ),
        mainVariables.manageVariables.addProduct.tableData.isEmpty
            ? const SizedBox()
            : Center(
                child: SizedBox(
                  width: mainFunctions.getWidgetWidth(width: 450),
                  child: NumberPaginator(
                    initialPage: 0,
                    numberPages: mainVariables.manageVariables.totalPages,
                    onPageChange: (int index) {
                      mainVariables.manageVariables.currentPage = index + 1;
                      context.read<ManageBloc>().add(const ManagePageFilterEvent());
                    },
                    config: NumberPaginatorUIConfig(
                      buttonShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8), side: const BorderSide(color: Color(0xffF1F1F1), width: 1)),
                      buttonSelectedForegroundColor: Colors.white,
                      buttonUnselectedForegroundColor: const Color(0xff333333),
                      buttonUnselectedBackgroundColor: Colors.white,
                      buttonSelectedBackgroundColor: const Color(0xff0C3788),
                    ),
                  ),
                ),
              ),
      ],
    );
  }

  Widget brandAddWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 80),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Brand/Type",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: mainFunctions.getTextSize(fontSize: 15), color: const Color(0xff111111)),
              ),
              SizedBox(
                height: mainFunctions.getWidgetHeight(height: 10),
              ),
              SizedBox(
                height: mainFunctions.getWidgetHeight(height: 44),
                width: mainFunctions.getWidgetWidth(width: MediaQuery.of(context).orientation == Orientation.portrait ? mainFunctions.getWidgetWidth(width: 280) : mainFunctions.getWidgetWidth(width: 400)),
                child: TextFormField(
                  controller: mainVariables.manageVariables.addBrand.brandController,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: mainFunctions.getWidgetWidth(width: 15)),
                    hintText: "Select or Add Product/brand",
                    hintStyle: TextStyle(
                      fontSize: mainFunctions.getTextSize(fontSize: 13),
                      fontWeight: FontWeight.w400,
                      color: const Color(0xff838195),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                    ),
                  ),
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: mainFunctions.getTextSize(fontSize: 15)),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 50),
        ),
        LoadingButton(
          status: mainVariables.manageVariables.loader,
          onTap: () {
            setState(() {
              mainVariables.manageVariables.loader = true;
            });
            if (mainVariables.manageVariables.addBrand.brandController.text.isEmpty) {
              mainWidgets.flushBarWidget(context: context, message: "Please enter the brand type");
              setState(() {
                mainVariables.manageVariables.loader = false;
              });
            } else {
              context.read<ManageBloc>().add(const AddBrandTypeEvent());
              FocusManager.instance.primaryFocus?.unfocus();
            }
          },
          text: "Add",
          height: mainFunctions.getWidgetHeight(height: 42),
          width: mainFunctions.getWidgetWidth(width: 132),
          fontSize: 16,
          extraWidget: Icon(
            Icons.add,
            color: mainColors.whiteColor,
            size: 20,
          ),
        ),
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 28),
        ),
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 52),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Brand/Type List",
                style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 20), color: mainColors.headingBlueColor, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                width: mainFunctions.getWidgetWidth(width: 200),
                height: mainFunctions.getWidgetHeight(height: 36),
                child: TextFormField(
                  controller: mainVariables.manageVariables.addBrand.searchBar,
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
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: const Color(0XFFEDEDED).withOpacity(0.12))),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: const Color(0XFFEDEDED).withOpacity(0.12))),
                    disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: const Color(0XFFEDEDED).withOpacity(0.12))),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: const Color(0XFFEDEDED).withOpacity(0.12))),
                    focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: const Color(0XFFEDEDED).withOpacity(0.12))),
                    errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: const Color(0XFFEDEDED).withOpacity(0.12))),
                    hintText: "Search",
                    hintStyle: TextStyle(color: const Color(0XFF686868), fontSize: mainFunctions.getTextSize(fontSize: 16), fontWeight: FontWeight.w400),
                  ),
                  onChanged: (value) {
                    mainVariables.manageVariables.currentPage = 1;
                    context.read<ManageBloc>().add(const ManagePageFilterEvent());
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
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 8),
        ),
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 350),
          child: mainVariables.manageVariables.addBrand.tableData.isEmpty
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
                      const Text("Brand type list is Empty"),
                    ],
                  ),
                )
              : StickyHeadersTable(
                  columnsLength: mainVariables.manageVariables.addBrand.tableHeading.length,
                  rowsLength: mainVariables.manageVariables.addBrand.tableData.length,
                  showHorizontalScrollbar: false,
                  showVerticalScrollbar: false,
                  columnsTitleBuilder: (int columnIndex) {
                    return columnIndex == 1
                        ? Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: EdgeInsets.only(right: mainFunctions.getWidgetWidth(width: 50)),
                              child: Text(
                                mainVariables.manageVariables.addBrand.tableHeading[columnIndex],
                                maxLines: 2,
                                style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 12), overflow: TextOverflow.ellipsis, fontWeight: FontWeight.w600),
                              ),
                            ),
                          )
                        : Padding(
                            padding: EdgeInsets.only(left: mainFunctions.getWidgetWidth(width: 75)),
                            child: Text(
                              mainVariables.manageVariables.addBrand.tableHeading[columnIndex],
                              maxLines: 2,
                              style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 12), overflow: TextOverflow.ellipsis, fontWeight: FontWeight.w600),
                            ),
                          );
                  },
                  rowsTitleBuilder: (int rowIndex) {
                    return Center(
                      child: Text(
                        ((mainVariables.manageVariables.currentPage - 1) * 7) + (rowIndex + 1) < 10
                            ? "0${((mainVariables.manageVariables.currentPage - 1) * 7) + (rowIndex + 1)}"
                            : "${((mainVariables.manageVariables.currentPage - 1) * 7) + (rowIndex + 1)}",
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: mainFunctions.getTextSize(fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    );
                  },
                  contentCellBuilder: (int columnIndex, int rowIndex) {
                    return Center(
                      child: columnIndex == 1
                          ? Padding(
                              padding: EdgeInsets.only(right: mainFunctions.getWidgetWidth(width: 50)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      mainVariables.manageVariables.addBrand.editBrandController.text = mainVariables.manageVariables.addBrand.tableData[rowIndex][0];
                                      mainWidgets.showAnimatedDialog(
                                        context: context,
                                        height: 200,
                                        width: 274,
                                        child: editBrandContent(index: rowIndex),
                                      );
                                    },
                                    child: Container(
                                      height: mainFunctions.getWidgetHeight(height: 22),
                                      width: mainFunctions.getWidgetWidth(width: 22),
                                      decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/home/edit.png"), fit: BoxFit.fill)),
                                    ),
                                  ),
                                  SizedBox(
                                    width: mainFunctions.getWidgetWidth(width: 8),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      mainWidgets.showAnimatedDialog(
                                        context: context,
                                        height: 170,
                                        width: 274,
                                        child: deleteBrandContent(data: mainVariables.manageVariables.addBrand.tableData[rowIndex], index: rowIndex),
                                      );
                                    },
                                    child: Container(
                                      height: mainFunctions.getWidgetHeight(height: 22),
                                      width: mainFunctions.getWidgetWidth(width: 22),
                                      decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/home/delete.png"), fit: BoxFit.fill)),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Padding(
                              padding: EdgeInsets.only(left: mainFunctions.getWidgetWidth(width: 75)),
                              child: Text(
                                mainVariables.manageVariables.addBrand.tableData[rowIndex][columnIndex],
                                maxLines: 1,
                                style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 12), overflow: TextOverflow.ellipsis, fontWeight: FontWeight.normal),
                              ),
                            ),
                    );
                  },
                  legendCell: Text(
                    "S.No",
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: mainFunctions.getTextSize(fontSize: 12),
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.w600,
                    ),
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
                            mainFunctions.getWidgetWidth(width: 305),
                            mainFunctions.getWidgetWidth(width: 305),
                          ]
                        : [
                            mainFunctions.getWidgetHeight(height: 450),
                            mainFunctions.getWidgetHeight(height: 450),
                          ],
                    contentCellHeight: 40,
                    stickyLegendWidth: 40,
                    stickyLegendHeight: 40,
                  ),
                ),
        ),
        mainVariables.manageVariables.addBrand.tableData.isEmpty
            ? const SizedBox()
            : Center(
                child: SizedBox(
                  width: mainFunctions.getWidgetWidth(width: 450),
                  child: NumberPaginator(
                    initialPage: 0,
                    numberPages: mainVariables.manageVariables.totalPages,
                    onPageChange: (int index) {
                      mainVariables.manageVariables.currentPage = index + 1;
                      context.read<ManageBloc>().add(const ManagePageFilterEvent());
                    },
                    config: NumberPaginatorUIConfig(
                      buttonShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8), side: const BorderSide(color: Color(0xffF1F1F1), width: 1)),
                      buttonSelectedForegroundColor: Colors.white,
                      buttonUnselectedForegroundColor: const Color(0xff333333),
                      buttonUnselectedBackgroundColor: Colors.white,
                      buttonSelectedBackgroundColor: const Color(0xff0C3788),
                    ),
                  ),
                ),
              ),
      ],
    );
  }

  Widget categoryAddWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 80),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Category",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: mainFunctions.getTextSize(fontSize: 15), color: const Color(0xff111111)),
                  ),
                  SizedBox(
                    height: mainFunctions.getWidgetHeight(height: 10),
                  ),
                  SizedBox(
                    height: mainFunctions.getWidgetHeight(height: 44),
                    width: mainFunctions.getWidgetWidth(width: MediaQuery.of(context).orientation == Orientation.portrait ? mainFunctions.getWidgetWidth(width: 280) : mainFunctions.getWidgetWidth(width: 400)),
                    child: TextFormField(
                      controller: mainVariables.manageVariables.addCategory.categoryController,
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: mainFunctions.getWidgetWidth(width: 15)),
                        hintText: "Add category",
                        hintStyle: TextStyle(
                          fontSize: mainFunctions.getTextSize(fontSize: 13),
                          fontWeight: FontWeight.w400,
                          color: const Color(0xff838195),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                        ),
                      ),
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: mainFunctions.getTextSize(fontSize: 15)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 50),
        ),
        LoadingButton(
          status: mainVariables.manageVariables.loader,
          onTap: () {
            setState(() {
              mainVariables.manageVariables.loader = true;
            });
            if (mainVariables.manageVariables.addCategory.categoryController.text.isEmpty) {
              mainWidgets.flushBarWidget(context: context, message: "Please enter the category");
              setState(() {
                mainVariables.manageVariables.loader = false;
              });
            } else {
              context.read<ManageBloc>().add(const AddCategoryEvent());
              FocusManager.instance.primaryFocus?.unfocus();
            }
          },
          text: "Add",
          height: mainFunctions.getWidgetHeight(height: 42),
          width: mainFunctions.getWidgetWidth(width: 132),
          fontSize: 16,
          extraWidget: Icon(
            Icons.add,
            color: mainColors.whiteColor,
            size: 20,
          ),
        ),
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 28),
        ),
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 52),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Category List",
                style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 20), color: mainColors.headingBlueColor, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                width: mainFunctions.getWidgetWidth(width: 280),
                height: mainFunctions.getWidgetHeight(height: 36),
                child: TextFormField(
                  controller: mainVariables.manageVariables.addCategory.searchBar,
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
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: const Color(0XFF767680).withOpacity(0.12))),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: const Color(0XFF767680).withOpacity(0.12))),
                    disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: const Color(0XFF767680).withOpacity(0.12))),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: const Color(0XFF767680).withOpacity(0.12))),
                    focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: const Color(0XFF767680).withOpacity(0.12))),
                    errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: const Color(0XFF767680).withOpacity(0.12))),
                    hintText: "Search",
                    hintStyle: TextStyle(color: const Color(0XFF686868), fontSize: mainFunctions.getTextSize(fontSize: 16), fontWeight: FontWeight.w400),
                  ),
                  onChanged: (value) {
                    mainVariables.manageVariables.currentPage = 1;
                    context.read<ManageBloc>().add(const ManagePageFilterEvent());
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
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 28),
        ),
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 350),
          child: mainVariables.manageVariables.addCategory.tableData.isEmpty
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
                      const Text("Category list is Empty"),
                    ],
                  ),
                )
              : StickyHeadersTable(
                  columnsLength: mainVariables.manageVariables.addCategory.tableHeading.length,
                  rowsLength: mainVariables.manageVariables.addCategory.tableData.length,
                  showHorizontalScrollbar: false,
                  showVerticalScrollbar: false,
                  columnsTitleBuilder: (int columnIndex) {
                    return columnIndex == 1
                        ? Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: EdgeInsets.only(right: mainFunctions.getWidgetWidth(width: 50)),
                              child: Text(
                                mainVariables.manageVariables.addCategory.tableHeading[columnIndex],
                                maxLines: 2,
                                style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 12), overflow: TextOverflow.ellipsis, fontWeight: FontWeight.w600),
                              ),
                            ),
                          )
                        : Padding(
                            padding: EdgeInsets.only(left: mainFunctions.getWidgetWidth(width: 75)),
                            child: Text(
                              mainVariables.manageVariables.addCategory.tableHeading[columnIndex],
                              maxLines: 2,
                              style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 12), overflow: TextOverflow.ellipsis, fontWeight: FontWeight.w600),
                            ),
                          );
                  },
                  rowsTitleBuilder: (int rowIndex) {
                    return Center(
                      child: Text(
                        ((mainVariables.manageVariables.currentPage - 1) * 7) + (rowIndex + 1) < 10
                            ? "0${((mainVariables.manageVariables.currentPage - 1) * 7) + (rowIndex + 1)}"
                            : "${((mainVariables.manageVariables.currentPage - 1) * 7) + (rowIndex + 1)}",
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: mainFunctions.getTextSize(fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    );
                  },
                  contentCellBuilder: (int columnIndex, int rowIndex) {
                    return Center(
                      child: columnIndex == 1
                          ? Padding(
                              padding: EdgeInsets.only(right: mainFunctions.getWidgetWidth(width: 50)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      mainVariables.manageVariables.addCategory.editCategoryController.text = mainVariables.manageVariables.addCategory.tableData[rowIndex][0];
                                      mainWidgets.showAnimatedDialog(
                                        context: context,
                                        height: 200,
                                        width: 274,
                                        child: editCategoryContent(index: rowIndex),
                                      );
                                    },
                                    child: Container(
                                      height: mainFunctions.getWidgetHeight(height: 22),
                                      width: mainFunctions.getWidgetWidth(width: 22),
                                      decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/home/edit.png"), fit: BoxFit.fill)),
                                    ),
                                  ),
                                  SizedBox(
                                    width: mainFunctions.getWidgetWidth(width: 8),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      mainWidgets.showAnimatedDialog(
                                        context: context,
                                        height: 170,
                                        width: 274,
                                        child: deleteCategoryContent(data: mainVariables.manageVariables.addCategory.tableData[rowIndex], index: rowIndex),
                                      );
                                    },
                                    child: Container(
                                      height: mainFunctions.getWidgetHeight(height: 22),
                                      width: mainFunctions.getWidgetWidth(width: 22),
                                      decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/home/delete.png"), fit: BoxFit.fill)),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Padding(
                              padding: EdgeInsets.only(left: mainFunctions.getWidgetWidth(width: 75)),
                              child: Text(
                                mainVariables.manageVariables.addCategory.tableData[rowIndex][columnIndex],
                                maxLines: 1,
                                style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 12), overflow: TextOverflow.ellipsis, fontWeight: FontWeight.normal),
                              ),
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
                            mainFunctions.getWidgetWidth(width: 305),
                            mainFunctions.getWidgetWidth(width: 305),
                          ]
                        : [
                            mainFunctions.getWidgetHeight(height: 450),
                            mainFunctions.getWidgetHeight(height: 450),
                          ],
                    contentCellHeight: 40,
                    stickyLegendWidth: 40,
                    stickyLegendHeight: 40,
                  ),
                ),
        ),
        mainVariables.manageVariables.addCategory.tableData.isEmpty
            ? const SizedBox()
            : Center(
                child: SizedBox(
                  width: mainFunctions.getWidgetWidth(width: 450),
                  child: NumberPaginator(
                    numberPages: mainVariables.manageVariables.totalPages,
                    onPageChange: (int index) {
                      mainVariables.manageVariables.currentPage = index + 1;
                      context.read<ManageBloc>().add(const ManagePageFilterEvent());
                    },
                    config: NumberPaginatorUIConfig(
                      buttonShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8), side: const BorderSide(color: Color(0xffF1F1F1), width: 1)),
                      buttonSelectedForegroundColor: Colors.white,
                      buttonUnselectedForegroundColor: const Color(0xff333333),
                      buttonUnselectedBackgroundColor: Colors.white,
                      buttonSelectedBackgroundColor: const Color(0xff0C3788),
                    ),
                  ),
                ),
              ),
      ],
    );
  }

  Widget crewAddWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 80),
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
                      "Crew Name",
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: mainFunctions.getTextSize(fontSize: 15), color: const Color(0xff111111)),
                    ),
                    SizedBox(
                      height: mainFunctions.getWidgetHeight(height: 10),
                    ),
                    SizedBox(
                      height: mainFunctions.getWidgetHeight(height: 44),
                      width: mainFunctions.getWidgetWidth(width: MediaQuery.of(context).orientation == Orientation.portrait ? mainFunctions.getWidgetWidth(width: 280) : mainFunctions.getWidgetWidth(width: 400)),
                      child: TextFormField(
                        controller: mainVariables.manageVariables.addCrew.crewController,
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: mainFunctions.getWidgetWidth(width: 15)),
                          hintText: "Enter Crew Name",
                          hintStyle: TextStyle(
                            fontSize: mainFunctions.getTextSize(fontSize: 13),
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff838195),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                          ),
                        ),
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: mainFunctions.getTextSize(fontSize: 15)),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: mainFunctions.getWidgetWidth(width: 15)),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Enter E-mail",
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: mainFunctions.getTextSize(fontSize: 15), color: const Color(0xff111111)),
                    ),
                    SizedBox(
                      height: mainFunctions.getWidgetHeight(height: 10),
                    ),
                    SizedBox(
                      height: mainFunctions.getWidgetHeight(height: 44),
                      width: mainFunctions.getWidgetWidth(width: MediaQuery.of(context).orientation == Orientation.portrait ? mainFunctions.getWidgetWidth(width: 280) : mainFunctions.getWidgetWidth(width: 400)),
                      child: TextFormField(
                        controller: mainVariables.manageVariables.addCrew.crewEmailController,
                        keyboardType: TextInputType.emailAddress,
                        //inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp('^[A-Z]'))],
                        maxLines: 1,
                        minLines: 1,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: mainFunctions.getWidgetWidth(width: 15)),
                          hintText: "Add email",
                          hintStyle: TextStyle(
                            fontSize: mainFunctions.getTextSize(fontSize: 13),
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff838195),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
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
          height: mainFunctions.getWidgetHeight(height: 14),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Role",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: mainFunctions.getTextSize(fontSize: 15), color: const Color(0xff111111)),
            ),
            SizedBox(
              height: mainFunctions.getWidgetHeight(height: 44),
              width: mainFunctions.getWidgetWidth(width: MediaQuery.of(context).orientation == Orientation.portrait ? mainFunctions.getWidgetWidth(width: 280) : mainFunctions.getWidgetWidth(width: 400)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: RadioListTile(
                      value: "admin",
                      groupValue: mainVariables.manageVariables.addCrew.selectedRole,
                      onChanged: (value) {
                        setState(() {
                          mainVariables.manageVariables.addCrew.selectedRole = value ?? "";
                        });
                      },
                      title: Text(
                        "Admin",
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: mainFunctions.getTextSize(fontSize: 13), color: const Color(0xff111111)),
                      ),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                  SizedBox(
                    width: mainFunctions.getWidgetWidth(width: 12),
                  ),
                  Expanded(
                    child: RadioListTile(
                      value: "user",
                      groupValue: mainVariables.manageVariables.addCrew.selectedRole,
                      onChanged: (value) {
                        setState(() {
                          mainVariables.manageVariables.addCrew.selectedRole = value ?? "";
                        });
                      },
                      title: Text(
                        "User",
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: mainFunctions.getTextSize(fontSize: 13), color: const Color(0xff111111)),
                      ),
                      contentPadding: EdgeInsets.zero,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 14),
        ),
        Text(
          "Instructions: Your password must contain at least one upper case, at least one lower case, at least one special character, length within 8 to 40 characters",
          style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 11), color: Colors.green, fontWeight: FontWeight.w400),
        ),
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 80),
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
                      "Password",
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: mainFunctions.getTextSize(fontSize: 15), color: const Color(0xff111111)),
                    ),
                    SizedBox(
                      height: mainFunctions.getWidgetHeight(height: 10),
                    ),
                    SizedBox(
                      height: mainFunctions.getWidgetHeight(height: 44),
                      width: mainFunctions.getWidgetWidth(width: MediaQuery.of(context).orientation == Orientation.portrait ? mainFunctions.getWidgetWidth(width: 280) : mainFunctions.getWidgetWidth(width: 400)),
                      child: TextFormField(
                        controller: mainVariables.manageVariables.addCrew.passwordController,
                        keyboardType: TextInputType.text,
                        obscureText: mainVariables.manageVariables.addCrew.crewObscureText,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: mainFunctions.getWidgetWidth(width: 15)),
                            hintText: "Enter Password",
                            hintStyle: TextStyle(
                              fontSize: mainFunctions.getTextSize(fontSize: 13),
                              fontWeight: FontWeight.w400,
                              color: const Color(0xff838195),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  mainVariables.manageVariables.addCrew.crewObscureText = !mainVariables.manageVariables.addCrew.crewObscureText;
                                });
                              },
                              icon: mainVariables.manageVariables.addCrew.crewObscureText ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility),
                            )),
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: mainFunctions.getTextSize(fontSize: 15)),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: mainFunctions.getWidgetWidth(width: 15)),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Confirm password",
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: mainFunctions.getTextSize(fontSize: 15), color: const Color(0xff111111)),
                    ),
                    SizedBox(
                      height: mainFunctions.getWidgetHeight(height: 10),
                    ),
                    SizedBox(
                      height: mainFunctions.getWidgetHeight(height: 44),
                      width: mainFunctions.getWidgetWidth(width: MediaQuery.of(context).orientation == Orientation.portrait ? mainFunctions.getWidgetWidth(width: 280) : mainFunctions.getWidgetWidth(width: 400)),
                      child: TextFormField(
                        controller: mainVariables.manageVariables.addCrew.confirmPasswordController,
                        keyboardType: TextInputType.emailAddress,
                        obscureText: mainVariables.manageVariables.addCrew.crewObscureText2,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: mainFunctions.getWidgetWidth(width: 15)),
                            hintText: "Re-type your password",
                            hintStyle: TextStyle(
                              fontSize: mainFunctions.getTextSize(fontSize: 13),
                              fontWeight: FontWeight.w400,
                              color: const Color(0xff838195),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  mainVariables.manageVariables.addCrew.crewObscureText2 = !mainVariables.manageVariables.addCrew.crewObscureText2;
                                });
                              },
                              icon: mainVariables.manageVariables.addCrew.crewObscureText2 ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility),
                            )),
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
          height: mainFunctions.getWidgetHeight(height: 50),
        ),
        LoadingButton(
          status: mainVariables.manageVariables.loader,
          onTap: () async {
            setState(() {
              mainVariables.manageVariables.loader = true;
            });
            context.read<ManageBloc>().add(const AddCrewEvent());
            FocusManager.instance.primaryFocus?.unfocus();
          },
          text: "Add",
          height: mainFunctions.getWidgetHeight(height: 42),
          width: mainFunctions.getWidgetWidth(width: 132),
          fontSize: 16,
          extraWidget: Icon(
            Icons.add,
            color: mainColors.whiteColor,
            size: 20,
          ),
        ),
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 28),
        ),
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 52),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Crew List",
                style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 20), color: mainColors.headingBlueColor, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                width: mainFunctions.getWidgetWidth(width: 200),
                height: mainFunctions.getWidgetHeight(height: 36),
                child: TextFormField(
                  controller: mainVariables.manageVariables.addCrew.searchBar,
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
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: const Color(0XFF767680).withOpacity(0.12))),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: const Color(0XFF767680).withOpacity(0.12))),
                    disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: const Color(0XFF767680).withOpacity(0.12))),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: const Color(0XFF767680).withOpacity(0.12))),
                    focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: const Color(0XFF767680).withOpacity(0.12))),
                    errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: const Color(0XFF767680).withOpacity(0.12))),
                    hintText: "Search",
                    hintStyle: TextStyle(color: const Color(0XFF686868), fontSize: mainFunctions.getTextSize(fontSize: 16), fontWeight: FontWeight.w400),
                  ),
                  onChanged: (value) {
                    mainVariables.manageVariables.currentPage = 1;
                    context.read<ManageBloc>().add(const ManagePageFilterEvent());
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
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 28),
        ),
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 350),
          child: mainVariables.manageVariables.addCrew.tableData.isEmpty
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
                      const Text("Crew list is Empty"),
                    ],
                  ),
                )
              : StickyHeadersTable(
                  columnsLength: mainVariables.manageVariables.addCrew.tableHeading.length,
                  rowsLength: mainVariables.manageVariables.addCrew.tableData.length,
                  showHorizontalScrollbar: false,
                  showVerticalScrollbar: false,
                  columnsTitleBuilder: (int columnIndex) {
                    return Center(
                      child: Text(
                        mainVariables.manageVariables.addCrew.tableHeading[columnIndex],
                        maxLines: 2,
                        style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 12), overflow: TextOverflow.ellipsis, fontWeight: FontWeight.w600),
                      ),
                    );
                  },
                  rowsTitleBuilder: (int rowIndex) {
                    return Center(
                      child: Text(
                        ((mainVariables.manageVariables.currentPage - 1) * 7) + (rowIndex + 1) < 10
                            ? "0${((mainVariables.manageVariables.currentPage - 1) * 7) + (rowIndex + 1)}"
                            : "${((mainVariables.manageVariables.currentPage - 1) * 7) + (rowIndex + 1)}",
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: mainFunctions.getTextSize(fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    );
                  },
                  contentCellBuilder: (int columnIndex, int rowIndex) {
                    return Center(
                      child: columnIndex == 0
                          ? Center(
                              child: mainVariables.manageVariables.addCrew.tableData[rowIndex][columnIndex] == ""
                                  ? Image.asset(
                                      "assets/home/user.png",
                                      height: mainFunctions.getWidgetHeight(height: 22),
                                      width: mainFunctions.getWidgetWidth(width: 22),
                                    )
                                  : Container(
                                      height: mainFunctions.getWidgetHeight(height: 22),
                                      width: mainFunctions.getWidgetWidth(width: 22),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.black,
                                        image: DecorationImage(
                                          image: NetworkImage(mainVariables.manageVariables.addCrew.tableData[rowIndex][columnIndex]),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                            )
                          : columnIndex == 4
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        mainVariables.manageVariables.addCrew.crewEditController.text = mainVariables.manageVariables.addCrew.tableData[rowIndex][1];
                                        mainVariables.manageVariables.addCrew.crewEmailEditController.text = mainVariables.manageVariables.addCrew.tableData[rowIndex][2];
                                        mainVariables.manageVariables.addCrew.selectedRole2 = mainVariables.manageVariables.addCrew.tableData[rowIndex][6];
                                        mainWidgets.showAnimatedDialog(
                                          context: context,
                                          height: 350,
                                          width: 400,
                                          child: editCrewContent(index: rowIndex),
                                        );
                                      },
                                      child: Container(
                                        height: mainFunctions.getWidgetHeight(height: 22),
                                        width: mainFunctions.getWidgetWidth(width: 22),
                                        decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/home/edit.png"), fit: BoxFit.fill)),
                                      ),
                                    ),
                                    SizedBox(
                                      width: mainFunctions.getWidgetWidth(width: 8),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        mainWidgets.showAnimatedDialog(
                                          context: context,
                                          height: 170,
                                          width: 274,
                                          child: deleteCrewContent(data: mainVariables.manageVariables.addCrew.tableData[rowIndex], index: rowIndex),
                                        );
                                      },
                                      child: Container(
                                        height: mainFunctions.getWidgetHeight(height: 22),
                                        width: mainFunctions.getWidgetWidth(width: 22),
                                        decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/home/delete.png"), fit: BoxFit.fill)),
                                      ),
                                    ),
                                  ],
                                )
                              : columnIndex == 3
                                  ? InkWell(
                                      onTap: () {
                                        if (mainVariables.manageVariables.addCrew.tableData[rowIndex][3] == "active") {
                                          context.read<ManageBloc>().add(CrewDeactivateEvent(index: rowIndex));
                                        } else {
                                          context.read<ManageBloc>().add(CrewActivateEvent(index: rowIndex));
                                        }
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: mainFunctions.getWidgetWidth(width: 5),
                                          vertical: mainFunctions.getWidgetHeight(height: 5),
                                        ),
                                        margin: EdgeInsets.symmetric(horizontal: mainFunctions.getWidgetWidth(width: 15)),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(16),
                                          color: mainVariables.manageVariables.addCrew.tableData[rowIndex][columnIndex] == "active" ? const Color(0xffECFDF3) : const Color(0xffF1F1F1),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              height: mainFunctions.getWidgetHeight(height: 6),
                                              width: mainFunctions.getWidgetWidth(width: 6),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: mainVariables.manageVariables.addCrew.tableData[rowIndex][columnIndex] == "active" ? const Color(0xff037847) : const Color(0xff4B4B4B),
                                              ),
                                            ),
                                            SizedBox(
                                              width: mainFunctions.getWidgetWidth(width: 5),
                                            ),
                                            Text(
                                              mainVariables.manageVariables.addCrew.tableData[rowIndex][columnIndex] == "active" ? "Active" : "In Active",
                                              maxLines: 1,
                                              style: TextStyle(
                                                  fontSize: mainFunctions.getTextSize(fontSize: 12),
                                                  overflow: TextOverflow.ellipsis,
                                                  fontWeight: FontWeight.normal,
                                                  color: mainVariables.manageVariables.addCrew.tableData[rowIndex][columnIndex] == "active" ? const Color(0xff037847) : const Color(0xff4B4B4B)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : columnIndex == 2 || columnIndex == 1
                                      ? SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          physics: const BouncingScrollPhysics(),
                                          child: Text(
                                            mainVariables.manageVariables.addCrew.tableData[rowIndex][columnIndex],
                                            maxLines: 1,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontSize: mainFunctions.getTextSize(fontSize: 14),
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        )
                                      : Text(
                                          mainVariables.manageVariables.addCrew.tableData[rowIndex][columnIndex],
                                          maxLines: 2,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: mainFunctions.getTextSize(fontSize: 12),
                                            overflow: TextOverflow.ellipsis,
                                            fontWeight: FontWeight.normal,
                                          ),
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
                            mainFunctions.getWidgetWidth(width: 60),
                            mainFunctions.getWidgetWidth(width: 130),
                            mainFunctions.getWidgetWidth(width: 160),
                            mainFunctions.getWidgetWidth(width: 150),
                            mainFunctions.getWidgetWidth(width: 100),
                          ]
                        : [
                            mainFunctions.getWidgetHeight(height: 120),
                            mainFunctions.getWidgetHeight(height: 200),
                            mainFunctions.getWidgetHeight(height: 200),
                            mainFunctions.getWidgetHeight(height: 200),
                            mainFunctions.getWidgetHeight(height: 180),
                          ],
                    contentCellHeight: 40,
                    stickyLegendWidth: 40,
                    stickyLegendHeight: 40,
                  ),
                ),
        ),
        mainVariables.manageVariables.addCrew.tableData.isEmpty
            ? const SizedBox()
            : Center(
                child: SizedBox(
                  width: mainFunctions.getWidgetWidth(width: 450),
                  child: NumberPaginator(
                    initialPage: 0,
                    numberPages: mainVariables.manageVariables.totalPages,
                    onPageChange: (int index) {
                      mainVariables.manageVariables.currentPage = index + 1;
                      context.read<ManageBloc>().add(const ManagePageFilterEvent());
                    },
                    config: NumberPaginatorUIConfig(
                      buttonShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8), side: const BorderSide(color: Color(0xffF1F1F1), width: 1)),
                      buttonSelectedForegroundColor: Colors.white,
                      buttonUnselectedForegroundColor: const Color(0xff333333),
                      buttonUnselectedBackgroundColor: Colors.white,
                      buttonSelectedBackgroundColor: const Color(0xff0C3788),
                    ),
                  ),
                ),
              ),
      ],
    );
  }

  Widget handlerAddWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 80),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Handler",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: mainFunctions.getTextSize(fontSize: 15),
                      color: const Color(0xff111111),
                    ),
                  ),
                  SizedBox(
                    height: mainFunctions.getWidgetHeight(height: 10),
                  ),
                  SizedBox(
                    height: mainFunctions.getWidgetHeight(height: 44),
                    width: mainFunctions.getWidgetWidth(
                      width: MediaQuery.of(context).orientation == Orientation.portrait ? mainFunctions.getWidgetWidth(width: 280) : mainFunctions.getWidgetWidth(width: 400),
                    ),
                    child: TextFormField(
                      controller: mainVariables.manageVariables.addHandler.handlerController,
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: mainFunctions.getWidgetWidth(width: 15)),
                        hintText: "Add handler",
                        hintStyle: TextStyle(
                          fontSize: mainFunctions.getTextSize(fontSize: 13),
                          fontWeight: FontWeight.w400,
                          color: const Color(0xff838195),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                        ),
                      ),
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: mainFunctions.getTextSize(fontSize: 15)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 50),
        ),
        LoadingButton(
          status: mainVariables.manageVariables.loader,
          onTap: () {
            setState(() {
              mainVariables.manageVariables.loader = true;
            });
            if (mainVariables.manageVariables.addHandler.handlerController.text.isEmpty) {
              mainWidgets.flushBarWidget(context: context, message: "Please enter the category");
              setState(() {
                mainVariables.manageVariables.loader = false;
              });
            } else {
              context.read<ManageBloc>().add(const AddHandlerEvent());
              FocusManager.instance.primaryFocus?.unfocus();
            }
          },
          text: "Add",
          height: mainFunctions.getWidgetHeight(height: 42),
          width: mainFunctions.getWidgetWidth(width: 132),
          fontSize: 16,
          extraWidget: Icon(
            Icons.add,
            color: mainColors.whiteColor,
            size: 20,
          ),
        ),
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 28),
        ),
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 52),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Handlers List",
                style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 20), color: mainColors.headingBlueColor, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                width: mainFunctions.getWidgetWidth(width: 200),
                height: mainFunctions.getWidgetHeight(height: 36),
                child: TextFormField(
                  controller: mainVariables.manageVariables.addHandler.searchBar,
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
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: const Color(0XFF767680).withOpacity(0.12))),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: const Color(0XFF767680).withOpacity(0.12))),
                    disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: const Color(0XFF767680).withOpacity(0.12))),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: const Color(0XFF767680).withOpacity(0.12))),
                    focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: const Color(0XFF767680).withOpacity(0.12))),
                    errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: const Color(0XFF767680).withOpacity(0.12))),
                    hintText: "Search",
                    hintStyle: TextStyle(color: const Color(0XFF686868), fontSize: mainFunctions.getTextSize(fontSize: 16), fontWeight: FontWeight.w400),
                  ),
                  onChanged: (value) {
                    mainVariables.manageVariables.currentPage = 1;
                    context.read<ManageBloc>().add(const ManagePageFilterEvent());
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
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 28),
        ),
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 350),
          child: mainVariables.manageVariables.addHandler.tableData.isEmpty
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
                      const Text("Handler list is Empty"),
                    ],
                  ),
                )
              : StickyHeadersTable(
                  columnsLength: mainVariables.manageVariables.addHandler.tableHeading.length,
                  rowsLength: mainVariables.manageVariables.addHandler.tableData.length,
                  showHorizontalScrollbar: false,
                  showVerticalScrollbar: false,
                  columnsTitleBuilder: (int columnIndex) {
                    return columnIndex == 1
                        ? Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: EdgeInsets.only(right: mainFunctions.getWidgetWidth(width: 50)),
                              child: Text(
                                mainVariables.manageVariables.addHandler.tableHeading[columnIndex],
                                maxLines: 2,
                                style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 12), overflow: TextOverflow.ellipsis, fontWeight: FontWeight.w600),
                              ),
                            ),
                          )
                        : Padding(
                            padding: EdgeInsets.only(left: mainFunctions.getWidgetWidth(width: 75)),
                            child: Text(
                              mainVariables.manageVariables.addHandler.tableHeading[columnIndex],
                              maxLines: 2,
                              style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 12), overflow: TextOverflow.ellipsis, fontWeight: FontWeight.w600),
                            ),
                          );
                  },
                  rowsTitleBuilder: (int rowIndex) {
                    return Center(
                      child: Text(
                        ((mainVariables.manageVariables.currentPage - 1) * 7) + (rowIndex + 1) < 10
                            ? "0${((mainVariables.manageVariables.currentPage - 1) * 7) + (rowIndex + 1)}"
                            : "${((mainVariables.manageVariables.currentPage - 1) * 7) + (rowIndex + 1)}",
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: mainFunctions.getTextSize(fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    );
                  },
                  contentCellBuilder: (int columnIndex, int rowIndex) {
                    return Center(
                      child: columnIndex == 1
                          ? Padding(
                              padding: EdgeInsets.only(right: mainFunctions.getWidgetWidth(width: 50)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      mainVariables.manageVariables.addHandler.editHandlerController.text = mainVariables.manageVariables.addHandler.tableData[rowIndex][0];
                                      mainWidgets.showAnimatedDialog(
                                        context: context,
                                        height: 200,
                                        width: 274,
                                        child: editHandlerContent(index: rowIndex),
                                      );
                                    },
                                    child: Container(
                                      height: mainFunctions.getWidgetHeight(height: 22),
                                      width: mainFunctions.getWidgetWidth(width: 22),
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage("assets/home/edit.png"),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: mainFunctions.getWidgetWidth(width: 8),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      mainWidgets.showAnimatedDialog(
                                        context: context,
                                        height: 170,
                                        width: 274,
                                        child: deleteHandlerContent(data: mainVariables.manageVariables.addHandler.tableData[rowIndex], index: rowIndex),
                                      );
                                    },
                                    child: Container(
                                      height: mainFunctions.getWidgetHeight(height: 22),
                                      width: mainFunctions.getWidgetWidth(width: 22),
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage("assets/home/delete.png"),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Padding(
                              padding: EdgeInsets.only(left: mainFunctions.getWidgetWidth(width: 75)),
                              child: Text(
                                mainVariables.manageVariables.addHandler.tableData[rowIndex][columnIndex],
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: mainFunctions.getTextSize(fontSize: 12),
                                  overflow: TextOverflow.ellipsis,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
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
                            mainFunctions.getWidgetWidth(width: 305),
                            mainFunctions.getWidgetWidth(width: 305),
                          ]
                        : [
                            mainFunctions.getWidgetHeight(height: 450),
                            mainFunctions.getWidgetHeight(height: 450),
                          ],
                    contentCellHeight: 40,
                    stickyLegendWidth: 40,
                    stickyLegendHeight: 40,
                  ),
                ),
        ),
        mainVariables.manageVariables.addHandler.tableData.isEmpty
            ? const SizedBox()
            : Center(
                child: SizedBox(
                  width: mainFunctions.getWidgetWidth(width: 450),
                  child: NumberPaginator(
                    initialPage: 0,
                    numberPages: mainVariables.manageVariables.totalPages,
                    onPageChange: (int index) {
                      mainVariables.manageVariables.currentPage = index + 1;
                      context.read<ManageBloc>().add(const ManagePageFilterEvent());
                    },
                    config: NumberPaginatorUIConfig(
                      buttonShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8), side: const BorderSide(color: Color(0xffF1F1F1), width: 1)),
                      buttonSelectedForegroundColor: Colors.white,
                      buttonUnselectedForegroundColor: const Color(0xff333333),
                      buttonUnselectedBackgroundColor: Colors.white,
                      buttonSelectedBackgroundColor: const Color(0xff0C3788),
                    ),
                  ),
                ),
              ),
      ],
    );
  }

  Widget wareHouseAddWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 80),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Warehouse",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: mainFunctions.getTextSize(fontSize: 15), color: const Color(0xff111111)),
                  ),
                  SizedBox(
                    height: mainFunctions.getWidgetHeight(height: 10),
                  ),
                  SizedBox(
                    height: mainFunctions.getWidgetHeight(height: 44),
                    width: mainFunctions.getWidgetWidth(width: MediaQuery.of(context).orientation == Orientation.portrait ? mainFunctions.getWidgetWidth(width: 280) : mainFunctions.getWidgetWidth(width: 400)),
                    child: TextFormField(
                      controller: mainVariables.manageVariables.addWareHouse.wareHouseController,
                      keyboardType: TextInputType.text,
                      inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')), UpperCaseTextFormatter()],
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: mainFunctions.getWidgetWidth(width: 15)),
                        hintText: "Add warehouse",
                        hintStyle: TextStyle(
                          fontSize: mainFunctions.getTextSize(fontSize: 13),
                          fontWeight: FontWeight.w400,
                          color: const Color(0xff838195),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                        ),
                      ),
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: mainFunctions.getTextSize(fontSize: 15)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 50),
        ),
        LoadingButton(
          status: mainVariables.manageVariables.loader,
          onTap: () {
            setState(() {
              mainVariables.manageVariables.loader = true;
            });
            if (mainVariables.manageVariables.addWareHouse.wareHouseController.text.isEmpty) {
              mainWidgets.flushBarWidget(context: context, message: "Please enter the category");
              setState(() {
                mainVariables.manageVariables.loader = false;
              });
            } else {
              context.read<ManageBloc>().add(const AddWarehouseOrAircraftEvent());
              FocusManager.instance.primaryFocus?.unfocus();
            }
          },
          text: "Add",
          height: mainFunctions.getWidgetHeight(height: 42),
          width: mainFunctions.getWidgetWidth(width: 132),
          fontSize: 16,
          extraWidget: Icon(
            Icons.add,
            color: mainColors.whiteColor,
            size: 20,
          ),
        ),
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 28),
        ),
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 52),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Warehouse List",
                style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 20), color: mainColors.headingBlueColor, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                width: mainFunctions.getWidgetWidth(width: 200),
                height: mainFunctions.getWidgetHeight(height: 36),
                child: TextFormField(
                  controller: mainVariables.manageVariables.addWareHouse.searchBar,
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
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: const Color(0XFF767680).withOpacity(0.12))),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: const Color(0XFF767680).withOpacity(0.12))),
                    disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: const Color(0XFF767680).withOpacity(0.12))),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: const Color(0XFF767680).withOpacity(0.12))),
                    focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: const Color(0XFF767680).withOpacity(0.12))),
                    errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: const Color(0XFF767680).withOpacity(0.12))),
                    hintText: "Search",
                    hintStyle: TextStyle(color: const Color(0XFF686868), fontSize: mainFunctions.getTextSize(fontSize: 16), fontWeight: FontWeight.w400),
                  ),
                  onChanged: (value) {
                    mainVariables.manageVariables.currentPage = 1;
                    context.read<ManageBloc>().add(const ManagePageFilterEvent());
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
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 28),
        ),
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 350),
          child: mainVariables.manageVariables.addWareHouse.tableData.isEmpty
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
                      const Text("Warehouse list is Empty"),
                    ],
                  ),
                )
              : StickyHeadersTable(
                  columnsLength: mainVariables.manageVariables.addWareHouse.tableHeading.length,
                  rowsLength: mainVariables.manageVariables.addWareHouse.tableData.length,
                  showHorizontalScrollbar: false,
                  showVerticalScrollbar: false,
                  columnsTitleBuilder: (int columnIndex) {
                    return columnIndex == 1
                        ? Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: EdgeInsets.only(right: mainFunctions.getWidgetWidth(width: 50)),
                              child: Text(
                                mainVariables.manageVariables.addWareHouse.tableHeading[columnIndex],
                                maxLines: 2,
                                style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 12), overflow: TextOverflow.ellipsis, fontWeight: FontWeight.w600),
                              ),
                            ),
                          )
                        : Padding(
                            padding: EdgeInsets.only(left: mainFunctions.getWidgetWidth(width: 75)),
                            child: Text(
                              mainVariables.manageVariables.addWareHouse.tableHeading[columnIndex],
                              maxLines: 2,
                              style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 12), overflow: TextOverflow.ellipsis, fontWeight: FontWeight.w600),
                            ),
                          );
                  },
                  rowsTitleBuilder: (int rowIndex) {
                    return Center(
                      child: Text(
                        ((mainVariables.manageVariables.currentPage - 1) * 7) + (rowIndex + 1) < 10
                            ? "0${((mainVariables.manageVariables.currentPage - 1) * 7) + (rowIndex + 1)}"
                            : "${((mainVariables.manageVariables.currentPage - 1) * 7) + (rowIndex + 1)}",
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: mainFunctions.getTextSize(fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    );
                  },
                  contentCellBuilder: (int columnIndex, int rowIndex) {
                    return Center(
                      child: columnIndex == 1
                          ? Padding(
                              padding: EdgeInsets.only(right: mainFunctions.getWidgetWidth(width: 50)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      mainVariables.manageVariables.addWareHouse.editWareHouseController.text = mainVariables.manageVariables.addWareHouse.tableData[rowIndex][0];
                                      mainWidgets.showAnimatedDialog(
                                        context: context,
                                        height: 200,
                                        width: 274,
                                        child: editWarehouseOrAircraftContent(index: rowIndex),
                                      );
                                    },
                                    child: Container(
                                      height: mainFunctions.getWidgetHeight(height: 22),
                                      width: mainFunctions.getWidgetWidth(width: 22),
                                      decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/home/edit.png"), fit: BoxFit.fill)),
                                    ),
                                  ),
                                  SizedBox(
                                    width: mainFunctions.getWidgetWidth(width: 8),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      mainWidgets.showAnimatedDialog(
                                        context: context,
                                        height: 170,
                                        width: 274,
                                        child: deleteWarehouseOrAircraftContent(data: mainVariables.manageVariables.addWareHouse.tableData[rowIndex], index: rowIndex),
                                      );
                                    },
                                    child: Container(
                                      height: mainFunctions.getWidgetHeight(height: 22),
                                      width: mainFunctions.getWidgetWidth(width: 22),
                                      decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/home/delete.png"), fit: BoxFit.fill)),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Padding(
                              padding: EdgeInsets.only(left: mainFunctions.getWidgetWidth(width: 75)),
                              child: Text(
                                mainVariables.manageVariables.addWareHouse.tableData[rowIndex][columnIndex],
                                maxLines: 1,
                                style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 12), overflow: TextOverflow.ellipsis, fontWeight: FontWeight.normal),
                              ),
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
                            mainFunctions.getWidgetWidth(width: 305),
                            mainFunctions.getWidgetWidth(width: 305),
                          ]
                        : [
                            mainFunctions.getWidgetHeight(height: 450),
                            mainFunctions.getWidgetHeight(height: 450),
                          ],
                    contentCellHeight: 40,
                    stickyLegendWidth: 40,
                    stickyLegendHeight: 40,
                  ),
                ),
        ),
        mainVariables.manageVariables.addWareHouse.tableData.isEmpty
            ? const SizedBox()
            : Center(
                child: SizedBox(
                  width: mainFunctions.getWidgetWidth(width: 450),
                  child: NumberPaginator(
                    initialPage: 0,
                    numberPages: mainVariables.manageVariables.totalPages,
                    onPageChange: (int index) {
                      mainVariables.manageVariables.currentPage = index + 1;
                      context.read<ManageBloc>().add(const ManagePageFilterEvent());
                    },
                    config: NumberPaginatorUIConfig(
                      buttonShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8), side: const BorderSide(color: Color(0xffF1F1F1), width: 1)),
                      buttonSelectedForegroundColor: Colors.white,
                      buttonUnselectedForegroundColor: const Color(0xff333333),
                      buttonUnselectedBackgroundColor: Colors.white,
                      buttonSelectedBackgroundColor: const Color(0xff0C3788),
                    ),
                  ),
                ),
              ),
      ],
    );
  }

  Widget airCraftAddWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 80),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Aircraft",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: mainFunctions.getTextSize(fontSize: 15), color: const Color(0xff111111)),
                  ),
                  SizedBox(
                    height: mainFunctions.getWidgetHeight(height: 10),
                  ),
                  SizedBox(
                    height: mainFunctions.getWidgetHeight(height: 44),
                    width: mainFunctions.getWidgetWidth(width: MediaQuery.of(context).orientation == Orientation.portrait ? mainFunctions.getWidgetWidth(width: 280) : mainFunctions.getWidgetWidth(width: 400)),
                    child: TextFormField(
                      controller: mainVariables.manageVariables.addAirCraft.airCraftController,
                      keyboardType: TextInputType.text,
                      inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')), UpperCaseTextFormatter()],
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: mainFunctions.getWidgetWidth(width: 15)),
                        hintText: "Add aircraft",
                        hintStyle: TextStyle(
                          fontSize: mainFunctions.getTextSize(fontSize: 13),
                          fontWeight: FontWeight.w400,
                          color: const Color(0xff838195),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                        ),
                      ),
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: mainFunctions.getTextSize(fontSize: 15)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 50),
        ),
        LoadingButton(
          status: mainVariables.manageVariables.loader,
          onTap: () {
            setState(() {
              mainVariables.manageVariables.loader = true;
            });
            if (mainVariables.manageVariables.addAirCraft.airCraftController.text.isEmpty) {
              mainWidgets.flushBarWidget(context: context, message: "Please enter the category");
              setState(() {
                mainVariables.manageVariables.loader = false;
              });
            } else {
              context.read<ManageBloc>().add(const AddWarehouseOrAircraftEvent());
              FocusManager.instance.primaryFocus?.unfocus();
            }
          },
          text: "Add",
          height: mainFunctions.getWidgetHeight(height: 42),
          width: mainFunctions.getWidgetWidth(width: 132),
          fontSize: 16,
          extraWidget: Icon(
            Icons.add,
            color: mainColors.whiteColor,
            size: 20,
          ),
        ),
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 28),
        ),
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 52),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "AirCrafts List",
                style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 20), color: mainColors.headingBlueColor, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                width: mainFunctions.getWidgetWidth(width: 200),
                height: mainFunctions.getWidgetHeight(height: 36),
                child: TextFormField(
                  controller: mainVariables.manageVariables.addAirCraft.searchBar,
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
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: const Color(0XFF767680).withOpacity(0.12))),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: const Color(0XFF767680).withOpacity(0.12))),
                    disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: const Color(0XFF767680).withOpacity(0.12))),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: const Color(0XFF767680).withOpacity(0.12))),
                    focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: const Color(0XFF767680).withOpacity(0.12))),
                    errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: const Color(0XFF767680).withOpacity(0.12))),
                    hintText: "Search",
                    hintStyle: TextStyle(color: const Color(0XFF686868), fontSize: mainFunctions.getTextSize(fontSize: 16), fontWeight: FontWeight.w400),
                  ),
                  onChanged: (value) {
                    mainVariables.manageVariables.currentPage = 1;
                    context.read<ManageBloc>().add(const ManagePageFilterEvent());
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
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 28),
        ),
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 350),
          child: mainVariables.manageVariables.addAirCraft.tableData.isEmpty
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
                      const Text("Aircraft list is Empty"),
                    ],
                  ),
                )
              : StickyHeadersTable(
                  columnsLength: mainVariables.manageVariables.addAirCraft.tableHeading.length,
                  rowsLength: mainVariables.manageVariables.addAirCraft.tableData.length,
                  showHorizontalScrollbar: false,
                  showVerticalScrollbar: false,
                  columnsTitleBuilder: (int columnIndex) {
                    return columnIndex == 1
                        ? Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: EdgeInsets.only(right: mainFunctions.getWidgetWidth(width: 50)),
                              child: Text(
                                mainVariables.manageVariables.addAirCraft.tableHeading[columnIndex],
                                maxLines: 2,
                                style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 12), overflow: TextOverflow.ellipsis, fontWeight: FontWeight.w600),
                              ),
                            ),
                          )
                        : Padding(
                            padding: EdgeInsets.only(left: mainFunctions.getWidgetWidth(width: 75)),
                            child: Text(
                              mainVariables.manageVariables.addAirCraft.tableHeading[columnIndex],
                              maxLines: 2,
                              style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 12), overflow: TextOverflow.ellipsis, fontWeight: FontWeight.w600),
                            ),
                          );
                  },
                  rowsTitleBuilder: (int rowIndex) {
                    return Center(
                      child: Text(
                        ((mainVariables.manageVariables.currentPage - 1) * 7) + (rowIndex + 1) < 10
                            ? "0${((mainVariables.manageVariables.currentPage - 1) * 7) + (rowIndex + 1)}"
                            : "${((mainVariables.manageVariables.currentPage - 1) * 7) + (rowIndex + 1)}",
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: mainFunctions.getTextSize(fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    );
                  },
                  contentCellBuilder: (int columnIndex, int rowIndex) {
                    return Center(
                      child: columnIndex == 1
                          ? Padding(
                              padding: EdgeInsets.only(right: mainFunctions.getWidgetWidth(width: 50)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      mainVariables.manageVariables.addAirCraft.editAirCraftController.text = mainVariables.manageVariables.addAirCraft.tableData[rowIndex][0];
                                      mainWidgets.showAnimatedDialog(
                                        context: context,
                                        height: 200,
                                        width: 274,
                                        child: editWarehouseOrAircraftContent(index: rowIndex),
                                      );
                                    },
                                    child: Container(
                                      height: mainFunctions.getWidgetHeight(height: 22),
                                      width: mainFunctions.getWidgetWidth(width: 22),
                                      decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/home/edit.png"), fit: BoxFit.fill)),
                                    ),
                                  ),
                                  SizedBox(
                                    width: mainFunctions.getWidgetWidth(width: 8),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      mainWidgets.showAnimatedDialog(
                                        context: context,
                                        height: 170,
                                        width: 274,
                                        child: deleteWarehouseOrAircraftContent(data: mainVariables.manageVariables.addAirCraft.tableData[rowIndex], index: rowIndex),
                                      );
                                    },
                                    child: Container(
                                      height: mainFunctions.getWidgetHeight(height: 22),
                                      width: mainFunctions.getWidgetWidth(width: 22),
                                      decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/home/delete.png"), fit: BoxFit.fill)),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Padding(
                              padding: EdgeInsets.only(left: mainFunctions.getWidgetWidth(width: 75)),
                              child: Text(
                                mainVariables.manageVariables.addAirCraft.tableData[rowIndex][columnIndex].toUpperCase(),
                                maxLines: 1,
                                style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 12), overflow: TextOverflow.ellipsis, fontWeight: FontWeight.normal),
                              ),
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
                            mainFunctions.getWidgetWidth(width: 305),
                            mainFunctions.getWidgetWidth(width: 305),
                          ]
                        : [
                            mainFunctions.getWidgetHeight(height: 450),
                            mainFunctions.getWidgetHeight(height: 450),
                          ],
                    contentCellHeight: 40,
                    stickyLegendWidth: 40,
                    stickyLegendHeight: 40,
                  ),
                ),
        ),
        mainVariables.manageVariables.addAirCraft.tableData.isEmpty
            ? const SizedBox()
            : Center(
                child: SizedBox(
                  width: mainFunctions.getWidgetWidth(width: 450),
                  child: NumberPaginator(
                    initialPage: 0,
                    numberPages: mainVariables.manageVariables.totalPages,
                    onPageChange: (int index) {
                      mainVariables.manageVariables.currentPage = index + 1;
                      context.read<ManageBloc>().add(const ManagePageFilterEvent());
                    },
                    config: NumberPaginatorUIConfig(
                      buttonShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8), side: const BorderSide(color: Color(0xffF1F1F1), width: 1)),
                      buttonSelectedForegroundColor: Colors.white,
                      buttonUnselectedForegroundColor: const Color(0xff333333),
                      buttonUnselectedBackgroundColor: Colors.white,
                      buttonSelectedBackgroundColor: const Color(0xff0C3788),
                    ),
                  ),
                ),
              ),
      ],
    );
  }

  Widget sectorAddWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 80),
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
                      "ICAO",
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: mainFunctions.getTextSize(fontSize: 15), color: const Color(0xff111111)),
                    ),
                    SizedBox(
                      height: mainFunctions.getWidgetHeight(height: 10),
                    ),
                    SizedBox(
                      height: mainFunctions.getWidgetHeight(height: 44),
                      width: mainFunctions.getWidgetWidth(width: MediaQuery.of(context).orientation == Orientation.portrait ? mainFunctions.getWidgetWidth(width: 280) : mainFunctions.getWidgetWidth(width: 400)),
                      child: TextFormField(
                        controller: mainVariables.manageVariables.addSector.icaoController,
                        keyboardType: TextInputType.text,
                        inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')), UpperCaseTextFormatter()],
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: mainFunctions.getWidgetWidth(width: 15)),
                          hintText: "Add ICAO",
                          hintStyle: TextStyle(
                            fontSize: mainFunctions.getTextSize(fontSize: 13),
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff838195),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                          ),
                        ),
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: mainFunctions.getTextSize(fontSize: 15)),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: mainFunctions.getWidgetWidth(width: 15)),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "IATA",
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: mainFunctions.getTextSize(fontSize: 15), color: const Color(0xff111111)),
                    ),
                    SizedBox(
                      height: mainFunctions.getWidgetHeight(height: 10),
                    ),
                    SizedBox(
                      height: mainFunctions.getWidgetHeight(height: 44),
                      width: mainFunctions.getWidgetWidth(width: MediaQuery.of(context).orientation == Orientation.portrait ? mainFunctions.getWidgetWidth(width: 280) : mainFunctions.getWidgetWidth(width: 400)),
                      child: TextFormField(
                        controller: mainVariables.manageVariables.addSector.iataController,
                        keyboardType: TextInputType.emailAddress,
                        inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')), UpperCaseTextFormatter()],
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: mainFunctions.getWidgetWidth(width: 15)),
                          hintText: "Add IATA",
                          hintStyle: TextStyle(
                            fontSize: mainFunctions.getTextSize(fontSize: 13),
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff838195),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
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
          height: mainFunctions.getWidgetHeight(height: 22),
        ),
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 80),
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
                      "Airport Name",
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: mainFunctions.getTextSize(fontSize: 15), color: const Color(0xff111111)),
                    ),
                    SizedBox(
                      height: mainFunctions.getWidgetHeight(height: 10),
                    ),
                    SizedBox(
                      height: mainFunctions.getWidgetHeight(height: 44),
                      width: mainFunctions.getWidgetWidth(width: MediaQuery.of(context).orientation == Orientation.portrait ? mainFunctions.getWidgetWidth(width: 280) : mainFunctions.getWidgetWidth(width: 400)),
                      child: TextFormField(
                        controller: mainVariables.manageVariables.addSector.airportController,
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: mainFunctions.getWidgetWidth(width: 15)),
                          hintText: "Add Airport Name",
                          hintStyle: TextStyle(
                            fontSize: mainFunctions.getTextSize(fontSize: 13),
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff838195),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                          ),
                        ),
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: mainFunctions.getTextSize(fontSize: 15)),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: mainFunctions.getWidgetWidth(width: 15)),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "City",
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: mainFunctions.getTextSize(fontSize: 15), color: const Color(0xff111111)),
                    ),
                    SizedBox(
                      height: mainFunctions.getWidgetHeight(height: 10),
                    ),
                    SizedBox(
                      height: mainFunctions.getWidgetHeight(height: 44),
                      width: mainFunctions.getWidgetWidth(width: MediaQuery.of(context).orientation == Orientation.portrait ? mainFunctions.getWidgetWidth(width: 280) : mainFunctions.getWidgetWidth(width: 400)),
                      child: TextFormField(
                        controller: mainVariables.manageVariables.addSector.cityController,
                        keyboardType: TextInputType.emailAddress,
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: mainFunctions.getWidgetWidth(width: 15)),
                          hintText: "Add City",
                          hintStyle: TextStyle(
                            fontSize: mainFunctions.getTextSize(fontSize: 13),
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff838195),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
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
          height: mainFunctions.getWidgetHeight(height: 50),
        ),
        LoadingButton(
          status: mainVariables.manageVariables.loader,
          onTap: () {
            setState(() {
              mainVariables.manageVariables.loader = true;
            });
            if (mainVariables.manageVariables.addSector.iataController.text.isEmpty ||
                mainVariables.manageVariables.addSector.icaoController.text.isEmpty ||
                mainVariables.manageVariables.addSector.airportController.text.isEmpty ||
                mainVariables.manageVariables.addSector.cityController.text.isEmpty) {
              mainWidgets.flushBarWidget(context: context, message: "Please enter the all the field");
              setState(() {
                mainVariables.manageVariables.loader = false;
              });
            } else {
              context.read<ManageBloc>().add(const AddSectorEvent());
              FocusManager.instance.primaryFocus?.unfocus();
            }
          },
          text: "Add",
          height: mainFunctions.getWidgetHeight(height: 42),
          width: mainFunctions.getWidgetWidth(width: 132),
          fontSize: 16,
          extraWidget: Icon(
            Icons.add,
            color: mainColors.whiteColor,
            size: 20,
          ),
        ),
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 28),
        ),
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 52),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Airports List",
                style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 20), color: mainColors.headingBlueColor, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                width: mainFunctions.getWidgetWidth(width: 280),
                height: mainFunctions.getWidgetHeight(height: 36),
                child: TextFormField(
                  controller: mainVariables.manageVariables.addSector.searchBar,
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
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: const Color(0XFF767680).withOpacity(0.12))),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: const Color(0XFF767680).withOpacity(0.12))),
                    disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: const Color(0XFF767680).withOpacity(0.12))),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: const Color(0XFF767680).withOpacity(0.12))),
                    focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: const Color(0XFF767680).withOpacity(0.12))),
                    errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: const Color(0XFF767680).withOpacity(0.12))),
                    hintText: "Search",
                    hintStyle: TextStyle(color: const Color(0XFF686868), fontSize: mainFunctions.getTextSize(fontSize: 16), fontWeight: FontWeight.w400),
                  ),
                  onChanged: (value) {
                    mainVariables.manageVariables.currentPage = 1;
                    context.read<ManageBloc>().add(const ManagePageFilterEvent());
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
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 28),
        ),
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 350),
          child: mainVariables.manageVariables.addSector.tableData.isEmpty
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
                      const Text("Sector list is Empty"),
                    ],
                  ),
                )
              : StickyHeadersTable(
                  columnsLength: mainVariables.manageVariables.addSector.tableHeading.length,
                  rowsLength: mainVariables.manageVariables.addSector.tableData.length,
                  showHorizontalScrollbar: false,
                  showVerticalScrollbar: false,
                  columnsTitleBuilder: (int columnIndex) {
                    return Center(
                      child: Text(
                        mainVariables.manageVariables.addSector.tableHeading[columnIndex],
                        maxLines: 2,
                        style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 12), overflow: TextOverflow.ellipsis, fontWeight: FontWeight.w600),
                      ),
                    );
                  },
                  rowsTitleBuilder: (int rowIndex) {
                    return Center(
                      child: Text(
                        ((mainVariables.manageVariables.currentPage - 1) * 7) + (rowIndex + 1) < 10
                            ? "0${((mainVariables.manageVariables.currentPage - 1) * 7) + (rowIndex + 1)}"
                            : "${((mainVariables.manageVariables.currentPage - 1) * 7) + (rowIndex + 1)}",
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: mainFunctions.getTextSize(fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    );
                  },
                  contentCellBuilder: (int columnIndex, int rowIndex) {
                    return Center(
                      child: columnIndex == 4
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    mainVariables.manageVariables.addSector.icaoEditController.text = mainVariables.manageVariables.addSector.tableData[rowIndex][2];
                                    mainVariables.manageVariables.addSector.iataEditController.text = mainVariables.manageVariables.addSector.tableData[rowIndex][3];
                                    mainVariables.manageVariables.addSector.airportEditController.text = mainVariables.manageVariables.addSector.tableData[rowIndex][0];
                                    mainVariables.manageVariables.addSector.cityEditController.text = mainVariables.manageVariables.addSector.tableData[rowIndex][1];
                                    mainWidgets.showAnimatedDialog(
                                      context: context,
                                      height: 420,
                                      width: 400,
                                      child: editSectorContent(index: rowIndex),
                                    );
                                  },
                                  child: Container(
                                    height: mainFunctions.getWidgetHeight(height: 22),
                                    width: mainFunctions.getWidgetWidth(width: 22),
                                    decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/home/edit.png"), fit: BoxFit.fill)),
                                  ),
                                ),
                                SizedBox(
                                  width: mainFunctions.getWidgetWidth(width: 16),
                                ),
                                InkWell(
                                  onTap: () {
                                    mainWidgets.showAnimatedDialog(
                                      context: context,
                                      height: 170,
                                      width: 274,
                                      child: deleteSectorContent(data: mainVariables.manageVariables.addSector.tableData[rowIndex], index: rowIndex),
                                    );
                                  },
                                  child: Container(
                                    height: mainFunctions.getWidgetHeight(height: 22),
                                    width: mainFunctions.getWidgetWidth(width: 22),
                                    decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/home/delete.png"), fit: BoxFit.fill)),
                                  ),
                                ),
                              ],
                            )
                          : Text(
                              mainVariables.manageVariables.addSector.tableData[rowIndex][columnIndex],
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
                            mainFunctions.getWidgetWidth(width: 160),
                            mainFunctions.getWidgetWidth(width: 120),
                            mainFunctions.getWidgetWidth(width: 110),
                            mainFunctions.getWidgetWidth(width: 110),
                            mainFunctions.getWidgetWidth(width: 110),
                          ]
                        : [
                            mainFunctions.getWidgetHeight(height: 215),
                            mainFunctions.getWidgetHeight(height: 175),
                            mainFunctions.getWidgetHeight(height: 175),
                            mainFunctions.getWidgetHeight(height: 165),
                            mainFunctions.getWidgetHeight(height: 165),
                          ],
                    contentCellHeight: 40,
                    stickyLegendWidth: 40,
                    stickyLegendHeight: 40,
                  ),
                ),
        ),
        mainVariables.manageVariables.addSector.tableData.isEmpty
            ? const SizedBox()
            : Center(
                child: SizedBox(
                  width: mainFunctions.getWidgetWidth(width: 450),
                  child: NumberPaginator(
                    initialPage: 0,
                    numberPages: mainVariables.manageVariables.totalPages,
                    onPageChange: (int index) {
                      mainVariables.manageVariables.currentPage = index + 1;
                      context.read<ManageBloc>().add(const ManagePageFilterEvent());
                    },
                    config: NumberPaginatorUIConfig(
                      buttonShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8), side: const BorderSide(color: Color(0xffF1F1F1), width: 1)),
                      buttonSelectedForegroundColor: Colors.white,
                      buttonUnselectedForegroundColor: const Color(0xff333333),
                      buttonUnselectedBackgroundColor: Colors.white,
                      buttonSelectedBackgroundColor: const Color(0xff0C3788),
                    ),
                  ),
                ),
              ),
      ],
    );
  }

  Widget dialogContent() {
    return StatefulBuilder(builder: (BuildContext context, StateSetter modelSetState) {
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: mainFunctions.getWidgetWidth(width: 20),
          vertical: mainFunctions.getWidgetHeight(height: 20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              width: mainFunctions.getWidgetWidth(width: 1112),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Upload CSV',
                    style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 24), fontWeight: FontWeight.w600),
                  ),
                  IconButton(
                      onPressed: () {
                        modelSetState(() {
                          mainVariables.manageVariables.selectedFileName = "";
                          mainVariables.manageVariables.csvUploadFileLoader = false;
                        });
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.close,
                        color: mainColors.blackColor,
                      ))
                ],
              ),
            ),
            SizedBox(height: mainFunctions.getWidgetHeight(height: 15)),
            Text(
              'Please select .csv file to import the data',
              style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 16), fontWeight: FontWeight.w500),
            ),
            SizedBox(height: mainFunctions.getWidgetHeight(height: 15)),
            Center(
                child: Container(
              height: mainFunctions.getWidgetHeight(height: 75),
              width: mainFunctions.getWidgetWidth(width: 75),
              padding: EdgeInsets.symmetric(
                horizontal: mainFunctions.getWidgetWidth(width: 15),
                vertical: mainFunctions.getWidgetHeight(height: 15),
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  image: const DecorationImage(
                    image: AssetImage("assets/home/csv_file.png"),
                    fit: BoxFit.fill,
                  ),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 4.0,
                      spreadRadius: 0.0,
                      color: Colors.grey.shade300,
                    ),
                  ]),
            )),
            SizedBox(height: mainFunctions.getWidgetHeight(height: 15)),
            Center(
              child: mainVariables.manageVariables.selectedFileName != ""
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: mainFunctions.getWidgetWidth(width: 200),
                          child: Text(
                            mainVariables.manageVariables.selectedFileName,
                            style: TextStyle(
                              fontSize: mainFunctions.getTextSize(fontSize: 11),
                              color: const Color(0xff007BFE),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            modelSetState(() {
                              mainVariables.manageVariables.selectedFileName = "";
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Remove", style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 11), color: Colors.red)),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () async {
                            modelSetState(() {
                              mainVariables.manageVariables.selectedFileName = "";
                              mainVariables.manageVariables.csvUploadFileLoader = true;
                            });
                            String path = await mainFunctions.pickFiles(isPdf: false, context: context);
                            List<String> pathList = path.split("/");
                            modelSetState(() {
                              mainVariables.manageVariables.selectedFileName = pathList.last;
                              mainVariables.manageVariables.csvUploadFileLoader = false;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("change", style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 11), color: Colors.green)),
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(),
            ),
            SizedBox(height: mainFunctions.getWidgetHeight(height: 25)),
            Center(
              child: InkWell(
                onTap: () {
                  mainVariables.manageVariables.selectedFileName != ""
                      ? context.read<ManageBloc>().add(InventoryBulkUploadEvent(setState: modelSetState))
                      : context.read<ManageBloc>().add(CsvFileSelectionEvent(setState: modelSetState, context: context));
                },
                child: mainVariables.manageVariables.csvUploadFileLoader
                    ? const CircularProgressIndicator()
                    : Container(
                        width: mainFunctions.getWidgetHeight(height: 132),
                        height: mainFunctions.getWidgetHeight(height: 42),
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(
                          vertical: mainFunctions.getWidgetHeight(height: 8),
                          horizontal: mainFunctions.getWidgetWidth(width: 8),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          gradient: const LinearGradient(
                            colors: [
                              Color(0XFF0C3788),
                              Color(0XFFBC0044),
                            ],
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(mainVariables.manageVariables.selectedFileName != "" ? "Save" : 'Choose file',
                                textAlign: TextAlign.center, style: TextStyle(color: const Color(0xffffffff), fontSize: mainFunctions.getTextSize(fontSize: 14), fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ),
              ),
            )
          ],
        ),
      );
    });
  }

  Widget deleteProductContent({required List<String> data, required int index}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 52),
          child: Center(
            child: Text(
              'Delete ${data[1]}',
              maxLines: 2,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 14), fontWeight: FontWeight.w600, color: const Color(0xff111111)),
            ),
          ),
        ),
        const Divider(
          color: Color(0xffCECECE),
          height: 0,
          thickness: 1,
        ),
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 12),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: mainFunctions.getWidgetWidth(width: 15)),
          child: Text(
            "This will permanently delete “${data[1]}” from the list..",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: mainFunctions.getTextSize(fontSize: 12),
              color: const Color(0xff181818),
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 16),
        ),
        Container(
          height: mainFunctions.getWidgetHeight(height: 44),
          padding: EdgeInsets.symmetric(horizontal: mainFunctions.getWidgetWidth(width: 20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton(
                  style: TextButton.styleFrom(splashFactory: NoSplash.splashFactory),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                      fontSize: mainFunctions.getTextSize(fontSize: 16),
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff111111),
                    ),
                  )),
              TextButton(
                  style: TextButton.styleFrom(splashFactory: NoSplash.splashFactory),
                  onPressed: () {
                    context.read<ManageBloc>().add(DeleteProductEvent(index: index));
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Delete",
                    style: TextStyle(
                      fontSize: mainFunctions.getTextSize(fontSize: 16),
                      fontWeight: FontWeight.w500,
                      color: const Color(0xffF85359),
                    ),
                  )),
            ],
          ),
        ),
      ],
    );
  }

  Widget editProductContent() {
    return Column(
      children: [
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 50),
        ),
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 80),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: EasyAutocomplete(
                  key: key6,
                  labelText: "Category",
                  hintText: "select or add category",
                  initialValue: mainVariables.manageVariables.addProduct.tableData[mainVariables.manageVariables.addProduct.editSelectedIndex][2],
                  focusNode: mainVariables.manageVariables.addProduct.categoryEditControllerFocusNode,
                  enabled: mainVariables.manageVariables.addProduct.isEdit,
                  textFieldHeight: mainFunctions.getWidgetHeight(height: 44),
                  textFieldWidth: mainFunctions.getWidgetWidth(width: MediaQuery.of(context).orientation == Orientation.portrait ? mainFunctions.getWidgetWidth(width: 280) : mainFunctions.getWidgetWidth(width: 400)),
                  suggestions: mainVariables.manageVariables.categorySuggestionList,
                  onChanged: (value) {
                    mainVariables.manageVariables.addProduct.categoryEditId = value;
                  },
                  onSubmitted: (value) {
                    mainVariables.manageVariables.addProduct.categoryEditId = value;
                  },
                  suggestionBackgroundColor: Colors.white,
                  buttonString: "Manage Category",
                  selectedIndex: 3,
                ),
              ),
              SizedBox(width: mainFunctions.getWidgetWidth(width: 15)),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Product",
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: mainFunctions.getTextSize(fontSize: 15), color: const Color(0xff111111)),
                    ),
                    SizedBox(
                      height: mainFunctions.getWidgetHeight(height: 10),
                    ),
                    SizedBox(
                      height: mainFunctions.getWidgetHeight(height: 44),
                      width: mainFunctions.getWidgetWidth(
                        width: MediaQuery.of(context).orientation == Orientation.portrait ? mainFunctions.getWidgetWidth(width: 280) : mainFunctions.getWidgetWidth(width: 400),
                      ),
                      child: TextFormField(
                        controller: mainVariables.manageVariables.addProduct.productEditController,
                        keyboardType: TextInputType.text,
                        enabled: mainVariables.manageVariables.addProduct.isEdit,
                        decoration: InputDecoration(
                          fillColor: mainVariables.manageVariables.addProduct.isEdit ? Colors.white : const Color(0xffF7F7F7),
                          filled: true,
                          hintText: "Add Product",
                          hintStyle: TextStyle(
                            fontSize: mainFunctions.getTextSize(fontSize: 13),
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff838195),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                          ),
                        ),
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: mainFunctions.getTextSize(fontSize: 15),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 22),
        ),
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 80),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: EasyAutocomplete(
                  key: key7,
                  labelText: "Brand/ Type",
                  hintText: "select or add location",
                  focusNode: mainVariables.manageVariables.addProduct.brandEditControllerFocusNode,
                  initialValue: mainVariables.manageVariables.addProduct.tableData[mainVariables.manageVariables.addProduct.editSelectedIndex][7],
                  textFieldHeight: mainFunctions.getWidgetHeight(height: 44),
                  enabled: mainVariables.manageVariables.addProduct.isEdit,
                  textFieldWidth: mainFunctions.getWidgetWidth(width: MediaQuery.of(context).orientation == Orientation.portrait ? mainFunctions.getWidgetWidth(width: 280) : mainFunctions.getWidgetWidth(width: 400)),
                  decoration: InputDecoration(
                    fillColor: mainVariables.manageVariables.addProduct.isEdit ? Colors.white : const Color(0xffF7F7F7),
                    filled: true,
                    hintText: "select or add location",
                    hintStyle: TextStyle(
                      fontSize: mainFunctions.getTextSize(fontSize: 13),
                      fontWeight: FontWeight.w400,
                      color: const Color(0xff838195),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                    ),
                    suffixIcon: mainVariables.manageVariables.addProduct.isEdit ? const Icon(Icons.keyboard_arrow_down) : const SizedBox(),
                  ),
                  suggestions: mainVariables.manageVariables.brandTypeSuggestionList,
                  onChanged: (value) {
                    mainVariables.manageVariables.addProduct.brandEditId = value;
                  },
                  onSubmitted: (value) {
                    mainVariables.manageVariables.addProduct.brandEditId = value;
                  },
                  suggestionBackgroundColor: Colors.white,
                  buttonString: "Manage Brand Type",
                  selectedIndex: 2,
                ),
              ),
              SizedBox(width: mainFunctions.getWidgetWidth(width: 15)),
              mainVariables.manageVariables.addProduct.tableData[mainVariables.manageVariables.addProduct.editSelectedIndex][10] == "0"
                  ? const Expanded(
                      child: SizedBox(),
                    )
                  : Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Days until expiry",
                            style: TextStyle(fontWeight: FontWeight.w600, fontSize: mainFunctions.getTextSize(fontSize: 15), color: const Color(0xff111111)),
                          ),
                          SizedBox(
                            height: mainFunctions.getWidgetHeight(height: 10),
                          ),
                          SizedBox(
                            height: mainFunctions.getWidgetHeight(height: 44),
                            width: mainFunctions.getWidgetWidth(
                              width: MediaQuery.of(context).orientation == Orientation.portrait ? mainFunctions.getWidgetWidth(width: 280) : mainFunctions.getWidgetWidth(width: 400),
                            ),
                            child: TextFormField(
                              controller: mainVariables.manageVariables.addProduct.daysUntilEditController,
                              keyboardType: TextInputType.number,
                              enabled: mainVariables.manageVariables.addProduct.isEdit,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: mainVariables.manageVariables.addProduct.isEdit ? Colors.white : const Color(0xffF7F7F7),
                                hintText: "Add days until expiry",
                                hintStyle: TextStyle(
                                  fontSize: mainFunctions.getTextSize(fontSize: 13),
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xff838195),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                                ),
                              ),
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: mainFunctions.getTextSize(fontSize: 15),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        ),
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 16),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "Status : ",
              style: TextStyle(
                fontSize: mainFunctions.getTextSize(fontSize: 12),
                overflow: TextOverflow.ellipsis,
                fontWeight: FontWeight.normal,
              ),
            ),
            mainVariables.manageVariables.addProduct.isEdit
                ? InkWell(
                    onTap: () {
                      if (mainVariables.manageVariables.addProduct.tableData[mainVariables.manageVariables.addProduct.editSelectedIndex][3] == "active") {
                        context.read<ManageBloc>().add(ProductDeactivateEvent(index: mainVariables.manageVariables.addProduct.editSelectedIndex));
                      } else {
                        context.read<ManageBloc>().add(ProductActivateEvent(index: mainVariables.manageVariables.addProduct.editSelectedIndex));
                      }
                    },
                    child: Container(
                      width: mainFunctions.getWidgetWidth(width: 150),
                      padding: EdgeInsets.symmetric(
                        horizontal: mainFunctions.getWidgetWidth(width: 5),
                        vertical: mainFunctions.getWidgetHeight(height: 5),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: mainVariables.manageVariables.addProduct.tableData[mainVariables.manageVariables.addProduct.editSelectedIndex][3] == "active" ? const Color(0xffECFDF3) : const Color(0xffF1F1F1),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: mainFunctions.getWidgetHeight(height: 6),
                            width: mainFunctions.getWidgetWidth(width: 6),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: mainVariables.manageVariables.addProduct.tableData[mainVariables.manageVariables.addProduct.editSelectedIndex][3] == "active" ? const Color(0xff037847) : const Color(0xff4B4B4B),
                            ),
                          ),
                          SizedBox(
                            width: mainFunctions.getWidgetWidth(width: 5),
                          ),
                          Text(
                            mainVariables.manageVariables.addProduct.tableData[mainVariables.manageVariables.addProduct.editSelectedIndex][3] == "active" ? "Active" : "In Active",
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: mainFunctions.getTextSize(fontSize: 12),
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.normal,
                                color: mainVariables.manageVariables.addProduct.tableData[mainVariables.manageVariables.addProduct.editSelectedIndex][3] == "active" ? const Color(0xff037847) : const Color(0xff4B4B4B)),
                          ),
                        ],
                      ),
                    ),
                  )
                : Container(
                    width: mainFunctions.getWidgetWidth(width: 150),
                    padding: EdgeInsets.symmetric(
                      horizontal: mainFunctions.getWidgetWidth(width: 5),
                      vertical: mainFunctions.getWidgetHeight(height: 5),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: mainVariables.manageVariables.addProduct.tableData[mainVariables.manageVariables.addProduct.editSelectedIndex][3] == "active" ? const Color(0xffECFDF3) : const Color(0xffF1F1F1),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: mainFunctions.getWidgetHeight(height: 6),
                          width: mainFunctions.getWidgetWidth(width: 6),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: mainVariables.manageVariables.addProduct.tableData[mainVariables.manageVariables.addProduct.editSelectedIndex][3] == "active" ? const Color(0xff037847) : const Color(0xff4B4B4B),
                          ),
                        ),
                        SizedBox(
                          width: mainFunctions.getWidgetWidth(width: 5),
                        ),
                        Text(
                          mainVariables.manageVariables.addProduct.tableData[mainVariables.manageVariables.addProduct.editSelectedIndex][3] == "active" ? "Active" : "In Active",
                          maxLines: 1,
                          style: TextStyle(
                              fontSize: mainFunctions.getTextSize(fontSize: 12),
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.normal,
                              color: mainVariables.manageVariables.addProduct.tableData[mainVariables.manageVariables.addProduct.editSelectedIndex][3] == "active" ? const Color(0xff037847) : const Color(0xff4B4B4B)),
                        ),
                      ],
                    ),
                  ),
          ],
        ),
        mainVariables.manageVariables.addProduct.isEdit
            ? SizedBox(
                height: mainFunctions.getWidgetHeight(height: 50),
              )
            : const SizedBox(),
        mainVariables.manageVariables.addProduct.isEdit
            ? LoadingButton(
                status: mainVariables.manageVariables.loader,
                onTap: () {
                  context.read<ManageBloc>().add(EditProductEvent(index: mainVariables.manageVariables.addProduct.editSelectedIndex));
                  setState(() {
                    mainVariables.manageVariables.addProduct.isEdit = false;
                    mainVariables.manageVariables.addProduct.isCreate = true;
                  });
                },
                text: "Save",
                height: mainFunctions.getWidgetHeight(height: 42),
                width: mainFunctions.getWidgetWidth(width: 132),
                fontSize: 16,
                extraWidget: Icon(
                  Icons.add,
                  color: mainColors.whiteColor,
                  size: 20,
                ),
              )
            : const SizedBox(),
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 28),
        ),
      ],
    );
  }

  Widget deleteBrandContent({required List<String> data, required int index}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 52),
          child: Center(
            child: Text(
              'Delete ${data[0]}',
              maxLines: 2,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 14), fontWeight: FontWeight.w600, color: const Color(0xff111111)),
            ),
          ),
        ),
        const Divider(
          color: Color(0xffCECECE),
          height: 0,
          thickness: 1,
        ),
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 12),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: mainFunctions.getWidgetWidth(width: 15)),
          child: Text(
            "This will permanently delete “${data[0]}” from the list..",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: mainFunctions.getTextSize(fontSize: 12),
              color: const Color(0xff181818),
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 16),
        ),
        Container(
          height: mainFunctions.getWidgetHeight(height: 44),
          padding: EdgeInsets.symmetric(horizontal: mainFunctions.getWidgetWidth(width: 20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton(
                  style: TextButton.styleFrom(splashFactory: NoSplash.splashFactory),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                      fontSize: mainFunctions.getTextSize(fontSize: 16),
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff111111),
                    ),
                  )),
              TextButton(
                  style: TextButton.styleFrom(splashFactory: NoSplash.splashFactory),
                  onPressed: () {
                    context.read<ManageBloc>().add(DeleteBrandTypeEvent(index: index));
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Delete",
                    style: TextStyle(
                      fontSize: mainFunctions.getTextSize(fontSize: 16),
                      fontWeight: FontWeight.w500,
                      color: const Color(0xffF85359),
                    ),
                  )),
            ],
          ),
        ),
      ],
    );
  }

  Widget editBrandContent({required int index}) {
    return Container(
      height: mainFunctions.getWidgetHeight(height: 162),
      width: mainFunctions.getWidgetWidth(width: 450),
      padding: EdgeInsets.symmetric(
        horizontal: mainFunctions.getWidgetWidth(width: 20),
        vertical: mainFunctions.getWidgetHeight(height: 10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Edit Brand/type",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: mainFunctions.getTextSize(fontSize: 15),
              color: const Color(0xff111111),
            ),
          ),
          SizedBox(
            height: mainFunctions.getWidgetHeight(height: 10),
          ),
          TextFormField(
            controller: mainVariables.manageVariables.addBrand.editBrandController,
            keyboardType: TextInputType.text,
            maxLines: 2,
            minLines: 1,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
              ),
            ),
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: mainFunctions.getTextSize(fontSize: 15)),
          ),
          SizedBox(
            height: mainFunctions.getWidgetHeight(height: 22),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () async {
                  Navigator.pop(context);
                },
                child: Container(
                  width: mainFunctions.getWidgetHeight(height: 75),
                  height: mainFunctions.getWidgetHeight(height: 38),
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(
                    vertical: mainFunctions.getWidgetHeight(height: 8),
                    horizontal: mainFunctions.getWidgetWidth(width: 8),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.grey.shade200, width: 1),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Cancel',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: mainFunctions.getTextSize(fontSize: 12),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  if (mainVariables.manageVariables.addBrand.editBrandController.text.isEmpty) {
                  } else {
                    context.read<ManageBloc>().add(EditBrandTypeEvent(index: index));
                    Navigator.pop(context);
                  }
                },
                child: Container(
                  width: mainFunctions.getWidgetHeight(height: 80),
                  height: mainFunctions.getWidgetHeight(height: 38),
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(
                    vertical: mainFunctions.getWidgetHeight(height: 8),
                    horizontal: mainFunctions.getWidgetWidth(width: 8),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0XFF0C3788),
                        Color(0XFFBC0044),
                      ],
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Confirm',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xffffffff),
                          fontSize: mainFunctions.getTextSize(fontSize: 12),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget deleteCategoryContent({required List<String> data, required int index}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 52),
          child: Center(
            child: Text(
              'Delete ${data[0]}',
              maxLines: 2,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 14), fontWeight: FontWeight.w600, color: const Color(0xff111111)),
            ),
          ),
        ),
        const Divider(
          color: Color(0xffCECECE),
          height: 0,
          thickness: 1,
        ),
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 12),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: mainFunctions.getWidgetWidth(width: 15)),
          child: Text(
            "This will permanently delete “${data[0]}” from the list..",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: mainFunctions.getTextSize(fontSize: 12),
              color: const Color(0xff181818),
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 16),
        ),
        Container(
          height: mainFunctions.getWidgetHeight(height: 44),
          padding: EdgeInsets.symmetric(horizontal: mainFunctions.getWidgetWidth(width: 20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton(
                  style: TextButton.styleFrom(splashFactory: NoSplash.splashFactory),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                      fontSize: mainFunctions.getTextSize(fontSize: 16),
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff111111),
                    ),
                  )),
              TextButton(
                  style: TextButton.styleFrom(splashFactory: NoSplash.splashFactory),
                  onPressed: () {
                    context.read<ManageBloc>().add(DeleteCategoryEvent(index: index));
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Delete",
                    style: TextStyle(
                      fontSize: mainFunctions.getTextSize(fontSize: 16),
                      fontWeight: FontWeight.w500,
                      color: const Color(0xffF85359),
                    ),
                  )),
            ],
          ),
        ),
      ],
    );
  }

  Widget editCategoryContent({required int index}) {
    return Container(
      height: mainFunctions.getWidgetHeight(height: 162),
      width: mainFunctions.getWidgetWidth(width: 450),
      padding: EdgeInsets.symmetric(
        horizontal: mainFunctions.getWidgetWidth(width: 20),
        vertical: mainFunctions.getWidgetHeight(height: 10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Edit Category",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: mainFunctions.getTextSize(fontSize: 15),
              color: const Color(0xff111111),
            ),
          ),
          SizedBox(
            height: mainFunctions.getWidgetHeight(height: 10),
          ),
          TextFormField(
            controller: mainVariables.manageVariables.addCategory.editCategoryController,
            keyboardType: TextInputType.text,
            maxLines: 2,
            minLines: 1,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
              ),
            ),
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: mainFunctions.getTextSize(fontSize: 15)),
          ),
          SizedBox(
            height: mainFunctions.getWidgetHeight(height: 22),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () async {
                  Navigator.pop(context);
                },
                child: Container(
                  width: mainFunctions.getWidgetHeight(height: 75),
                  height: mainFunctions.getWidgetHeight(height: 38),
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(
                    vertical: mainFunctions.getWidgetHeight(height: 8),
                    horizontal: mainFunctions.getWidgetWidth(width: 8),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.grey.shade200, width: 1),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Cancel',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: mainFunctions.getTextSize(fontSize: 12),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  if (mainVariables.manageVariables.addCategory.editCategoryController.text.isEmpty) {
                  } else {
                    context.read<ManageBloc>().add(EditCategoryEvent(index: index));
                    Navigator.pop(context);
                  }
                },
                child: Container(
                  width: mainFunctions.getWidgetHeight(height: 80),
                  height: mainFunctions.getWidgetHeight(height: 38),
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(
                    vertical: mainFunctions.getWidgetHeight(height: 8),
                    horizontal: mainFunctions.getWidgetWidth(width: 8),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0XFF0C3788),
                        Color(0XFFBC0044),
                      ],
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Confirm',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xffffffff),
                          fontSize: mainFunctions.getTextSize(fontSize: 12),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget deleteCrewContent({required List<String> data, required int index}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 52),
          child: Center(
            child: Text(
              'Delete ${data[1]}',
              maxLines: 2,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 14), fontWeight: FontWeight.w600, color: const Color(0xff111111)),
            ),
          ),
        ),
        const Divider(
          color: Color(0xffCECECE),
          height: 0,
          thickness: 1,
        ),
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 12),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: mainFunctions.getWidgetWidth(width: 15)),
          child: Text(
            "This will permanently delete “${data[1]}” from the list..",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: mainFunctions.getTextSize(fontSize: 12),
              color: const Color(0xff181818),
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 16),
        ),
        Container(
          height: mainFunctions.getWidgetHeight(height: 44),
          padding: EdgeInsets.symmetric(horizontal: mainFunctions.getWidgetWidth(width: 20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton(
                  style: TextButton.styleFrom(splashFactory: NoSplash.splashFactory),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                      fontSize: mainFunctions.getTextSize(fontSize: 16),
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff111111),
                    ),
                  )),
              TextButton(
                  style: TextButton.styleFrom(splashFactory: NoSplash.splashFactory),
                  onPressed: () {
                    context.read<ManageBloc>().add(DeleteCrewEvent(index: index));
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Delete",
                    style: TextStyle(
                      fontSize: mainFunctions.getTextSize(fontSize: 16),
                      fontWeight: FontWeight.w500,
                      color: const Color(0xffF85359),
                    ),
                  )),
            ],
          ),
        ),
      ],
    );
  }

  Widget editCrewContent({required int index}) {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter modelSetState) {
        return Container(
          height: mainFunctions.getWidgetHeight(height: 162),
          width: mainFunctions.getWidgetWidth(width: 450),
          padding: EdgeInsets.symmetric(
            horizontal: mainFunctions.getWidgetWidth(width: 20),
            vertical: mainFunctions.getWidgetHeight(height: 10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Edit Crew",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: mainFunctions.getTextSize(fontSize: 15),
                  color: const Color(0xff111111),
                ),
              ),
              SizedBox(
                height: mainFunctions.getWidgetHeight(height: 10),
              ),
              TextFormField(
                controller: mainVariables.manageVariables.addCrew.crewEditController,
                keyboardType: TextInputType.text,
                maxLines: 2,
                minLines: 1,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                    ),
                    labelText: "Crew Name"),
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: mainFunctions.getTextSize(fontSize: 15)),
              ),
              SizedBox(
                height: mainFunctions.getWidgetHeight(height: 22),
              ),
              TextFormField(
                controller: mainVariables.manageVariables.addCrew.crewEmailEditController,
                keyboardType: TextInputType.text,
                maxLines: 2,
                minLines: 1,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                    ),
                    labelText: "Email"),
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: mainFunctions.getTextSize(fontSize: 15)),
              ),
              SizedBox(
                height: mainFunctions.getWidgetHeight(height: 22),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Role",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: mainFunctions.getTextSize(fontSize: 15), color: const Color(0xff111111)),
                  ),
                  SizedBox(
                    height: mainFunctions.getWidgetHeight(height: 44),
                    width: mainFunctions.getWidgetWidth(width: MediaQuery.of(context).orientation == Orientation.portrait ? mainFunctions.getWidgetWidth(width: 280) : mainFunctions.getWidgetWidth(width: 400)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: RadioListTile(
                            value: "admin",
                            groupValue: mainVariables.manageVariables.addCrew.selectedRole2,
                            onChanged: (value) {
                              modelSetState(() {
                                mainVariables.manageVariables.addCrew.selectedRole2 = value ?? "";
                              });
                            },
                            title: Text(
                              "Admin",
                              style: TextStyle(fontWeight: FontWeight.w600, fontSize: mainFunctions.getTextSize(fontSize: 13), color: const Color(0xff111111)),
                            ),
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                        SizedBox(
                          width: mainFunctions.getWidgetWidth(width: 12),
                        ),
                        Expanded(
                          child: RadioListTile(
                            value: "user",
                            groupValue: mainVariables.manageVariables.addCrew.selectedRole2,
                            onChanged: (value) {
                              modelSetState(() {
                                mainVariables.manageVariables.addCrew.selectedRole2 = value ?? "";
                              });
                            },
                            title: Text(
                              "User",
                              style: TextStyle(fontWeight: FontWeight.w600, fontSize: mainFunctions.getTextSize(fontSize: 13), color: const Color(0xff111111)),
                            ),
                            contentPadding: EdgeInsets.zero,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: mainFunctions.getWidgetHeight(height: 22),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () async {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: mainFunctions.getWidgetHeight(height: 75),
                      height: mainFunctions.getWidgetHeight(height: 38),
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                        vertical: mainFunctions.getWidgetHeight(height: 8),
                        horizontal: mainFunctions.getWidgetWidth(width: 8),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.grey.shade200, width: 1),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Cancel',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: mainFunctions.getTextSize(fontSize: 12),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      context.read<ManageBloc>().add(EditCrewEvent(index: index));
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: mainFunctions.getWidgetHeight(height: 80),
                      height: mainFunctions.getWidgetHeight(height: 38),
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                        vertical: mainFunctions.getWidgetHeight(height: 8),
                        horizontal: mainFunctions.getWidgetWidth(width: 8),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: const LinearGradient(
                          colors: [
                            Color(0XFF0C3788),
                            Color(0XFFBC0044),
                          ],
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Confirm',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xffffffff),
                              fontSize: mainFunctions.getTextSize(fontSize: 12),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  Widget deleteHandlerContent({required List<String> data, required int index}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 52),
          child: Center(
            child: Text(
              'Delete ${data[0]}',
              maxLines: 2,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 14), fontWeight: FontWeight.w600, color: const Color(0xff111111)),
            ),
          ),
        ),
        const Divider(
          color: Color(0xffCECECE),
          height: 0,
          thickness: 1,
        ),
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 12),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: mainFunctions.getWidgetWidth(width: 15)),
          child: Text(
            "This will permanently delete “${data[0]}” from the list..",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: mainFunctions.getTextSize(fontSize: 12),
              color: const Color(0xff181818),
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 16),
        ),
        Container(
          height: mainFunctions.getWidgetHeight(height: 44),
          padding: EdgeInsets.symmetric(horizontal: mainFunctions.getWidgetWidth(width: 20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton(
                  style: TextButton.styleFrom(splashFactory: NoSplash.splashFactory),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                      fontSize: mainFunctions.getTextSize(fontSize: 16),
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff111111),
                    ),
                  )),
              TextButton(
                  style: TextButton.styleFrom(splashFactory: NoSplash.splashFactory),
                  onPressed: () {
                    context.read<ManageBloc>().add(DeleteHandlerEvent(index: index));
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Delete",
                    style: TextStyle(
                      fontSize: mainFunctions.getTextSize(fontSize: 16),
                      fontWeight: FontWeight.w500,
                      color: const Color(0xffF85359),
                    ),
                  )),
            ],
          ),
        ),
      ],
    );
  }

  Widget editHandlerContent({required int index}) {
    return Container(
      height: mainFunctions.getWidgetHeight(height: 162),
      width: mainFunctions.getWidgetWidth(width: 450),
      padding: EdgeInsets.symmetric(
        horizontal: mainFunctions.getWidgetWidth(width: 20),
        vertical: mainFunctions.getWidgetHeight(height: 10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Edit Handler",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: mainFunctions.getTextSize(fontSize: 15),
              color: const Color(0xff111111),
            ),
          ),
          SizedBox(
            height: mainFunctions.getWidgetHeight(height: 10),
          ),
          TextFormField(
            controller: mainVariables.manageVariables.addHandler.editHandlerController,
            keyboardType: TextInputType.text,
            maxLines: 2,
            minLines: 1,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
              ),
            ),
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: mainFunctions.getTextSize(fontSize: 15)),
          ),
          SizedBox(
            height: mainFunctions.getWidgetHeight(height: 22),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () async {
                  Navigator.pop(context);
                },
                child: Container(
                  width: mainFunctions.getWidgetHeight(height: 75),
                  height: mainFunctions.getWidgetHeight(height: 38),
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(
                    vertical: mainFunctions.getWidgetHeight(height: 8),
                    horizontal: mainFunctions.getWidgetWidth(width: 8),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.grey.shade200, width: 1),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Cancel',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: mainFunctions.getTextSize(fontSize: 12),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  if (mainVariables.manageVariables.addHandler.editHandlerController.text.isEmpty) {
                  } else {
                    context.read<ManageBloc>().add(EditHandlerEvent(index: index));
                    Navigator.pop(context);
                  }
                },
                child: Container(
                  width: mainFunctions.getWidgetHeight(height: 80),
                  height: mainFunctions.getWidgetHeight(height: 38),
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(
                    vertical: mainFunctions.getWidgetHeight(height: 8),
                    horizontal: mainFunctions.getWidgetWidth(width: 8),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0XFF0C3788),
                        Color(0XFFBC0044),
                      ],
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Confirm',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xffffffff),
                          fontSize: mainFunctions.getTextSize(fontSize: 12),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget deleteWarehouseOrAircraftContent({required List<String> data, required int index}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 52),
          child: Center(
            child: Text(
              'Delete ${data[0]}',
              maxLines: 2,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 14), fontWeight: FontWeight.w600, color: const Color(0xff111111)),
            ),
          ),
        ),
        const Divider(
          color: Color(0xffCECECE),
          height: 0,
          thickness: 1,
        ),
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 12),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: mainFunctions.getWidgetWidth(width: 15)),
          child: Text(
            "This will permanently delete “${data[0]}” from the list..",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: mainFunctions.getTextSize(fontSize: 12),
              color: const Color(0xff181818),
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 16),
        ),
        Container(
          height: mainFunctions.getWidgetHeight(height: 44),
          padding: EdgeInsets.symmetric(horizontal: mainFunctions.getWidgetWidth(width: 20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton(
                  style: TextButton.styleFrom(splashFactory: NoSplash.splashFactory),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                      fontSize: mainFunctions.getTextSize(fontSize: 16),
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff111111),
                    ),
                  )),
              TextButton(
                  style: TextButton.styleFrom(splashFactory: NoSplash.splashFactory),
                  onPressed: () {
                    context.read<ManageBloc>().add(DeleteWarehouseOrAircraftEvent(index: index));
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Delete",
                    style: TextStyle(
                      fontSize: mainFunctions.getTextSize(fontSize: 16),
                      fontWeight: FontWeight.w500,
                      color: const Color(0xffF85359),
                    ),
                  )),
            ],
          ),
        ),
      ],
    );
  }

  Widget editWarehouseOrAircraftContent({required int index}) {
    return Container(
      height: mainFunctions.getWidgetHeight(height: 162),
      width: mainFunctions.getWidgetWidth(width: 450),
      padding: EdgeInsets.symmetric(
        horizontal: mainFunctions.getWidgetWidth(width: 20),
        vertical: mainFunctions.getWidgetHeight(height: 10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Edit ${mainVariables.manageVariables.manageSelectedIndex == 6 ? "Warhouse" : "Aircraft"}",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: mainFunctions.getTextSize(fontSize: 15),
              color: const Color(0xff111111),
            ),
          ),
          SizedBox(
            height: mainFunctions.getWidgetHeight(height: 10),
          ),
          TextFormField(
            controller: mainVariables.manageVariables.manageSelectedIndex == 6 ? mainVariables.manageVariables.addWareHouse.editWareHouseController : mainVariables.manageVariables.addAirCraft.editAirCraftController,
            keyboardType: TextInputType.text,
            maxLines: 2,
            minLines: 1,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
              ),
            ),
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: mainFunctions.getTextSize(fontSize: 15)),
          ),
          SizedBox(
            height: mainFunctions.getWidgetHeight(height: 22),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () async {
                  Navigator.pop(context);
                },
                child: Container(
                  width: mainFunctions.getWidgetHeight(height: 75),
                  height: mainFunctions.getWidgetHeight(height: 38),
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(
                    vertical: mainFunctions.getWidgetHeight(height: 8),
                    horizontal: mainFunctions.getWidgetWidth(width: 8),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.grey.shade200, width: 1),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Cancel',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: mainFunctions.getTextSize(fontSize: 12),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  if (mainVariables.manageVariables.manageSelectedIndex == 6) {
                    if (mainVariables.manageVariables.addWareHouse.editWareHouseController.text.isEmpty) {
                    } else {
                      context.read<ManageBloc>().add(EditWarehouseOrAircraftEvent(index: index));
                      Navigator.pop(context);
                    }
                  } else {
                    if (mainVariables.manageVariables.addAirCraft.editAirCraftController.text.isEmpty) {
                    } else {
                      context.read<ManageBloc>().add(EditWarehouseOrAircraftEvent(index: index));
                      Navigator.pop(context);
                    }
                  }
                },
                child: Container(
                  width: mainFunctions.getWidgetHeight(height: 80),
                  height: mainFunctions.getWidgetHeight(height: 38),
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(
                    vertical: mainFunctions.getWidgetHeight(height: 8),
                    horizontal: mainFunctions.getWidgetWidth(width: 8),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0XFF0C3788),
                        Color(0XFFBC0044),
                      ],
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Confirm',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xffffffff),
                          fontSize: mainFunctions.getTextSize(fontSize: 12),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget deleteSectorContent({required List<String> data, required int index}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 52),
          child: Center(
            child: Text(
              'Delete ${data[2]}',
              maxLines: 2,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 14), fontWeight: FontWeight.w600, color: const Color(0xff111111)),
            ),
          ),
        ),
        const Divider(
          color: Color(0xffCECECE),
          height: 0,
          thickness: 1,
        ),
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 12),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: mainFunctions.getWidgetWidth(width: 15)),
          child: Text(
            "This will permanently delete “${data[0]}” from the list..",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: mainFunctions.getTextSize(fontSize: 12),
              color: const Color(0xff181818),
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 16),
        ),
        Container(
          height: mainFunctions.getWidgetHeight(height: 44),
          padding: EdgeInsets.symmetric(horizontal: mainFunctions.getWidgetWidth(width: 20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton(
                  style: TextButton.styleFrom(splashFactory: NoSplash.splashFactory),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                      fontSize: mainFunctions.getTextSize(fontSize: 16),
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff111111),
                    ),
                  )),
              TextButton(
                  style: TextButton.styleFrom(splashFactory: NoSplash.splashFactory),
                  onPressed: () {
                    context.read<ManageBloc>().add(DeleteSectorEvent(index: index));
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Delete",
                    style: TextStyle(
                      fontSize: mainFunctions.getTextSize(fontSize: 16),
                      fontWeight: FontWeight.w500,
                      color: const Color(0xffF85359),
                    ),
                  )),
            ],
          ),
        ),
      ],
    );
  }

  Widget editSectorContent({required int index}) {
    return Container(
      height: mainFunctions.getWidgetHeight(height: 162),
      width: mainFunctions.getWidgetWidth(width: 450),
      padding: EdgeInsets.symmetric(
        horizontal: mainFunctions.getWidgetWidth(width: 20),
        vertical: mainFunctions.getWidgetHeight(height: 10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Edit Sector",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: mainFunctions.getTextSize(fontSize: 15),
              color: const Color(0xff111111),
            ),
          ),
          SizedBox(
            height: mainFunctions.getWidgetHeight(height: 10),
          ),
          TextFormField(
            controller: mainVariables.manageVariables.addSector.icaoEditController,
            keyboardType: TextInputType.text,
            maxLines: 2,
            minLines: 1,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                ),
                labelText: "ICAO"),
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: mainFunctions.getTextSize(fontSize: 15)),
          ),
          SizedBox(
            height: mainFunctions.getWidgetHeight(height: 22),
          ),
          TextFormField(
            controller: mainVariables.manageVariables.addSector.iataEditController,
            keyboardType: TextInputType.text,
            maxLines: 2,
            minLines: 1,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                ),
                labelText: "IATA"),
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: mainFunctions.getTextSize(fontSize: 15)),
          ),
          SizedBox(
            height: mainFunctions.getWidgetHeight(height: 22),
          ),
          TextFormField(
            controller: mainVariables.manageVariables.addSector.airportEditController,
            keyboardType: TextInputType.text,
            maxLines: 2,
            minLines: 1,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                ),
                labelText: "Airport Name"),
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: mainFunctions.getTextSize(fontSize: 15)),
          ),
          SizedBox(
            height: mainFunctions.getWidgetHeight(height: 22),
          ),
          TextFormField(
            controller: mainVariables.manageVariables.addSector.cityEditController,
            keyboardType: TextInputType.text,
            maxLines: 2,
            minLines: 1,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                ),
                labelText: "City"),
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: mainFunctions.getTextSize(fontSize: 15)),
          ),
          SizedBox(
            height: mainFunctions.getWidgetHeight(height: 22),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () async {
                  Navigator.pop(context);
                },
                child: Container(
                  width: mainFunctions.getWidgetHeight(height: 75),
                  height: mainFunctions.getWidgetHeight(height: 38),
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(
                    vertical: mainFunctions.getWidgetHeight(height: 8),
                    horizontal: mainFunctions.getWidgetWidth(width: 8),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.grey.shade200, width: 1),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Cancel',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: mainFunctions.getTextSize(fontSize: 12),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  context.read<ManageBloc>().add(EditSectorEvent(index: index));
                  Navigator.pop(context);
                },
                child: Container(
                  width: mainFunctions.getWidgetHeight(height: 80),
                  height: mainFunctions.getWidgetHeight(height: 38),
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(
                    vertical: mainFunctions.getWidgetHeight(height: 8),
                    horizontal: mainFunctions.getWidgetWidth(width: 8),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0XFF0C3788),
                        Color(0XFFBC0044),
                      ],
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Confirm',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xffffffff),
                          fontSize: mainFunctions.getTextSize(fontSize: 12),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
