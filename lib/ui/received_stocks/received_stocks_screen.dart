import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_sticky_headers/table_sticky_headers.dart';
import 'package:tvsaviation/bloc/rail_navigation/rail_navigation_bloc.dart';
import 'package:tvsaviation/bloc/received_stocks/received_stocks_bloc.dart';
import 'package:tvsaviation/bloc/reports/reports_bloc.dart';
import 'package:tvsaviation/resources/constants.dart';
import 'package:tvsaviation/resources/drop_down_lib/dropdown_textfield.dart';
import 'package:tvsaviation/resources/widgets.dart';

class ReceivedStocksScreen extends StatefulWidget {
  static const String id = "received_stocks";
  const ReceivedStocksScreen({super.key});

  @override
  State<ReceivedStocksScreen> createState() => _ReceivedStocksScreenState();
}

class _ReceivedStocksScreenState extends State<ReceivedStocksScreen> {
  String buttonString = "Continue";

  @override
  void initState() {
    context.read<ReceivedStocksBloc>().add(const ReceivedStocksInitial());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvoked: (value) {
          mainVariables.receivedStocksVariables.disputePageOpened = false;
          if (mainVariables.receivedStocksVariables.pageState == "transit_confirm") {
            setState(() {
              mainVariables.receivedStocksVariables.pageState = "transit";
              buttonString = "Continue";
            });
          } else if (mainVariables.receivedStocksVariables.pageState == "transit") {
            mainVariables.generalVariables.railNavigateIndex = mainVariables.generalVariables.railNavigateBackIndex;
            mainVariables.generalVariables.railNavigateIndex = 11;
            context.read<RailNavigationBloc>().add(const RailNavigationSelectedWidgetEvent());
          } else if (mainVariables.receivedStocksVariables.pageState == "dispute") {
            mainVariables.generalVariables.railNavigateBackIndex = mainVariables.generalVariables.railNavigateIndex;
            mainVariables.generalVariables.railNavigateIndex = 13;
            context.read<RailNavigationBloc>().add(const RailNavigationSelectedWidgetEvent());
          } else {
            context.read<ReportsBloc>().add(ReportsPageChangingEvent(index: mainVariables.reportsVariables.reportsSelectedIndex));
            mainVariables.generalVariables.railNavigateBackIndex = mainVariables.generalVariables.railNavigateIndex;
            mainVariables.generalVariables.railNavigateIndex = 4;
            mainVariables.railNavigationVariables.mainSelectedIndex = 4;
            context.read<RailNavigationBloc>().add(const RailNavigationSelectedWidgetEvent());
          }
        },
        child: bodyWidget());
  }

  Widget bodyWidget() {
    return BlocConsumer<ReceivedStocksBloc, ReceivedStocksState>(
      listener: (BuildContext context, ReceivedStocksState receivedStocks) {
        if (receivedStocks is ReceivedStocksFailure) {
          mainWidgets.flushBarWidget(context: context, message: receivedStocks.errorMessage);
          setState(() {
            mainVariables.receivedStocksVariables.continueLoader = false;
          });
        } else if (receivedStocks is ReceivedStocksSuccess) {
          mainVariables.generalVariables.currentPage.value = "";
          mainVariables.generalVariables.selectedTransId = "";
          mainVariables.generalVariables.railNavigateBackIndex = mainVariables.generalVariables.railNavigateIndex;
          mainVariables.generalVariables.railNavigateIndex = 0;
          context.read<RailNavigationBloc>().add(const RailNavigationSelectedWidgetEvent());
          mainWidgets.flushBarWidget(context: context, message: receivedStocks.message);
          setState(() {
            mainVariables.receivedStocksVariables.continueLoader = false;
          });
        }
      },
      builder: (BuildContext context, ReceivedStocksState receivedStocks) {
        if (receivedStocks is ReceivedStocksLoaded) {
          return SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: mainFunctions.getWidgetHeight(height: 20), horizontal: mainFunctions.getWidgetWidth(width: 20)),
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
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
                            mainVariables.receivedStocksVariables.disputePageOpened = false;
                            if (mainVariables.receivedStocksVariables.pageState == "transit_confirm") {
                              setState(() {
                                mainVariables.receivedStocksVariables.pageState = "transit";
                                buttonString = "Continue";
                              });
                            } else if (mainVariables.receivedStocksVariables.pageState == "transit") {
                              mainVariables.generalVariables.railNavigateIndex = mainVariables.generalVariables.railNavigateBackIndex;
                              mainVariables.generalVariables.railNavigateIndex = 11;
                              context.read<RailNavigationBloc>().add(const RailNavigationSelectedWidgetEvent());
                            } else if (mainVariables.receivedStocksVariables.pageState == "dispute") {
                              mainVariables.generalVariables.railNavigateBackIndex = mainVariables.generalVariables.railNavigateIndex;
                              mainVariables.generalVariables.railNavigateIndex = 13;
                              context.read<RailNavigationBloc>().add(const RailNavigationSelectedWidgetEvent());
                            } else {
                              context.read<ReportsBloc>().add(ReportsPageChangingEvent(index: mainVariables.reportsVariables.reportsSelectedIndex));
                              mainVariables.generalVariables.railNavigateBackIndex = mainVariables.generalVariables.railNavigateIndex;
                              mainVariables.generalVariables.railNavigateIndex = 4;
                              mainVariables.railNavigationVariables.mainSelectedIndex = 4;
                              context.read<RailNavigationBloc>().add(const RailNavigationSelectedWidgetEvent());
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
                                    ),
                                    Text(
                                      "Received Stocks",
                                      style: mainTextStyle.normalTextStyle.copyWith(color: mainColors.headingBlueColor, fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                                Text(
                                  "Trans ID : ${mainVariables.generalVariables.selectedTransId}",
                                  style: mainTextStyle.normalTextStyle.copyWith(
                                    color: const Color(0xff007BFE),
                                    fontWeight: FontWeight.w600,
                                    fontSize: mainFunctions.getTextSize(fontSize: 18),
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
                        SizedBox(
                          height: mainFunctions.getWidgetHeight(height: 16),
                        ),
                        mainVariables.receivedStocksVariables.pageState == "reports"
                            ? Padding(
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
                                                      SizedBox(
                                                        height: mainFunctions.getWidgetHeight(height: 38),
                                                        child: TextFormField(
                                                            style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 13), fontWeight: FontWeight.w600, color: const Color(0xff111111), overflow: TextOverflow.ellipsis),
                                                            maxLines: 1,
                                                            controller: mainVariables.receivedStocksVariables.receiverInfo.crewHandlerController,
                                                            readOnly: true,
                                                            decoration: InputDecoration(
                                                              fillColor: const Color(0xffF7F7F7),
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
                                                      SizedBox(
                                                        height: mainFunctions.getWidgetHeight(height: 38),
                                                        child: TextFormField(
                                                            controller: mainVariables.receivedStocksVariables.receiverInfo.stockTypeController,
                                                            style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 13), fontWeight: FontWeight.w600, color: const Color(0xff111111), overflow: TextOverflow.ellipsis),
                                                            maxLines: 1,
                                                            readOnly: true,
                                                            decoration: InputDecoration(
                                                              fillColor: const Color(0xffF7F7F7),
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
                                                      SizedBox(
                                                        height: mainFunctions.getWidgetHeight(height: 38),
                                                        child: TextFormField(
                                                            controller: mainVariables.receivedStocksVariables.receiverInfo.locationController,
                                                            style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 13), fontWeight: FontWeight.w600, color: const Color(0xff111111), overflow: TextOverflow.ellipsis),
                                                            maxLines: 1,
                                                            readOnly: true,
                                                            decoration: InputDecoration(
                                                              fillColor: const Color(0xffF7F7F7),
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
                                                            SizedBox(
                                                              height: mainFunctions.getWidgetHeight(height: 38),
                                                              child: TextFormField(
                                                                  controller: mainVariables.receivedStocksVariables.receiverInfo.fromSectorController,
                                                                  style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 13), fontWeight: FontWeight.w600, color: const Color(0xff111111), overflow: TextOverflow.ellipsis),
                                                                  maxLines: 1,
                                                                  minLines: 1,
                                                                  readOnly: true,
                                                                  decoration: InputDecoration(
                                                                    fillColor: const Color(0xffF7F7F7),
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
                                                              child: TextFormField(
                                                                  controller: mainVariables.receivedStocksVariables.receiverInfo.toSectorController,
                                                                  style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 13), fontWeight: FontWeight.w600, color: const Color(0xff111111), overflow: TextOverflow.ellipsis),
                                                                  maxLines: 1,
                                                                  minLines: 1,
                                                                  readOnly: true,
                                                                  decoration: InputDecoration(
                                                                    fillColor: const Color(0xffF7F7F7),
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
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    )),
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
                                                      SizedBox(
                                                        height: mainFunctions.getWidgetHeight(height: 38),
                                                        child: TextFormField(
                                                            controller: mainVariables.receivedStocksVariables.senderInfo.crewHandlerController,
                                                            style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 13), fontWeight: FontWeight.w600, color: const Color(0xff111111), overflow: TextOverflow.ellipsis),
                                                            maxLines: 1,
                                                            readOnly: true,
                                                            decoration: InputDecoration(
                                                              fillColor: const Color(0xffF7F7F7),
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
                                                        "Crew / Handler Name ",
                                                        style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 14), fontWeight: FontWeight.w600, color: const Color(0xff111111)),
                                                      ),
                                                      SizedBox(
                                                        height: mainFunctions.getWidgetHeight(height: 38),
                                                        child: TextFormField(
                                                            controller: mainVariables.receivedStocksVariables.senderInfo.crewHandlerNameController,
                                                            style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 13), fontWeight: FontWeight.w600, color: const Color(0xff111111), overflow: TextOverflow.ellipsis),
                                                            maxLines: 1,
                                                            readOnly: true,
                                                            decoration: InputDecoration(
                                                              fillColor: const Color(0xffF7F7F7),
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
                                                      SizedBox(
                                                        height: mainFunctions.getWidgetHeight(height: 38),
                                                        child: TextFormField(
                                                            controller: mainVariables.receivedStocksVariables.senderInfo.locationController,
                                                            style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 13), fontWeight: FontWeight.w600, color: const Color(0xff111111), overflow: TextOverflow.ellipsis),
                                                            maxLines: 1,
                                                            readOnly: true,
                                                            decoration: InputDecoration(
                                                              fillColor: const Color(0xffF7F7F7),
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
                                                      SizedBox(
                                                        height: mainFunctions.getWidgetHeight(height: 38),
                                                        child: TextFormField(
                                                            controller: mainVariables.receivedStocksVariables.senderInfo.stockTypeController,
                                                            style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 13), fontWeight: FontWeight.w600, color: const Color(0xff111111), overflow: TextOverflow.ellipsis),
                                                            maxLines: 1,
                                                            minLines: 1,
                                                            readOnly: true,
                                                            decoration: InputDecoration(
                                                              fillColor: const Color(0xffF7F7F7),
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
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    )),
                                  ],
                                ),
                              )
                            : Padding(
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
                                                        "Crew / Handler ",
                                                        style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 14), fontWeight: FontWeight.w600, color: const Color(0xff111111)),
                                                      ),
                                                      SizedBox(
                                                        height: mainFunctions.getWidgetHeight(height: 38),
                                                        child: TextFormField(
                                                            controller: mainVariables.receivedStocksVariables.senderInfo.crewHandlerController,
                                                            style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 13), fontWeight: FontWeight.w600, color: const Color(0xff111111), overflow: TextOverflow.ellipsis),
                                                            maxLines: 1,
                                                            readOnly: true,
                                                            decoration: InputDecoration(
                                                              fillColor: const Color(0xffF7F7F7),
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
                                                        "Crew / Handler Name ",
                                                        style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 14), fontWeight: FontWeight.w600, color: const Color(0xff111111)),
                                                      ),
                                                      SizedBox(
                                                        height: mainFunctions.getWidgetHeight(height: 38),
                                                        child: TextFormField(
                                                            controller: mainVariables.receivedStocksVariables.senderInfo.crewHandlerNameController,
                                                            style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 13), fontWeight: FontWeight.w600, color: const Color(0xff111111), overflow: TextOverflow.ellipsis),
                                                            maxLines: 1,
                                                            readOnly: true,
                                                            decoration: InputDecoration(
                                                              fillColor: const Color(0xffF7F7F7),
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
                                                      SizedBox(
                                                        height: mainFunctions.getWidgetHeight(height: 38),
                                                        child: TextFormField(
                                                            controller: mainVariables.receivedStocksVariables.senderInfo.locationController,
                                                            style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 13), fontWeight: FontWeight.w600, color: const Color(0xff111111), overflow: TextOverflow.ellipsis),
                                                            maxLines: 1,
                                                            readOnly: true,
                                                            decoration: InputDecoration(
                                                              fillColor: const Color(0xffF7F7F7),
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
                                                      SizedBox(
                                                        height: mainFunctions.getWidgetHeight(height: 38),
                                                        child: TextFormField(
                                                            controller: mainVariables.receivedStocksVariables.senderInfo.stockTypeController,
                                                            style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 13), fontWeight: FontWeight.w600, color: const Color(0xff111111), overflow: TextOverflow.ellipsis),
                                                            maxLines: 1,
                                                            minLines: 1,
                                                            readOnly: true,
                                                            decoration: InputDecoration(
                                                              fillColor: const Color(0xffF7F7F7),
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
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    )),
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
                                                        "Crew Name ",
                                                        style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 14), fontWeight: FontWeight.w600, color: const Color(0xff111111)),
                                                      ),
                                                      SizedBox(
                                                        height: mainFunctions.getWidgetHeight(height: 38),
                                                        child: TextFormField(
                                                            style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 13), fontWeight: FontWeight.w600, color: const Color(0xff111111), overflow: TextOverflow.ellipsis),
                                                            maxLines: 1,
                                                            controller: mainVariables.receivedStocksVariables.receiverInfo.crewHandlerController,
                                                            readOnly: true,
                                                            decoration: InputDecoration(
                                                              fillColor: const Color(0xffF7F7F7),
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
                                                      SizedBox(
                                                        height: mainFunctions.getWidgetHeight(height: 38),
                                                        child: TextFormField(
                                                            controller: mainVariables.receivedStocksVariables.receiverInfo.stockTypeController,
                                                            style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 13), fontWeight: FontWeight.w600, color: const Color(0xff111111), overflow: TextOverflow.ellipsis),
                                                            maxLines: 1,
                                                            readOnly: true,
                                                            decoration: InputDecoration(
                                                              fillColor: const Color(0xffF7F7F7),
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
                                                      mainVariables.receivedStocksVariables.pageState == "transit" && mainVariables.receivedStocksVariables.senderInfo.crewHandlerController.text == "Handler"
                                                          ? SizedBox(
                                                              height: mainFunctions.getWidgetHeight(height: 38),
                                                              child: DropdownButtonHideUnderline(
                                                                child: DropdownButton2<DropDownValueModel>(
                                                                  isExpanded: true,
                                                                  isDense: true,
                                                                  items: mainVariables.stockMovementVariables.senderInfo.locationDropDownList
                                                                      .map((item) => DropdownMenuItem<DropDownValueModel>(
                                                                            value: item,
                                                                            child: Text(
                                                                              item.name,
                                                                              style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 13), fontWeight: FontWeight.w600),
                                                                            ),
                                                                          ))
                                                                      .toList(),
                                                                  value: mainVariables.receivedStocksVariables.receiverInfo.receiverLocationChoose,
                                                                  onChanged: (DropDownValueModel? value) async {
                                                                    mainVariables.receivedStocksVariables.receiverInfo.receiverLocationChoose = value!;
                                                                    mainVariables.receivedStocksVariables.receiverInfo.locationController.text = value.name;
                                                                    setState(() {});
                                                                  },
                                                                  style: TextStyle(
                                                                    fontSize: mainFunctions.getTextSize(fontSize: 13),
                                                                    fontWeight: FontWeight.w600,
                                                                    color: const Color(0xff111111),
                                                                    overflow: TextOverflow.ellipsis,
                                                                    fontFamily: "Figtree",
                                                                  ),
                                                                  iconStyleData: const IconStyleData(
                                                                    icon: Icon(
                                                                      Icons.keyboard_arrow_down,
                                                                    ),
                                                                    iconSize: 22,
                                                                  ),
                                                                  buttonStyleData: ButtonStyleData(
                                                                    height: mainFunctions.getWidgetHeight(height: 50),
                                                                    elevation: 0,
                                                                    padding: EdgeInsets.only(right: mainFunctions.getWidgetWidth(width: 12)),
                                                                    decoration: BoxDecoration(
                                                                      borderRadius: BorderRadius.circular(6),
                                                                      border: Border.all(color: const Color(0xffD7D5E2), width: 1),
                                                                    ),
                                                                  ),
                                                                  menuItemStyleData: MenuItemStyleData(
                                                                    height: mainFunctions.getWidgetHeight(height: 40),
                                                                  ),
                                                                  dropdownStyleData: DropdownStyleData(
                                                                    maxHeight: mainFunctions.getWidgetHeight(height: 150),
                                                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.white),
                                                                    elevation: 4,
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                          : SizedBox(
                                                              height: mainFunctions.getWidgetHeight(height: 38),
                                                              child: TextFormField(
                                                                  controller: mainVariables.receivedStocksVariables.receiverInfo.locationController,
                                                                  style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 13), fontWeight: FontWeight.w600, color: const Color(0xff111111), overflow: TextOverflow.ellipsis),
                                                                  maxLines: 1,
                                                                  readOnly: true,
                                                                  decoration: InputDecoration(
                                                                    fillColor: const Color(0xffF7F7F7),
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
                                                            SizedBox(
                                                              height: mainFunctions.getWidgetHeight(height: 38),
                                                              child: TextFormField(
                                                                  controller: mainVariables.receivedStocksVariables.receiverInfo.fromSectorController,
                                                                  style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 13), fontWeight: FontWeight.w600, color: const Color(0xff111111), overflow: TextOverflow.ellipsis),
                                                                  maxLines: 1,
                                                                  minLines: 1,
                                                                  readOnly: true,
                                                                  decoration: InputDecoration(
                                                                    fillColor: const Color(0xffF7F7F7),
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
                                                              child: TextFormField(
                                                                  controller: mainVariables.receivedStocksVariables.receiverInfo.toSectorController,
                                                                  style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 13), fontWeight: FontWeight.w600, color: const Color(0xff111111), overflow: TextOverflow.ellipsis),
                                                                  maxLines: 1,
                                                                  minLines: 1,
                                                                  readOnly: true,
                                                                  decoration: InputDecoration(
                                                                    fillColor: const Color(0xffF7F7F7),
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
                        SizedBox(
                          height: mainFunctions.getWidgetHeight(height: 15),
                        ),
                        mainVariables.receivedStocksVariables.senderInfo.crewHandlerController.text == "Crew"
                            ? const SizedBox()
                            : Container(
                                height: mainFunctions.getWidgetHeight(height: 152),
                                margin: EdgeInsets.symmetric(horizontal: mainFunctions.getWidgetWidth(width: 28)),
                                padding: EdgeInsets.symmetric(horizontal: mainFunctions.getWidgetWidth(width: 10)),
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
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                                  "Handler's Name",
                                                  style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 14), fontWeight: FontWeight.w600, color: const Color(0xff111111)),
                                                ),
                                                SizedBox(
                                                  height: mainFunctions.getWidgetHeight(height: 38),
                                                  child: TextFormField(
                                                    controller: mainVariables.receivedStocksVariables.senderInfo.handlerNameController,
                                                    readOnly: true,
                                                    style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 13), fontWeight: FontWeight.w600, color: const Color(0xff111111), overflow: TextOverflow.ellipsis),
                                                    maxLines: 1,
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
                                                      hintText: "Enter handler’s name",
                                                      hintStyle: TextStyle(
                                                        fontSize: mainFunctions.getTextSize(fontSize: 13),
                                                        fontWeight: FontWeight.w400,
                                                        color: const Color(0xff838195),
                                                      ),
                                                    ),
                                                  ),
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
                                                  "Handler's Contact Number",
                                                  style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 14), fontWeight: FontWeight.w600, color: const Color(0xff111111)),
                                                ),
                                                SizedBox(
                                                  height: mainFunctions.getWidgetHeight(height: 38),
                                                  child: TextFormField(
                                                    controller: mainVariables.receivedStocksVariables.senderInfo.handlerNumberController,
                                                    readOnly: true,
                                                    keyboardType: TextInputType.number,
                                                    style: TextStyle(
                                                      fontSize: mainFunctions.getTextSize(fontSize: 13),
                                                      fontWeight: FontWeight.w600,
                                                      color: const Color(0xff111111),
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                    maxLines: 1,
                                                    decoration: InputDecoration(
                                                      fillColor: const Color(0xffFFFFFF),
                                                      filled: true,
                                                      contentPadding: EdgeInsets.only(left: mainFunctions.getWidgetWidth(width: 12)),
                                                      border: OutlineInputBorder(
                                                        borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                                                        borderRadius: BorderRadius.circular(12),
                                                      ),
                                                      focusedBorder: OutlineInputBorder(
                                                        borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                                                        borderRadius: BorderRadius.circular(12),
                                                      ),
                                                      enabledBorder: OutlineInputBorder(
                                                        borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                                                        borderRadius: BorderRadius.circular(12),
                                                      ),
                                                      disabledBorder: OutlineInputBorder(
                                                        borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                                                        borderRadius: BorderRadius.circular(12),
                                                      ),
                                                      hintText: "Enter handler’s contact number",
                                                      hintStyle: TextStyle(
                                                        fontSize: mainFunctions.getTextSize(fontSize: 13),
                                                        fontWeight: FontWeight.w400,
                                                        color: const Color(0xff838195),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: mainFunctions.getWidgetHeight(height: 5),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: mainFunctions.getWidgetWidth(width: 28),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(vertical: mainFunctions.getWidgetHeight(height: 12)),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Handler Sign",
                                                    style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 13), fontWeight: FontWeight.w600, color: const Color(0xff111111)),
                                                  ),
                                                  DottedBorder(
                                                    borderType: BorderType.RRect,
                                                    radius: const Radius.circular(12),
                                                    padding: const EdgeInsets.all(5),
                                                    child: mainVariables.receivedStocksVariables.senderInfo.image1 == ""
                                                        ? Container(
                                                            width: mainVariables.generalVariables.width <= 650 ? mainFunctions.getWidgetWidth(width: 74) : mainFunctions.getWidgetWidth(width: 100),
                                                            height: mainFunctions.getWidgetHeight(height: 95),
                                                            decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(15),
                                                            ),
                                                            child: Center(
                                                                child: Text(
                                                              "Handler not signed",
                                                              style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 10), fontWeight: FontWeight.w400, color: const Color(0xff393939)),
                                                            )),
                                                          )
                                                        : Container(
                                                            width: mainVariables.generalVariables.width <= 650 ? mainFunctions.getWidgetWidth(width: 74) : mainFunctions.getWidgetWidth(width: 100),
                                                            height: mainFunctions.getWidgetHeight(height: 95),
                                                            decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(15),
                                                                image: DecorationImage(
                                                                  image: NetworkImage(mainVariables.receivedStocksVariables.senderInfo.image1),
                                                                  fit: BoxFit.fill,
                                                                )),
                                                          ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: mainFunctions.getWidgetWidth(width: 10),
                                            ),
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Crew Sign",
                                                    style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 13), fontWeight: FontWeight.w600, color: const Color(0xff111111)),
                                                  ),
                                                  DottedBorder(
                                                    borderType: BorderType.RRect,
                                                    radius: const Radius.circular(12),
                                                    padding: const EdgeInsets.all(5),
                                                    child: mainVariables.receivedStocksVariables.senderInfo.image2 == ""
                                                        ? Container(
                                                            width: mainVariables.generalVariables.width <= 650 ? mainFunctions.getWidgetWidth(width: 74) : mainFunctions.getWidgetWidth(width: 100),
                                                            height: mainFunctions.getWidgetHeight(height: 95),
                                                            decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(15),
                                                            ),
                                                            child: Center(
                                                                child: Text(
                                                              "Crew not signed",
                                                              style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 10), fontWeight: FontWeight.w400, color: const Color(0xff393939)),
                                                            )),
                                                          )
                                                        : Container(
                                                            width: mainVariables.generalVariables.width <= 650 ? mainFunctions.getWidgetWidth(width: 74) : mainFunctions.getWidgetWidth(width: 100),
                                                            height: mainFunctions.getWidgetHeight(height: 95),
                                                            decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(15),
                                                                image: DecorationImage(
                                                                  image: NetworkImage(mainVariables.receivedStocksVariables.senderInfo.image2),
                                                                  fit: BoxFit.fill,
                                                                )),
                                                          ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: mainFunctions.getWidgetHeight(height: 8),
                  ),
                  SizedBox(
                    height: mainFunctions.getWidgetHeight(
                        height: mainVariables.receivedStocksVariables.pageState == "transit"
                            ? mainVariables.receivedStocksVariables.senderInfo.crewHandlerController.text == "Crew"
                                ? 425
                                : 300
                            : mainVariables.receivedStocksVariables.receivedStocksDisputes.tableData.isEmpty
                                ? mainVariables.receivedStocksVariables.senderInfo.crewHandlerController.text == "Crew"
                                    ? mainVariables.receivedStocksVariables.pageState == "transit_confirm"
                                        ? 425
                                        : 510
                                    : mainVariables.receivedStocksVariables.pageState == "transit_confirm"
                                        ? 265
                                        : 350
                                : mainVariables.receivedStocksVariables.senderInfo.crewHandlerController.text == "Crew"
                                    ? mainVariables.receivedStocksVariables.pageState == "transit_confirm"
                                        ? 300
                                        : 250
                                    : mainVariables.receivedStocksVariables.pageState == "transit_confirm"
                                        ? 225
                                        : 200),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: mainFunctions.getWidgetHeight(height: 12), vertical: mainFunctions.getWidgetWidth(width: 12)),
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
                                  style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 20), color: mainColors.headingBlueColor, fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "Total Products : ${mainVariables.receivedStocksVariables.totalProducts} | Total Qty: ${mainVariables.receivedStocksVariables.totalQuantity}",
                                  style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 15), color: const Color(0xff111111), fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                          const Divider(
                            color: Color(0xffD9D9D9),
                            thickness: 1.0,
                            height: 0,
                          ),
                          Expanded(
                            child: StickyHeadersTable(
                              columnsLength: mainVariables.receivedStocksVariables.receivedStocksInventory.tableHeading.length,
                              rowsLength: mainVariables.receivedStocksVariables.receivedStocksInventory.tableData.length,
                              showHorizontalScrollbar: false,
                              showVerticalScrollbar: false,
                              columnsTitleBuilder: (int columnIndex) {
                                return Center(
                                  child: Text(
                                    columnIndex == 7
                                        ? mainVariables.receivedStocksVariables.pageState == "transit"
                                            ? mainVariables.receivedStocksVariables.receivedStocksInventory.tableHeading[columnIndex]
                                            : ""
                                        : mainVariables.receivedStocksVariables.receivedStocksInventory.tableHeading[columnIndex],
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
                                    : columnIndex == 7
                                        ? mainVariables.receivedStocksVariables.pageState == "transit"
                                            ? InkWell(
                                                onTap: mainVariables.receivedStocksVariables.receivedStocksInventory.tableData[rowIndex][columnIndex + 2] == "no"
                                                    ? () {
                                                        mainVariables.stockDisputeVariables.senderLocationChoose = mainVariables.receivedStocksVariables.receiverInfo.receiverLocationChoose;
                                                        mainVariables.stockDisputeVariables.stockDisputeInventory.tableData.clear();
                                                        mainVariables.stockDisputeVariables.stockDisputeInventory.tableData.add([]);
                                                        mainVariables.generalVariables.selectedTransTempId = mainVariables.receivedStocksVariables.tempTransId;
                                                        mainVariables.generalVariables.selectedProductIndexForDispute = rowIndex;
                                                        mainVariables.receivedStocksVariables.disputePageOpened = true;
                                                        for (int i = 0; i < mainVariables.receivedStocksVariables.receivedStocksInventory.tableData[rowIndex].length; i++) {
                                                          if (mainVariables.receivedStocksVariables.receivedStocksInventory.tableData[rowIndex][i] == "-") {
                                                            mainVariables.stockDisputeVariables.stockDisputeInventory.tableData[0].add("0");
                                                          } else {
                                                            mainVariables.stockDisputeVariables.stockDisputeInventory.tableData[0].add(mainVariables.receivedStocksVariables.receivedStocksInventory.tableData[rowIndex][i]);
                                                          }
                                                        }
                                                        mainVariables.generalVariables.railNavigateBackIndex = mainVariables.generalVariables.railNavigateIndex;
                                                        mainVariables.railNavigationVariables.mainSelectedIndex = 2;
                                                        mainVariables.generalVariables.railNavigateIndex = 2;
                                                        context.read<RailNavigationBloc>().add(const RailNavigationSelectedWidgetEvent());
                                                      }
                                                    : () {
                                                        mainWidgets.flushBarWidget(context: context, message: "Already dispute added for this product");
                                                      },
                                                child: Center(
                                                  child: mainVariables.receivedStocksVariables.receivedStocksInventory.tableData[rowIndex][columnIndex + 2] == "no"
                                                      ? Image.asset(
                                                          "assets/home/dispute_not_added.png",
                                                          height: mainFunctions.getWidgetHeight(height: 22),
                                                          width: mainFunctions.getWidgetWidth(width: 22),
                                                        )
                                                      : Image.asset(
                                                          "assets/home/dispute_added.png",
                                                          height: mainFunctions.getWidgetHeight(height: 22),
                                                          width: mainFunctions.getWidgetWidth(width: 22),
                                                        ),
                                                ),
                                              )
                                            : const SizedBox()
                                        : Center(
                                            child: Text(
                                              mainVariables.receivedStocksVariables.receivedStocksInventory.tableData[rowIndex][columnIndex],
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
                                  columnWidths: mainVariables.receivedStocksVariables.pageState == "transit"
                                      ? MediaQuery.of(context).orientation == Orientation.portrait
                                          ? [
                                              mainFunctions.getWidgetWidth(width: 0),
                                              mainFunctions.getWidgetWidth(width: 0),
                                              mainFunctions.getWidgetWidth(width: 111),
                                              mainFunctions.getWidgetWidth(width: 111),
                                              mainFunctions.getWidgetWidth(width: 111),
                                              mainFunctions.getWidgetWidth(width: 111),
                                              mainFunctions.getWidgetWidth(width: 76),
                                              mainFunctions.getWidgetWidth(width: 111),
                                            ]
                                          : [
                                              mainFunctions.getWidgetHeight(height: 0),
                                              mainFunctions.getWidgetHeight(height: 0),
                                              mainFunctions.getWidgetHeight(height: 151),
                                              mainFunctions.getWidgetHeight(height: 151),
                                              mainFunctions.getWidgetHeight(height: 171),
                                              mainFunctions.getWidgetHeight(height: 171),
                                              mainFunctions.getWidgetHeight(height: 116),
                                              mainFunctions.getWidgetHeight(height: 151),
                                            ]
                                      : MediaQuery.of(context).orientation == Orientation.portrait
                                          ? [
                                              mainFunctions.getWidgetWidth(width: 0),
                                              mainFunctions.getWidgetWidth(width: 0),
                                              mainFunctions.getWidgetWidth(width: 134),
                                              mainFunctions.getWidgetWidth(width: 134),
                                              mainFunctions.getWidgetWidth(width: 134),
                                              mainFunctions.getWidgetWidth(width: 134),
                                              mainFunctions.getWidgetWidth(width: 89),
                                              mainFunctions.getWidgetWidth(width: 0),
                                            ]
                                          : [
                                              mainFunctions.getWidgetHeight(height: 0),
                                              mainFunctions.getWidgetHeight(height: 0),
                                              mainFunctions.getWidgetHeight(height: 190),
                                              mainFunctions.getWidgetHeight(height: 190),
                                              mainFunctions.getWidgetHeight(height: 190),
                                              mainFunctions.getWidgetHeight(height: 190),
                                              mainFunctions.getWidgetHeight(height: 90),
                                              mainFunctions.getWidgetHeight(height: 0),
                                            ],
                                  contentCellHeight: 40,
                                  stickyLegendWidth: 40,
                                  stickyLegendHeight: 40),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: mainFunctions.getWidgetHeight(height: 8),
                  ),
                  mainVariables.receivedStocksVariables.pageState == "transit"
                      ? const SizedBox()
                      : mainVariables.receivedStocksVariables.receivedStocksDisputes.tableData.isEmpty
                          ? const SizedBox()
                          : SizedBox(
                              height: mainFunctions.getWidgetHeight(height: mainVariables.receivedStocksVariables.senderInfo.crewHandlerController.text == "Crew" ? 300 : 225),
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: mainFunctions.getWidgetHeight(height: 12), vertical: mainFunctions.getWidgetWidth(width: 12)),
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
                                            "Disputes",
                                            style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 20), color: mainColors.headingBlueColor, fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            "Total Products : ${mainVariables.receivedStocksVariables.totalDisputeProducts} | Total Qty: ${mainVariables.receivedStocksVariables.totalDisputeQuantity}",
                                            style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 15), color: const Color(0xff111111), fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Divider(
                                      color: Color(0xffD9D9D9),
                                      thickness: 1.0,
                                      height: 0,
                                    ),
                                    Expanded(
                                      child: StickyHeadersTable(
                                        columnsLength: mainVariables.receivedStocksVariables.receivedStocksDisputes.tableHeading.length,
                                        rowsLength: mainVariables.receivedStocksVariables.receivedStocksDisputes.tableData.length,
                                        showHorizontalScrollbar: false,
                                        showVerticalScrollbar: false,
                                        columnsTitleBuilder: (int columnIndex) {
                                          return Center(
                                            child: Text(
                                              mainVariables.receivedStocksVariables.receivedStocksDisputes.tableHeading[columnIndex],
                                              maxLines: 2,
                                              style: const TextStyle(fontSize: 12, overflow: TextOverflow.ellipsis, fontWeight: FontWeight.w600),
                                            ),
                                          );
                                        },
                                        rowsTitleBuilder: (int rowIndex) {
                                          return Center(
                                            child: Text(
                                              (rowIndex + 1) < 10 ? "0${rowIndex + 1}" : "${rowIndex + 1}",
                                              maxLines: 2,
                                              style: const TextStyle(fontSize: 12, overflow: TextOverflow.ellipsis, fontWeight: FontWeight.normal),
                                            ),
                                          );
                                        },
                                        contentCellBuilder: (int columnIndex, int rowIndex) {
                                          return columnIndex == 0
                                              ? const SizedBox()
                                              : Center(
                                                  child: Text(
                                                    mainVariables.receivedStocksVariables.receivedStocksDisputes.tableData[rowIndex][columnIndex],
                                                    maxLines: 2,
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(fontSize: 12, overflow: TextOverflow.ellipsis, fontWeight: FontWeight.normal),
                                                  ),
                                                );
                                        },
                                        legendCell: const Text(
                                          "S.No",
                                          maxLines: 1,
                                          style: TextStyle(fontSize: 12, overflow: TextOverflow.ellipsis, fontWeight: FontWeight.w600),
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
                                                    mainFunctions.getWidgetWidth(width: 85),
                                                    mainFunctions.getWidgetWidth(width: 110),
                                                    mainFunctions.getWidgetWidth(width: 110),
                                                    mainFunctions.getWidgetWidth(width: 125),
                                                    mainFunctions.getWidgetWidth(width: 125),
                                                    mainFunctions.getWidgetWidth(width: 65),
                                                  ]
                                                : [
                                                    mainFunctions.getWidgetHeight(height: 0),
                                                    mainFunctions.getWidgetHeight(height: 155),
                                                    mainFunctions.getWidgetHeight(height: 155),
                                                    mainFunctions.getWidgetHeight(height: 155),
                                                    mainFunctions.getWidgetHeight(height: 155),
                                                    mainFunctions.getWidgetHeight(height: 155),
                                                    mainFunctions.getWidgetHeight(height: 135),
                                                  ],
                                            contentCellHeight: 40,
                                            stickyLegendWidth: 40,
                                            stickyLegendHeight: 40),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                  mainVariables.receivedStocksVariables.pageState == "transit"
                      ? const SizedBox()
                      : SizedBox(
                          height: mainFunctions.getWidgetHeight(height: 8),
                        ),
                  SizedBox(
                    height: mainFunctions.getWidgetHeight(height: 106),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: mainFunctions.getWidgetHeight(height: 12), vertical: mainFunctions.getWidgetWidth(width: 12)),
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
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: mainFunctions.getWidgetHeight(height: 24),
                                  child: Text(
                                    "Sender remarks",
                                    style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 20), color: const Color(0xff0C3788), fontWeight: FontWeight.w600),
                                  ),
                                ),
                                SizedBox(
                                  height: mainFunctions.getWidgetHeight(height: 8),
                                ),
                                SizedBox(
                                  height: mainFunctions.getWidgetHeight(height: 50),
                                  child: TextFormField(
                                    style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 13), fontWeight: FontWeight.w600, color: const Color(0xff111111), overflow: TextOverflow.ellipsis),
                                    maxLines: 2,
                                    controller: mainVariables.receivedStocksVariables.senderRemarksController,
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.done,
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
                                      hintText: "add  remarks here",
                                      hintStyle: TextStyle(
                                        fontSize: mainFunctions.getTextSize(fontSize: 13),
                                        fontWeight: FontWeight.w400,
                                        color: const Color(0xff838195),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          mainVariables.receivedStocksVariables.pageState == "transit"
                              ? const SizedBox()
                              : SizedBox(
                                  width: mainFunctions.getWidgetWidth(width: 20),
                                ),
                          mainVariables.receivedStocksVariables.pageState == "transit"
                              ? const SizedBox()
                              : Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: mainFunctions.getWidgetHeight(height: 24),
                                        child: Text(
                                          "Receiver remarks",
                                          style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 20), color: const Color(0xff0C3788), fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      SizedBox(
                                        height: mainFunctions.getWidgetHeight(height: 8),
                                      ),
                                      SizedBox(
                                        height: mainFunctions.getWidgetHeight(height: 50),
                                        child: TextFormField(
                                          style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 13), fontWeight: FontWeight.w600, color: const Color(0xff111111), overflow: TextOverflow.ellipsis),
                                          maxLines: 2,
                                          controller: mainVariables.receivedStocksVariables.receiverRemarksController,
                                          keyboardType: TextInputType.text,
                                          textInputAction: TextInputAction.done,
                                          readOnly: mainVariables.receivedStocksVariables.pageState != "transit_confirm",
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
                                            hintText: "add  remarks here",
                                            hintStyle: TextStyle(
                                              fontSize: mainFunctions.getTextSize(fontSize: 13),
                                              fontWeight: FontWeight.w400,
                                              color: const Color(0xff838195),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
                  mainVariables.receivedStocksVariables.pageState == "transit" || mainVariables.receivedStocksVariables.pageState == "transit_confirm"
                      ? SizedBox(
                          height: mainFunctions.getWidgetHeight(height: 40),
                        )
                      : const SizedBox(),
                  mainVariables.receivedStocksVariables.pageState == "transit" || mainVariables.receivedStocksVariables.pageState == "transit_confirm"
                      ? LoadingButton(
                          status: mainVariables.receivedStocksVariables.continueLoader,
                          onTap: () {
                            if (mainVariables.receivedStocksVariables.pageState == "transit_confirm") {
                              setState(() {
                                mainVariables.receivedStocksVariables.continueLoader = true;
                              });
                              mainVariables.transitVariables.receivedPageOpened = false;
                              context.read<ReceivedStocksBloc>().add(const ReceivedStocksConfirm());
                            } else {
                              setState(() {
                                mainVariables.receivedStocksVariables.pageState = "transit_confirm";
                                buttonString = "Received";
                              });
                            }
                          },
                          text: buttonString,
                          height: 42,
                          width: 132,
                          fontSize: 16,
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          );
        } else if (receivedStocks is ReceivedStocksLoading) {
          return SizedBox(
            height: mainFunctions.getWidgetHeight(height: mainVariables.generalVariables.height),
            width: mainFunctions.getWidgetWidth(width: mainVariables.generalVariables.width),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
