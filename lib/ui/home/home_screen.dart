import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tvsaviation/bloc/check_list/check_list_bloc.dart';
import 'package:tvsaviation/bloc/home/home_bloc.dart';
import 'package:tvsaviation/bloc/rail_navigation/rail_navigation_bloc.dart';
import 'package:tvsaviation/bloc/reports/reports_bloc.dart';
import 'package:tvsaviation/data/hive/location/location_data.dart';
import 'package:tvsaviation/data/model/variable_model/check_list_variables.dart';
import 'package:tvsaviation/data/model/variable_model/stock_movement_variables.dart';
import 'package:tvsaviation/main.dart';
import 'package:tvsaviation/resources/constants.dart';
import 'package:tvsaviation/resources/drop_down_lib/dropdown_textfield.dart';
import 'package:upgrader/upgrader.dart';

class HomeScreen extends StatefulWidget {
  static const String id = "home";
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<HomeBloc>().add(const HomeInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvoked: (value) {
          mainWidgets.showAnimatedDialog(
            context: context,
            height: 170,
            width: 274,
            child: exitContent(),
          );
        },
        child: UpgradeAlert(
            dialogStyle: Platform.isAndroid ? UpgradeDialogStyle.material : UpgradeDialogStyle.cupertino,
            showReleaseNotes: false,
            showIgnore: false,
            shouldPopScope: () => true,
            upgrader: Upgrader(
              messages: MyUpGraderMessages(),
            ),
            child: bodyWidget()));
  }

  Widget bodyWidget() {
    return Stack(
      children: [
        Container(
          height: mainFunctions.getWidgetHeight(height: 238),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/home/tvs_home_main_dash.png"),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: mainFunctions.getWidgetHeight(height: 20),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    mainVariables.generalVariables.railNavigateBackIndex = mainVariables.generalVariables.railNavigateIndex;
                    mainVariables.generalVariables.railNavigateIndex = 8;
                    mainVariables.notificationVariables.locationId = "";
                    context.read<RailNavigationBloc>().add(const RailNavigationSelectedWidgetEvent());
                  },
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Container(height: mainFunctions.getWidgetHeight(height: 45), width: mainFunctions.getWidgetWidth(width: 45), color: Colors.transparent),
                      Positioned(
                        left: 0,
                        bottom: 0,
                        child: Container(
                          height: mainFunctions.getWidgetHeight(height: 40),
                          width: mainFunctions.getWidgetWidth(width: 40),
                          decoration: const BoxDecoration(
                            image: DecorationImage(image: AssetImage("assets/home/notification_bell.png"), fit: BoxFit.fill),
                          ),
                        ),
                      ),
                      BlocBuilder<HomeBloc, HomeState>(
                        builder: (BuildContext context, HomeState state) {
                          return mainVariables.homeVariables.badgeNotifyCount == 0
                              ? const SizedBox()
                              : Container(
                                  height: mainFunctions.getWidgetHeight(height: 24),
                                  width: mainFunctions.getWidgetWidth(width: 24),
                                  decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xff007BFE)),
                                  child: Center(
                                    child: Text(
                                      mainVariables.homeVariables.badgeNotifyCount > 999 ? "999+" : mainVariables.homeVariables.badgeNotifyCount.toString(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: mainVariables.homeVariables.badgeNotifyCount.toString().length == 1 || mainVariables.homeVariables.badgeNotifyCount.toString().length == 2
                                              ? mainFunctions.getTextSize(fontSize: 12)
                                              : mainVariables.homeVariables.badgeNotifyCount.toString().length == 3
                                                  ? mainFunctions.getTextSize(fontSize: 10)
                                                  : mainFunctions.getTextSize(fontSize: 8)),
                                    ),
                                  ),
                                );
                        },
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: mainFunctions.getWidgetWidth(
                    width: 40,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: mainFunctions.getWidgetHeight(height: 134),
            ),
            Row(
              children: [
                SizedBox(
                  width: mainFunctions.getWidgetWidth(width: 35),
                ),
                BlocBuilder<HomeBloc, HomeState>(
                  builder: (BuildContext context, HomeState home) {
                    if (home is HomeLoaded) {
                      return ValueListenableBuilder(
                        valueListenable: Hive.box<LocationResponse>('locations').listenable(),
                        builder: (context, Box<LocationResponse> box, data) {
                          if (box.values.isEmpty) {
                            return Expanded(
                              child: InkWell(
                                onTap: () {
                                  mainVariables.generalVariables.railNavigateBackIndex = mainVariables.generalVariables.railNavigateIndex;
                                  mainVariables.generalVariables.railNavigateIndex = 11;
                                  context.read<RailNavigationBloc>().add(const RailNavigationSelectedWidgetEvent());
                                },
                                child: Container(
                                  height: mainFunctions.getWidgetHeight(height: 112),
                                  padding: EdgeInsets.only(
                                    left: mainFunctions.getWidgetWidth(width: 12),
                                    top: mainFunctions.getWidgetHeight(height: 20),
                                  ),
                                  decoration: BoxDecoration(
                                    color: mainColors.whiteColor,
                                    borderRadius: BorderRadius.circular(6),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 4,
                                        spreadRadius: 0,
                                        color: mainColors.blackColor.withOpacity(0.16),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: mainFunctions.getWidgetHeight(height: 38),
                                        width: mainFunctions.getWidgetWidth(width: 38),
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage("assets/home/transit.png"),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: mainFunctions.getWidgetHeight(height: 18)),
                                      Text(
                                        "Transit",
                                        maxLines: 1,
                                        style: mainTextStyle.smallTextStyle.copyWith(color: const Color(0xff111111), overflow: TextOverflow.ellipsis),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }
                          return Expanded(
                            child: InkWell(
                              onTap: () {
                                mainVariables.stockMovementVariables.sendData = SendDataValueModel.fromJson(const {});
                                mainVariables.stockMovementVariables.selectedProductsList = [];
                                mainVariables.stockMovementVariables.receiverInfo.receiverType = "Crew";
                                mainVariables.stockMovementVariables.senderInfo.crewHandlerController.text = "${mainVariables.generalVariables.userData.firstName} ${mainVariables.generalVariables.userData.lastName}";
                                mainVariables.stockMovementVariables.sendData.senderName = mainVariables.generalVariables.userData.id;
                                mainVariables.stockMovementVariables.senderInfo.senderLocationChoose = DropDownValueModel.fromJson(const {});
                                mainVariables.stockMovementVariables.senderInfo.senderStockTypeChoose = DropDownValueModel.fromJson(const {});
                                mainVariables.stockMovementVariables.senderInfo.senderFromSectorChoose = DropDownValueModel.fromJson(const {});
                                mainVariables.stockMovementVariables.senderInfo.senderToSectorChoose = DropDownValueModel.fromJson(const {});
                                mainVariables.stockMovementVariables.receiverInfo.crewChoose = DropDownValueModel.fromJson(const {});
                                mainVariables.stockMovementVariables.receiverInfo.handlerChoose = DropDownValueModel.fromJson(const {});
                                mainVariables.stockMovementVariables.receiverInfo.receiverLocationChoose = DropDownValueModel.fromJson(const {});
                                mainVariables.stockMovementVariables.receiverInfo.receiverStockTypeChoose = DropDownValueModel.fromJson(const {});
                                mainVariables.generalVariables.railNavigateBackIndex = mainVariables.generalVariables.railNavigateIndex;
                                mainVariables.generalVariables.railNavigateIndex = 10;
                                context.read<RailNavigationBloc>().add(const RailNavigationSelectedWidgetEvent());
                              },
                              child: Container(
                                height: mainFunctions.getWidgetHeight(height: 112),
                                padding: EdgeInsets.only(
                                  left: mainFunctions.getWidgetWidth(width: 12),
                                  top: mainFunctions.getWidgetHeight(height: 20),
                                ),
                                decoration: BoxDecoration(
                                  color: mainColors.whiteColor,
                                  borderRadius: BorderRadius.circular(6),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 4,
                                      spreadRadius: 0,
                                      color: mainColors.blackColor.withOpacity(0.16),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: mainFunctions.getWidgetHeight(height: 38),
                                      width: mainFunctions.getWidgetWidth(width: 38),
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage("assets/home/stock_movement.png"),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: mainFunctions.getWidgetHeight(height: 18)),
                                    Text(
                                      "Stock movement",
                                      maxLines: 1,
                                      style: mainTextStyle.smallTextStyle.copyWith(color: const Color(0xff111111), overflow: TextOverflow.ellipsis),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else if (home is HomeLoading) {
                      return Expanded(
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey.shade200,
                          highlightColor: Colors.white,
                          child: Container(
                            height: mainFunctions.getWidgetHeight(height: 112),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: mainColors.whiteColor),
                            padding: EdgeInsets.only(left: mainFunctions.getWidgetWidth(width: 20), top: mainFunctions.getWidgetHeight(height: 16), right: mainFunctions.getWidgetWidth(width: 20)),
                          ),
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
                SizedBox(
                  width: mainFunctions.getWidgetWidth(width: 53),
                ),
                BlocBuilder<HomeBloc, HomeState>(
                  builder: (BuildContext context, HomeState home) {
                    if (home is HomeLoaded) {
                      return ValueListenableBuilder(
                        valueListenable: Hive.box<LocationResponse>('locations').listenable(),
                        builder: (context, Box<LocationResponse> box, data) {
                          if (box.values.isEmpty) {
                            return Expanded(
                              child: Shimmer.fromColors(
                                baseColor: Colors.grey.shade200,
                                highlightColor: Colors.white,
                                child: Container(
                                  height: mainFunctions.getWidgetHeight(height: 112),
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: mainColors.whiteColor),
                                  padding: EdgeInsets.only(left: mainFunctions.getWidgetWidth(width: 20), top: mainFunctions.getWidgetHeight(height: 16), right: mainFunctions.getWidgetWidth(width: 20)),
                                ),
                              ),
                            );
                          }
                          return BlocBuilder<HomeBloc, HomeState>(
                            builder: (BuildContext context, HomeState home) {
                              if (home is HomeLoaded) {
                                return ValueListenableBuilder(
                                  valueListenable: Hive.box<LocationResponse>('locations').listenable(),
                                  builder: (context, Box<LocationResponse> box, data) {
                                    if (box.values.isEmpty) {
                                      return Expanded(
                                        child: InkWell(
                                          onTap: () {
                                            mainVariables.generalVariables.railNavigateBackIndex = mainVariables.generalVariables.railNavigateIndex;
                                            mainVariables.generalVariables.railNavigateIndex = 11;
                                            context.read<RailNavigationBloc>().add(const RailNavigationSelectedWidgetEvent());
                                          },
                                          child: Container(
                                            height: mainFunctions.getWidgetHeight(height: 112),
                                            padding: EdgeInsets.only(
                                              left: mainFunctions.getWidgetWidth(width: 12),
                                              top: mainFunctions.getWidgetHeight(height: 20),
                                            ),
                                            decoration: BoxDecoration(
                                              color: mainColors.whiteColor,
                                              borderRadius: BorderRadius.circular(6),
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 4,
                                                  spreadRadius: 0,
                                                  color: mainColors.blackColor.withOpacity(0.16),
                                                ),
                                              ],
                                            ),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  height: mainFunctions.getWidgetHeight(height: 38),
                                                  width: mainFunctions.getWidgetWidth(width: 38),
                                                  decoration: const BoxDecoration(
                                                    image: DecorationImage(
                                                      image: AssetImage("assets/home/transit.png"),
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: mainFunctions.getWidgetHeight(height: 18)),
                                                Text(
                                                  "Transit",
                                                  maxLines: 1,
                                                  style: mainTextStyle.smallTextStyle.copyWith(color: const Color(0xff111111), overflow: TextOverflow.ellipsis),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                    return Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          mainVariables.generalVariables.railNavigateBackIndex = mainVariables.generalVariables.railNavigateIndex;
                                          mainVariables.generalVariables.railNavigateIndex = 11;
                                          context.read<RailNavigationBloc>().add(const RailNavigationSelectedWidgetEvent());
                                        },
                                        child: Container(
                                          height: mainFunctions.getWidgetHeight(height: 112),
                                          padding: EdgeInsets.only(
                                            left: mainFunctions.getWidgetWidth(width: 12),
                                            top: mainFunctions.getWidgetHeight(height: 20),
                                          ),
                                          decoration: BoxDecoration(
                                            color: mainColors.whiteColor,
                                            borderRadius: BorderRadius.circular(6),
                                            boxShadow: [
                                              BoxShadow(
                                                blurRadius: 4,
                                                spreadRadius: 0,
                                                color: mainColors.blackColor.withOpacity(0.16),
                                              ),
                                            ],
                                          ),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                height: mainFunctions.getWidgetHeight(height: 38),
                                                width: mainFunctions.getWidgetWidth(width: 38),
                                                decoration: const BoxDecoration(
                                                  image: DecorationImage(
                                                    image: AssetImage("assets/home/transit.png"),
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: mainFunctions.getWidgetHeight(height: 18)),
                                              Text(
                                                "Transit",
                                                maxLines: 1,
                                                style: mainTextStyle.smallTextStyle.copyWith(color: const Color(0xff111111), overflow: TextOverflow.ellipsis),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              } else if (home is HomeLoading) {
                                return Expanded(
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.grey.shade200,
                                    highlightColor: Colors.white,
                                    child: Container(
                                      height: mainFunctions.getWidgetHeight(height: 112),
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: mainColors.whiteColor),
                                      padding: EdgeInsets.only(left: mainFunctions.getWidgetWidth(width: 20), top: mainFunctions.getWidgetHeight(height: 16), right: mainFunctions.getWidgetWidth(width: 20)),
                                    ),
                                  ),
                                );
                              } else {
                                return const SizedBox();
                              }
                            },
                          );
                        },
                      );
                    } else if (home is HomeLoading) {
                      return Expanded(
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey.shade200,
                          highlightColor: Colors.white,
                          child: Container(
                            height: mainFunctions.getWidgetHeight(height: 112),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: mainColors.whiteColor),
                            padding: EdgeInsets.only(left: mainFunctions.getWidgetWidth(width: 20), top: mainFunctions.getWidgetHeight(height: 16), right: mainFunctions.getWidgetWidth(width: 20)),
                          ),
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
                SizedBox(
                  width: mainFunctions.getWidgetWidth(width: 53),
                ),
                BlocBuilder<HomeBloc, HomeState>(
                  builder: (BuildContext context, HomeState home) {
                    if (home is HomeLoaded) {
                      return ValueListenableBuilder(
                        valueListenable: Hive.box<LocationResponse>('locations').listenable(),
                        builder: (context, Box<LocationResponse> box, data) {
                          if (box.values.isEmpty) {
                            return Expanded(
                              child: InkWell(
                                onTap: () {
                                  context.read<ReportsBloc>().add(const ReportsPageChangingEvent(index: 4));
                                  mainVariables.generalVariables.railNavigateBackIndex = mainVariables.generalVariables.railNavigateIndex;
                                  mainVariables.generalVariables.railNavigateIndex = 4;
                                  mainVariables.railNavigationVariables.mainSelectedIndex = 4;
                                  context.read<RailNavigationBloc>().add(const RailNavigationSelectedWidgetEvent());
                                },
                                child: Container(
                                  height: mainFunctions.getWidgetHeight(height: 112),
                                  padding: EdgeInsets.only(
                                    left: mainFunctions.getWidgetWidth(width: 12),
                                    top: mainFunctions.getWidgetHeight(height: 20),
                                  ),
                                  decoration: BoxDecoration(
                                    color: mainColors.whiteColor,
                                    borderRadius: BorderRadius.circular(6),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 4,
                                        spreadRadius: 0,
                                        color: mainColors.blackColor.withOpacity(0.16),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: mainFunctions.getWidgetHeight(height: 38),
                                        width: mainFunctions.getWidgetWidth(width: 38),
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage("assets/home/transaction.png"),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: mainFunctions.getWidgetHeight(height: 18)),
                                      Text(
                                        "Transaction History",
                                        maxLines: 1,
                                        style: mainTextStyle.smallTextStyle.copyWith(color: const Color(0xff111111), overflow: TextOverflow.ellipsis),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }
                          return Expanded(
                            child: InkWell(
                              onTap: () {
                                context.read<ReportsBloc>().add(const ReportsPageChangingEvent(index: 4));
                                mainVariables.generalVariables.railNavigateBackIndex = mainVariables.generalVariables.railNavigateIndex;
                                mainVariables.generalVariables.railNavigateIndex = 4;
                                mainVariables.railNavigationVariables.mainSelectedIndex = 4;
                                context.read<RailNavigationBloc>().add(const RailNavigationSelectedWidgetEvent());
                              },
                              child: Container(
                                height: mainFunctions.getWidgetHeight(height: 112),
                                padding: EdgeInsets.only(
                                  left: mainFunctions.getWidgetWidth(width: 12),
                                  top: mainFunctions.getWidgetHeight(height: 20),
                                ),
                                decoration: BoxDecoration(
                                  color: mainColors.whiteColor,
                                  borderRadius: BorderRadius.circular(6),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 4,
                                      spreadRadius: 0,
                                      color: mainColors.blackColor.withOpacity(0.16),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: mainFunctions.getWidgetHeight(height: 38),
                                      width: mainFunctions.getWidgetWidth(width: 38),
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage("assets/home/transaction.png"),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: mainFunctions.getWidgetHeight(height: 18)),
                                    Text(
                                      "Transaction History",
                                      maxLines: 1,
                                      style: mainTextStyle.smallTextStyle.copyWith(color: const Color(0xff111111), overflow: TextOverflow.ellipsis),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else if (home is HomeLoading) {
                      return Expanded(
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey.shade200,
                          highlightColor: Colors.white,
                          child: Container(
                            height: mainFunctions.getWidgetHeight(height: 112),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: mainColors.whiteColor),
                            padding: EdgeInsets.only(left: mainFunctions.getWidgetWidth(width: 20), top: mainFunctions.getWidgetHeight(height: 16), right: mainFunctions.getWidgetWidth(width: 20)),
                          ),
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
                SizedBox(
                  width: mainFunctions.getWidgetWidth(width: 35),
                ),
              ],
            ),
            SizedBox(height: mainFunctions.getWidgetHeight(height: 20)),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: mainFunctions.getWidgetHeight(height: 40)),
                    Center(
                      child: ShaderMask(
                        blendMode: BlendMode.srcIn,
                        shaderCallback: (Rect bounds) {
                          return const LinearGradient(
                            colors: [
                              Color(0XFF0C3788),
                              Color(0XFFBC0044),
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ).createShader(bounds);
                        },
                        child: const Text(
                          'Locations',
                          style: TextStyle(
                            fontSize: 28.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: mainFunctions.getWidgetHeight(height: 22)),
                    Container(
                      height: mainFunctions.getWidgetHeight(height: 294),
                      margin: EdgeInsets.symmetric(horizontal: mainFunctions.getWidgetWidth(width: 15)),
                      padding: EdgeInsets.symmetric(horizontal: mainFunctions.getWidgetWidth(width: 15), vertical: mainFunctions.getWidgetHeight(height: 15)),
                      decoration: BoxDecoration(color: const Color(0xffEAF1FF), borderRadius: BorderRadius.circular(10)),
                      child: Scrollbar(
                        child: BlocConsumer<HomeBloc, HomeState>(
                          listenWhen: (previous, current) {
                            return previous != current;
                          },
                          buildWhen: (previous, current) {
                            return previous != current;
                          },
                          listener: (BuildContext context, HomeState home) {
                            if (home is HomeFailure) {
                              mainWidgets.flushBarWidget(context: context, message: home.errorMessage);
                            }
                          },
                          builder: (BuildContext context, HomeState home) {
                            if (home is HomeLoaded) {
                              return ValueListenableBuilder(
                                valueListenable: Hive.box<LocationResponse>('locations').listenable(),
                                builder: (context, Box<LocationResponse> box, data) {
                                  if (box.values.isEmpty) {
                                    return const Center(child: Text('No data available'));
                                  }
                                  return GridView.builder(
                                    itemCount: box.values.length,
                                    padding: EdgeInsets.zero,
                                    physics: const ScrollPhysics(),
                                    shrinkWrap: true,
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      mainAxisSpacing: mainFunctions.getWidgetHeight(height: 30),
                                      crossAxisSpacing: mainFunctions.getWidgetWidth(width: 28),
                                      mainAxisExtent: mainFunctions.getWidgetHeight(height: 112),
                                    ),
                                    itemBuilder: (BuildContext context, int index) {
                                      LocationResponse location = box.getAt(index) ?? LocationResponse.fromJson({});
                                      return InkWell(
                                        onTap: () {
                                          mainVariables.generalVariables.railNavigateBackIndex = mainVariables.generalVariables.railNavigateIndex;
                                          mainVariables.generalVariables.railNavigateIndex = 1;
                                          mainVariables.homeVariables.homeLocationSelectedIndex = mainVariables.homeVariables.locationIdList.indexOf(location.id);
                                          mainVariables.railNavigationVariables.mainSelectedIndex = 1;
                                          mainVariables.notificationVariables.locationId = location.id;
                                          context.read<RailNavigationBloc>().add(const RailNavigationSelectedWidgetEvent());
                                        },
                                        child: Container(
                                          height: mainFunctions.getWidgetHeight(height: 112),
                                          width: mainFunctions.getWidgetWidth(width: 202),
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: mainColors.whiteColor),
                                          padding: EdgeInsets.only(left: mainFunctions.getWidgetWidth(width: 20), top: mainFunctions.getWidgetHeight(height: 16), right: mainFunctions.getWidgetWidth(width: 20)),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    height: mainFunctions.getWidgetHeight(height: 38),
                                                    width: mainFunctions.getWidgetWidth(width: 38),
                                                    decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                      image: AssetImage(location.type == "warehouse" && location.name == "TVS OFFICE"
                                                          ? "assets/home/store_room.png"
                                                          : location.type == "warehouse"
                                                              ? "assets/home/tvs_secondary.png"
                                                              : "assets/home/aircraft.png"),
                                                      fit: BoxFit.fill,
                                                    )),
                                                  ),
                                                  mainVariables.homeVariables.locationCountList.isNotEmpty
                                                      ? mainVariables.homeVariables.locationCountList[mainVariables.homeVariables.locationIdList.indexOf(location.id)] == 0
                                                          ? const SizedBox()
                                                          : InkWell(
                                                              onTap: () {
                                                                mainVariables.generalVariables.railNavigateBackIndex = mainVariables.generalVariables.railNavigateIndex;
                                                                mainVariables.generalVariables.railNavigateIndex = 8;
                                                                mainVariables.notificationVariables.locationId = location.id;
                                                                context.read<RailNavigationBloc>().add(const RailNavigationSelectedWidgetEvent());
                                                              },
                                                              child: Container(
                                                                height: mainFunctions.getWidgetHeight(height: 20),
                                                                width: mainFunctions.getWidgetWidth(width: 28),
                                                                decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(30),
                                                                  color: const Color(0xff007BFE),
                                                                ),
                                                                child: Center(
                                                                  child: Text(
                                                                    mainVariables.homeVariables.locationCountList[mainVariables.homeVariables.locationIdList.indexOf(location.id)].toString(),
                                                                    style: mainTextStyle.labelTextStyle.copyWith(fontWeight: FontWeight.w500, color: const Color(0xffF4F4F4)),
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                      : const SizedBox()
                                                ],
                                              ),
                                              SizedBox(height: mainFunctions.getWidgetHeight(height: 20)),
                                              Text(
                                                location.name,
                                                maxLines: 1,
                                                style: mainTextStyle.smallTextStyle.copyWith(color: const Color(0xff111111), overflow: TextOverflow.ellipsis),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              );
                            } else if (home is HomeLoading) {
                              return GridView.builder(
                                itemCount: mainVariables.homeVariables.locationList.length,
                                padding: EdgeInsets.zero,
                                physics: const ScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: mainFunctions.getWidgetHeight(height: 30),
                                  crossAxisSpacing: mainFunctions.getWidgetWidth(width: 28),
                                  mainAxisExtent: mainFunctions.getWidgetHeight(height: 112),
                                ),
                                itemBuilder: (BuildContext context, int index) {
                                  return Shimmer.fromColors(
                                    baseColor: Colors.grey.shade200,
                                    highlightColor: Colors.white,
                                    child: Container(
                                      height: mainFunctions.getWidgetHeight(height: 112),
                                      width: mainFunctions.getWidgetWidth(width: 202),
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: mainColors.whiteColor),
                                      padding: EdgeInsets.only(left: mainFunctions.getWidgetWidth(width: 20), top: mainFunctions.getWidgetHeight(height: 16), right: mainFunctions.getWidgetWidth(width: 20)),
                                    ),
                                  );
                                },
                              );
                            } else {
                              return const SizedBox();
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: mainFunctions.getWidgetHeight(height: 40)),
                    Center(
                      child: ShaderMask(
                        blendMode: BlendMode.srcIn,
                        shaderCallback: (Rect bounds) {
                          return const LinearGradient(
                            colors: [
                              Color(0XFF0C3788),
                              Color(0XFFBC0044),
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ).createShader(bounds);
                        },
                        child: const Text(
                          'Quick links',
                          style: TextStyle(
                            fontSize: 28.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: mainFunctions.getWidgetHeight(height: 22)),
                    Container(
                      height: mainFunctions.getWidgetHeight(height: 254),
                      margin: EdgeInsets.symmetric(horizontal: mainFunctions.getWidgetWidth(width: 35)),
                      child: GridView.builder(
                        itemCount: mainVariables.homeVariables.quickLinksList.length,
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: mainFunctions.getWidgetHeight(height: 30),
                          crossAxisSpacing: mainFunctions.getWidgetWidth(width: 28),
                          mainAxisExtent: mainFunctions.getWidgetHeight(height: 112),
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () async {
                              mainVariables.homeVariables.quickLinksEnabled = true;
                              if (index < 3) {
                                mainVariables.generalVariables.railNavigateBackIndex = mainVariables.generalVariables.railNavigateIndex;
                                mainVariables.generalVariables.railNavigateIndex = 1;
                                mainVariables.inventoryVariables.tabControllerIndex = index;
                                mainVariables.railNavigationVariables.mainSelectedIndex = 1;
                                mainVariables.generalVariables.currentPage = "".obs;
                                context.read<RailNavigationBloc>().add(const RailNavigationSelectedWidgetEvent());
                              } else {
                                if (index - 3 == 1) {
                                  SharedPreferences prefs = await SharedPreferences.getInstance();
                                  DateTime convertDate = DateTime.parse(prefs.getString("dialog_time") ?? DateTime.now().add(const Duration(days: 2)).toString());
                                  DateTime today = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
                                  DateTime aDate = DateTime(convertDate.year, convertDate.month, convertDate.day);
                                  if (context.mounted) {
                                    if (aDate == today) {
                                      mainVariables.checkListVariables = CheckListVariables.fromJson({});
                                      context.read<CheckListBloc>().add(const CheckListPageChangingEvent(index: 1));
                                      mainVariables.checkListVariables.checkListSelectedIndex = 1;
                                      mainVariables.generalVariables.railNavigateBackIndex = mainVariables.generalVariables.railNavigateIndex;
                                      mainVariables.generalVariables.railNavigateIndex = 5;
                                      mainVariables.railNavigationVariables.mainSelectedIndex = 5;
                                      context.read<RailNavigationBloc>().add(const RailNavigationSelectedWidgetEvent());
                                      SharedPreferences prefs = await SharedPreferences.getInstance();
                                      prefs.setString("dialog_time", DateTime.now().toString());
                                    } else {
                                      mainWidgets.showAnimatedDialog(
                                        context: context,
                                        height: 155,
                                        width: 285,
                                        child: mainWidgets.updateConsumptionContent(context: context),
                                      );
                                    }
                                  }
                                } else {
                                  mainVariables.checkListVariables = CheckListVariables.fromJson({});
                                  context.read<CheckListBloc>().add(CheckListPageChangingEvent(index: index - 3));
                                  mainVariables.checkListVariables.checkListSelectedIndex = index - 3;
                                  mainVariables.generalVariables.railNavigateBackIndex = mainVariables.generalVariables.railNavigateIndex;
                                  mainVariables.generalVariables.railNavigateIndex = 5;
                                  mainVariables.railNavigationVariables.mainSelectedIndex = 5;
                                  context.read<RailNavigationBloc>().add(const RailNavigationSelectedWidgetEvent());
                                }
                              }
                            },
                            child: Container(
                              height: mainFunctions.getWidgetHeight(height: 112),
                              width: mainFunctions.getWidgetWidth(width: 202),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: const Color(0xffF0F1FF)),
                              padding: EdgeInsets.only(
                                left: mainFunctions.getWidgetWidth(width: 15),
                                top: mainFunctions.getWidgetHeight(height: 16),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: mainFunctions.getWidgetHeight(height: 38),
                                        width: mainFunctions.getWidgetWidth(width: 38),
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                          image: AssetImage(mainVariables.homeVariables.quickLinksList[index].imageData),
                                          fit: BoxFit.fill,
                                        )),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: mainFunctions.getWidgetHeight(height: 20)),
                                  Text(
                                    mainVariables.homeVariables.quickLinksList[index].text,
                                    maxLines: 1,
                                    style: mainTextStyle.smallTextStyle.copyWith(color: const Color(0xff111111), overflow: TextOverflow.ellipsis, fontSize: mainFunctions.getTextSize(fontSize: 14)),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: mainFunctions.getWidgetHeight(height: 22)),
                  ],
                ),
              ),
            )
          ],
        )
      ],
    );
  }

  Widget exitContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 52),
          child: Center(
            child: Text(
              'Exit App',
              style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 20), fontWeight: FontWeight.w600, color: const Color(0xff111111)),
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
        Text(
          "Are you sure want to exit the app.",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: mainFunctions.getTextSize(fontSize: 15),
            color: const Color(0xff181818),
          ),
          textAlign: TextAlign.center,
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
                    if (Platform.isAndroid) {
                      SystemNavigator.pop();
                    } else if (Platform.isIOS) {
                      exit(0);
                    }
                  },
                  child: Text(
                    "Exit",
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
}
