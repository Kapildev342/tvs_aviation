import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tvsaviation/bloc/notification/notification_bloc.dart';
import 'package:tvsaviation/bloc/rail_navigation/rail_navigation_bloc.dart';
import 'package:tvsaviation/data/model/api_model/notification_model.dart';
import 'package:tvsaviation/resources/constants.dart';

class NotificationScreen extends StatefulWidget {
  static const String id = "notification";

  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> with TickerProviderStateMixin {
  @override
  void initState() {
    mainVariables.notificationVariables.tabController = TabController(length: 6, vsync: this, initialIndex: 0);
    context.read<NotificationBloc>().add(NotificationInitialEvent(locationId: mainVariables.notificationVariables.locationId, index: 0));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvoked: (value) {
          mainVariables.generalVariables.railNavigateIndex = mainVariables.generalVariables.railNavigateBackIndex;
          context.read<RailNavigationBloc>().add(const RailNavigationBackWidgetEvent());
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
          InkWell(
            onTap: () {
              mainVariables.generalVariables.railNavigateIndex = mainVariables.generalVariables.railNavigateBackIndex;
              context.read<RailNavigationBloc>().add(const RailNavigationBackWidgetEvent());
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
                    "Notification",
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
            height: mainFunctions.getWidgetHeight(height: 6),
          ),
          BlocBuilder<NotificationBloc, NotificationState>(
            builder: (BuildContext context, NotificationState notify) {
              return TabBar(
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorColor: mainVariables.notificationVariables.tabsEnableList[0]
                      ? const Color(0xff2E70E8)
                      : mainVariables.notificationVariables.tabsEnableList[1]
                          ? const Color(0xff0C3788)
                          : mainVariables.notificationVariables.tabsEnableList[2]
                              ? const Color(0xffF85359)
                              : mainVariables.notificationVariables.tabsEnableList[3]
                                  ? const Color(0xffE1A900)
                                  : mainVariables.notificationVariables.tabsEnableList[4]
                                      ? const Color(0xffEF7606)
                                      : const Color(0xff037847),
                  indicatorWeight: 5,
                  isScrollable: true,
                  dividerHeight: 1,
                  dividerColor: const Color(0xffF2F4F7),
                  tabAlignment: TabAlignment.start,
                  onTap: (value) {
                    context.read<NotificationBloc>().add(NotificationInitialEvent(locationId: mainVariables.notificationVariables.locationId, index: value));
                  },
                  controller: mainVariables.notificationVariables.tabController,
                  tabs: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("All",
                            style: TextStyle(
                                color: mainVariables.notificationVariables.tabsEnableList[0] ? const Color(0xff2E70E8) : const Color(0xffD3D3D3),
                                fontSize: mainFunctions.getTextSize(fontSize: 14),
                                fontWeight: FontWeight.w600,
                                overflow: TextOverflow.ellipsis)),
                        SizedBox(
                          width: mainFunctions.getWidgetWidth(width: 5),
                        ),
                        mainVariables.notificationVariables.unreadCountAll == 0
                            ? const SizedBox()
                            : Container(
                                height: mainFunctions.getWidgetHeight(height: 16),
                                width: mainFunctions.getWidgetWidth(width: 24),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(26),
                                  color: mainVariables.notificationVariables.tabsEnableList[0] ? const Color(0xff2E70E8) : const Color(0xffF2F2F2),
                                ),
                                child: Center(
                                  child: Text(
                                    mainVariables.notificationVariables.unreadCountAll.toString(),
                                    style: mainTextStyle.labelTextStyle.copyWith(fontWeight: FontWeight.w500, color: mainVariables.notificationVariables.tabsEnableList[0] ? const Color(0xffF4F4F4) : const Color(0xff334155), fontSize: 10),
                                  ),
                                ),
                              ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Transit",
                            style: TextStyle(
                                color: mainVariables.notificationVariables.tabsEnableList[1] ? const Color(0xff0C3788) : const Color(0xffD3D3D3),
                                fontSize: mainFunctions.getTextSize(fontSize: 14),
                                fontWeight: FontWeight.w600,
                                overflow: TextOverflow.ellipsis)),
                        SizedBox(
                          width: mainFunctions.getWidgetWidth(width: 5),
                        ),
                        mainVariables.notificationVariables.unreadCountTransit == 0
                            ? const SizedBox()
                            : Container(
                                height: mainFunctions.getWidgetHeight(height: 16),
                                width: mainFunctions.getWidgetWidth(width: 24),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(26),
                                  color: mainVariables.notificationVariables.tabsEnableList[1] ? const Color(0xff0C3788) : const Color(0xffF2F2F2),
                                ),
                                child: Center(
                                  child: Text(
                                    mainVariables.notificationVariables.unreadCountTransit.toString(),
                                    style: mainTextStyle.labelTextStyle.copyWith(fontWeight: FontWeight.w500, color: mainVariables.notificationVariables.tabsEnableList[1] ? const Color(0xffF4F4F4) : const Color(0xff334155), fontSize: 10),
                                  ),
                                ),
                              ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Expiry",
                            style: TextStyle(
                                color: mainVariables.notificationVariables.tabsEnableList[2] ? const Color(0xffF85359) : const Color(0xffD3D3D3),
                                fontSize: mainFunctions.getTextSize(fontSize: 14),
                                fontWeight: FontWeight.w600,
                                overflow: TextOverflow.ellipsis)),
                        SizedBox(
                          width: mainFunctions.getWidgetWidth(width: 5),
                        ),
                        mainVariables.notificationVariables.unreadCountExpiry == 0
                            ? const SizedBox()
                            : Container(
                                height: mainFunctions.getWidgetHeight(height: 16),
                                width: mainFunctions.getWidgetWidth(width: 24),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(26),
                                  color: mainVariables.notificationVariables.tabsEnableList[2] ? const Color(0xffF85359) : const Color(0xffF2F2F2),
                                ),
                                child: Center(
                                  child: Text(
                                    mainVariables.notificationVariables.unreadCountExpiry.toString(),
                                    style: mainTextStyle.labelTextStyle.copyWith(fontWeight: FontWeight.w500, color: mainVariables.notificationVariables.tabsEnableList[2] ? const Color(0xffF4F4F4) : const Color(0xff334155), fontSize: 10),
                                  ),
                                ),
                              ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Low stock",
                            style: TextStyle(
                                color: mainVariables.notificationVariables.tabsEnableList[3] ? const Color(0xffE1A900) : const Color(0xffD3D3D3),
                                fontSize: mainFunctions.getTextSize(fontSize: 14),
                                fontWeight: FontWeight.w600,
                                overflow: TextOverflow.ellipsis)),
                        SizedBox(
                          width: mainFunctions.getWidgetWidth(width: 5),
                        ),
                        mainVariables.notificationVariables.unreadCountLowStock == 0
                            ? const SizedBox()
                            : Container(
                                height: mainFunctions.getWidgetHeight(height: 16),
                                width: mainFunctions.getWidgetWidth(width: 24),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(26),
                                  color: mainVariables.notificationVariables.tabsEnableList[3] ? const Color(0xffE1A900) : const Color(0xffF2F2F2),
                                ),
                                child: Center(
                                  child: Text(
                                    mainVariables.notificationVariables.unreadCountLowStock.toString(),
                                    style: mainTextStyle.labelTextStyle.copyWith(fontWeight: FontWeight.w500, color: mainVariables.notificationVariables.tabsEnableList[3] ? const Color(0xffF4F4F4) : const Color(0xff334155), fontSize: 10),
                                  ),
                                ),
                              ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Stock Disputes",
                            maxLines: 2,
                            style: TextStyle(
                                color: mainVariables.notificationVariables.tabsEnableList[4] ? const Color(0xffEF7606) : const Color(0xffD3D3D3),
                                fontSize: mainFunctions.getTextSize(fontSize: 14),
                                fontWeight: FontWeight.w600,
                                overflow: TextOverflow.ellipsis)),
                        SizedBox(
                          width: mainFunctions.getWidgetWidth(width: 5),
                        ),
                        mainVariables.notificationVariables.unreadCountDispute == 0
                            ? const SizedBox()
                            : Container(
                                height: mainFunctions.getWidgetHeight(height: 16),
                                width: mainFunctions.getWidgetWidth(width: 24),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(26),
                                  color: mainVariables.notificationVariables.tabsEnableList[4] ? const Color(0xffEF7606) : const Color(0xffF2F2F2),
                                ),
                                child: Center(
                                  child: Text(
                                    mainVariables.notificationVariables.unreadCountDispute.toString(),
                                    style: mainTextStyle.labelTextStyle.copyWith(fontWeight: FontWeight.w500, color: mainVariables.notificationVariables.tabsEnableList[4] ? const Color(0xffF4F4F4) : const Color(0xff334155), fontSize: 10),
                                  ),
                                ),
                              ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Checklist",
                            style: TextStyle(
                                color: mainVariables.notificationVariables.tabsEnableList[5] ? const Color(0xff037847) : const Color(0xffD3D3D3),
                                fontSize: mainFunctions.getTextSize(fontSize: 14),
                                fontWeight: FontWeight.w600,
                                overflow: TextOverflow.ellipsis)),
                        SizedBox(
                          width: mainFunctions.getWidgetWidth(width: 5),
                        ),
                        mainVariables.notificationVariables.unreadCountChecklist == 0
                            ? const SizedBox()
                            : Container(
                                height: mainFunctions.getWidgetHeight(height: 16),
                                width: mainFunctions.getWidgetWidth(width: 24),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(26),
                                  color: mainVariables.notificationVariables.tabsEnableList[5] ? const Color(0xff037847) : const Color(0xffF2F2F2),
                                ),
                                child: Center(
                                  child: Text(
                                    mainVariables.notificationVariables.unreadCountChecklist.toString(),
                                    style: mainTextStyle.labelTextStyle.copyWith(fontWeight: FontWeight.w500, color: mainVariables.notificationVariables.tabsEnableList[5] ? const Color(0xffF4F4F4) : const Color(0xff334155), fontSize: 10),
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ]);
            },
          ),
          BlocConsumer<NotificationBloc, NotificationState>(
            listenWhen: (previous, current) {
              return previous != current;
            },
            buildWhen: (previous, current) {
              return previous != current;
            },
            listener: (BuildContext context, NotificationState notify) {
              if (notify is NotificationFailure) {
                mainWidgets.flushBarWidget(context: context, message: notify.errorMessage);
              }
            },
            builder: (BuildContext context, NotificationState notify) {
              if (notify is NotificationLoaded) {
                return Expanded(
                  child: mainVariables.notificationVariables.notifyList.isEmpty
                      ? const Center(
                          child: Text("No data available"),
                        )
                      : ListView.builder(
                          itemCount: mainVariables.notificationVariables.notifyList.length,
                          padding: EdgeInsets.zero,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                index == 0
                                    ? Padding(
                                        padding: EdgeInsets.symmetric(horizontal: mainFunctions.getWidgetWidth(width: 20)),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: mainFunctions.getWidgetHeight(height: 32),
                                            ),
                                            Text(
                                              mainVariables.notificationVariables.notifyList[index].changedDate,
                                              style: TextStyle(
                                                fontSize: mainFunctions.getTextSize(fontSize: 14),
                                                color: const Color(0xffA4A4A4),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : mainVariables.notificationVariables.notifyList[index].changedDate == mainVariables.notificationVariables.notifyList[index - 1].changedDate
                                        ? const SizedBox()
                                        : Padding(
                                            padding: EdgeInsets.symmetric(horizontal: mainFunctions.getWidgetWidth(width: 20)),
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: mainFunctions.getWidgetHeight(height: 32),
                                                ),
                                                Text(
                                                  mainVariables.notificationVariables.notifyList[index].changedDate,
                                                  style: TextStyle(
                                                    fontSize: mainFunctions.getTextSize(fontSize: 14),
                                                    color: const Color(0xffA4A4A4),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                mainVariables.notificationVariables.notifyList[index].isChanged ? SizedBox(height: mainFunctions.getWidgetHeight(height: 12)) : const SizedBox(),
                                Column(
                                  children: [
                                    InkWell(
                                      onTap: mainVariables.notificationVariables.notifyList[index].readStatus
                                          ? () {}
                                          : () {
                                        mainVariables.notificationVariables.notifyList[index].readStatus = true;
                                        setState(() {});
                                              context.read<NotificationBloc>().add(NotificationReadEvent(
                                                    notificationId: mainVariables.notificationVariables.notifyList[index].id,
                                                    index: index,
                                                    category: mainVariables.notificationVariables.notifyList[index].category,
                                                  ));
                                            },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: mainVariables.notificationVariables.notifyList[index].readStatus ? Colors.grey.shade200 : Colors.white,
                                          border: Border.all(color: Colors.white, width: 2),
                                        ),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: mainFunctions.getWidgetHeight(height: 12),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(horizontal: mainFunctions.getWidgetWidth(width: 20)),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.symmetric(horizontal: mainFunctions.getWidgetHeight(height: 21)),
                                                    height: mainFunctions.getWidgetHeight(height: 42),
                                                    width: mainFunctions.getWidgetWidth(width: 42),
                                                    decoration: BoxDecoration(shape: BoxShape.circle, image: DecorationImage(image: NetworkImage(mainVariables.notificationVariables.notifyList[index].productImage), fit: BoxFit.fill)),
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.min,
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        mainWidgets.stockType(
                                                          category: mainVariables.notificationVariables.notifyList[index].category.toLowerCase(),
                                                          status: mainVariables.notificationVariables.notifyList[index].readStatus,
                                                          fromDialog: false,
                                                        ),
                                                        Text(
                                                          mainVariables.notificationVariables.notifyList[index].message,
                                                          maxLines: 2,
                                                          style: TextStyle(overflow: TextOverflow.ellipsis, fontWeight: mainVariables.notificationVariables.notifyList[index].readStatus ? FontWeight.w400 : FontWeight.w500),
                                                        ),
                                                        mainWidgets.idType(
                                                          category: mainVariables.notificationVariables.notifyList[index].category,
                                                          bottomId: mainVariables.notificationVariables.notifyList[index].bottomId,
                                                          status: mainVariables.notificationVariables.notifyList[index].readStatus,
                                                          fromDialog: false,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Column(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Text(
                                                        mainVariables.notificationVariables.notifyList[index].changedTime,
                                                        style: TextStyle(fontWeight: mainVariables.notificationVariables.notifyList[index].readStatus ? FontWeight.w500 : FontWeight.w600),
                                                      ),
                                                      SizedBox(height: mainFunctions.getWidgetHeight(height: 15)),
                                                      mainVariables.notificationVariables.notifyList[index].readStatus
                                                          ? const SizedBox()
                                                          : Container(
                                                              height: mainFunctions.getWidgetHeight(height: 10),
                                                              width: mainFunctions.getWidgetWidth(width: 10),
                                                              decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.green),
                                                            ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: mainFunctions.getWidgetHeight(height: 12),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const Divider(
                                      thickness: 1,
                                      height: 0,
                                      color: Color(0xffE4E8EE),
                                    ),
                                  ],
                                )
                              ],
                            );
                          }),
                );
              } else if (notify is NotificationLoading) {
                return Expanded(
                  child: ListView.builder(
                      itemCount: 7,
                      padding: EdgeInsets.zero,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(),
                            Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.white, width: 2),
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: mainFunctions.getWidgetHeight(height: 12),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: mainFunctions.getWidgetWidth(width: 20)),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Shimmer.fromColors(
                                              baseColor: Colors.grey.shade200,
                                              highlightColor: Colors.white,
                                              child: Container(
                                                margin: EdgeInsets.symmetric(horizontal: mainFunctions.getWidgetHeight(height: 21)),
                                                height: mainFunctions.getWidgetHeight(height: 42),
                                                width: mainFunctions.getWidgetWidth(width: 42),
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                    image: NetworkImage("http://192.168.1.11:3000/uploads/products/1717063316526-franco-antonio-giovanella-lnpQHFfRXLg-unsplash.jpg"),
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Shimmer.fromColors(
                                                    baseColor: Colors.grey.shade200,
                                                    highlightColor: Colors.white,
                                                    child: mainWidgets.stockType(
                                                      category: "TRANSIT",
                                                      status: false,
                                                      fromDialog: false,
                                                    ),
                                                  ),
                                                  Shimmer.fromColors(
                                                    baseColor: Colors.grey.shade200,
                                                    highlightColor: Colors.white,
                                                    child: const Text(
                                                      "Jolly Roger is sending stocks from TVS OFFICE to WOA-SINGAPORE.",
                                                      maxLines: 2,
                                                      style: TextStyle(overflow: TextOverflow.ellipsis, fontWeight: FontWeight.w500),
                                                    ),
                                                  ),
                                                  Shimmer.fromColors(
                                                    baseColor: Colors.grey.shade200,
                                                    highlightColor: Colors.white,
                                                    child: mainWidgets.idType(
                                                      category: "Transit Id",
                                                      bottomId: "123456789",
                                                      status: false,
                                                      fromDialog: false,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Shimmer.fromColors(
                                              baseColor: Colors.grey.shade200,
                                              highlightColor: Colors.white,
                                              child: const Text(
                                                "10:00 PM",
                                                style: TextStyle(fontWeight: FontWeight.w600),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: mainFunctions.getWidgetHeight(height: 12),
                                      ),
                                    ],
                                  ),
                                ),
                                const Divider(
                                  thickness: 1,
                                  height: 0,
                                  color: Color(0xffE4E8EE),
                                ),
                              ],
                            )
                          ],
                        );
                      }),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget dialogContent({required NotificationData data}) {
    return SizedBox(
      width: mainFunctions.getWidgetWidth(width: 600),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            height: mainFunctions.getWidgetHeight(height: 52),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.close,
                      color: Color(0xff1C1C1D),
                      size: 20,
                    )),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: mainFunctions.getWidgetWidth(width: 20)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        mainWidgets.stockType(
                          category: data.category.toLowerCase(),
                          status: false,
                          fromDialog: true,
                        ),
                        mainWidgets.idType(
                          category: data.category,
                          bottomId: data.bottomId,
                          status: false,
                          fromDialog: true,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            color: Color(0xffCECECE),
            height: 0,
            thickness: 1,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: mainFunctions.getWidgetHeight(height: 12),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: mainFunctions.getWidgetWidth(width: 20)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: mainFunctions.getWidgetHeight(height: 52),
                      width: mainFunctions.getWidgetWidth(width: 52),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(data.productImage),
                            fit: BoxFit.fill,
                          )),
                    ),
                    SizedBox(
                      width: mainFunctions.getWidgetWidth(width: 12),
                    ),
                    Expanded(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.message,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: mainFunctions.getTextSize(fontSize: 14),
                            color: const Color(0xff272627),
                          ),
                        ),
                      ],
                    ))
                  ],
                ),
              ),
              SizedBox(height: mainFunctions.getWidgetHeight(height: 24)),
            ],
          )
        ],
      ),
    );
  }
}
