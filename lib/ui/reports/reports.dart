import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:table_sticky_headers/table_sticky_headers.dart';
import 'package:tvsaviation/bloc/check_list/check_list_bloc.dart';
import 'package:tvsaviation/bloc/rail_navigation/rail_navigation_bloc.dart';
import 'package:tvsaviation/bloc/reports/reports_bloc.dart';
import 'package:tvsaviation/data/model/variable_model/check_list_variables.dart';
import 'package:tvsaviation/resources/constants.dart';

class ReportsScreen extends StatefulWidget {
  static const String id = "reports";
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvoked: (value) {
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
      margin: EdgeInsets.symmetric(vertical: mainFunctions.getWidgetHeight(height: 20), horizontal: mainFunctions.getWidgetWidth(width: 20)),
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
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: Color(0xff0C3788),
                  ),
                ),
                BlocBuilder<ReportsBloc, ReportsState>(
                  builder: (BuildContext context, ReportsState reports) {
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
          Container(
            height: mainFunctions.getWidgetHeight(height: 60),
            padding: EdgeInsets.symmetric(horizontal: mainFunctions.getWidgetWidth(width: 12), vertical: mainFunctions.getWidgetHeight(height: 12)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: BlocBuilder<ReportsBloc, ReportsState>(
                    builder: (context, state) {
                      return TextFormField(
                        onChanged: (value) {
                          mainVariables.reportsVariables.currentPage = 1;
                          context.read<ReportsBloc>().add(const ReportsFilterEvent());
                        },
                        controller: mainVariables.reportsVariables.searchController,
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: mainFunctions.getTextSize(fontSize: 15), color: mainColors.blackColor),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          fillColor: const Color(0xFF767680).withOpacity(0.12),
                          filled: true,
                          prefixIcon: Icon(
                            Icons.search,
                            color: const Color(0xff3C3C43).withOpacity(0.6),
                          ),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0XFFEDEDED))),
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0XFFEDEDED))),
                          disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0XFFEDEDED))),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0XFFEDEDED))),
                          focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0XFFEDEDED))),
                          errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0XFFEDEDED))),
                          hintText: "Search",
                          hintStyle: TextStyle(color: const Color(0XFF3C3C43).withOpacity(0.6), fontSize: mainFunctions.getTextSize(fontSize: 17), fontWeight: FontWeight.w400),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  width: mainFunctions.getWidgetWidth(width: 16),
                ),
                InkWell(
                  onTap: () {
                    Scaffold.of(context).openDrawer();
                  },
                  child: Container(
                    width: mainFunctions.getWidgetHeight(height: 84),
                    height: mainFunctions.getWidgetHeight(height: 36),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: const Color(0xffEDEDED), width: 1),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: mainFunctions.getWidgetHeight(height: 18),
                          width: mainFunctions.getWidgetWidth(width: 18),
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/reports/sort.png"),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: mainFunctions.getWidgetWidth(width: 12),
                        ),
                        Text("Filter", textAlign: TextAlign.center, style: TextStyle(color: const Color(0xff0C3788), fontSize: mainFunctions.getTextSize(fontSize: 13), fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: mainFunctions.getWidgetWidth(width: 16),
                ),
                InkWell(
                  onTap: () {
                    context.read<ReportsBloc>().add(const DownloadFileEvent());
                  },
                  child: Material(
                    elevation: 0,
                    borderRadius: BorderRadius.circular(4),
                    clipBehavior: Clip.antiAlias,
                    child: Container(
                      width: mainFunctions.getWidgetHeight(height: 116),
                      height: mainFunctions.getWidgetHeight(height: 36),
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0XFF0C3788),
                              Color(0XFFBC0044),
                            ],
                          ),
                          shape: BoxShape.rectangle),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: mainFunctions.getWidgetHeight(height: 16),
                            width: mainFunctions.getWidgetWidth(width: 16),
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/reports/download.png"),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: mainFunctions.getWidgetWidth(width: 4),
                          ),
                          Text("Download CSV", textAlign: TextAlign.center, style: TextStyle(color: const Color(0xffffffff), fontSize: mainFunctions.getTextSize(fontSize: 11), fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: mainFunctions.getWidgetHeight(height: 16),
          ),
          BlocConsumer<ReportsBloc, ReportsState>(
            listenWhen: (previous, current) {
              return previous != current;
            },
            buildWhen: (previous, current) {
              return previous != current;
            },
            listener: (BuildContext context, ReportsState reports) {
              if (reports is ReportsFailure) {
                mainWidgets.flushBarWidget(context: context, message: reports.errorMessage);
              } else if (reports is ReportsSuccess) {
                mainWidgets.flushBarWidget(context: context, message: reports.message);
              }
            },
            builder: (BuildContext context, ReportsState reports) {
              if (reports is ReportsLoaded) {
                return tableWidget();
              } else if (reports is ReportsLoading) {
                return const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
          SizedBox(
            height: mainFunctions.getWidgetHeight(height: 16),
          ),
          BlocBuilder<ReportsBloc, ReportsState>(
            builder: (BuildContext context, ReportsState reports) {
              if (reports is ReportsLoaded) {
                return paginationConditionWidget();
              } else if (reports is ReportsLoading) {
                return mainVariables.reportsVariables.transaction.tableData.isEmpty &&
                        mainVariables.reportsVariables.overall.tableData.isEmpty &&
                        mainVariables.reportsVariables.lowStock.tableData.isEmpty &&
                        mainVariables.reportsVariables.expiry.tableData.isEmpty &&
                        mainVariables.reportsVariables.dispute.tableData.isEmpty &&
                        mainVariables.reportsVariables.cabinGalley.tableData.isEmpty &&
                        mainVariables.reportsVariables.preflight.tableData.isEmpty &&
                        mainVariables.reportsVariables.postFlight.tableData.isEmpty &&
                        mainVariables.reportsVariables.maintenance.tableData.isEmpty
                    ? const SizedBox()
                    : Center(
                        child: SizedBox(
                          width: mainFunctions.getWidgetWidth(width: 450),
                          child: NumberPaginator(
                            initialPage: 0,
                            numberPages: mainVariables.reportsVariables.totalPages,
                            onPageChange: (int index) {
                              setState(() {
                                mainVariables.reportsVariables.currentPage = index + 1;
                              });
                              context.read<ReportsBloc>().add(const ReportsFilterEvent());
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
                      );
              } else {
                return mainVariables.reportsVariables.transaction.tableData.isEmpty &&
                        mainVariables.reportsVariables.overall.tableData.isEmpty &&
                        mainVariables.reportsVariables.lowStock.tableData.isEmpty &&
                        mainVariables.reportsVariables.expiry.tableData.isEmpty &&
                        mainVariables.reportsVariables.dispute.tableData.isEmpty &&
                        mainVariables.reportsVariables.cabinGalley.tableData.isEmpty &&
                        mainVariables.reportsVariables.preflight.tableData.isEmpty &&
                        mainVariables.reportsVariables.postFlight.tableData.isEmpty &&
                        mainVariables.reportsVariables.maintenance.tableData.isEmpty
                    ? const SizedBox()
                    : Center(
                        child: SizedBox(
                          width: mainFunctions.getWidgetWidth(width: 450),
                          child: NumberPaginator(
                            initialPage: 0,
                            numberPages: mainVariables.reportsVariables.totalPages,
                            onPageChange: (int index) {
                              setState(() {
                                mainVariables.reportsVariables.currentPage = index + 1;
                              });
                              context.read<ReportsBloc>().add(const ReportsFilterEvent());
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
                      );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget headerTextWidget() {
    switch (mainVariables.reportsVariables.reportsSelectedIndex) {
      case 0:
        return Text(
          mainVariables.reportsVariables.overall.heading,
          style: mainTextStyle.normalTextStyle.copyWith(color: mainColors.headingBlueColor, fontWeight: FontWeight.w600),
        );
      case 1:
        return Text(
          mainVariables.reportsVariables.lowStock.heading,
          style: mainTextStyle.normalTextStyle.copyWith(color: mainColors.headingBlueColor, fontWeight: FontWeight.w600),
        );
      case 2:
        return Text(
          mainVariables.reportsVariables.expiry.heading,
          style: mainTextStyle.normalTextStyle.copyWith(color: mainColors.headingBlueColor, fontWeight: FontWeight.w600),
        );
      case 3:
        return Text(
          mainVariables.reportsVariables.dispute.heading,
          style: mainTextStyle.normalTextStyle.copyWith(color: mainColors.headingBlueColor, fontWeight: FontWeight.w600),
        );
      case 4:
        return Text(
          mainVariables.reportsVariables.transaction.heading,
          style: mainTextStyle.normalTextStyle.copyWith(color: mainColors.headingBlueColor, fontWeight: FontWeight.w600),
        );
      case 5:
        return Text(
          mainVariables.reportsVariables.cabinGalley.heading,
          style: mainTextStyle.normalTextStyle.copyWith(color: mainColors.headingBlueColor, fontWeight: FontWeight.w600),
        );
      case 6:
        return Text(
          mainVariables.reportsVariables.preflight.heading,
          style: mainTextStyle.normalTextStyle.copyWith(color: mainColors.headingBlueColor, fontWeight: FontWeight.w600),
        );
      case 7:
        return Text(
          mainVariables.reportsVariables.postFlight.heading,
          style: mainTextStyle.normalTextStyle.copyWith(color: mainColors.headingBlueColor, fontWeight: FontWeight.w600),
        );
      case 8:
        return Text(
          mainVariables.reportsVariables.maintenance.heading,
          style: mainTextStyle.normalTextStyle.copyWith(color: mainColors.headingBlueColor, fontWeight: FontWeight.w600),
        );
      case 9:
        return Text(
          mainVariables.reportsVariables.safety.heading,
          style: mainTextStyle.normalTextStyle.copyWith(color: mainColors.headingBlueColor, fontWeight: FontWeight.w600),
        );
      default:
        return Container();
    }
  }

  Widget tableWidget() {
    switch (mainVariables.reportsVariables.reportsSelectedIndex) {
      case 0:
        return Expanded(
          child: mainVariables.reportsVariables.overall.tableData.isEmpty
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
                      const Text("No reports found"),
                    ],
                  ),
                )
              : Padding(
                  padding: EdgeInsets.symmetric(horizontal: mainFunctions.getWidgetWidth(width: 20)),
                  child: StickyHeadersTable(
                    columnsLength: mainVariables.reportsVariables.overall.tableHeading.length,
                    rowsLength: mainVariables.reportsVariables.overall.tableData.length,
                    showHorizontalScrollbar: false,
                    showVerticalScrollbar: false,
                    columnsTitleBuilder: (int columnIndex) {
                      return Center(
                        child: Text(
                          mainVariables.reportsVariables.overall.tableHeading[columnIndex],
                          maxLines: 2,
                          style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 12), overflow: TextOverflow.ellipsis, fontWeight: FontWeight.w600),
                        ),
                      );
                    },
                    rowsTitleBuilder: (int rowIndex) {
                      return Center(
                        child: Text(
                          ((mainVariables.reportsVariables.currentPage - 1) * 10) + (rowIndex + 1) < 10
                              ? "0${((mainVariables.reportsVariables.currentPage - 1) * 10) + (rowIndex + 1)}"
                              : "${((mainVariables.reportsVariables.currentPage - 1) * 10) + (rowIndex + 1)}",
                          maxLines: 2,
                          style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 12), overflow: TextOverflow.ellipsis, fontWeight: FontWeight.normal),
                        ),
                      );
                    },
                    contentCellBuilder: (int columnIndex, int rowIndex) {
                      return columnIndex == 0
                          ? const SizedBox()/*Center(
                              child: Image.network(
                              mainVariables.reportsVariables.overall.tableData[rowIndex][columnIndex],
                              height: mainFunctions.getWidgetHeight(height: 24),
                              width: mainFunctions.getWidgetWidth(width: 24),
                            ))*/
                          : Center(
                              child: Text(
                                mainVariables.reportsVariables.overall.tableData[rowIndex][columnIndex],
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
                              mainFunctions.getWidgetWidth(width: 150),
                              mainFunctions.getWidgetWidth(width: 150),
                              mainFunctions.getWidgetWidth(width: 150),
                              mainFunctions.getWidgetWidth(width: 150),
                            ]
                          : [
                              mainFunctions.getWidgetHeight(height: 0),
                              mainFunctions.getWidgetHeight(height: 220),
                              mainFunctions.getWidgetHeight(height: 220),
                              mainFunctions.getWidgetHeight(height: 220),
                              mainFunctions.getWidgetHeight(height: 220),
                            ],
                      contentCellHeight: 40,
                      stickyLegendWidth: 40,
                      stickyLegendHeight: 40,
                    ),
                  ),
                ),
        );
      case 1:
        return Expanded(
          child: mainVariables.reportsVariables.lowStock.tableData.isEmpty
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
                      const Text("No low stock reports found"),
                    ],
                  ),
                )
              : Padding(
                  padding: EdgeInsets.symmetric(horizontal: mainFunctions.getWidgetWidth(width: 20)),
                  child: StickyHeadersTable(
                    columnsLength: mainVariables.reportsVariables.lowStock.tableHeading.length,
                    rowsLength: mainVariables.reportsVariables.lowStock.tableData.length,
                    showHorizontalScrollbar: false,
                    showVerticalScrollbar: false,
                    columnsTitleBuilder: (int columnIndex) {
                      return columnIndex == 3
                          ? InkWell(
                              onTap: () {
                                mainVariables.reportsVariables.sortInt = (mainVariables.reportsVariables.sortInt * -1);
                                context.read<ReportsBloc>().add(const ReportsFilterEvent());
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    mainVariables.reportsVariables.lowStock.tableHeading[columnIndex],
                                    maxLines: 2,
                                    style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 12), overflow: TextOverflow.ellipsis, fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    width: mainFunctions.getWidgetWidth(width: 6),
                                  ),
                                  Image.asset(
                                    "assets/reports/arrow_up_down.png",
                                    height: mainFunctions.getWidgetHeight(height: 8),
                                    width: mainFunctions.getWidgetWidth(width: 6),
                                    fit: BoxFit.fill,
                                  ),
                                ],
                              ),
                            )
                          : Center(
                              child: Text(
                                mainVariables.reportsVariables.lowStock.tableHeading[columnIndex],
                                maxLines: 2,
                                style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 12), overflow: TextOverflow.ellipsis, fontWeight: FontWeight.w600),
                              ),
                            );
                    },
                    rowsTitleBuilder: (int rowIndex) {
                      return Center(
                        child: Text(
                          ((mainVariables.reportsVariables.currentPage - 1) * 10) + (rowIndex + 1) < 10
                              ? "0${((mainVariables.reportsVariables.currentPage - 1) * 10) + (rowIndex + 1)}"
                              : "${((mainVariables.reportsVariables.currentPage - 1) * 10) + (rowIndex + 1)}",
                          maxLines: 2,
                          style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 12), overflow: TextOverflow.ellipsis, fontWeight: FontWeight.normal),
                        ),
                      );
                    },
                    contentCellBuilder: (int columnIndex, int rowIndex) {
                      return columnIndex == 0
                          ? const SizedBox()
                          : Center(
                              child: Text(
                                mainVariables.reportsVariables.lowStock.tableData[rowIndex][columnIndex],
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: mainFunctions.getTextSize(fontSize: 12),
                                  overflow: TextOverflow.ellipsis,
                                  fontWeight: FontWeight.normal,
                                  color: columnIndex == 4 ? Colors.red : Colors.black,
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
                              mainFunctions.getWidgetWidth(width: 0),
                              mainFunctions.getWidgetWidth(width: 120),
                              mainFunctions.getWidgetWidth(width: 120),
                              mainFunctions.getWidgetWidth(width: 125),
                              mainFunctions.getWidgetWidth(width: 125),
                              mainFunctions.getWidgetWidth(width: 120),
                              mainFunctions.getWidgetWidth(width: 120),
                            ]
                          : [
                              mainFunctions.getWidgetHeight(height: 0),
                              mainFunctions.getWidgetHeight(height: 145),
                              mainFunctions.getWidgetHeight(height: 145),
                              mainFunctions.getWidgetHeight(height: 145),
                              mainFunctions.getWidgetHeight(height: 145),
                              mainFunctions.getWidgetHeight(height: 145),
                              mainFunctions.getWidgetHeight(height: 145),
                            ],
                      contentCellHeight: 40,
                      stickyLegendWidth: 40,
                      stickyLegendHeight: 40,
                    ),
                  ),
                ),
        );
      case 2:
        return Expanded(
          child: mainVariables.reportsVariables.expiry.tableData.isEmpty
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
                      const Text("No expiry reports found"),
                    ],
                  ),
                )
              : Padding(
                  padding: EdgeInsets.symmetric(horizontal: mainFunctions.getWidgetWidth(width: 20)),
                  child: StickyHeadersTable(
                    columnsLength: mainVariables.reportsVariables.expiry.tableHeading.length,
                    rowsLength: mainVariables.reportsVariables.expiry.tableData.length,
                    showHorizontalScrollbar: false,
                    showVerticalScrollbar: false,
                    columnsTitleBuilder: (int columnIndex) {
                      return columnIndex == 4
                          ? InkWell(
                              onTap: () {
                                mainVariables.reportsVariables.sortInt = (mainVariables.reportsVariables.sortInt * -1);
                                context.read<ReportsBloc>().add(const ReportsFilterEvent());
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    mainVariables.reportsVariables.expiry.tableHeading[columnIndex],
                                    maxLines: 2,
                                    style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 12), overflow: TextOverflow.ellipsis, fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    width: mainFunctions.getWidgetWidth(width: 6),
                                  ),
                                  Image.asset(
                                    "assets/reports/arrow_up_down.png",
                                    height: mainFunctions.getWidgetHeight(height: 8),
                                    width: mainFunctions.getWidgetWidth(width: 6),
                                    fit: BoxFit.fill,
                                  ),
                                ],
                              ),
                            )
                          : Center(
                              child: Text(
                                mainVariables.reportsVariables.expiry.tableHeading[columnIndex],
                                maxLines: 2,
                                style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 12), overflow: TextOverflow.ellipsis, fontWeight: FontWeight.w600),
                                textAlign: TextAlign.center,
                              ),
                            );
                    },
                    rowsTitleBuilder: (int rowIndex) {
                      return Center(
                        child: Text(
                          ((mainVariables.reportsVariables.currentPage - 1) * 10) + (rowIndex + 1) < 10
                              ? "0${((mainVariables.reportsVariables.currentPage - 1) * 10) + (rowIndex + 1)}"
                              : "${((mainVariables.reportsVariables.currentPage - 1) * 10) + (rowIndex + 1)}",
                          maxLines: 2,
                          style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 12), overflow: TextOverflow.ellipsis, fontWeight: FontWeight.normal),
                        ),
                      );
                    },
                    contentCellBuilder: (int columnIndex, int rowIndex) {
                      return columnIndex == 0
                          ? const SizedBox()
                          : Center(
                              child: Text(
                                mainVariables.reportsVariables.expiry.tableData[rowIndex][columnIndex],
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 12), overflow: TextOverflow.ellipsis, fontWeight: FontWeight.normal, color: columnIndex == 5 ? Colors.red : Colors.black),
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
                              mainFunctions.getWidgetWidth(width: 0),
                              mainFunctions.getWidgetWidth(width: 105),
                              mainFunctions.getWidgetWidth(width: 105),
                              mainFunctions.getWidgetWidth(width: 105),
                              mainFunctions.getWidgetWidth(width: 100),
                              mainFunctions.getWidgetWidth(width: 100),
                              mainFunctions.getWidgetWidth(width: 90),
                            ]
                          : [
                              mainFunctions.getWidgetHeight(height: 0),
                              mainFunctions.getWidgetHeight(height: 150),
                              mainFunctions.getWidgetHeight(height: 150),
                              mainFunctions.getWidgetHeight(height: 150),
                              mainFunctions.getWidgetHeight(height: 145),
                              mainFunctions.getWidgetHeight(height: 145),
                              mainFunctions.getWidgetHeight(height: 145),
                            ],
                      contentCellHeight: 40,
                      stickyLegendWidth: 40,
                      stickyLegendHeight: 40,
                    ),
                  ),
                ),
        );
      case 3:
        return Expanded(
          child: mainVariables.reportsVariables.dispute.tableData.isEmpty
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
                      const Text("No dispute reports found"),
                    ],
                  ),
                )
              : Padding(
                  padding: EdgeInsets.symmetric(horizontal: mainFunctions.getWidgetWidth(width: 20)),
                  child: StickyHeadersTable(
                    columnsLength: mainVariables.reportsVariables.dispute.tableHeading.length,
                    rowsLength: mainVariables.reportsVariables.dispute.tableData.length,
                    showHorizontalScrollbar: false,
                    showVerticalScrollbar: false,
                    columnsTitleBuilder: (int columnIndex) {
                      return columnIndex == 1
                          ? InkWell(
                              onTap: () {
                                mainVariables.reportsVariables.sortInt = (mainVariables.reportsVariables.sortInt * -1);
                                context.read<ReportsBloc>().add(const ReportsFilterEvent());
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    mainVariables.reportsVariables.dispute.tableHeading[columnIndex],
                                    maxLines: 2,
                                    style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 12), overflow: TextOverflow.ellipsis, fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    width: mainFunctions.getWidgetWidth(width: 6),
                                  ),
                                  Image.asset(
                                    "assets/reports/arrow_up_down.png",
                                    height: mainFunctions.getWidgetHeight(height: 8),
                                    width: mainFunctions.getWidgetWidth(width: 6),
                                    fit: BoxFit.fill,
                                  ),
                                ],
                              ),
                            )
                          : Center(
                              child: Text(
                                mainVariables.reportsVariables.dispute.tableHeading[columnIndex],
                                maxLines: 2,
                                style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 12), overflow: TextOverflow.ellipsis, fontWeight: FontWeight.w600),
                              ),
                            );
                    },
                    rowsTitleBuilder: (int rowIndex) {
                      return Center(
                        child: Text(
                          ((mainVariables.reportsVariables.currentPage - 1) * 10) + (rowIndex + 1) < 10
                              ? "0${((mainVariables.reportsVariables.currentPage - 1) * 10) + (rowIndex + 1)}"
                              : "${((mainVariables.reportsVariables.currentPage - 1) * 10) + (rowIndex + 1)}",
                          maxLines: 2,
                          style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 12), overflow: TextOverflow.ellipsis, fontWeight: FontWeight.normal),
                        ),
                      );
                    },
                    contentCellBuilder: (int columnIndex, int rowIndex) {
                      return columnIndex == 5
                          ? Center(
                              child: IconButton(
                                onPressed: () {
                                  mainVariables.reportsVariables.selectedResolutionIndex = rowIndex;
                                  mainVariables.generalVariables.currentPage.value = "resolution";
                                  mainVariables.reportsVariables.addDisputePageChanged = true;
                                  mainVariables.generalVariables.selectedDisputeId = mainVariables.reportsVariables.dispute.tableData[rowIndex][columnIndex + 1];
                                  mainVariables.generalVariables.selectedTransId = mainVariables.reportsVariables.dispute.tableData[rowIndex][columnIndex + 2];
                                  mainVariables.generalVariables.railNavigateBackIndex = mainVariables.generalVariables.railNavigateIndex;
                                  mainVariables.generalVariables.railNavigateIndex = 13;
                                  context.read<RailNavigationBloc>().add(const RailNavigationSelectedWidgetEvent());
                                },
                                icon: Icon(
                                  Icons.visibility_outlined,
                                  size: 24,
                                  color: mainVariables.reportsVariables.dispute.tableData[rowIndex][columnIndex] == "true" ? /*const Color(0xffF92C38)*/ const Color(0xff037847): const Color(0xffF92C38),
                                ),
                              ),
                            )
                          : Center(
                              child: Text(
                                mainVariables.reportsVariables.dispute.tableData[rowIndex][columnIndex],
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 12), overflow: TextOverflow.ellipsis, fontWeight: FontWeight.normal),
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
                              mainFunctions.getWidgetWidth(width: 100),
                              mainFunctions.getWidgetWidth(width: 110),
                              mainFunctions.getWidgetWidth(width: 110),
                              mainFunctions.getWidgetWidth(width: 110),
                              mainFunctions.getWidgetWidth(width: 70),
                              mainFunctions.getWidgetWidth(width: 110),
                            ]
                          : [
                              mainFunctions.getWidgetHeight(height: 150),
                              mainFunctions.getWidgetHeight(height: 160),
                              mainFunctions.getWidgetHeight(height: 160),
                              mainFunctions.getWidgetHeight(height: 160),
                              mainFunctions.getWidgetHeight(height: 120),
                              mainFunctions.getWidgetHeight(height: 160),
                            ],
                      contentCellHeight: 40,
                      stickyLegendWidth: 40,
                      stickyLegendHeight: 40,
                    ),
                  ),
                ),
        );
      case 4:
        return Expanded(
          child: mainVariables.reportsVariables.transaction.tableData.isEmpty
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
                      const Text("No transaction reports found"),
                    ],
                  ),
                )
              : DataTable2(
                  columnSpacing: 15,
                  horizontalMargin: 15,
                  fixedLeftColumns: 2,
                  dividerThickness: 0.0,
                  dataRowHeight: 40,
                  minWidth: mainVariables.reportsVariables.transaction.tableHeading.length * mainFunctions.getWidgetWidth(width: 150),
                  columns: List.generate(
                    mainVariables.reportsVariables.transaction.tableHeading.length,
                    (index) => DataColumn2(
                        label: Center(
                          child: Text(
                            mainVariables.reportsVariables.transaction.tableHeading[index],
                            maxLines: 2,
                            style: TextStyle(
                              fontSize: mainFunctions.getTextSize(fontSize: 14),
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Figtree",
                            ),
                          ),
                        ),
                        size: ColumnSize.L,
                        fixedWidth: mainFunctions.getWidgetWidth(width: index == 0 ? 45 : 135)),
                  ),
                  rows: List<DataRow>.generate(
                    mainVariables.reportsVariables.transaction.tableData.length,
                    (rowIndex) => DataRow(
                      cells: List.generate(
                          mainVariables.reportsVariables.transaction.tableHeading.length,
                          (columnIndex) => columnIndex == 0
                              ? DataCell(
                                  Center(
                                    child: Text(
                                      ((mainVariables.reportsVariables.currentPage - 1) * 10) + (rowIndex + 1) < 10
                                          ? "0${((mainVariables.reportsVariables.currentPage - 1) * 10) + (rowIndex + 1)}"
                                          : "${((mainVariables.reportsVariables.currentPage - 1) * 10) + (rowIndex + 1)}",
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: mainFunctions.getTextSize(fontSize: 12),
                                        overflow: TextOverflow.ellipsis,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "Figtree",
                                      ),
                                    ),
                                  ),
                                )
                              : columnIndex == 1
                                  ? DataCell(
                                      InkWell(
                                        onTap: () {
                                          mainVariables.generalVariables.selectedTransId = mainVariables.reportsVariables.transaction.tableData[rowIndex][columnIndex];
                                          mainVariables.generalVariables.railNavigateBackIndex = mainVariables.generalVariables.railNavigateIndex;
                                          mainVariables.generalVariables.railNavigateIndex = 9;
                                          mainVariables.receivedStocksVariables.pageState = "reports";
                                          context.read<RailNavigationBloc>().add(const RailNavigationSelectedWidgetEvent());
                                        },
                                        child: Center(
                                          child: Text(
                                            mainVariables.reportsVariables.transaction.tableData[rowIndex][columnIndex],
                                            maxLines: 2,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: mainFunctions.getTextSize(fontSize: 12),
                                              overflow: TextOverflow.ellipsis,
                                              fontWeight: FontWeight.w500,
                                              color: const Color(0xff007BFE),
                                              fontFamily: "Figtree",
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : DataCell(
                                      Center(
                                        child: Text(
                                          mainVariables.reportsVariables.transaction.tableData[rowIndex][columnIndex],
                                          maxLines: 2,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: mainFunctions.getTextSize(fontSize: 12),
                                            overflow: TextOverflow.ellipsis,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "Figtree",
                                          ),
                                        ),
                                      ),
                                    )),
                    ),
                  ),
                ),
        );
      case 5:
        return Expanded(
          child: mainVariables.reportsVariables.cabinGalley.tableData.isEmpty
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
                      const Text("No Cabin & Galley reports found"),
                    ],
                  ),
                )
              : DataTable2(
                  columnSpacing: 15,
                  horizontalMargin: 15,
                  fixedLeftColumns: 2,
                  dividerThickness: 0.0,
                  dataRowHeight: 40,
                  minWidth: mainVariables.reportsVariables.cabinGalley.tableHeading.length * mainFunctions.getWidgetWidth(width: 150),
                  columns: List.generate(
                    mainVariables.reportsVariables.cabinGalley.tableHeading.length,
                    (index) => DataColumn2(
                        label: index == 2
                            ? InkWell(
                                onTap: () {
                                  mainVariables.reportsVariables.sortInt = (mainVariables.reportsVariables.sortInt * -1);
                                  context.read<ReportsBloc>().add(const ReportsFilterEvent());
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      mainVariables.reportsVariables.cabinGalley.tableHeading[index],
                                      maxLines: 2,
                                      style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 12), overflow: TextOverflow.ellipsis, fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      width: mainFunctions.getWidgetWidth(width: 6),
                                    ),
                                    Image.asset(
                                      "assets/reports/arrow_up_down.png",
                                      height: mainFunctions.getWidgetHeight(height: 8),
                                      width: mainFunctions.getWidgetWidth(width: 6),
                                      fit: BoxFit.fill,
                                    ),
                                  ],
                                ),
                              )
                            : Center(
                                child: Text(
                                  mainVariables.reportsVariables.cabinGalley.tableHeading[index],
                                  maxLines: 2,
                                  style: TextStyle(
                                    fontSize: mainFunctions.getTextSize(fontSize: 14),
                                    overflow: TextOverflow.ellipsis,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Figtree",
                                  ),
                                ),
                              ),
                        size: ColumnSize.L,
                        fixedWidth: mainFunctions.getWidgetWidth(width: index == 0 ? 45 : 135)),
                  ),
                  rows: List<DataRow>.generate(
                    mainVariables.reportsVariables.cabinGalley.tableData.length,
                    (rowIndex) => DataRow(
                      cells: List.generate(
                          mainVariables.reportsVariables.cabinGalley.tableHeading.length,
                          (columnIndex) => columnIndex == 0
                              ? DataCell(
                                  Center(
                                    child: Text(
                                      ((mainVariables.reportsVariables.currentPage - 1) * 10) + (rowIndex + 1) < 10
                                          ? "0${((mainVariables.reportsVariables.currentPage - 1) * 10) + (rowIndex + 1)}"
                                          : "${((mainVariables.reportsVariables.currentPage - 1) * 10) + (rowIndex + 1)}",
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: mainFunctions.getTextSize(fontSize: 12),
                                        overflow: TextOverflow.ellipsis,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "Figtree",
                                      ),
                                    ),
                                  ),
                                )
                              : columnIndex == 1
                                  ? DataCell(InkWell(
                                      onTap: () {
                                        mainVariables.generalVariables.selectedTransId = mainVariables.reportsVariables.cabinGalley.tableData[rowIndex][columnIndex - 1];
                                        mainVariables.generalVariables.railNavigateBackIndex = mainVariables.generalVariables.railNavigateIndex;
                                        mainVariables.generalVariables.railNavigateIndex = 9;
                                        mainVariables.receivedStocksVariables.pageState = "reports";
                                        context.read<RailNavigationBloc>().add(const RailNavigationSelectedWidgetEvent());
                                      },
                                      child: Center(
                                          child: Text(
                                        mainVariables.reportsVariables.cabinGalley.tableData[rowIndex][columnIndex - 1],
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 12), overflow: TextOverflow.ellipsis, fontWeight: FontWeight.normal, color: const Color(0xff007BFE)),
                                      )),
                                    ))
                                  : DataCell(
                                      Center(
                                        child: Text(
                                          mainVariables.reportsVariables.cabinGalley.tableData[rowIndex][columnIndex - 1],
                                          maxLines: 2,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: mainFunctions.getTextSize(fontSize: 12),
                                            overflow: TextOverflow.ellipsis,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "Figtree",
                                          ),
                                        ),
                                      ),
                                    )),
                    ),
                  ),
                ),
        );
      case 6:
        return Expanded(
          child: mainVariables.reportsVariables.preflight.tableData.isEmpty
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
                      const Text("No Preflight reports found"),
                    ],
                  ),
                )
              : DataTable2(
                  columnSpacing: 15,
                  horizontalMargin: 15,
                  fixedLeftColumns: 2,
                  dividerThickness: 0.0,
                  dataRowHeight: 40,
                  minWidth: mainVariables.reportsVariables.preflight.tableHeading.length * mainFunctions.getWidgetWidth(width: 150),
                  columns: List.generate(
                    mainVariables.reportsVariables.preflight.tableHeading.length,
                    (index) => DataColumn2(
                        label: index == 2
                            ? InkWell(
                                onTap: () {
                                  mainVariables.reportsVariables.sortInt = (mainVariables.reportsVariables.sortInt * -1);
                                  context.read<ReportsBloc>().add(const ReportsFilterEvent());
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      mainVariables.reportsVariables.preflight.tableHeading[index],
                                      maxLines: 2,
                                      style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 12), overflow: TextOverflow.ellipsis, fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      width: mainFunctions.getWidgetWidth(width: 6),
                                    ),
                                    Image.asset(
                                      "assets/reports/arrow_up_down.png",
                                      height: mainFunctions.getWidgetHeight(height: 8),
                                      width: mainFunctions.getWidgetWidth(width: 6),
                                      fit: BoxFit.fill,
                                    ),
                                  ],
                                ),
                              )
                            : Center(
                                child: Text(
                                  mainVariables.reportsVariables.preflight.tableHeading[index],
                                  maxLines: 2,
                                  style: TextStyle(
                                    fontSize: mainFunctions.getTextSize(fontSize: 14),
                                    overflow: TextOverflow.ellipsis,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Figtree",
                                  ),
                                ),
                              ),
                        size: ColumnSize.L,
                        fixedWidth: mainFunctions.getWidgetWidth(width: index == 0 ? 45 : 135)),
                  ),
                  rows: List<DataRow>.generate(
                    mainVariables.reportsVariables.preflight.tableData.length,
                    (rowIndex) => DataRow(
                      cells: List.generate(
                          mainVariables.reportsVariables.preflight.tableHeading.length,
                          (columnIndex) => columnIndex == 0
                              ? DataCell(
                                  Center(
                                    child: Text(
                                      ((mainVariables.reportsVariables.currentPage - 1) * 10) + (rowIndex + 1) < 10
                                          ? "0${((mainVariables.reportsVariables.currentPage - 1) * 10) + (rowIndex + 1)}"
                                          : "${((mainVariables.reportsVariables.currentPage - 1) * 10) + (rowIndex + 1)}",
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: mainFunctions.getTextSize(fontSize: 12),
                                        overflow: TextOverflow.ellipsis,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "Figtree",
                                      ),
                                    ),
                                  ),
                                )
                              : columnIndex == 1
                                  ? DataCell(InkWell(
                                      onTap: () {
                                        mainVariables.checkListVariables = CheckListVariables.fromJson({});
                                        mainVariables.checkListVariables.checkListSelectedIndex = 0;
                                        mainVariables.generalVariables.selectedCheckListId = mainVariables.reportsVariables.preflight.tableData[rowIndex][0];
                                        context.read<CheckListBloc>().add(const CheckListPageInitialEvent());
                                        mainVariables.generalVariables.railNavigateBackIndex = mainVariables.generalVariables.railNavigateIndex;
                                        mainVariables.generalVariables.railNavigateIndex = 5;
                                        mainVariables.generalVariables.currentPage.value = "view_check_list";
                                        context.read<RailNavigationBloc>().add(const RailNavigationSelectedWidgetEvent());
                                      },
                                      child: Center(
                                          child: Text(
                                        mainVariables.reportsVariables.preflight.tableData[rowIndex][columnIndex - 1],
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 12), overflow: TextOverflow.ellipsis, fontWeight: FontWeight.normal, color: const Color(0xff007BFE)),
                                      )),
                                    ))
                                  : DataCell(
                                      Center(
                                        child: Text(
                                          mainVariables.reportsVariables.preflight.tableData[rowIndex][columnIndex - 1],
                                          maxLines: 2,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: mainFunctions.getTextSize(fontSize: 12),
                                            overflow: TextOverflow.ellipsis,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "Figtree",
                                          ),
                                        ),
                                      ),
                                    )),
                    ),
                  ),
                ),
        );
      case 7:
        return Expanded(
          child: mainVariables.reportsVariables.postFlight.tableData.isEmpty
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
                      const Text("No post flight reports found"),
                    ],
                  ),
                )
              : DataTable2(
                  columnSpacing: 15,
                  horizontalMargin: 15,
                  fixedLeftColumns: 2,
                  dividerThickness: 0.0,
                  dataRowHeight: 40,
                  minWidth: mainVariables.reportsVariables.postFlight.tableHeading.length * mainFunctions.getWidgetWidth(width: 150),
                  columns: List.generate(
                    mainVariables.reportsVariables.postFlight.tableHeading.length,
                    (index) => DataColumn2(
                        label: index == 2
                            ? InkWell(
                                onTap: () {
                                  mainVariables.reportsVariables.sortInt = (mainVariables.reportsVariables.sortInt * -1);
                                  context.read<ReportsBloc>().add(const ReportsFilterEvent());
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      mainVariables.reportsVariables.postFlight.tableHeading[index],
                                      maxLines: 2,
                                      style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 12), overflow: TextOverflow.ellipsis, fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      width: mainFunctions.getWidgetWidth(width: 6),
                                    ),
                                    Image.asset(
                                      "assets/reports/arrow_up_down.png",
                                      height: mainFunctions.getWidgetHeight(height: 8),
                                      width: mainFunctions.getWidgetWidth(width: 6),
                                      fit: BoxFit.fill,
                                    ),
                                  ],
                                ),
                              )
                            : Center(
                                child: Text(
                                  mainVariables.reportsVariables.postFlight.tableHeading[index],
                                  maxLines: 2,
                                  style: TextStyle(
                                    fontSize: mainFunctions.getTextSize(fontSize: 14),
                                    overflow: TextOverflow.ellipsis,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Figtree",
                                  ),
                                ),
                              ),
                        size: ColumnSize.L,
                        fixedWidth: mainFunctions.getWidgetWidth(width: index == 0 ? 45 : 135)),
                  ),
                  rows: List<DataRow>.generate(
                    mainVariables.reportsVariables.postFlight.tableData.length,
                    (rowIndex) => DataRow(
                      cells: List.generate(
                          mainVariables.reportsVariables.postFlight.tableHeading.length,
                          (columnIndex) => columnIndex == 0
                              ? DataCell(
                                  Center(
                                    child: Text(
                                      ((mainVariables.reportsVariables.currentPage - 1) * 10) + (rowIndex + 1) < 10
                                          ? "0${((mainVariables.reportsVariables.currentPage - 1) * 10) + (rowIndex + 1)}"
                                          : "${((mainVariables.reportsVariables.currentPage - 1) * 10) + (rowIndex + 1)}",
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: mainFunctions.getTextSize(fontSize: 12),
                                        overflow: TextOverflow.ellipsis,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "Figtree",
                                      ),
                                    ),
                                  ),
                                )
                              : columnIndex == 1
                                  ? DataCell(InkWell(
                                      onTap: () {
                                        mainVariables.checkListVariables = CheckListVariables.fromJson({});
                                        mainVariables.checkListVariables.checkListSelectedIndex = 1;
                                        mainVariables.generalVariables.selectedCheckListId = mainVariables.reportsVariables.postFlight.tableData[rowIndex][0];
                                        context.read<CheckListBloc>().add(const CheckListPageInitialEvent());
                                        mainVariables.generalVariables.railNavigateBackIndex = mainVariables.generalVariables.railNavigateIndex;
                                        mainVariables.generalVariables.railNavigateIndex = 5;
                                        mainVariables.generalVariables.currentPage.value = "view_check_list";
                                        context.read<RailNavigationBloc>().add(const RailNavigationSelectedWidgetEvent());
                                      },
                                      child: Center(
                                          child: Text(
                                        mainVariables.reportsVariables.postFlight.tableData[rowIndex][columnIndex - 1],
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 12), overflow: TextOverflow.ellipsis, fontWeight: FontWeight.normal, color: const Color(0xff007BFE)),
                                      )),
                                    ))
                                  : DataCell(
                                      Center(
                                        child: Text(
                                          mainVariables.reportsVariables.postFlight.tableData[rowIndex][columnIndex - 1],
                                          maxLines: 2,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: mainFunctions.getTextSize(fontSize: 12),
                                            overflow: TextOverflow.ellipsis,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "Figtree",
                                          ),
                                        ),
                                      ),
                                    )),
                    ),
                  ),
                ),
        );
      case 8:
        return Expanded(
          child: mainVariables.reportsVariables.maintenance.tableData.isEmpty
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
                      const Text("No maintenance reports found"),
                    ],
                  ),
                )
              : DataTable2(
                  columnSpacing: 15,
                  horizontalMargin: 15,
                  fixedLeftColumns: 2,
                  dividerThickness: 0.0,
                  dataRowHeight: 40,
                  minWidth: mainVariables.reportsVariables.maintenance.tableHeading.length * mainFunctions.getWidgetWidth(width: 150),
                  columns: List.generate(
                    mainVariables.reportsVariables.maintenance.tableHeading.length,
                    (index) => DataColumn2(
                        label: index == 2
                            ? InkWell(
                                onTap: () {
                                  mainVariables.reportsVariables.sortInt = (mainVariables.reportsVariables.sortInt * -1);
                                  context.read<ReportsBloc>().add(const ReportsFilterEvent());
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      mainVariables.reportsVariables.maintenance.tableHeading[index],
                                      maxLines: 2,
                                      style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 12), overflow: TextOverflow.ellipsis, fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      width: mainFunctions.getWidgetWidth(width: 6),
                                    ),
                                    Image.asset(
                                      "assets/reports/arrow_up_down.png",
                                      height: mainFunctions.getWidgetHeight(height: 8),
                                      width: mainFunctions.getWidgetWidth(width: 6),
                                      fit: BoxFit.fill,
                                    ),
                                  ],
                                ),
                              )
                            : Center(
                                child: Text(
                                  mainVariables.reportsVariables.maintenance.tableHeading[index],
                                  maxLines: 2,
                                  style: TextStyle(
                                    fontSize: mainFunctions.getTextSize(fontSize: 14),
                                    overflow: TextOverflow.ellipsis,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Figtree",
                                  ),
                                ),
                              ),
                        size: ColumnSize.L,
                        fixedWidth: mainFunctions.getWidgetWidth(width: index == 0 ? 45 : 135)),
                  ),
                  rows: List<DataRow>.generate(
                    mainVariables.reportsVariables.maintenance.tableData.length,
                    (rowIndex) => DataRow(
                      cells: List.generate(
                          mainVariables.reportsVariables.maintenance.tableHeading.length,
                          (columnIndex) => columnIndex == 0
                              ? DataCell(
                                  Center(
                                    child: Text(
                                      ((mainVariables.reportsVariables.currentPage - 1) * 10) + (rowIndex + 1) < 10
                                          ? "0${((mainVariables.reportsVariables.currentPage - 1) * 10) + (rowIndex + 1)}"
                                          : "${((mainVariables.reportsVariables.currentPage - 1) * 10) + (rowIndex + 1)}",
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: mainFunctions.getTextSize(fontSize: 12),
                                        overflow: TextOverflow.ellipsis,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "Figtree",
                                      ),
                                    ),
                                  ),
                                )
                              : columnIndex == 1
                                  ? DataCell(InkWell(
                                      onTap: () {
                                        mainVariables.checkListVariables = CheckListVariables.fromJson({});
                                        mainVariables.checkListVariables.checkListSelectedIndex = 2;
                                        mainVariables.generalVariables.selectedCheckListId = mainVariables.reportsVariables.maintenance.tableData[rowIndex][0];
                                        context.read<CheckListBloc>().add(const CheckListPageInitialEvent());
                                        mainVariables.generalVariables.railNavigateBackIndex = mainVariables.generalVariables.railNavigateIndex;
                                        mainVariables.generalVariables.railNavigateIndex = 5;
                                        mainVariables.generalVariables.currentPage.value = "view_check_list";
                                        context.read<RailNavigationBloc>().add(const RailNavigationSelectedWidgetEvent());
                                      },
                                      child: Center(
                                          child: Text(
                                        mainVariables.reportsVariables.maintenance.tableData[rowIndex][columnIndex - 1],
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 12), overflow: TextOverflow.ellipsis, fontWeight: FontWeight.normal, color: const Color(0xff007BFE)),
                                      )),
                                    ))
                                  : DataCell(
                                      Center(
                                        child: Text(
                                          mainVariables.reportsVariables.maintenance.tableData[rowIndex][columnIndex - 1],
                                          maxLines: 2,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: mainFunctions.getTextSize(fontSize: 12),
                                            overflow: TextOverflow.ellipsis,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "Figtree",
                                          ),
                                        ),
                                      ),
                                    )),
                    ),
                  ),
                ),
        );
      case 9:
        return Expanded(
          child: mainVariables.reportsVariables.safety.tableData.isEmpty
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
                      const Text("No safety reports found"),
                    ],
                  ),
                )
              : DataTable2(
                  columnSpacing: 15,
                  horizontalMargin: 15,
                  fixedLeftColumns: 2,
                  dividerThickness: 0.0,
                  dataRowHeight: 40,
                  minWidth: mainVariables.reportsVariables.safety.tableHeading.length * mainFunctions.getWidgetWidth(width: 150),
                  columns: List.generate(
                    mainVariables.reportsVariables.safety.tableHeading.length,
                    (index) => DataColumn2(
                        label: index == 2
                            ? InkWell(
                                onTap: () {
                                  mainVariables.reportsVariables.sortInt = (mainVariables.reportsVariables.sortInt * -1);
                                  context.read<ReportsBloc>().add(const ReportsFilterEvent());
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      mainVariables.reportsVariables.safety.tableHeading[index],
                                      maxLines: 2,
                                      style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 12), overflow: TextOverflow.ellipsis, fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      width: mainFunctions.getWidgetWidth(width: 6),
                                    ),
                                    Image.asset(
                                      "assets/reports/arrow_up_down.png",
                                      height: mainFunctions.getWidgetHeight(height: 8),
                                      width: mainFunctions.getWidgetWidth(width: 6),
                                      fit: BoxFit.fill,
                                    ),
                                  ],
                                ),
                              )
                            : Center(
                                child: Text(
                                  mainVariables.reportsVariables.safety.tableHeading[index],
                                  maxLines: 2,
                                  style: TextStyle(
                                    fontSize: mainFunctions.getTextSize(fontSize: 14),
                                    overflow: TextOverflow.ellipsis,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Figtree",
                                  ),
                                ),
                              ),
                        size: ColumnSize.L,
                        fixedWidth: mainFunctions.getWidgetWidth(width: index == 0 ? 45 : 135)),
                  ),
                  rows: List<DataRow>.generate(
                    mainVariables.reportsVariables.safety.tableData.length,
                    (rowIndex) => DataRow(
                      cells: List.generate(
                          mainVariables.reportsVariables.safety.tableHeading.length,
                          (columnIndex) => columnIndex == 0
                              ? DataCell(
                                  Center(
                                    child: Text(
                                      ((mainVariables.reportsVariables.currentPage - 1) * 10) + (rowIndex + 1) < 10
                                          ? "0${((mainVariables.reportsVariables.currentPage - 1) * 10) + (rowIndex + 1)}"
                                          : "${((mainVariables.reportsVariables.currentPage - 1) * 10) + (rowIndex + 1)}",
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: mainFunctions.getTextSize(fontSize: 12),
                                        overflow: TextOverflow.ellipsis,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "Figtree",
                                      ),
                                    ),
                                  ),
                                )
                              : columnIndex == 1
                                  ? DataCell(InkWell(
                                      onTap: () {
                                        mainVariables.checkListVariables = CheckListVariables.fromJson({});
                                        mainVariables.checkListVariables.checkListSelectedIndex = 2;
                                        mainVariables.generalVariables.selectedCheckListId = mainVariables.reportsVariables.safety.tableData[rowIndex][0];
                                        context.read<CheckListBloc>().add(const CheckListPageInitialEvent());
                                        mainVariables.generalVariables.railNavigateBackIndex = mainVariables.generalVariables.railNavigateIndex;
                                        mainVariables.generalVariables.railNavigateIndex = 5;
                                        mainVariables.generalVariables.currentPage.value = "view_check_list";
                                        context.read<RailNavigationBloc>().add(const RailNavigationSelectedWidgetEvent());
                                      },
                                      child: Center(
                                          child: Text(
                                        mainVariables.reportsVariables.safety.tableData[rowIndex][columnIndex - 1],
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 12), overflow: TextOverflow.ellipsis, fontWeight: FontWeight.normal, color: const Color(0xff007BFE)),
                                      )),
                                    ))
                                  : DataCell(
                                      Center(
                                        child: Text(
                                          mainVariables.reportsVariables.safety.tableData[rowIndex][columnIndex - 1],
                                          maxLines: 2,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: mainFunctions.getTextSize(fontSize: 12),
                                            overflow: TextOverflow.ellipsis,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "Figtree",
                                          ),
                                        ),
                                      ),
                                    )),
                    ),
                  ),
                ),
        );
      default:
        return Container();
    }
  }

  Widget paginationConditionWidget() {
    switch (mainVariables.reportsVariables.reportsSelectedIndex) {
      case 0:
        return mainVariables.reportsVariables.overall.tableData.isEmpty ? const SizedBox() : paginationWidget();
      case 1:
        return mainVariables.reportsVariables.lowStock.tableData.isEmpty ? const SizedBox() : paginationWidget();
      case 2:
        return mainVariables.reportsVariables.expiry.tableData.isEmpty ? const SizedBox() : paginationWidget();
      case 3:
        return mainVariables.reportsVariables.dispute.tableData.isEmpty ? const SizedBox() : paginationWidget();
      case 4:
        return mainVariables.reportsVariables.transaction.tableData.isEmpty ? const SizedBox() : paginationWidget();
      case 5:
        return mainVariables.reportsVariables.cabinGalley.tableData.isEmpty ? const SizedBox() : paginationWidget();
      case 6:
        return mainVariables.reportsVariables.preflight.tableData.isEmpty ? const SizedBox() : paginationWidget();
      case 7:
        return mainVariables.reportsVariables.postFlight.tableData.isEmpty ? const SizedBox() : paginationWidget();
      case 8:
        return mainVariables.reportsVariables.maintenance.tableData.isEmpty ? const SizedBox() : paginationWidget();
      case 9:
        return mainVariables.reportsVariables.safety.tableData.isEmpty ? const SizedBox() : paginationWidget();
      default:
        return Container();
    }
  }

  Widget paginationWidget() {
    return Center(
      child: SizedBox(
        width: mainFunctions.getWidgetWidth(width: 450),
        child: NumberPaginator(
          initialPage: mainVariables.reportsVariables.numberController!.currentPage,
          controller: mainVariables.reportsVariables.numberController,
          numberPages: mainVariables.reportsVariables.totalPages,
          onPageChange: (int index) {
            mainVariables.reportsVariables.currentPage = index + 1;
            context.read<ReportsBloc>().add(const ReportsFilterEvent());
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
    );
  }
}
