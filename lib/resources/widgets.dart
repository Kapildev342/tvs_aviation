import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:tvsaviation/bloc/check_list/check_list_bloc.dart';
import 'package:tvsaviation/bloc/rail_navigation/rail_navigation_bloc.dart';
import 'package:tvsaviation/bloc/reports/reports_bloc.dart';
import 'package:tvsaviation/bloc/transit/transit_bloc.dart';
import 'package:tvsaviation/data/model/variable_model/check_list_variables.dart';
import 'package:tvsaviation/resources/constants.dart';

class Widgets {
  Widget primaryContainerWidget({
    required Widget body,
    required BuildContext context,
  }) {
    return Container(
      height: mainVariables.generalVariables.height,
      width: mainVariables.generalVariables.width,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0XFF0C3788),
            Color(0XFFBC0044),
          ],
        ),
      ),
      child: SafeArea(
        child: Scaffold(
          drawer: Obx(() => mainVariables.generalVariables.currentPage.value == "transit" ? drawerTransitWidget(context: context) : drawerWidget(context: context)),
          body: body,
        ),
      ),
    );
  }

  Future flushBarWidget({
    required BuildContext context,
    required String message,
  }) async {
    return Flushbar(
      messageText: Text(
        message,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: mainFunctions.getTextSize(fontSize: 14),
          color: Colors.black,
        ),
      ),
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      isDismissible: true,
      duration: const Duration(seconds: 2),
      margin: EdgeInsets.only(left: mainFunctions.getWidgetWidth(width: 400), right: mainFunctions.getWidgetWidth(width: 20), top: mainFunctions.getWidgetHeight(height: 20)),
      borderRadius: BorderRadius.circular(15),
      backgroundColor: Colors.grey.shade300,
      animationDuration: const Duration(milliseconds: 1000),
    ).show(context);
  }

  Widget nonLoginTextField({
    required TextEditingController controller,
    required String hintText,
  }) {
    return SizedBox(
      height: mainFunctions.getWidgetHeight(height: 50),
      width: mainFunctions.getWidgetWidth(width: 377),
      child: TextFormField(
        controller: controller,
        style: mainTextStyle.normalTextStyle,
        decoration: InputDecoration(
          fillColor: const Color(0xFFFFFFFF),
          filled: true,
          contentPadding: EdgeInsets.only(left: mainFunctions.getWidgetWidth(width: 25)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0XFFEDEDED))),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0XFFEDEDED))),
          disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0XFFEDEDED))),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0XFFEDEDED))),
          focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0XFFEDEDED))),
          errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0XFFEDEDED))),
          hintText: hintText,
          hintStyle: TextStyle(color: const Color(0XFF686868), fontSize: mainFunctions.getTextSize(fontSize: 12), fontWeight: FontWeight.w400),
        ),
      ),
    );
  }

  Widget stockType({required String category, required bool status, required bool fromDialog}) {
    switch (category) {
      case "transit":
        return Text(
          "TRANSIT",
          style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: fromDialog ? 16 : 11), fontWeight: status ? FontWeight.w400 : FontWeight.w600, color: const Color(0xff0C3788)),
        );
      case "expiry":
        return Text(
          "Expiry warning",
          style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: fromDialog ? 16 : 11), fontWeight: status ? FontWeight.w400 : FontWeight.w600, color: const Color(0xffF85359)),
        );
      case "low_stock":
        return Text(
          "LOW STOCK",
          style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: fromDialog ? 16 : 11), fontWeight: status ? FontWeight.w400 : FontWeight.w600, color: const Color(0xffE1A900)),
        );
      case "stock_dispute":
        return Text(
          "DISPUTE",
          style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: fromDialog ? 16 : 11), fontWeight: status ? FontWeight.w400 : FontWeight.w600, color: const Color(0xffEF7606)),
        );
      case "checklist":
        return Text(
          "CHECKLIST",
          style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: fromDialog ? 16 : 11), fontWeight: status ? FontWeight.w400 : FontWeight.w600, color: const Color(0xff037847)),
        );
      default:
        return Text(category);
    }
  }

  Widget idType({required String category, required String bottomId, required bool status, required bool fromDialog}) {
    switch (category) {
      case "transit":
        return Text(
          "Transit ID : $bottomId",
          style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: fromDialog ? 16 : 11), fontWeight: status ? FontWeight.w400 : FontWeight.w600),
        );
      case "expiry":
        return Text(
          "Barcode : $bottomId",
          style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: fromDialog ? 16 : 11), fontWeight: status ? FontWeight.w400 : FontWeight.w600),
        );
      case "low_stock":
        return Text(
          "Barcode : $bottomId",
          style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: fromDialog ? 16 : 11), fontWeight: status ? FontWeight.w400 : FontWeight.w600),
        );
      case "stock_dispute":
        return Text(
          "Dispute Id : $bottomId",
          style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: fromDialog ? 16 : 11), fontWeight: status ? FontWeight.w400 : FontWeight.w600),
        );
      case "checklist":
        return Text(
          "Sector : $bottomId",
          style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: fromDialog ? 16 : 11), fontWeight: status ? FontWeight.w400 : FontWeight.w600),
        );
      default:
        return Text(category);
    }
  }

  Widget buttonWidget({
    required Function onTap,
    required Size size,
    required String buttonText,
  }) {
    return GestureDetector(
      onTap: onTap(),
      child: Center(
        child: Container(
            height: mainFunctions.getWidgetHeight(height: size.height),
            width: mainFunctions.getWidgetWidth(width: size.width),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0XFF0C3788),
                  Color(0XFFBC0044),
                ],
              ),
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  spreadRadius: 0.0,
                  blurRadius: 4.0,
                  color: Colors.grey.shade300,
                ),
              ],
            ),
            child: Center(
              child: Text(
                buttonText,
                style: TextStyle(color: const Color(0xffffffff), fontSize: mainFunctions.getTextSize(fontSize: 22), fontWeight: FontWeight.w600),
              ),
            )),
      ),
    );
  }

  void showAnimatedDialog({
    required BuildContext context,
    required double height,
    required double width,
    required Widget child,
  }) {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (BuildContext buildContext, Animation animation, Animation secondaryAnimation) {
        return Center(
          child: Container(
            height: mainFunctions.getWidgetHeight(height: height),
            width: mainFunctions.getWidgetWidth(width: width),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Material(
              type: MaterialType.transparency,
              child: child,
            ),
          ),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
    );
  }

  Widget dialogContent({required BuildContext context, required String type}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 52),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    "You don't have permission to do this",
                    style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 20), fontWeight: FontWeight.w600, color: const Color(0xff111111)),
                  ),
                ),
              ),
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.close,
                    color: Color(0xff1C1C1D),
                    size: 20,
                  )),
            ],
          ),
        ),
        const Divider(
          color: Color(0xffCECECE),
          height: 0,
          thickness: 1,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: mainFunctions.getWidgetWidth(width: 20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: mainFunctions.getWidgetHeight(height: 12),
              ),
              Text("You’ll need grant $type permission in the app settings page in order to complete this task. Visit the settings page and enable '$type permission' to grant this permission."),
              SizedBox(
                height: mainFunctions.getWidgetHeight(height: 12),
              ),
            ],
          ),
        )
      ],
    );
  }


  Widget drawerWidget({
    required BuildContext context,
  }) {
    return BlocBuilder<ReportsBloc, ReportsState>(
      builder: (BuildContext context, ReportsState reports) {
        if (reports is ReportsLoaded) {
          return Padding(
            padding: EdgeInsets.only(left: mainFunctions.getWidgetWidth(width: 100.0)),
            child: Drawer(
              width: mainFunctions.getWidgetWidth(width: 346),
              backgroundColor: Colors.white,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(24),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: mainFunctions.getWidgetHeight(height: 20),
                ),
                child: ListView(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: mainFunctions.getWidgetWidth(width: 20),
                      ),
                      child: SizedBox(
                        height: mainFunctions.getWidgetHeight(height: 28),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Filter',
                              style: TextStyle(
                                fontSize: mainFunctions.getTextSize(fontSize: 24),
                                fontWeight: FontWeight.w600,
                                color: const Color(0xff111111),
                              ),
                            ),
                            GestureDetector(
                                onTap: () {
                                  Scaffold.of(context).closeDrawer();
                                  context.read<ReportsBloc>().add(const LocationSelectionAllEvent(isAllCheck: true));
                                  context.read<ReportsBloc>().add(const CalenderSelectionEvent(startDate: null, endDate: null));
                                  context.read<ReportsBloc>().add(const ReportsFilterEvent());
                                },
                                child: Text(
                                  "Clear All",
                                  style: TextStyle(
                                    fontSize: mainFunctions.getTextSize(fontSize: 14),
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xff0C3788),
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: mainFunctions.getWidgetHeight(height: 12)),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: mainFunctions.getWidgetWidth(width: 20),
                      ),
                      child: SizedBox(
                        height: mainFunctions.getWidgetHeight(height: 50),
                        child: Text(
                          "Select categories that you want to see inside the table",
                          style: TextStyle(
                            fontSize: mainFunctions.getTextSize(fontSize: 13),
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff666666),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: mainFunctions.getWidgetHeight(height: 18)),
                    const Divider(
                      height: 0,
                      thickness: 1,
                      color: Color(0xffD0D0D0),
                    ),
                    SizedBox(height: mainFunctions.getWidgetHeight(height: 20)),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: mainFunctions.getWidgetWidth(width: 20),
                      ),
                      child: SizedBox(
                        height: mainFunctions.getWidgetHeight(height: 72),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Date range",
                              style: TextStyle(
                                fontSize: mainFunctions.getTextSize(fontSize: 15),
                                fontWeight: FontWeight.w600,
                                color: const Color(0xff111111),
                              ),
                            ),
                            SizedBox(
                              height: mainFunctions.getWidgetHeight(height: 10),
                            ),
                            SizedBox(
                              height: mainFunctions.getWidgetHeight(height: 38),
                              child: TextFormField(
                                controller: mainVariables.reportsVariables.filterController,
                                style: TextStyle(fontWeight: FontWeight.w500, fontSize: mainFunctions.getTextSize(fontSize: 15), color: mainColors.blackColor),
                                readOnly: true,
                                onTap: () {
                                  context.read<ReportsBloc>().add(const CalenderEnablingEvent());
                                },
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.only(left: 15),
                                  fillColor: const Color(0xFFEEEEEF),
                                  filled: true,
                                  suffixIcon: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: mainFunctions.getWidgetWidth(width: 7.0),
                                      vertical: mainFunctions.getWidgetHeight(height: 7.0),
                                    ),
                                    child: Image.asset(
                                      "assets/reports/calender_suffix.png",
                                      height: mainFunctions.getWidgetHeight(height: 24),
                                      width: mainFunctions.getWidgetWidth(width: 24),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: const BorderSide(color: Color(0XFFEDEDED))),
                                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: const BorderSide(color: Color(0XFFEDEDED))),
                                  disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: const BorderSide(color: Color(0XFFEDEDED))),
                                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: const BorderSide(color: Color(0XFFEDEDED))),
                                  focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: const BorderSide(color: Color(0XFFEDEDED))),
                                  errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: const BorderSide(color: Color(0XFFEDEDED))),
                                  hintText: "DD-MM-YYYY  -  DD-MM-YYYY",
                                  hintStyle: TextStyle(color: const Color(0XFFAFAFAF), fontSize: mainFunctions.getTextSize(fontSize: 14), fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: mainFunctions.getWidgetHeight(height: 16),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: mainFunctions.getWidgetWidth(width: 20),
                      ),
                      child: AnimatedCrossFade(
                        firstChild: Container(
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
                            selectionMode: DateRangePickerSelectionMode.range,
                            startRangeSelectionColor: const Color(0xff0C3788),
                            endRangeSelectionColor: const Color(0xff0C3788),
                            initialSelectedRange: PickerDateRange(
                              mainVariables.reportsVariables.filterSelectedStartDate ?? DateTime.now(),
                              mainVariables.reportsVariables.filterSelectedEndDate ?? DateTime.now(),
                            ),
                            cancelText: "CLEAR",
                            backgroundColor: Colors.white,
                            toggleDaySelection: true,
                            showNavigationArrow: true,
                            headerHeight: 50,
                            showActionButtons: true,
                            headerStyle: DateRangePickerHeaderStyle(
                              textAlign: TextAlign.center,
                              backgroundColor: mainColors.headingBlueColor,
                              textStyle: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                            onCancel: () {
                              context.read<ReportsBloc>().add(const CalenderEnablingEvent());
                              context.read<ReportsBloc>().add(const CalenderSelectionEvent(startDate: null, endDate: null));
                            },
                            onSubmit: (value) {
                              context.read<ReportsBloc>().add(const CalenderEnablingEvent());
                            },
                            onSelectionChanged: (value) {
                              PickerDateRange argValue = value.value;
                              context.read<ReportsBloc>().add(CalenderSelectionEvent(startDate: argValue.startDate, endDate: argValue.endDate));
                            },
                            showTodayButton: false,
                            monthFormat: "MMMM",
                            monthViewSettings: const DateRangePickerMonthViewSettings(
                              firstDayOfWeek: 1,
                              dayFormat: "EE",
                              viewHeaderHeight: 50,
                            ),
                            view: DateRangePickerView.month,
                          ),
                        ),
                        secondChild: const SizedBox(),
                        crossFadeState: mainVariables.reportsVariables.filterCalenderEnabled ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                        duration: const Duration(milliseconds: 500),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: mainFunctions.getWidgetWidth(width: 20),
                      ),
                      child: Text(
                        "Locations",
                        style: TextStyle(
                          fontSize: mainFunctions.getTextSize(fontSize: 15),
                          fontWeight: FontWeight.w600,
                          color: const Color(0xff000000),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: mainFunctions.getWidgetHeight(height: 16),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: mainFunctions.getWidgetWidth(width: 20),
                      ),
                      child: CheckboxListTile(
                        contentPadding: EdgeInsets.zero,
                        value: mainVariables.reportsVariables.selectAllEnabled,
                        activeColor: const Color(0xff0C3788),
                        onChanged: (value) {
                          context.read<ReportsBloc>().add(LocationSelectionAllEvent(isAllCheck: value ?? false));
                        },
                        title: Text(
                          "All",
                          style: TextStyle(
                            fontSize: mainFunctions.getTextSize(fontSize: 15),
                            fontWeight: FontWeight.w600,
                            color: const Color(0xff000000),
                          ),
                        ),
                        checkboxShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                    ),
                    const Divider(
                      height: 0,
                      thickness: 1,
                      color: Color(0xffEDEDED),
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemCount: mainVariables.stockMovementVariables.senderInfo.locationDropDownList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: mainFunctions.getWidgetWidth(width: 20),
                                ),
                                child: CheckboxListTile(
                                  contentPadding: EdgeInsets.zero,
                                  value: mainVariables.reportsVariables.locationSelectEnabledList[index],
                                  activeColor: const Color(0xff0C3788),
                                  onChanged: (value) {
                                    context.read<ReportsBloc>().add(LocationSelectionSingleEvent(selectedIndex: index, selectedIndexValue: value ?? false));
                                  },
                                  title: Text(
                                    mainVariables.stockMovementVariables.senderInfo.locationDropDownList[index].name.toUpperCase(),
                                    style: TextStyle(
                                      fontSize: mainFunctions.getTextSize(fontSize: 15),
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xff000000),
                                    ),
                                  ),
                                  checkboxShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                  controlAffinity: ListTileControlAffinity.leading,
                                ),
                              ),
                              const Divider(
                                height: 0,
                                thickness: 1,
                                color: Color(0xffEDEDED),
                              ),
                            ],
                          );
                        }),
                    const Divider(
                      height: 0,
                      thickness: 1,
                      color: Color(0xffEDEDED),
                    ),
                    SizedBox(
                      height: mainFunctions.getWidgetHeight(height: 30),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: mainFunctions.getWidgetWidth(width: 20),
                      ),
                      child: SizedBox(
                        height: mainFunctions.getWidgetHeight(height: 44),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Obx(() => Text(
                                      "${mainVariables.reportsVariables.selectedCount.value} Selected",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: mainFunctions.getTextSize(fontSize: 14),
                                        color: const Color(0xff111111),
                                      ),
                                    )),
                                Text(
                                  "${mainVariables.stockMovementVariables.senderInfo.locationDropDownList.length + 1} Total Filters",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: mainFunctions.getTextSize(fontSize: 12),
                                    color: const Color(0xff8C8C8C),
                                  ),
                                ),
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                Scaffold.of(context).closeDrawer();
                                context.read<ReportsBloc>().add(const ReportsFilterEvent());
                              },
                              child: Material(
                                elevation: 0,
                                borderRadius: BorderRadius.circular(4),
                                clipBehavior: Clip.antiAlias,
                                child: Container(
                                  width: mainFunctions.getWidgetHeight(height: 121),
                                  height: mainFunctions.getWidgetHeight(height: 40),
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0XFF0C3788),
                                          Color(0XFFBC0044),
                                        ],
                                      ),
                                      shape: BoxShape.rectangle),
                                  child: Text("Save Changes", textAlign: TextAlign.center, style: TextStyle(color: const Color(0xffffffff), fontSize: mainFunctions.getTextSize(fontSize: 14), fontWeight: FontWeight.w500)),
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
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Widget drawerTransitWidget({
    required BuildContext context,
  }) {
    return BlocBuilder<TransitBloc, TransitState>(
      builder: (BuildContext context, TransitState transit) {
        if (transit is TransitLoaded) {
          return Padding(
            padding: EdgeInsets.only(left: mainFunctions.getWidgetWidth(width: 100.0)),
            child: Drawer(
              width: mainFunctions.getWidgetWidth(width: 346),
              backgroundColor: Colors.white,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(24),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: mainFunctions.getWidgetHeight(height: 20),
                ),
                child: ListView(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: mainFunctions.getWidgetWidth(width: 20),
                      ),
                      child: SizedBox(
                        height: mainFunctions.getWidgetHeight(height: 28),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Filter',
                              style: TextStyle(
                                fontSize: mainFunctions.getTextSize(fontSize: 24),
                                fontWeight: FontWeight.w600,
                                color: const Color(0xff111111),
                              ),
                            ),
                            GestureDetector(
                                onTap: () {
                                  Scaffold.of(context).closeDrawer();
                                  context.read<TransitBloc>().add(const LocationSelectionAllTransitEvent(isAllCheck: true));
                                  context.read<TransitBloc>().add(const CalenderSelectionTransitEvent(startDate: null, endDate: null));
                                  context.read<TransitBloc>().add(const TransitFilterEvent());
                                },
                                child: Text(
                                  "Clear All",
                                  style: TextStyle(
                                    fontSize: mainFunctions.getTextSize(fontSize: 14),
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xff0C3788),
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: mainFunctions.getWidgetHeight(height: 12)),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: mainFunctions.getWidgetWidth(width: 20),
                      ),
                      child: SizedBox(
                        height: mainFunctions.getWidgetHeight(height: 50),
                        child: Text(
                          "Select categories that you want to see inside the table",
                          style: TextStyle(
                            fontSize: mainFunctions.getTextSize(fontSize: 13),
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff666666),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: mainFunctions.getWidgetHeight(height: 18)),
                    const Divider(
                      height: 0,
                      thickness: 1,
                      color: Color(0xffD0D0D0),
                    ),
                    SizedBox(height: mainFunctions.getWidgetHeight(height: 20)),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: mainFunctions.getWidgetWidth(width: 20),
                      ),
                      child: SizedBox(
                        height: mainFunctions.getWidgetHeight(height: 72),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Date Range",
                              style: TextStyle(
                                fontSize: mainFunctions.getTextSize(fontSize: 15),
                                fontWeight: FontWeight.w600,
                                color: const Color(0xff111111),
                              ),
                            ),
                            SizedBox(
                              height: mainFunctions.getWidgetHeight(height: 10),
                            ),
                            SizedBox(
                              height: mainFunctions.getWidgetHeight(height: 38),
                              child: TextFormField(
                                controller: mainVariables.transitVariables.filterController,
                                style: TextStyle(fontWeight: FontWeight.w500, fontSize: mainFunctions.getTextSize(fontSize: 15), color: mainColors.blackColor),
                                readOnly: true,
                                onTap: () {
                                  context.read<TransitBloc>().add(const CalenderEnablingTransitEvent());
                                },
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.only(left: 15),
                                  fillColor: const Color(0xFFEEEEEF),
                                  filled: true,
                                  suffixIcon: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: mainFunctions.getWidgetWidth(width: 7.0),
                                      vertical: mainFunctions.getWidgetHeight(height: 7.0),
                                    ),
                                    child: Image.asset(
                                      "assets/reports/calender_suffix.png",
                                      height: mainFunctions.getWidgetHeight(height: 24),
                                      width: mainFunctions.getWidgetWidth(width: 24),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: const BorderSide(color: Color(0XFFEDEDED))),
                                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: const BorderSide(color: Color(0XFFEDEDED))),
                                  disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: const BorderSide(color: Color(0XFFEDEDED))),
                                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: const BorderSide(color: Color(0XFFEDEDED))),
                                  focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: const BorderSide(color: Color(0XFFEDEDED))),
                                  errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: const BorderSide(color: Color(0XFFEDEDED))),
                                  hintText: "DD-MM-YYYY  -  DD-MM-YYYY",
                                  hintStyle: TextStyle(color: const Color(0XFFAFAFAF), fontSize: mainFunctions.getTextSize(fontSize: 14), fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: mainFunctions.getWidgetHeight(height: 16),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: mainFunctions.getWidgetWidth(width: 20),
                      ),
                      child: AnimatedCrossFade(
                        firstChild: Container(
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
                            selectionMode: DateRangePickerSelectionMode.range,
                            startRangeSelectionColor: const Color(0xff0C3788),
                            endRangeSelectionColor: const Color(0xff0C3788),
                            initialSelectedRange: PickerDateRange(
                              mainVariables.transitVariables.filterSelectedStartDate ?? DateTime.now(),
                              mainVariables.transitVariables.filterSelectedEndDate ?? DateTime.now(),
                            ),
                            cancelText: "CLEAR",
                            backgroundColor: Colors.white,
                            toggleDaySelection: true,
                            showNavigationArrow: true,
                            headerHeight: 50,
                            showActionButtons: true,
                            headerStyle: DateRangePickerHeaderStyle(
                              textAlign: TextAlign.center,
                              backgroundColor: mainColors.headingBlueColor,
                              textStyle: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                            onCancel: () {
                              context.read<TransitBloc>().add(const CalenderEnablingTransitEvent());
                              context.read<TransitBloc>().add(const CalenderSelectionTransitEvent(startDate: null, endDate: null));
                            },
                            onSubmit: (value) {
                              context.read<TransitBloc>().add(const CalenderEnablingTransitEvent());
                            },
                            onSelectionChanged: (value) {
                              PickerDateRange argValue = value.value;
                              context.read<TransitBloc>().add(CalenderSelectionTransitEvent(startDate: argValue.startDate, endDate: argValue.endDate));
                            },
                            showTodayButton: false,
                            monthFormat: "MMMM",
                            monthViewSettings: const DateRangePickerMonthViewSettings(
                              firstDayOfWeek: 1,
                              dayFormat: "EE",
                              viewHeaderHeight: 50,
                            ),
                            view: DateRangePickerView.month,
                          ),
                        ),
                        secondChild: const SizedBox(),
                        crossFadeState: mainVariables.transitVariables.filterCalenderEnabled ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                        duration: const Duration(milliseconds: 500),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: mainFunctions.getWidgetWidth(width: 20),
                      ),
                      child: Text(
                        "Locations",
                        style: TextStyle(
                          fontSize: mainFunctions.getTextSize(fontSize: 15),
                          fontWeight: FontWeight.w600,
                          color: const Color(0xff000000),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: mainFunctions.getWidgetHeight(height: 16),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: mainFunctions.getWidgetWidth(width: 20),
                      ),
                      child: CheckboxListTile(
                        contentPadding: EdgeInsets.zero,
                        value: mainVariables.transitVariables.selectAllEnabled,
                        activeColor: const Color(0xff0C3788),
                        onChanged: (value) {
                          context.read<TransitBloc>().add(LocationSelectionAllTransitEvent(isAllCheck: value ?? false));
                        },
                        title: Text(
                          "All",
                          style: TextStyle(
                            fontSize: mainFunctions.getTextSize(fontSize: 15),
                            fontWeight: FontWeight.w600,
                            color: const Color(0xff000000),
                          ),
                        ),
                        checkboxShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                    ),
                    const Divider(
                      height: 0,
                      thickness: 1,
                      color: Color(0xffEDEDED),
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemCount: mainVariables.stockMovementVariables.senderInfo.locationDropDownList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: mainFunctions.getWidgetWidth(width: 20),
                                ),
                                child: CheckboxListTile(
                                  contentPadding: EdgeInsets.zero,
                                  value: mainVariables.transitVariables.locationSelectEnabledList[index],
                                  activeColor: const Color(0xff0C3788),
                                  onChanged: (value) {
                                    context.read<TransitBloc>().add(LocationSelectionSingleTransitEvent(selectedIndex: index, selectedIndexValue: value ?? false));
                                  },
                                  title: Text(
                                    mainVariables.stockMovementVariables.senderInfo.locationDropDownList[index].name.toUpperCase(),
                                    style: TextStyle(
                                      fontSize: mainFunctions.getTextSize(fontSize: 15),
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xff000000),
                                    ),
                                  ),
                                  checkboxShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                  controlAffinity: ListTileControlAffinity.leading,
                                ),
                              ),
                              const Divider(
                                height: 0,
                                thickness: 1,
                                color: Color(0xffEDEDED),
                              ),
                            ],
                          );
                        }),
                    const Divider(
                      height: 0,
                      thickness: 1,
                      color: Color(0xffEDEDED),
                    ),
                    SizedBox(
                      height: mainFunctions.getWidgetHeight(height: 30),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: mainFunctions.getWidgetWidth(width: 20),
                      ),
                      child: SizedBox(
                        height: mainFunctions.getWidgetHeight(height: 44),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Obx(() => Text(
                                      "${mainVariables.transitVariables.selectedCount.value} Selected",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: mainFunctions.getTextSize(fontSize: 14),
                                        color: const Color(0xff111111),
                                      ),
                                    )),
                                Text(
                                  "${mainVariables.stockMovementVariables.senderInfo.locationDropDownList.length + 1} Total Filters",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: mainFunctions.getTextSize(fontSize: 12),
                                    color: const Color(0xff8C8C8C),
                                  ),
                                ),
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                Scaffold.of(context).closeDrawer();
                                context.read<TransitBloc>().add(const TransitFilterEvent());
                              },
                              child: Material(
                                elevation: 0,
                                borderRadius: BorderRadius.circular(4),
                                clipBehavior: Clip.antiAlias,
                                child: Container(
                                  width: mainFunctions.getWidgetHeight(height: 121),
                                  height: mainFunctions.getWidgetHeight(height: 40),
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0XFF0C3788),
                                          Color(0XFFBC0044),
                                        ],
                                      ),
                                      shape: BoxShape.rectangle),
                                  child: Text("Save Changes", textAlign: TextAlign.center, style: TextStyle(color: const Color(0xffffffff), fontSize: mainFunctions.getTextSize(fontSize: 14), fontWeight: FontWeight.w500)),
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
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  void showAlertDialog({
    required BuildContext context,
    required Widget content,
    required bool isDismissible,
  }) {
    showDialog(
      barrierDismissible: isDismissible,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          backgroundColor: const Color(0xffE5E7EB),
          contentPadding: EdgeInsets.zero,
          content: content,
        );
      },
    );
  }

  Widget selectionTypeContent({
    required BuildContext context,
    required StateSetter modelSetState,
  }) {
    return Container(
      width: mainFunctions.getWidgetWidth(width: 450),
      padding: EdgeInsets.symmetric(
        horizontal: mainFunctions.getWidgetHeight(height: 12),
        vertical: mainFunctions.getWidgetWidth(width: 12),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color(0xffffffff),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: mainFunctions.getWidgetHeight(height: 10),
          ),
          Row(
            children: [
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(
                    Icons.close,
                    color: Color(0xff1C1C1D),
                    size: 20,
                  )),
              Expanded(
                child: Center(
                  child: Text(
                    'Select Type',
                    style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 16), fontWeight: FontWeight.w600, color: const Color(0xff111111)),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: mainFunctions.getWidgetHeight(height: 14)),
          const Divider(
            color: Color(0xffCECECE),
            height: 0,
            thickness: 1,
          ),
          SizedBox(height: mainFunctions.getWidgetHeight(height: 14)),
          InkWell(
            onTap: () async {
              Navigator.pop(context);
              XFile? returnFile = await mainFunctions.cameraImage(context: context);
              mainVariables.manageVariables.addProduct.selectedImage = File(returnFile!.path);
              mainVariables.homeVariables.selectedImage = File(returnFile.path);
              List<String> stringsList = mainVariables.manageVariables.addProduct.selectedImage!.path.split("/");
              mainVariables.manageVariables.addProduct.selectedFileName = stringsList[stringsList.length - 1];
              mainVariables.homeVariables.selectedFileName = stringsList[stringsList.length - 1];
              modelSetState(() {});
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: mainFunctions.getWidgetWidth(width: 15),
                    vertical: mainFunctions.getWidgetHeight(height: 15),
                  ),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xffE4E5E8),
                  ),
                  child: Image.asset(
                    "assets/home/camera.png",
                    height: mainFunctions.getWidgetHeight(height: 20),
                    width: mainFunctions.getWidgetWidth(width: 20),
                  ),
                ),
                SizedBox(
                  width: mainFunctions.getWidgetWidth(width: 15),
                ),
                Expanded(
                  child: Text(
                    "Camera",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: mainFunctions.getTextSize(fontSize: 14)),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: mainFunctions.getWidgetHeight(height: 14)),
          InkWell(
            onTap: () async {
              Navigator.pop(context);
              XFile? returnFile = await mainFunctions.galleryImage(context: context);
              mainVariables.manageVariables.addProduct.selectedImage = File(returnFile!.path);
              mainVariables.homeVariables.selectedImage = File(returnFile.path);
              List<String> stringsList = mainVariables.manageVariables.addProduct.selectedImage!.path.split("/");
              mainVariables.manageVariables.addProduct.selectedFileName = stringsList[stringsList.length - 1];
              mainVariables.homeVariables.selectedFileName = stringsList[stringsList.length - 1];
              modelSetState(() {});
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: mainFunctions.getWidgetWidth(width: 15),
                    vertical: mainFunctions.getWidgetHeight(height: 15),
                  ),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xffE4E5E8),
                  ),
                  child: Image.asset(
                    "assets/home/image_gallery.png",
                    height: mainFunctions.getWidgetHeight(height: 20),
                    width: mainFunctions.getWidgetWidth(width: 20),
                  ),
                ),
                SizedBox(
                  width: mainFunctions.getWidgetWidth(width: 15),
                ),
                Expanded(
                  child: Text(
                    "Gallery",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: mainFunctions.getTextSize(fontSize: 14)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget selectionTypeEditContent({
    required BuildContext context,
    required StateSetter modelSetState,
  }) {
    return Container(
      width: mainFunctions.getWidgetWidth(width: 450),
      padding: EdgeInsets.symmetric(
        horizontal: mainFunctions.getWidgetHeight(height: 12),
        vertical: mainFunctions.getWidgetWidth(width: 12),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color(0xffffffff),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: mainFunctions.getWidgetHeight(height: 10),
          ),
          Row(
            children: [
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(
                    Icons.close,
                    color: Color(0xff1C1C1D),
                    size: 20,
                  )),
              Expanded(
                child: Center(
                  child: Text(
                    'Select Type',
                    style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 16), fontWeight: FontWeight.w600, color: const Color(0xff111111)),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: mainFunctions.getWidgetHeight(height: 14)),
          const Divider(
            color: Color(0xffCECECE),
            height: 0,
            thickness: 1,
          ),
          SizedBox(height: mainFunctions.getWidgetHeight(height: 14)),
          InkWell(
            onTap: () async {
              Navigator.pop(context);
              XFile? returnFile = await mainFunctions.cameraImage(context: context);
              mainVariables.manageVariables.addProduct.selectedEditImage = File(returnFile!.path);
              List<String> stringsList = mainVariables.manageVariables.addProduct.selectedEditImage!.path.split("/");
              mainVariables.manageVariables.addProduct.selectedEditFileName = stringsList[stringsList.length - 1];
              modelSetState(() {});
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: mainFunctions.getWidgetWidth(width: 15),
                    vertical: mainFunctions.getWidgetHeight(height: 15),
                  ),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xffE4E5E8),
                  ),
                  child: Image.asset(
                    "assets/home/camera.png",
                    height: mainFunctions.getWidgetHeight(height: 20),
                    width: mainFunctions.getWidgetWidth(width: 20),
                  ),
                ),
                SizedBox(
                  width: mainFunctions.getWidgetWidth(width: 15),
                ),
                Expanded(
                  child: Text(
                    "Camera",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: mainFunctions.getTextSize(fontSize: 14)),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: mainFunctions.getWidgetHeight(height: 14)),
          InkWell(
            onTap: () async {
              Navigator.pop(context);
              XFile? returnFile = await mainFunctions.galleryImage(context: context);
              mainVariables.manageVariables.addProduct.selectedEditImage = File(returnFile!.path);
              List<String> stringsList = mainVariables.manageVariables.addProduct.selectedEditImage!.path.split("/");
              mainVariables.manageVariables.addProduct.selectedEditFileName = stringsList[stringsList.length - 1];
              modelSetState(() {});
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: mainFunctions.getWidgetWidth(width: 15),
                    vertical: mainFunctions.getWidgetHeight(height: 15),
                  ),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xffE4E5E8),
                  ),
                  child: Image.asset(
                    "assets/home/image_gallery.png",
                    height: mainFunctions.getWidgetHeight(height: 20),
                    width: mainFunctions.getWidgetWidth(width: 20),
                  ),
                ),
                SizedBox(
                  width: mainFunctions.getWidgetWidth(width: 15),
                ),
                Expanded(
                  child: Text(
                    "Gallery",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: mainFunctions.getTextSize(fontSize: 14)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget updateConsumptionContent({required BuildContext context}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          height: mainFunctions.getWidgetHeight(height: 111),
          margin: EdgeInsets.symmetric(horizontal: mainFunctions.getWidgetWidth(width: 23)),
          child: Center(
            child: Text(
              "Have you updated today's consumption?",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: mainFunctions.getTextSize(fontSize: 17),
                color: const Color(0xff181818),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Divider(
          color: const Color(0xff3C3C43).withOpacity(0.36),
          thickness: 0.33,
          height: 0,
        ),
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 44),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Center(
                  child: Text(
                    "No",
                    style: TextStyle(color: const Color(0xffFF484F), fontWeight: FontWeight.w600, fontSize: mainFunctions.getTextSize(fontSize: 16)),
                  ),
                ),
              )),
              VerticalDivider(
                color: const Color(0xff3C3C43).withOpacity(0.36),
                thickness: 0.33,
                width: 0,
              ),
              Expanded(
                child: InkWell(
                  onTap: () async {
                    Navigator.pop(context);
                    mainVariables.checkListVariables = CheckListVariables.fromJson({});
                    context.read<CheckListBloc>().add(const CheckListPageChangingEvent(index: 1));
                    mainVariables.checkListVariables.checkListSelectedIndex = 1;
                    mainVariables.generalVariables.railNavigateBackIndex = mainVariables.generalVariables.railNavigateIndex;
                    mainVariables.generalVariables.railNavigateIndex = 5;
                    mainVariables.railNavigationVariables.mainSelectedIndex = 5;
                    context.read<RailNavigationBloc>().add(const RailNavigationSelectedWidgetEvent());
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.setString("dialog_time", DateTime.now().toString());
                  },
                  child: Center(
                    child: Text(
                      "Yes",
                      style: TextStyle(color: const Color(0xff00931D), fontWeight: FontWeight.w600, fontSize: mainFunctions.getTextSize(fontSize: 16)),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class LoadingButton extends StatelessWidget {
  const LoadingButton({
    super.key,
    required this.status,
    required this.onTap,
    required this.text,
    this.height,
    this.width,
    this.fontSize,
    this.margin,
    this.padding,
    this.extraWidget,
  });

  final bool status;

  final String text;

  final double? fontSize;

  final double? width;

  final double? height;

  final EdgeInsetsGeometry? margin;

  final EdgeInsetsGeometry? padding;

  final VoidCallback onTap;

  final Widget? extraWidget;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: status ? null : onTap,
        child: Material(
          elevation: 0,
          borderRadius: BorderRadius.circular(30),
          clipBehavior: Clip.antiAlias,
          child: AnimatedContainer(
            width: status ? mainFunctions.getWidgetWidth(width: 58) : width ?? mainFunctions.getWidgetWidth(width: 200),
            height: status ? mainFunctions.getWidgetHeight(height: 58) : height ?? mainFunctions.getWidgetHeight(height: 58),
            alignment: Alignment.center,
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.all(5),
            margin: margin,
            decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0XFF0C3788),
                    Color(0XFFBC0044),
                  ],
                ),
                shape: status ? BoxShape.circle : BoxShape.rectangle),
            child: status
                ? const CircularProgressIndicator(color: Colors.white, strokeWidth: 3)
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      extraWidget ?? const SizedBox(),
                      extraWidget == null
                          ? const SizedBox()
                          : SizedBox(
                              width: mainFunctions.getWidgetWidth(width: 5),
                            ),
                      Text(text.trim(), textAlign: TextAlign.center, style: TextStyle(color: const Color(0xffffffff), fontSize: mainFunctions.getTextSize(fontSize: fontSize ?? 22), fontWeight: FontWeight.w600)),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

class LowerCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toLowerCase(),
      selection: newValue.selection,
    );
  }
}
