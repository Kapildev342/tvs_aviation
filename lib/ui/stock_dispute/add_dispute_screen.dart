import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_sticky_headers/table_sticky_headers.dart';
import 'package:tvsaviation/bloc/add_dispute/add_dispute_bloc.dart';
import 'package:tvsaviation/bloc/rail_navigation/rail_navigation_bloc.dart';
import 'package:tvsaviation/bloc/reports/reports_bloc.dart';
import 'package:tvsaviation/resources/constants.dart';
import 'package:tvsaviation/resources/widgets.dart';

class AddDisputeScreen extends StatefulWidget {
  static const String id = "add_dispute";
  const AddDisputeScreen({super.key});

  @override
  State<AddDisputeScreen> createState() => _AddDisputeScreenState();
}

class _AddDisputeScreenState extends State<AddDisputeScreen> {
  @override
  void initState() {
    mainVariables.addDisputeVariables.totalProducts = 0;
    mainVariables.addDisputeVariables.totalQuantity = 0;
    mainVariables.addDisputeVariables.commentsBar.text = "";
    if (mainVariables.generalVariables.currentPage.value == "resolution") {
      context.read<AddDisputeBloc>().add(const AddDisputeDetailsEvent());
    } else if (mainVariables.generalVariables.currentPage.value == "inventory") {
      context.read<AddDisputeBloc>().add(const AddDisputeDetailsEvent());
    } else {
      mainVariables.addDisputeVariables.totalProducts = mainVariables.stockDisputeVariables.sendData.products.length;
      for (int i = 0; i < mainVariables.stockDisputeVariables.sendData.products.length; i++) {
        mainVariables.addDisputeVariables.totalQuantity = (mainVariables.addDisputeVariables.totalQuantity + mainVariables.stockDisputeVariables.sendData.products[i].quantity).round();
      }
      context.read<AddDisputeBloc>().add(const AddDisputeInitialEvent());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvoked: (value) {
          if (mainVariables.generalVariables.currentPage.value == "resolution") {
            mainVariables.generalVariables.selectedTransTempId = "";
            mainVariables.generalVariables.currentPage.value = "";
            context.read<ReportsBloc>().add(const ReportsPageChangingEvent(index: 3));
            mainVariables.generalVariables.railNavigateBackIndex = mainVariables.generalVariables.railNavigateIndex;
            mainVariables.generalVariables.railNavigateIndex = 4;
            mainVariables.railNavigationVariables.mainSelectedIndex = 3;
            context.read<RailNavigationBloc>().add(const RailNavigationSelectedWidgetEvent());
          } else if (mainVariables.generalVariables.currentPage.value == "inventory") {
            mainVariables.generalVariables.selectedTransTempId = "";
            mainVariables.generalVariables.currentPage.value = "";
            context.read<ReportsBloc>().add(const ReportsPageChangingEvent(index: 0));
            mainVariables.generalVariables.railNavigateBackIndex = mainVariables.generalVariables.railNavigateIndex;
            mainVariables.generalVariables.railNavigateIndex = 1;
            mainVariables.railNavigationVariables.mainSelectedIndex = 1;
            context.read<RailNavigationBloc>().add(const RailNavigationSelectedWidgetEvent());
          } else {
            mainVariables.receivedStocksVariables.pageState = "";
            mainVariables.generalVariables.railNavigateIndex = mainVariables.generalVariables.railNavigateBackIndex;
            context.read<RailNavigationBloc>().add(const RailNavigationBackWidgetEvent());
          }
        },
        child: bodyWidget());
  }

  Widget bodyWidget() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: mainFunctions.getWidgetHeight(height: 20), horizontal: mainFunctions.getWidgetWidth(width: 20)),
      decoration: BoxDecoration(
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
                    if (mainVariables.generalVariables.currentPage.value == "resolution") {
                      mainVariables.generalVariables.selectedTransTempId = "";
                      mainVariables.generalVariables.currentPage.value = "";
                      context.read<ReportsBloc>().add(const ReportsPageChangingEvent(index: 3));
                      mainVariables.generalVariables.railNavigateBackIndex = mainVariables.generalVariables.railNavigateIndex;
                      mainVariables.generalVariables.railNavigateIndex = 4;
                      mainVariables.railNavigationVariables.mainSelectedIndex = 3;
                      context.read<RailNavigationBloc>().add(const RailNavigationSelectedWidgetEvent());
                    } else if (mainVariables.generalVariables.currentPage.value == "inventory") {
                      mainVariables.generalVariables.selectedTransTempId = "";
                      mainVariables.generalVariables.currentPage.value = "";
                      context.read<ReportsBloc>().add(const ReportsPageChangingEvent(index: 0));
                      mainVariables.generalVariables.railNavigateBackIndex = mainVariables.generalVariables.railNavigateIndex;
                      mainVariables.generalVariables.railNavigateIndex = 1;
                      mainVariables.railNavigationVariables.mainSelectedIndex = 1;
                      context.read<RailNavigationBloc>().add(const RailNavigationSelectedWidgetEvent());
                    } else {
                      mainVariables.receivedStocksVariables.pageState = "";
                      mainVariables.generalVariables.railNavigateIndex = mainVariables.generalVariables.railNavigateBackIndex;
                      context.read<RailNavigationBloc>().add(const RailNavigationBackWidgetEvent());
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: mainFunctions.getWidgetWidth(width: 20)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
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
                            ),
                          ],
                        ),
                        mainVariables.generalVariables.selectedTransId == ""
                            ? const SizedBox()
                            : InkWell(
                                onTap: () {
                                  mainVariables.generalVariables.currentPage.value = "resolution";
                                  mainVariables.generalVariables.railNavigateBackIndex = mainVariables.generalVariables.railNavigateIndex;
                                  mainVariables.generalVariables.railNavigateIndex = 9;
                                  mainVariables.receivedStocksVariables.pageState = "dispute";
                                  context.read<RailNavigationBloc>().add(const RailNavigationSelectedWidgetEvent());
                                },
                                child: Text(
                                  "Trans ID : ${mainVariables.generalVariables.selectedTransId}",
                                  style: mainTextStyle.normalTextStyle.copyWith(
                                    color: const Color(0xff007BFE),
                                    fontWeight: FontWeight.w600,
                                    fontSize: mainFunctions.getTextSize(fontSize: 18),
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
    return BlocConsumer<AddDisputeBloc, AddDisputeState>(
      listenWhen: (previous, current) {
        return previous != current;
      },
      buildWhen: (previous, current) {
        return previous != current;
      },
      listener: (BuildContext context, AddDisputeState addDispute) {
        if (addDispute is AddDisputeSuccess) {
          if (mainVariables.generalVariables.currentPage.value == "resolution") {
            mainVariables.generalVariables.selectedTransTempId = "";
            mainVariables.generalVariables.currentPage.value = "";
            context.read<ReportsBloc>().add(const ReportsPageChangingEvent(index: 3));
            mainVariables.generalVariables.railNavigateBackIndex = mainVariables.generalVariables.railNavigateIndex;
            mainVariables.generalVariables.railNavigateIndex = 4;
            mainVariables.railNavigationVariables.mainSelectedIndex = 3;
            context.read<RailNavigationBloc>().add(const RailNavigationSelectedWidgetEvent());
            setState(() {
              mainVariables.addDisputeVariables.loader = false;
            });
          } else if (mainVariables.generalVariables.currentPage.value == "inventory") {
            mainVariables.generalVariables.selectedTransTempId = "";
            mainVariables.generalVariables.currentPage.value = "";
            context.read<ReportsBloc>().add(const ReportsPageChangingEvent(index: 0));
            mainVariables.generalVariables.railNavigateBackIndex = mainVariables.generalVariables.railNavigateIndex;
            mainVariables.generalVariables.railNavigateIndex = 1;
            mainVariables.railNavigationVariables.mainSelectedIndex = 1;
            context.read<RailNavigationBloc>().add(const RailNavigationSelectedWidgetEvent());
            setState(() {
              mainVariables.addDisputeVariables.loader = false;
            });
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
            mainWidgets.flushBarWidget(context: context, message: addDispute.message);
            mainVariables.stockDisputeVariables.stockDisputeExit = false;
            setState(() {
              mainVariables.addDisputeVariables.loader = false;
            });
          }
        } else if (addDispute is AddDisputeFailure) {
          setState(() {
            mainVariables.addDisputeVariables.loader = false;
          });
          mainWidgets.flushBarWidget(context: context, message: addDispute.errorMessage);
        }
      },
      builder: (BuildContext context, AddDisputeState addDispute) {
        if (addDispute is AddDisputeLoaded) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: mainFunctions.getWidgetHeight(height: 355),
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
                                    initialValue: mainVariables.generalVariables.currentPage.value == "resolution" || mainVariables.generalVariables.currentPage.value == "inventory"
                                        ? mainVariables.addDisputeVariables.crewName
                                        : mainVariables.generalVariables.userData.firstName + mainVariables.generalVariables.userData.lastName,
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
                                  mainVariables.generalVariables.currentPage.value == "resolution" || mainVariables.generalVariables.currentPage.value == "inventory" ? "Dispute Id" : "Date",
                                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: mainFunctions.getTextSize(fontSize: 15), color: const Color(0xff111111)),
                                ),
                                SizedBox(
                                  height: mainFunctions.getWidgetHeight(height: 5),
                                ),
                                SizedBox(
                                  height: mainFunctions.getWidgetHeight(height: 43),
                                  child: TextFormField(
                                    initialValue: mainVariables.generalVariables.currentPage.value == "resolution" || mainVariables.generalVariables.currentPage.value == "inventory"
                                        ? mainVariables.addDisputeVariables.disputeId
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
                                    child: TextFormField(
                                        initialValue: mainVariables.generalVariables.currentPage.value == "resolution" || mainVariables.generalVariables.currentPage.value == "inventory"
                                            ? mainVariables.addDisputeVariables.location
                                            : mainVariables.stockDisputeVariables.senderLocationChoose.name,
                                        style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 13), fontWeight: FontWeight.w600, color: const Color(0xff111111), overflow: TextOverflow.ellipsis),
                                        maxLines: 1,
                                        readOnly: true,
                                        decoration: InputDecoration(
                                          fillColor: const Color(0xffFFFFFF),
                                          filled: true,
                                          contentPadding: EdgeInsets.only(left: mainFunctions.getWidgetWidth(width: 12)),
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
                                        )),
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
                                    child: TextFormField(
                                        initialValue: mainVariables.generalVariables.currentPage.value == "resolution" || mainVariables.generalVariables.currentPage.value == "inventory"
                                            ? mainVariables.addDisputeVariables.disputeReason
                                            : mainVariables.stockDisputeVariables.senderDisputeChoose.name,
                                        style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 13), fontWeight: FontWeight.w600, color: const Color(0xff111111), overflow: TextOverflow.ellipsis),
                                        maxLines: 1,
                                        readOnly: true,
                                        decoration: InputDecoration(
                                          fillColor: const Color(0xffFFFFFF),
                                          filled: true,
                                          contentPadding: EdgeInsets.only(left: mainFunctions.getWidgetWidth(width: 12)),
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
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: mainFunctions.getWidgetHeight(height: 23),
                    ),
                    SizedBox(
                      height: mainFunctions.getWidgetHeight(height: 134),
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
                                  controller: mainVariables.addDisputeVariables.commentsBar,
                                  style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 13), fontWeight: FontWeight.w600, color: const Color(0xff111111), overflow: TextOverflow.ellipsis),
                                  readOnly: mainVariables.generalVariables.currentPage.value == "resolution" || mainVariables.generalVariables.currentPage.value == "inventory" ? true : false,
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
                          mainVariables.generalVariables.currentPage.value == "resolution" || mainVariables.generalVariables.currentPage.value == "inventory" ? SizedBox(width: mainFunctions.getWidgetWidth(width: 71)) : const SizedBox(),
                          mainVariables.generalVariables.currentPage.value == "resolution" || mainVariables.generalVariables.currentPage.value == "inventory"
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
                                        style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 13), fontWeight: FontWeight.w600, color: const Color(0xff111111), overflow: TextOverflow.ellipsis),
                                        maxLines: 4,
                                        keyboardType: TextInputType.text,
                                        readOnly: mainVariables.generalVariables.userData.role != "admin" || mainVariables.addDisputeVariables.isResolved,
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
                    ),
                  ],
                ),
              ),
              SizedBox(height: mainFunctions.getWidgetHeight(height: 30)),
              Container(
                height: mainFunctions.getWidgetHeight(height: 525),
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
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: mainFunctions.getWidgetHeight(height: 52),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Inventory",
                            style: TextStyle(
                              fontSize: mainFunctions.getTextSize(fontSize: 20),
                              color: mainColors.headingBlueColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "Total Products : ${mainVariables.addDisputeVariables.totalProducts} | Total Qty : ${mainVariables.addDisputeVariables.totalQuantity}",
                            style: TextStyle(
                              fontSize: mainFunctions.getTextSize(fontSize: 15),
                              color: const Color(0xff111111),
                              fontWeight: FontWeight.w600,
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
                      height: mainFunctions.getWidgetHeight(height: 445),
                      child: StickyHeadersTable(
                        columnsLength: mainVariables.addDisputeVariables.stockDisputeInventory.tableHeading.length,
                        rowsLength: mainVariables.addDisputeVariables.stockDisputeInventory.tableData.length,
                        showHorizontalScrollbar: false,
                        showVerticalScrollbar: false,
                        columnsTitleBuilder: (int columnIndex) {
                          return Center(
                            child: Text(
                              mainVariables.addDisputeVariables.stockDisputeInventory.tableHeading[columnIndex],
                              maxLines: 2,
                              style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 12), overflow: TextOverflow.ellipsis, fontWeight: FontWeight.w600),
                              textAlign: TextAlign.center,
                            ),
                          );
                        },
                        rowsTitleBuilder: (int rowIndex) {
                          return Center(
                            child: Text(
                              (rowIndex + 1) < 10 ? "0${rowIndex + 1}" : "${rowIndex + 1}",
                              maxLines: 2,
                              style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 12), overflow: TextOverflow.ellipsis, fontWeight: FontWeight.normal),
                            ),
                          );
                        },
                        contentCellBuilder: (int columnIndex, int rowIndex) {
                          return columnIndex == 0
                              ? const SizedBox()
                              : columnIndex == 6
                                  ? Center(
                                      child: Text(
                                        mainVariables.generalVariables.currentPage.value == "resolution" || mainVariables.generalVariables.currentPage.value == "inventory"
                                            ? mainVariables.addDisputeVariables.stockDisputeInventory.tableData[rowIndex][columnIndex]
                                            : mainVariables.addDisputeVariables.stockDisputeInventory.tableData[rowIndex][columnIndex + 1],
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 12), overflow: TextOverflow.ellipsis, fontWeight: FontWeight.normal),
                                      ),
                                    )
                                  : Center(
                                      child: Text(
                                        mainVariables.addDisputeVariables.stockDisputeInventory.tableData[rowIndex][columnIndex],
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
                                  mainFunctions.getWidgetWidth(width: 140),
                                  mainFunctions.getWidgetWidth(width: 140),
                                  mainFunctions.getWidgetWidth(width: 130),
                                  mainFunctions.getWidgetWidth(width: 130),
                                  mainFunctions.getWidgetWidth(width: 80),
                                ]
                              : [
                                  mainFunctions.getWidgetHeight(height: 0),
                                  mainFunctions.getWidgetHeight(height: 0),
                                  mainFunctions.getWidgetHeight(height: 190),
                                  mainFunctions.getWidgetHeight(height: 190),
                                  mainFunctions.getWidgetHeight(height: 190),
                                  mainFunctions.getWidgetHeight(height: 190),
                                  mainFunctions.getWidgetHeight(height: 140),
                                ],
                          contentCellHeight: 40,
                          stickyLegendWidth: 40,
                          stickyLegendHeight: 40,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: mainFunctions.getWidgetHeight(height: 15),
              ),
              mainVariables.generalVariables.currentPage.value == "resolution" || mainVariables.generalVariables.currentPage.value == "inventory"
                  ? mainVariables.generalVariables.userData.role == "admin"
                      ? mainVariables.addDisputeVariables.isResolved
                          ? const SizedBox()
                          : LoadingButton(
                              status: mainVariables.addDisputeVariables.loader,
                              onTap: () {
                                setState(() {
                                  mainVariables.addDisputeVariables.loader = true;
                                });
                                context.read<AddDisputeBloc>().add(const AddDisputeAdminCommentsEvent());
                              },
                              text: "Resolve",
                              height: 42,
                              width: 132,
                              fontSize: mainFunctions.getTextSize(fontSize: 16),
                            )
                      : const SizedBox()
                  : LoadingButton(
                      status: mainVariables.addDisputeVariables.loader,
                      onTap: () {
                        setState(() {
                          mainVariables.addDisputeVariables.loader = true;
                        });
                        if (mainVariables.addDisputeVariables.commentsBar.text == "") {
                          mainWidgets.flushBarWidget(context: context, message: "Please Add Comments");
                          setState(() {
                            mainVariables.addDisputeVariables.loader = false;
                          });
                        } else {
                          mainVariables.stockDisputeVariables.sendData.comments = mainVariables.addDisputeVariables.commentsBar.text;
                          context.read<AddDisputeBloc>().add(const AddDisputeCreateEvent());
                        }
                      },
                      text: "Confirm",
                      height: 42,
                      width: 132,
                      fontSize: mainFunctions.getTextSize(fontSize: 16),
                    ),
              SizedBox(height: mainFunctions.getWidgetHeight(height: 20)),
            ],
          );
        } else if (addDispute is AddDisputeLoading) {
          return SizedBox(
            height: mainVariables.generalVariables.height,
            width: mainVariables.generalVariables.width,
            child: const Center(child: CircularProgressIndicator()),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
