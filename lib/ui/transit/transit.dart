import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:tvsaviation/bloc/rail_navigation/rail_navigation_bloc.dart';
import 'package:tvsaviation/bloc/transit/transit_bloc.dart';
import 'package:tvsaviation/resources/constants.dart';

class TransitScreen extends StatefulWidget {
  static const String id = "transit";

  const TransitScreen({super.key});

  @override
  State<TransitScreen> createState() => _TransitScreenState();
}

class _TransitScreenState extends State<TransitScreen> {
  @override
  void initState() {
    context.read<TransitBloc>().add(const TransitInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvoked: (value) {
          mainVariables.transitVariables.receivedPageOpened = false;
          mainVariables.transitVariables.currentPage = 1;
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
          InkWell(
            onTap: () {
              mainVariables.transitVariables.receivedPageOpened = false;
              mainVariables.transitVariables.currentPage = 1;
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
                    "Transit",
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
          Container(
            height: mainFunctions.getWidgetHeight(height: 60),
            padding: EdgeInsets.symmetric(horizontal: mainFunctions.getWidgetWidth(width: 12), vertical: mainFunctions.getWidgetHeight(height: 12)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TextFormField(
                    onChanged: (value) {
                      mainVariables.transitVariables.currentPage = 1;
                      context.read<TransitBloc>().add(const TransitFilterEvent());
                    },
                    controller: mainVariables.transitVariables.searchController,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: mainFunctions.getTextSize(fontSize: 15), color: mainColors.blackColor),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      fillColor: const Color(0xFF767680).withOpacity(0.12),
                      filled: true,
                      prefixIcon: Icon(
                        Icons.search,
                        color: const Color(0XFF3C3C43).withOpacity(0.6),
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
                  onTap: () async {
                    context.read<TransitBloc>().add(const DownloadFileEvent());
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
          Expanded(child: tableWidget()),
          BlocBuilder<TransitBloc, TransitState>(
            builder: (BuildContext context, TransitState transit) {
              if (transit is TransitLoaded) {
                return mainVariables.transitVariables.overallTransit.tableData.isEmpty
                    ? const SizedBox()
                    : Center(
                        child: SizedBox(
                          width: mainFunctions.getWidgetWidth(width: 450),
                          child: NumberPaginator(
                            initialPage: mainVariables.transitVariables.currentPage - 1,
                            numberPages: mainVariables.transitVariables.totalPages,
                            onPageChange: (int index) {
                              setState(() {
                                mainVariables.transitVariables.currentPage = index + 1;
                              });
                              context.read<TransitBloc>().add(const TransitFilterEvent());
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
              } else if (transit is TransitLoading) {
                return mainVariables.transitVariables.overallTransit.tableData.isEmpty
                    ? const SizedBox()
                    : Center(
                        child: SizedBox(
                          width: mainFunctions.getWidgetWidth(width: 450),
                          child: NumberPaginator(
                            initialPage: mainVariables.transitVariables.currentPage - 1,
                            numberPages: mainVariables.transitVariables.totalPages,
                            onPageChange: (int index) {
                              mainVariables.transitVariables.currentPage = index + 1;
                              context.read<TransitBloc>().add(const TransitFilterEvent());
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
                return mainVariables.transitVariables.overallTransit.tableData.isEmpty
                    ? const SizedBox()
                    : Center(
                        child: SizedBox(
                          width: mainFunctions.getWidgetWidth(width: 450),
                          child: NumberPaginator(
                            initialPage: mainVariables.transitVariables.currentPage - 1,
                            numberPages: mainVariables.transitVariables.totalPages,
                            onPageChange: (int index) {
                              mainVariables.transitVariables.currentPage = index + 1;
                              context.read<TransitBloc>().add(const TransitFilterEvent());
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
          SizedBox(
            height: mainFunctions.getWidgetHeight(height: 50),
          ),
        ],
      ),
    );
  }

  Widget tableWidget() {
    return BlocConsumer<TransitBloc, TransitState>(
      listenWhen: (previous, current) {
        return previous != current;
      },
      buildWhen: (previous, current) {
        return previous != current;
      },
      listener: (BuildContext context, TransitState transit) {
        if (transit is TransitFailure) {
          mainWidgets.flushBarWidget(context: context, message: transit.errorMessage);
        } else if (transit is TransitSuccess) {
          mainWidgets.flushBarWidget(context: context, message: transit.message);
        }
      },
      builder: (BuildContext context, TransitState transit) {
        if (transit is TransitLoaded) {
          return mainVariables.transitVariables.overallTransit.tableData.isEmpty
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
                      const Text("Transit List is Empty"),
                    ],
                  ),
                )
              : DataTable2(
                  columnSpacing: 15,
                  horizontalMargin: 15,
                  fixedLeftColumns: 2,
                  dividerThickness: 0.0,
                  dataRowHeight: 40,
                  minWidth: mainVariables.transitVariables.overallTransit.tableHeading.length * mainFunctions.getWidgetWidth(width: 150),
                  columns: List.generate(
                    mainVariables.transitVariables.overallTransit.tableHeading.length,
                    (index) => DataColumn2(
                        label: Center(
                          child: Text(
                            mainVariables.transitVariables.overallTransit.tableHeading[index],
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
                    mainVariables.transitVariables.overallTransit.tableData.length,
                    (rowIndex) => DataRow(
                      cells: List.generate(
                        mainVariables.transitVariables.overallTransit.tableHeading.length,
                        (columnIndex) => columnIndex == 0
                            ? DataCell(
                                Center(
                                  child: Text(
                                    ((mainVariables.transitVariables.currentPage - 1) * 10) + (rowIndex + 1) < 10
                                        ? "0${((mainVariables.transitVariables.currentPage - 1) * 10) + (rowIndex + 1)}"
                                        : "${((mainVariables.transitVariables.currentPage - 1) * 10) + (rowIndex + 1)}",
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
                                        mainVariables.transitVariables.receivedPageOpened = true;
                                        mainVariables.generalVariables.selectedTransId = mainVariables.transitVariables.overallTransit.tableData[rowIndex][columnIndex - 1];
                                        mainVariables.generalVariables.railNavigateBackIndex = mainVariables.generalVariables.railNavigateIndex;
                                        mainVariables.generalVariables.railNavigateIndex = 9;
                                        mainVariables.receivedStocksVariables.pageState = "transit";
                                        context.read<RailNavigationBloc>().add(const RailNavigationSelectedWidgetEvent());
                                      },
                                      child: Center(
                                          child: Text(
                                        mainVariables.transitVariables.overallTransit.tableData[rowIndex][columnIndex - 1],
                                        style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 12), overflow: TextOverflow.ellipsis, fontWeight: FontWeight.normal, color: const Color(0xff007BFE)),
                                      )),
                                    ),
                                  )
                                : columnIndex == 2
                                    ? DataCell(Padding(
                                        padding: EdgeInsets.symmetric(horizontal: mainFunctions.getWidgetWidth(width: 8)),
                                        child: Lottie.asset(
                                          "assets/rail_navigation/moving_flight.json",
                                        ),
                                      ))
                                    : DataCell(Center(
                                        child: Text(
                                          mainVariables.transitVariables.overallTransit.tableData[rowIndex][columnIndex - 1],
                                          maxLines: 2,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 12), overflow: TextOverflow.ellipsis, fontWeight: FontWeight.normal),
                                        ),
                                      )),
                      ),
                    ),
                  ),
                );
        } else if (transit is TransitLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
