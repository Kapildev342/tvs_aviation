import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tvsaviation/bloc/check_list/check_list_bloc.dart';
import 'package:tvsaviation/bloc/inventory/inventory_bloc.dart';
import 'package:tvsaviation/bloc/manage/manage_bloc.dart';
import 'package:tvsaviation/bloc/rail_navigation/rail_navigation_bloc.dart';
import 'package:tvsaviation/bloc/reports/reports_bloc.dart';
import 'package:tvsaviation/data/hive/user/user_data.dart';
import 'package:tvsaviation/data/model/api_model/edit_profile_model.dart';
import 'package:tvsaviation/data/model/variable_model/add_dispute_variables.dart';
import 'package:tvsaviation/data/model/variable_model/check_list_variables.dart';
import 'package:tvsaviation/data/model/variable_model/confirm_movement_variables.dart';
import 'package:tvsaviation/data/model/variable_model/home_variables.dart';
import 'package:tvsaviation/data/model/variable_model/inventory_variables.dart';
import 'package:tvsaviation/data/model/variable_model/manage_variables.dart';
import 'package:tvsaviation/data/model/variable_model/manual_variables.dart';
import 'package:tvsaviation/data/model/variable_model/notification_variables.dart';
import 'package:tvsaviation/data/model/variable_model/rail_navigation_variables.dart';
import 'package:tvsaviation/data/model/variable_model/received_stocks_variables.dart';
import 'package:tvsaviation/data/model/variable_model/reports_variables.dart';
import 'package:tvsaviation/data/model/variable_model/stock_dispute_variables.dart';
import 'package:tvsaviation/data/model/variable_model/stock_movement_variables.dart';
import 'package:tvsaviation/data/model/variable_model/transit_variables.dart';
import 'package:tvsaviation/resources/constants.dart';
import 'package:tvsaviation/resources/widgets.dart';
import 'package:tvsaviation/ui/home/home_screen.dart';
import 'package:tvsaviation/ui/inventory/inventory_screen.dart';
import 'package:tvsaviation/ui/login/login_screen.dart';

class RailNavigationScreen extends StatefulWidget {
  static const String id = "rail_navigation";
  const RailNavigationScreen({super.key});

  @override
  State<RailNavigationScreen> createState() => _RailNavigationScreenState();
}

class _RailNavigationScreenState extends State<RailNavigationScreen> with TickerProviderStateMixin {
  late AnimationController drawerController;
  late Animation<Offset> drawerAnimation;

  @override
  void initState() {
    super.initState();
    drawerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    drawerAnimation = Tween<Offset>(begin: const Offset(-2.0, 0.0), end: Offset.zero).animate(drawerController);
  }

  @override
  void didChangeDependencies() {
    context.read<RailNavigationBloc>().add(RailNavigationInitialEvent(modelSetState: setState));
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    drawerController.dispose();
    super.dispose();
  }

  void openDrawer() {
    setState(() {
      drawerController.forward();
      mainVariables.railNavigationVariables.isDrawerOpen = true;
    });
  }

  void closeDrawer() {
    setState(() {
      drawerController.reverse();
      mainVariables.railNavigationVariables.isDrawerOpen = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return mainWidgets.primaryContainerWidget(body: bodyWidget(), context: context);
  }

  Widget bodyWidget() {
    return BlocConsumer<RailNavigationBloc, RailNavigationState>(
      listenWhen: (previous, current) {
        return previous != current;
      },
      buildWhen: (previous, current) {
        return previous != current;
      },
      listener: (BuildContext context, RailNavigationState rail) {
        if (rail is RailNavigationSuccess) {
          mainWidgets.flushBarWidget(context: context, message: rail.message);
        } else if (rail is RailNavigationFailure) {
          mainWidgets.flushBarWidget(context: context, message: rail.errorMessage);
        }
      },
      builder: (BuildContext context, RailNavigationState rail) {
        if (rail is RailNavigationLoaded) {
          return Row(
            children: [
              Stack(
                children: [
                  LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
                    return SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight,
                        ),
                        child: IntrinsicHeight(
                          child: Container(
                            width: mainFunctions.getWidgetWidth(width: 100),
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/rail_navigation/gradientColor.png"),
                                fit: BoxFit.fill,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: mainFunctions.getWidgetHeight(height: 20)),
                              child: NavigationRail(
                                selectedIndex: mainVariables.railNavigationVariables.mainSelectedIndex,
                                onDestinationSelected: (int index) {
                                 if(mainVariables.generalVariables.railNavigateIndex==1 && context.read<InventoryBloc>().updatedInventoryCartList.isNotEmpty){
                                   mainWidgets.showAnimatedDialog(
                                     context: context,
                                     height: 200,
                                     width: 460,
                                     child: dialogCartContent(context:context),
                                   );
                                 }
                                 else{
                                   mainVariables.homeVariables.homeLocationSelectedIndex=-1;
                                   context.read<InventoryBloc>().updatedInventoryIdsList.clear();
                                   context.read<InventoryBloc>().updatedInventoryCartList.clear();
                                   context.read<InventoryBloc>().cartPageEnabled=false;
                                   context.read<InventoryBloc>().cartRemarksController = TextEditingController();
                                   setState(() {
                                     FocusManager.instance.primaryFocus!.unfocus();
                                     mainFunctions.unFocusOverLayEntryFunction();
                                     mainVariables.notificationVariables.locationId = "";
                                     mainVariables.receivedStocksVariables.pageState = "";
                                     mainVariables.generalVariables.currentPage.value = "";
                                     mainVariables.receivedStocksVariables.disputePageOpened = false;
                                     mainVariables.transitVariables.receivedPageOpened = false;
                                     mainVariables.reportsVariables.addDisputePageChanged = false;
                                     mainVariables.transitVariables.currentPage = 1;
                                     mainVariables.reportsVariables.currentPage = 1;
                                     if (index == 3) {
                                       context.read<ReportsBloc>().add(const ReportsPageChangingEvent(index: 3));
                                       mainVariables.generalVariables.railNavigateBackIndex = mainVariables.generalVariables.railNavigateIndex;
                                       mainVariables.generalVariables.railNavigateIndex = 4;
                                       mainVariables.railNavigationVariables.mainSelectedIndex = 3;
                                       mainVariables.reportsVariables.currentPage = 1;
                                       context.read<RailNavigationBloc>().add(const RailNavigationSelectedWidgetEvent());
                                     }
                                     else if (index == 4) {
                                       mainVariables.railNavigationVariables.drawerSelectedIndex = 0;
                                       openDrawer();
                                     }
                                     else if (index == 5) {
                                       mainVariables.railNavigationVariables.drawerSelectedIndex = 1;
                                       openDrawer();
                                     }
                                     else if (index == 6) {
                                       mainVariables.railNavigationVariables.drawerSelectedIndex = 2;
                                       openDrawer();
                                     }
                                     else {
                                       mainVariables.stockDisputeVariables = StockDisputeVariables.fromJson({});
                                       mainVariables.railNavigationVariables.mainSelectedIndex = index;
                                       mainVariables.generalVariables.railNavigateIndex = index;
                                       context.read<RailNavigationBloc>().add(const RailNavigationSelectedWidgetEvent());
                                     }
                                   });
                                 }
                                },
                                trailing: Expanded(
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: IconButton(
                                      onPressed: () {
                                        if(mainVariables.generalVariables.railNavigateIndex==1 && context.read<InventoryBloc>().updatedInventoryCartList.isNotEmpty){
                                          mainWidgets.showAnimatedDialog(
                                            context: context,
                                            height: 200,
                                            width: 460,
                                            child: dialogCartContent(context:context),
                                          );
                                        }else{
                                          mainVariables.homeVariables.homeLocationSelectedIndex=-1;
                                          context.read<InventoryBloc>().updatedInventoryIdsList.clear();
                                          context.read<InventoryBloc>().updatedInventoryCartList.clear();
                                          context.read<InventoryBloc>().cartPageEnabled=false;
                                          context.read<InventoryBloc>().cartRemarksController = TextEditingController();
                                          mainWidgets.showAnimatedDialog(
                                            context: context,
                                            height: 352,
                                            width: 460,
                                            child: dialogContent(),
                                          );
                                        }
                                      },
                                      icon: mainVariables.generalVariables.userData.profilePhoto == ""
                                          ? Container(
                                              height: mainFunctions.getWidgetHeight(height: 52),
                                              width: mainFunctions.getWidgetWidth(width: 52),
                                              decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                    image: AssetImage("assets/login/airplane_1.png"),
                                                    fit: BoxFit.fill,
                                                  )),
                                            )
                                          : Container(
                                              height: mainFunctions.getWidgetHeight(height: 52),
                                              width: mainFunctions.getWidgetWidth(width: 52),
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                    image: NetworkImage(mainVariables.generalVariables.userData.profilePhoto),
                                                    fit: BoxFit.fill,
                                                  )),
                                            ),
                                    ),
                                  ),
                                ),
                                labelType: NavigationRailLabelType.all,
                                backgroundColor: Colors.transparent,
                                selectedLabelTextStyle: mainTextStyle.labelTextStyle,
                                unselectedLabelTextStyle: mainTextStyle.labelTextStyle,
                                indicatorColor: mainColors.transparentColor,
                                destinations: [
                                  NavigationRailDestination(
                                    icon: Container(
                                      height: mainFunctions.getWidgetHeight(height: 48),
                                      width: mainFunctions.getWidgetWidth(width: 48),
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                              "assets/rail_navigation/tvs_main_page_logo.png",
                                            ),
                                            fit: BoxFit.fill),
                                      ),
                                    ),
                                    selectedIcon: Container(
                                      height: mainFunctions.getWidgetHeight(height: 48),
                                      width: mainFunctions.getWidgetWidth(width: 48),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: mainColors.whiteColor.withOpacity(0.3),
                                        image: const DecorationImage(
                                            image: AssetImage(
                                              "assets/rail_navigation/tvs_main_page_logo.png",
                                            ),
                                            fit: BoxFit.fill),
                                      ),
                                    ),
                                    label: Text(
                                      '',
                                      style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 12), fontFamily: "Figtree"),
                                    ),
                                  ),
                                  NavigationRailDestination(
                                    icon: Container(
                                      height: mainFunctions.getWidgetHeight(height: 48),
                                      width: mainFunctions.getWidgetWidth(width: 48),
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                              "assets/rail_navigation/inventory_logo.png",
                                            ),
                                            fit: BoxFit.fill),
                                      ),
                                    ),
                                    selectedIcon: Container(
                                      height: mainFunctions.getWidgetHeight(height: 48),
                                      width: mainFunctions.getWidgetWidth(width: 48),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: mainColors.whiteColor.withOpacity(0.3),
                                        image: const DecorationImage(
                                            image: AssetImage(
                                              "assets/rail_navigation/inventory_logo.png",
                                            ),
                                            fit: BoxFit.fill),
                                      ),
                                    ),
                                    label: Text(
                                      'Inventory',
                                      style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 12), fontFamily: "Figtree"),
                                    ),
                                  ),
                                  NavigationRailDestination(
                                    icon: Container(
                                      height: mainFunctions.getWidgetHeight(height: 48),
                                      width: mainFunctions.getWidgetWidth(width: 48),
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                              "assets/rail_navigation/disputes_logo.png",
                                            ),
                                            fit: BoxFit.fill),
                                      ),
                                    ),
                                    selectedIcon: Container(
                                      height: mainFunctions.getWidgetHeight(height: 48),
                                      width: mainFunctions.getWidgetWidth(width: 48),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: mainColors.whiteColor.withOpacity(0.3),
                                        image: const DecorationImage(
                                            image: AssetImage(
                                              "assets/rail_navigation/disputes_logo.png",
                                            ),
                                            fit: BoxFit.fill),
                                      ),
                                    ),
                                    label: SizedBox(
                                      width: mainFunctions.getWidgetWidth(width: 65),
                                      child: Text(
                                        'Stock Disputes',
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 12), fontFamily: "Figtree"),
                                      ),
                                    ),
                                  ),
                                  NavigationRailDestination(
                                    icon: Container(
                                      height: mainFunctions.getWidgetHeight(height: 48),
                                      width: mainFunctions.getWidgetWidth(width: 48),
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                              "assets/rail_navigation/resolution.png",
                                            ),
                                            fit: BoxFit.fill),
                                      ),
                                    ),
                                    selectedIcon: Container(
                                      height: mainFunctions.getWidgetHeight(height: 48),
                                      width: mainFunctions.getWidgetWidth(width: 48),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: mainColors.whiteColor.withOpacity(0.3),
                                        image: const DecorationImage(
                                            image: AssetImage(
                                              "assets/rail_navigation/resolution.png",
                                            ),
                                            fit: BoxFit.fill),
                                      ),
                                    ),
                                    label: SizedBox(
                                      width: mainFunctions.getWidgetWidth(width: 80),
                                      child: Text(
                                        'Resolution',
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 12), fontFamily: "Figtree"),
                                      ),
                                    ),
                                  ),
                                  NavigationRailDestination(
                                    icon: Container(
                                      height: mainFunctions.getWidgetHeight(height: 48),
                                      width: mainFunctions.getWidgetWidth(width: 48),
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                              "assets/rail_navigation/reports.png",
                                            ),
                                            fit: BoxFit.fill),
                                      ),
                                    ),
                                    selectedIcon: Container(
                                      height: mainFunctions.getWidgetHeight(height: 48),
                                      width: mainFunctions.getWidgetWidth(width: 48),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: mainColors.whiteColor.withOpacity(0.3),
                                        image: const DecorationImage(
                                            image: AssetImage(
                                              "assets/rail_navigation/reports.png",
                                            ),
                                            fit: BoxFit.fill),
                                      ),
                                    ),
                                    label: Text(
                                      'Reports',
                                      style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 12), fontFamily: "Figtree"),
                                    ),
                                  ),
                                  NavigationRailDestination(
                                    icon: Container(
                                      height: mainFunctions.getWidgetHeight(height: 48),
                                      width: mainFunctions.getWidgetWidth(width: 48),
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                              "assets/rail_navigation/check_list.png",
                                            ),
                                            fit: BoxFit.fill),
                                      ),
                                    ),
                                    selectedIcon: Container(
                                      height: mainFunctions.getWidgetHeight(height: 48),
                                      width: mainFunctions.getWidgetWidth(width: 48),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: mainColors.whiteColor.withOpacity(0.3),
                                        image: const DecorationImage(
                                            image: AssetImage(
                                              "assets/rail_navigation/check_list.png",
                                            ),
                                            fit: BoxFit.fill),
                                      ),
                                    ),
                                    label: Text(
                                      'Checklist',
                                      style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 12), fontFamily: "Figtree"),
                                    ),
                                  ),
                                  NavigationRailDestination(
                                    icon: Container(
                                      height: mainFunctions.getWidgetHeight(height: 48),
                                      width: mainFunctions.getWidgetWidth(width: 48),
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                              "assets/rail_navigation/manage.png",
                                            ),
                                            fit: BoxFit.fill),
                                      ),
                                    ),
                                    selectedIcon: Container(
                                      height: mainFunctions.getWidgetHeight(height: 48),
                                      width: mainFunctions.getWidgetWidth(width: 48),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: mainColors.whiteColor.withOpacity(0.3),
                                        image: const DecorationImage(
                                            image: AssetImage(
                                              "assets/rail_navigation/manage.png",
                                            ),
                                            fit: BoxFit.fill),
                                      ),
                                    ),
                                    label: Text(
                                      'Manage',
                                      style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 12), fontFamily: "Figtree"),
                                    ),
                                  ),
                                  NavigationRailDestination(
                                    icon: Container(
                                      height: mainFunctions.getWidgetHeight(height: 48),
                                      width: mainFunctions.getWidgetWidth(width: 48),
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                              "assets/rail_navigation/manual.png",
                                            ),
                                            fit: BoxFit.fill),
                                      ),
                                    ),
                                    selectedIcon: Container(
                                      height: mainFunctions.getWidgetHeight(height: 48),
                                      width: mainFunctions.getWidgetWidth(width: 48),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: mainColors.whiteColor.withOpacity(0.3),
                                        image: const DecorationImage(
                                            image: AssetImage(
                                              "assets/rail_navigation/manual.png",
                                            ),
                                            fit: BoxFit.fill),
                                      ),
                                    ),
                                    label: Text(
                                      'Manual',
                                      style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 12), fontFamily: "Figtree"),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                  mainVariables.railNavigationVariables.isDrawerOpen
                      ? GestureDetector(
                          onTap: () {
                            closeDrawer();
                          },
                          child: Container(
                            width: mainFunctions.getWidgetWidth(width: 100),
                            decoration: BoxDecoration(color: Colors.black.withOpacity(0.3)),
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
              Expanded(
                child: Stack(
                  children: [
                    Stack(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color(0XFF0C3788),
                                Color(0XFFBC0044),
                              ],
                            ),
                          ),
                          child: Container(
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                            child: Center(
                              child: mainVariables.generalVariables.mainScreenWidget,
                            ),
                          ),
                        ),
                        mainVariables.railNavigationVariables.isDrawerOpen
                            ? GestureDetector(
                                onTap: () {
                                  closeDrawer();
                                },
                                child: Container(
                                  decoration: BoxDecoration(color: Colors.white10.withOpacity(0.1)),
                                ),
                              )
                            : const SizedBox(),
                      ],
                    ),
                    SlideTransition(
                      position: drawerAnimation,
                      child: Container(
                        width: mainFunctions.getWidgetWidth(width: 250),
                        height: mainFunctions.getWidgetHeight(height: 1088),
                        decoration: const BoxDecoration(
                          color: Color(0xff132952),
                          borderRadius: BorderRadius.only(topRight: Radius.circular(15), bottomRight: Radius.circular(15)),
                        ),
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: mainFunctions.getWidgetHeight(height: 14),
                            ),
                            InkWell(
                              onTap: () {
                                closeDrawer();
                              },
                              child: Container(
                                height: mainFunctions.getWidgetHeight(height: 32),
                                padding: EdgeInsets.symmetric(
                                  horizontal: mainFunctions.getWidgetWidth(width: 15),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: mainFunctions.getWidgetWidth(width: 6),
                                    ),
                                    Icon(
                                      Icons.arrow_back_ios,
                                      color: mainColors.whiteColor,
                                      size: 20,
                                    ),
                                    Text(
                                      mainVariables.railNavigationVariables.tabsData[mainVariables.railNavigationVariables.drawerSelectedIndex].heading,
                                      style: mainTextStyle.drawerHeaderTextStyle,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: mainFunctions.getWidgetHeight(height: 22),
                            ),
                            Expanded(
                              child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  physics: const ScrollPhysics(),
                                  itemCount: mainVariables.railNavigationVariables.tabsData[mainVariables.railNavigationVariables.drawerSelectedIndex].drawerData.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return InkWell(
                                      onTap: () async {
                                        closeDrawer();
                                        if (mainVariables.railNavigationVariables.drawerSelectedIndex == 0) {
                                          mainVariables.reportsVariables = ReportsVariables.fromJson({});
                                          context.read<ReportsBloc>().add(ReportsPageChangingEvent(index: index));
                                          mainVariables.generalVariables.railNavigateBackIndex = mainVariables.generalVariables.railNavigateIndex;
                                          mainVariables.generalVariables.railNavigateIndex = 4;
                                          mainVariables.railNavigationVariables.mainSelectedIndex = 4;
                                          context.read<RailNavigationBloc>().add(const RailNavigationSelectedWidgetEvent());
                                        } else if (mainVariables.railNavigationVariables.drawerSelectedIndex == 1) {
                                          if (index == 1) {
                                            SharedPreferences prefs = await SharedPreferences.getInstance();
                                            DateTime convertDate = DateTime.parse(prefs.getString("dialog_time") ?? DateTime.now().add(const Duration(days: 2)).toString());
                                            DateTime today = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
                                            DateTime aDate = DateTime(convertDate.year, convertDate.month, convertDate.day);
                                            if (context.mounted) {
                                              if (aDate == today) {
                                                mainVariables.checkListVariables = CheckListVariables.fromJson({});
                                                context.read<CheckListBloc>().add(CheckListPageChangingEvent(index: index));
                                                mainVariables.checkListVariables.checkListSelectedIndex = index;
                                                mainVariables.generalVariables.railNavigateBackIndex = mainVariables.generalVariables.railNavigateIndex;
                                                mainVariables.generalVariables.railNavigateIndex = 5;
                                                mainVariables.railNavigationVariables.mainSelectedIndex = 5;
                                                context.read<RailNavigationBloc>().add(const RailNavigationSelectedWidgetEvent());
                                              } else {
                                                mainWidgets.showAnimatedDialog(
                                                  context: context,
                                                  height: 155,
                                                  width: 285,
                                                  child: mainWidgets.updateConsumptionContent(context: context),
                                                );
                                              }
                                            }
                                          }
                                          else {
                                            mainVariables.checkListVariables = CheckListVariables.fromJson({});
                                            context.read<CheckListBloc>().add(CheckListPageChangingEvent(index: index));
                                            mainVariables.checkListVariables.checkListSelectedIndex = index;
                                            mainVariables.generalVariables.railNavigateBackIndex = mainVariables.generalVariables.railNavigateIndex;
                                            mainVariables.generalVariables.railNavigateIndex = 5;
                                            mainVariables.railNavigationVariables.mainSelectedIndex = 5;
                                            context.read<RailNavigationBloc>().add(const RailNavigationSelectedWidgetEvent());
                                          }
                                        } else if (mainVariables.railNavigationVariables.drawerSelectedIndex == 2) {
                                          mainVariables.manageVariables = ManageVariables.fromJson({});
                                          context.read<ManageBloc>().add(ManagePageChangingEvent(index: index));
                                          mainVariables.manageVariables.manageSelectedIndex = index;
                                          mainVariables.generalVariables.railNavigateBackIndex = mainVariables.generalVariables.railNavigateIndex;
                                          mainVariables.generalVariables.railNavigateIndex = 6;
                                          mainVariables.railNavigationVariables.mainSelectedIndex = 6;
                                          context.read<RailNavigationBloc>().add(const RailNavigationSelectedWidgetEvent());
                                        }
                                      },
                                      child: mainVariables.railNavigationVariables.drawerSelectedIndex == 0 && index == 3
                                          ? const SizedBox()
                                          : Container(
                                              height: mainFunctions.getWidgetHeight(height: 46),
                                              padding: EdgeInsets.symmetric(
                                                horizontal: mainFunctions.getWidgetWidth(width: 15),
                                              ),
                                              margin: EdgeInsets.only(
                                                bottom: mainFunctions.getWidgetHeight(height: 12),
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    height: mainFunctions.getWidgetHeight(height: 24),
                                                    width: mainFunctions.getWidgetWidth(width: 24),
                                                    decoration: BoxDecoration(image: DecorationImage(image: AssetImage(mainVariables.railNavigationVariables.tabsData[mainVariables.railNavigationVariables.drawerSelectedIndex].drawerData[index].imageData), fit: BoxFit.fill)),
                                                  ),
                                                  SizedBox(
                                                    width: mainFunctions.getWidgetWidth(width: 12),
                                                  ),
                                                  Text(
                                                    mainVariables.railNavigationVariables.tabsData[mainVariables.railNavigationVariables.drawerSelectedIndex].drawerData[index].text,
                                                    style: mainTextStyle.drawerLabelTextStyle,
                                                  ),
                                                ],
                                              ),
                                            ),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget dialogContent() {
    return Column(
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
                child: Center(
                  child: Text(
                    'You',
                    style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 20), fontWeight: FontWeight.w600, color: const Color(0xff111111)),
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
            Container(
              height: mainFunctions.getWidgetHeight(height: 52),
              padding: EdgeInsets.symmetric(horizontal: mainFunctions.getWidgetWidth(width: 20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  mainVariables.generalVariables.userData.profilePhoto == ""
                      ? Container(
                          height: mainFunctions.getWidgetHeight(height: 52),
                          width: mainFunctions.getWidgetWidth(width: 52),
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage("assets/login/airplane_1.png"),
                                fit: BoxFit.fill,
                              )),
                        )
                      : Container(
                          height: mainFunctions.getWidgetHeight(height: 52),
                          width: mainFunctions.getWidgetWidth(width: 52),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: NetworkImage(mainVariables.generalVariables.userData.profilePhoto),
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
                        "${mainVariables.generalVariables.userData.firstName} ${mainVariables.generalVariables.userData.lastName}",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: mainFunctions.getTextSize(fontSize: 18),
                          color: const Color(0xff272627),
                        ),
                      ),
                      Text(
                        mainVariables.generalVariables.userData.role,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: mainFunctions.getTextSize(fontSize: 14),
                          color: const Color(0xff7D7D7D),
                        ),
                      )
                    ],
                  ))
                ],
              ),
            ),
            SizedBox(height: mainFunctions.getWidgetHeight(height: 24)),
            InkWell(
              onTap: () {
                Navigator.pop(context);
                mainVariables.homeVariables.selectedImage = null;
                mainVariables.homeVariables.firstNameController.text = mainVariables.generalVariables.userData.firstName;
                mainVariables.homeVariables.mailController.text = mainVariables.generalVariables.userData.email;
                mainVariables.homeVariables.networkImage = mainVariables.generalVariables.userData.profilePhoto;
                mainWidgets.showAlertDialog(
                  context: context,
                  content: editProfileContent(),
                  isDismissible: true,
                );
              },
              child: Container(
                height: mainFunctions.getWidgetHeight(height: 50),
                padding: EdgeInsets.symmetric(horizontal: mainFunctions.getWidgetWidth(width: 20), vertical: mainFunctions.getWidgetHeight(height: 12)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: mainFunctions.getWidgetHeight(height: 24),
                          width: mainFunctions.getWidgetWidth(width: 24),
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                            image: AssetImage("assets/home/Social_Icon.png"),
                            fit: BoxFit.fill,
                          )),
                        ),
                        SizedBox(
                          width: mainFunctions.getWidgetWidth(width: 12),
                        ),
                        Text(
                          "Edit profile",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: mainFunctions.getTextSize(fontSize: 16),
                            color: const Color(0xff242424),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "${mainVariables.generalVariables.userData.firstName} ${mainVariables.generalVariables.userData.lastName}",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: mainFunctions.getTextSize(fontSize: 14),
                            color: const Color(0xffA0A0A0),
                          ),
                        ),
                        SizedBox(
                          width: mainFunctions.getWidgetWidth(width: 12),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 20,
                          color: Color(0xffA0A0A0),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const Divider(
              color: Color(0xffDDDDDD),
              thickness: 1,
              height: 0,
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
                mainWidgets.showAlertDialog(
                  context: context,
                  content: changePasswordContent(),
                  isDismissible: false,
                );
              },
              child: Container(
                height: mainFunctions.getWidgetHeight(height: 50),
                padding: EdgeInsets.symmetric(horizontal: mainFunctions.getWidgetWidth(width: 20), vertical: mainFunctions.getWidgetHeight(height: 12)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: mainFunctions.getWidgetHeight(height: 24),
                      width: mainFunctions.getWidgetWidth(width: 24),
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage("assets/home/shield_security.png"),
                        fit: BoxFit.fill,
                      )),
                    ),
                    SizedBox(
                      width: mainFunctions.getWidgetWidth(width: 12),
                    ),
                    Text(
                      "Change password",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: mainFunctions.getTextSize(fontSize: 16),
                        color: const Color(0xff242424),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(
              color: Color(0xffDDDDDD),
              thickness: 1,
              height: 0,
            ),
            Container(
              height: mainFunctions.getWidgetHeight(height: 50),
              padding: EdgeInsets.symmetric(horizontal: mainFunctions.getWidgetWidth(width: 20), vertical: mainFunctions.getWidgetHeight(height: 12)),
              child: Text(
                "Version : 2.4.0 (1)",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: mainFunctions.getTextSize(fontSize: 16),
                  color: const Color(0xff242424),
                ),
              ),
            ),
            const Divider(
              color: Color(0xffDDDDDD),
              thickness: 1,
              height: 0,
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
                mainWidgets.showAnimatedDialog(
                  context: context,
                  height: 170,
                  width: 274,
                  child: signOutContent(),
                );
              },
              child: Container(
                height: mainFunctions.getWidgetHeight(height: 50),
                padding: EdgeInsets.symmetric(horizontal: mainFunctions.getWidgetWidth(width: 20), vertical: mainFunctions.getWidgetHeight(height: 12)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: mainFunctions.getWidgetHeight(height: 24),
                          width: mainFunctions.getWidgetWidth(width: 24),
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                            image: AssetImage("assets/home/exit.png"),
                            fit: BoxFit.fill,
                          )),
                        ),
                        SizedBox(
                          width: mainFunctions.getWidgetWidth(width: 12),
                        ),
                        Text(
                          "Sign Out",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: mainFunctions.getTextSize(fontSize: 16),
                            color: const Color(0xffFF0F0F),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget editProfileContent() {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter modelSetState) {
        return SizedBox(
          height: mainFunctions.getWidgetHeight(height: 560),
          width: mainFunctions.getWidgetWidth(width: 460),
          child: ListView(
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
                      child: Center(
                        child: Text(
                          'Edit Profile',
                          style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 20), fontWeight: FontWeight.w600, color: const Color(0xff111111)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: mainFunctions.getWidgetHeight(height: 52),
                      width: mainFunctions.getWidgetWidth(width: 52),
                    )
                  ],
                ),
              ),
              const Divider(
                color: Color(0xffCECECE),
                height: 0,
                thickness: 1,
              ),
              SizedBox(
                height: mainFunctions.getWidgetHeight(height: 26),
              ),
              mainVariables.homeVariables.selectedImage == null
                  ? mainVariables.homeVariables.networkImage != ""
                      ? Container(
                          height: mainFunctions.getWidgetHeight(height: 80),
                          width: mainFunctions.getWidgetWidth(width: 80),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xffE4E5E8),
                            border: Border.all(color: Colors.grey.shade200),
                            image: DecorationImage(
                              image: NetworkImage(mainVariables.homeVariables.networkImage),
                              fit: BoxFit.contain,
                            ),
                          ),
                        )
                      : Container(
                          height: mainFunctions.getWidgetHeight(height: 80),
                          width: mainFunctions.getWidgetWidth(width: 80),
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xffE4E5E8),
                              image: DecorationImage(
                                image: AssetImage("assets/login/airplane_1.png"),
                                fit: BoxFit.contain,
                              )),
                        )
                  : Container(
                      height: mainFunctions.getWidgetHeight(height: 80),
                      width: mainFunctions.getWidgetWidth(width: 80),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xffE4E5E8),
                        image: DecorationImage(
                          image: FileImage(mainVariables.homeVariables.selectedImage!),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
              mainVariables.homeVariables.selectedImage == null
                  ? TextButton(
                      onPressed: () {
                        mainVariables.homeVariables.selectedImage = null;
                        mainWidgets.showAlertDialog(
                            context: context,
                            content: mainWidgets.selectionTypeContent(
                              context: context,
                              modelSetState: modelSetState,
                            ),
                            isDismissible: true);
                      },
                      child: Text(
                        "Upload photo",
                        style: TextStyle(
                          fontSize: mainFunctions.getTextSize(fontSize: 15),
                          fontWeight: FontWeight.w600,
                          color: const Color(0xff0C3788),
                        ),
                      ))
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: () {
                              modelSetState(() {
                                mainVariables.homeVariables.selectedImage = null;
                              });
                            },
                            child: Text(
                              "Remove photo",
                              style: TextStyle(
                                fontSize: mainFunctions.getTextSize(fontSize: 15),
                                fontWeight: FontWeight.w600,
                                color: Colors.red,
                              ),
                            )),
                        TextButton(
                            onPressed: () {
                              mainWidgets.showAlertDialog(
                                  context: context,
                                  content: mainWidgets.selectionTypeContent(
                                    context: context,
                                    modelSetState: modelSetState,
                                  ),
                                  isDismissible: true);
                            },
                            child: Text(
                              "Change photo",
                              style: TextStyle(
                                fontSize: mainFunctions.getTextSize(fontSize: 15),
                                fontWeight: FontWeight.w600,
                                color: const Color(0xff0C3788),
                              ),
                            )),
                      ],
                    ),
              SizedBox(
                height: mainFunctions.getWidgetHeight(height: 10),
              ),
              const Divider(
                color: Color(0xffCECECE),
                height: 0,
                thickness: 1,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: mainFunctions.getWidgetWidth(width: 20),
                  vertical: mainFunctions.getWidgetHeight(height: 16),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Personal Information",
                      style: TextStyle(color: const Color(0xff767676), fontWeight: FontWeight.w600, fontSize: mainFunctions.getTextSize(fontSize: 15)),
                    ),
                    SizedBox(
                      height: mainFunctions.getWidgetHeight(height: 16),
                    ),
                    SizedBox(
                      height: mainFunctions.getWidgetHeight(height: 80),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Your Name",
                            style: TextStyle(fontWeight: FontWeight.w600, fontSize: mainFunctions.getTextSize(fontSize: 15), color: const Color(0xff111111)),
                          ),
                          SizedBox(
                            height: mainFunctions.getWidgetHeight(height: 10),
                          ),
                          SizedBox(
                            height: mainFunctions.getWidgetHeight(height: 44),
                            width: mainFunctions.getWidgetWidth(width: MediaQuery.of(context).orientation == Orientation.portrait ? mainFunctions.getWidgetWidth(width: 425) : mainFunctions.getWidgetWidth(width: 425)),
                            child: TextFormField(
                              controller: mainVariables.homeVariables.firstNameController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                hintText: "Add firstName",
                                hintStyle: TextStyle(
                                  fontSize: mainFunctions.getTextSize(fontSize: 13),
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xff838195),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(color: Color(0xff0C3788), width: 1),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(color: Color(0xff0C3788), width: 1),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(color: Color(0xff0C3788), width: 1),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(color: Color(0xff0C3788), width: 1),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(color: Color(0xff0C3788), width: 1),
                                ),
                              ),
                              style: TextStyle(fontWeight: FontWeight.w500, fontSize: mainFunctions.getTextSize(fontSize: 15)),
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "E - Mail",
                            style: TextStyle(fontWeight: FontWeight.w600, fontSize: mainFunctions.getTextSize(fontSize: 15), color: const Color(0xff111111)),
                          ),
                          SizedBox(
                            height: mainFunctions.getWidgetHeight(height: 10),
                          ),
                          SizedBox(
                            height: mainFunctions.getWidgetHeight(height: 44),
                            width: mainFunctions.getWidgetWidth(width: MediaQuery.of(context).orientation == Orientation.portrait ? mainFunctions.getWidgetWidth(width: 425) : mainFunctions.getWidgetWidth(width: 425)),
                            child: TextFormField(
                              controller: mainVariables.homeVariables.mailController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                hintText: "Add e mail",
                                hintStyle: TextStyle(
                                  fontSize: mainFunctions.getTextSize(fontSize: 13),
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xff838195),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(color: Color(0xff0C3788), width: 1),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(color: Color(0xff0C3788), width: 1),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(color: Color(0xff0C3788), width: 1),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(color: Color(0xff0C3788), width: 1),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(color: Color(0xff0C3788), width: 1),
                                ),
                              ),
                              style: TextStyle(fontWeight: FontWeight.w500, fontSize: mainFunctions.getTextSize(fontSize: 15)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: mainFunctions.getWidgetHeight(height: 40),
                    ),
                    LoadingButton(
                      status: mainVariables.homeVariables.profileSavingLoader,
                      onTap: () async {
                        mainVariables.homeVariables.profileSavingLoader = true;
                        if (mainVariables.homeVariables.firstNameController.text == "" || mainVariables.homeVariables.mailController.text == "") {
                          if (mainVariables.homeVariables.firstNameController.text == "") {
                            mainWidgets.flushBarWidget(context: context, message: "First name field is empty, Kindly enter the first name");
                          } else if (mainVariables.homeVariables.mailController.text == "") {
                            mainWidgets.flushBarWidget(context: context, message: "Mail field is empty, Kindly enter the valid email");
                          }
                          mainVariables.homeVariables.profileSavingLoader = false;
                        } else {
                          await mainVariables.repoImpl.editProfileFunction(query: {
                            "firstName": mainVariables.homeVariables.firstNameController.text,
                            "lastName": mainVariables.homeVariables.lastNameController.text,
                            "email": mainVariables.homeVariables.mailController.text,
                          }, files: {
                            "profileImage": mainVariables.homeVariables.selectedImage ?? File("")
                          }).onError((error, stackTrace) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.toString())));
                            mainVariables.homeVariables.profileSavingLoader = false;
                          }).then((value) async {
                            if (value != null) {
                              EditProfileModel editProfile = EditProfileModel.fromJson(value);
                              if (editProfile.status) {
                                mainVariables.generalVariables.userData = editProfile.updatedUser;
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(editProfile.message)));
                                Navigator.pop(context);
                                mainWidgets.showAnimatedDialog(
                                  context: context,
                                  height: 352,
                                  width: 460,
                                  child: dialogContent(),
                                );
                                mainVariables.homeVariables.profileSavingLoader = false;
                                var box = await Hive.openBox('boxData');
                                box.clear();
                                UserResponse userResponse = UserResponse(
                                  token: mainVariables.generalVariables.userToken,
                                  user: User(
                                    id: editProfile.updatedUser.id,
                                    firstName: editProfile.updatedUser.firstName,
                                    lastName: editProfile.updatedUser.lastName,
                                    email: editProfile.updatedUser.email,
                                    role: editProfile.updatedUser.role,
                                    createdAt: DateTime.parse("${editProfile.updatedUser.createdAt}"),
                                    updatedAt: DateTime.parse("${editProfile.updatedUser.updatedAt}"),
                                    activeStatus: editProfile.updatedUser.activeStatus,
                                    verificationCode: editProfile.updatedUser.verificationCode,
                                    verificationCodeExpiry: DateTime.parse("${editProfile.updatedUser.verificationCodeExpiry}"),
                                    profilePhoto: editProfile.updatedUser.profilePhoto,
                                  ),
                                  status: editProfile.status,
                                );
                                await box.put('user_response', userResponse);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(editProfile.message)));
                                mainVariables.homeVariables.profileSavingLoader = false;
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Something went wrong")));
                              mainVariables.homeVariables.profileSavingLoader = false;
                            }
                          });
                        }
                      },
                      text: "Save Changes",
                      height: 42,
                      width: 420,
                      fontSize: 15,
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget changePasswordContent() {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter modelSetState) {
        return SingleChildScrollView(
          child: SizedBox(
            width: mainFunctions.getWidgetWidth(width: 460),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
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
                            mainVariables.homeVariables.currentPasswordController.clear();
                            mainVariables.homeVariables.newPasswordController.clear();
                            mainVariables.homeVariables.confirmPasswordController.clear();
                            mainVariables.homeVariables.currentPasswordObscure = true;
                            mainVariables.homeVariables.newPasswordObscure = true;
                            mainVariables.homeVariables.confirmPasswordObscure = true;
                            mainVariables.homeVariables.isMatched = true;
                            mainVariables.homeVariables.forMatchedText = false;
                            mainVariables.homeVariables.isCorrectPassword = true;
                            mainVariables.homeVariables.passwordStatus = "Very Weak";
                            mainVariables.homeVariables.passwordStrength = 0.0;
                            mainVariables.homeVariables.progressColor = Colors.blue;
                            mainVariables.homeVariables.counter = 0;
                            mainVariables.homeVariables.isPasswordEmpty = false;
                            mainVariables.homeVariables.passwordEmpty = false;
                            mainVariables.homeVariables.lowerCase = false;
                            mainVariables.homeVariables.upperCase = false;
                            mainVariables.homeVariables.lengthCase = false;
                            mainVariables.homeVariables.symbolCase = false;
                            mainVariables.homeVariables.numberCase = false;
                          },
                          icon: const Icon(
                            Icons.close,
                            color: Color(0xff1C1C1D),
                            size: 20,
                          )),
                      Expanded(
                        child: Center(
                          child: Text(
                            'Change password',
                            style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 20), fontWeight: FontWeight.w600, color: const Color(0xff111111)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: mainFunctions.getWidgetHeight(height: 52),
                        width: mainFunctions.getWidgetWidth(width: 52),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  color: Color(0xffCECECE),
                  height: 0,
                  thickness: 1,
                ),
                SizedBox(
                  height: mainFunctions.getWidgetHeight(height: 20),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: mainFunctions.getWidgetWidth(width: 20),
                  ),
                  child: Text(
                    "your password must be contain 8 or more characters ,One upper case & Special letter(!@#\$%) & At least one number",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: mainFunctions.getTextSize(fontSize: 14),
                      color: const Color(0xff111111),
                    ),
                  ),
                ),
                SizedBox(height: mainFunctions.getWidgetHeight(height: 20)),
                const Divider(
                  color: Color(0xffCECECE),
                  height: 0,
                  thickness: 1,
                ),
                SizedBox(height: mainFunctions.getWidgetHeight(height: 20)),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: mainFunctions.getWidgetWidth(width: 20),
                    vertical: mainFunctions.getWidgetHeight(height: 16),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Current Password",
                            style: TextStyle(fontWeight: FontWeight.w600, fontSize: mainFunctions.getTextSize(fontSize: 15), color: const Color(0xff111111)),
                          ),
                          SizedBox(
                            height: mainFunctions.getWidgetHeight(height: 10),
                          ),
                          SizedBox(
                            height: mainFunctions.getWidgetHeight(height: 44),
                            width: mainFunctions.getWidgetWidth(width: MediaQuery.of(context).orientation == Orientation.portrait ? mainFunctions.getWidgetWidth(width: 425) : mainFunctions.getWidgetWidth(width: 425)),
                            child: TextFormField(
                              controller: mainVariables.homeVariables.currentPasswordController,
                              keyboardType: TextInputType.text,
                              obscureText: mainVariables.homeVariables.currentPasswordObscure,
                              decoration: InputDecoration(
                                  hintText: "Enter Current Password",
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
                                        context.read<RailNavigationBloc>().add(const PasswordToggleEvent(type: "current"));
                                        modelSetState(() {});
                                      },
                                      icon: mainVariables.homeVariables.currentPasswordObscure ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility))),
                              onChanged: (value) {
                                modelSetState(() {
                                  if (value.isNotEmpty) {
                                    mainVariables.homeVariables.passwordEmpty = false;
                                  } else {
                                    mainVariables.homeVariables.passwordEmpty = true;
                                  }
                                });
                              },
                              style: TextStyle(fontWeight: FontWeight.w500, fontSize: mainFunctions.getTextSize(fontSize: 15)),
                            ),
                          ),
                          mainVariables.homeVariables.passwordEmpty
                              ? Text(
                                  "password field is empty, please enter your password",
                                  style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 14), fontWeight: FontWeight.w500, color: Colors.red),
                                )
                              : const SizedBox(),
                        ],
                      ),
                      SizedBox(height: mainFunctions.getWidgetHeight(height: 16)),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "New Password",
                            style: TextStyle(fontWeight: FontWeight.w600, fontSize: mainFunctions.getTextSize(fontSize: 15), color: const Color(0xff111111)),
                          ),
                          SizedBox(
                            height: mainFunctions.getWidgetHeight(height: 10),
                          ),
                          SizedBox(
                            height: mainFunctions.getWidgetHeight(height: 44),
                            width: mainFunctions.getWidgetWidth(width: MediaQuery.of(context).orientation == Orientation.portrait ? mainFunctions.getWidgetWidth(width: 425) : mainFunctions.getWidgetWidth(width: 425)),
                            child: TextFormField(
                              controller: mainVariables.homeVariables.newPasswordController,
                              keyboardType: TextInputType.text,
                              obscureText: mainVariables.homeVariables.newPasswordObscure,
                              onTap: () {
                                if (mainVariables.homeVariables.newPasswordController.text != "") {
                                  if (mainVariables.homeVariables.newPasswordController.text != "") {
                                    mainVariables.homeVariables.isPasswordEmpty = false;
                                    mainVariables.homeVariables.isCorrectPassword = RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,40}$").hasMatch(mainVariables.homeVariables.newPasswordController.text);
                                    if (mainVariables.homeVariables.isCorrectPassword) {
                                      if (mainVariables.homeVariables.confirmPasswordController.text != "") {
                                        if (mainVariables.homeVariables.newPasswordController.text != mainVariables.homeVariables.confirmPasswordController.text) {
                                          mainVariables.homeVariables.isPasswordEmpty = false;
                                          mainVariables.homeVariables.isCorrectPassword = true;
                                          mainVariables.homeVariables.isMatched = false;
                                          mainVariables.homeVariables.forMatchedText = false;
                                          modelSetState(() {});
                                        } else {
                                          mainVariables.homeVariables.isPasswordEmpty = false;
                                          mainVariables.homeVariables.isCorrectPassword = true;
                                          mainVariables.homeVariables.isMatched = false;
                                          mainVariables.homeVariables.forMatchedText = true;
                                          modelSetState(() {});
                                        }
                                      } else {
                                        mainVariables.homeVariables.isPasswordEmpty = false;
                                        mainVariables.homeVariables.isCorrectPassword = true;
                                        mainVariables.homeVariables.isMatched = true;
                                        mainVariables.homeVariables.forMatchedText = false;
                                        modelSetState(() {});
                                      }
                                    } else {
                                      mainVariables.homeVariables.isPasswordEmpty = false;
                                      mainVariables.homeVariables.isCorrectPassword = false;
                                      mainVariables.homeVariables.isMatched = true;
                                      mainVariables.homeVariables.forMatchedText = false;
                                      modelSetState(() {});
                                    }
                                  } else {
                                    mainVariables.homeVariables.isPasswordEmpty = true;
                                    mainVariables.homeVariables.isCorrectPassword = true;
                                    mainVariables.homeVariables.isMatched = true;
                                    mainVariables.homeVariables.forMatchedText = false;
                                    modelSetState(() {});
                                  }
                                }
                              },
                              onTapOutside: (value) {
                                if (mainVariables.homeVariables.newPasswordController.text != "") {
                                  mainVariables.homeVariables.isPasswordEmpty = false;
                                  mainVariables.homeVariables.isCorrectPassword = RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,40}$").hasMatch(mainVariables.homeVariables.newPasswordController.text);
                                  if (mainVariables.homeVariables.isCorrectPassword) {
                                    if (mainVariables.homeVariables.confirmPasswordController.text != "") {
                                      if (mainVariables.homeVariables.newPasswordController.text != mainVariables.homeVariables.confirmPasswordController.text) {
                                        mainVariables.homeVariables.isPasswordEmpty = false;
                                        mainVariables.homeVariables.isCorrectPassword = true;
                                        mainVariables.homeVariables.isMatched = false;
                                        mainVariables.homeVariables.forMatchedText = false;
                                        modelSetState(() {});
                                      } else {
                                        mainVariables.homeVariables.isPasswordEmpty = false;
                                        mainVariables.homeVariables.isCorrectPassword = true;
                                        mainVariables.homeVariables.isMatched = false;
                                        mainVariables.homeVariables.forMatchedText = true;
                                        modelSetState(() {});
                                      }
                                    } else {
                                      mainVariables.homeVariables.isPasswordEmpty = false;
                                      mainVariables.homeVariables.isCorrectPassword = true;
                                      mainVariables.homeVariables.isMatched = true;
                                      mainVariables.homeVariables.forMatchedText = false;
                                      modelSetState(() {});
                                    }
                                  } else {
                                    mainVariables.homeVariables.isPasswordEmpty = false;
                                    mainVariables.homeVariables.isCorrectPassword = false;
                                    mainVariables.homeVariables.isMatched = true;
                                    mainVariables.homeVariables.forMatchedText = false;
                                    modelSetState(() {});
                                  }
                                } else {
                                  mainVariables.homeVariables.isPasswordEmpty = true;
                                  mainVariables.homeVariables.isCorrectPassword = true;
                                  mainVariables.homeVariables.isMatched = true;
                                  mainVariables.homeVariables.forMatchedText = false;
                                  modelSetState(() {});
                                }
                              },
                              onFieldSubmitted: (value) {
                                if (mainVariables.homeVariables.newPasswordController.text != "") {
                                  mainVariables.homeVariables.isPasswordEmpty = false;
                                  mainVariables.homeVariables.isCorrectPassword = RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,40}$").hasMatch(mainVariables.homeVariables.newPasswordController.text);
                                  if (mainVariables.homeVariables.isCorrectPassword) {
                                    if (mainVariables.homeVariables.confirmPasswordController.text != "") {
                                      if (mainVariables.homeVariables.newPasswordController.text != mainVariables.homeVariables.confirmPasswordController.text) {
                                        mainVariables.homeVariables.isPasswordEmpty = false;
                                        mainVariables.homeVariables.isCorrectPassword = true;
                                        mainVariables.homeVariables.isMatched = false;
                                        mainVariables.homeVariables.forMatchedText = false;
                                        modelSetState(() {});
                                      } else {
                                        mainVariables.homeVariables.isPasswordEmpty = false;
                                        mainVariables.homeVariables.isCorrectPassword = true;
                                        mainVariables.homeVariables.isMatched = false;
                                        mainVariables.homeVariables.forMatchedText = true;
                                        modelSetState(() {});
                                      }
                                    } else {
                                      mainVariables.homeVariables.isPasswordEmpty = false;
                                      mainVariables.homeVariables.isCorrectPassword = true;
                                      mainVariables.homeVariables.isMatched = true;
                                      mainVariables.homeVariables.forMatchedText = false;
                                      modelSetState(() {});
                                    }
                                  } else {
                                    mainVariables.homeVariables.isPasswordEmpty = false;
                                    mainVariables.homeVariables.isCorrectPassword = false;
                                    mainVariables.homeVariables.isMatched = true;
                                    mainVariables.homeVariables.forMatchedText = false;
                                    modelSetState(() {});
                                  }
                                } else {
                                  mainVariables.homeVariables.isPasswordEmpty = true;
                                  mainVariables.homeVariables.isCorrectPassword = true;
                                  mainVariables.homeVariables.isMatched = true;
                                  mainVariables.homeVariables.forMatchedText = false;
                                  modelSetState(() {});
                                }
                                FocusManager.instance.primaryFocus?.unfocus();
                              },
                              onEditingComplete: () {
                                if (mainVariables.homeVariables.newPasswordController.text != "") {
                                  mainVariables.homeVariables.isPasswordEmpty = false;
                                  mainVariables.homeVariables.isCorrectPassword = RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,40}$").hasMatch(mainVariables.homeVariables.newPasswordController.text);
                                  if (mainVariables.homeVariables.isCorrectPassword) {
                                    if (mainVariables.homeVariables.confirmPasswordController.text != "") {
                                      if (mainVariables.homeVariables.newPasswordController.text != mainVariables.homeVariables.confirmPasswordController.text) {
                                        mainVariables.homeVariables.isPasswordEmpty = false;
                                        mainVariables.homeVariables.isCorrectPassword = true;
                                        mainVariables.homeVariables.isMatched = false;
                                        mainVariables.homeVariables.forMatchedText = false;
                                        modelSetState(() {});
                                      } else {
                                        mainVariables.homeVariables.isPasswordEmpty = false;
                                        mainVariables.homeVariables.isCorrectPassword = true;
                                        mainVariables.homeVariables.isMatched = true;
                                        mainVariables.homeVariables.forMatchedText = true;
                                        modelSetState(() {});
                                      }
                                    } else {
                                      mainVariables.homeVariables.isPasswordEmpty = false;
                                      mainVariables.homeVariables.isCorrectPassword = true;
                                      mainVariables.homeVariables.isMatched = true;
                                      mainVariables.homeVariables.forMatchedText = false;
                                      modelSetState(() {});
                                    }
                                  } else {
                                    mainVariables.homeVariables.isPasswordEmpty = false;
                                    mainVariables.homeVariables.isCorrectPassword = false;
                                    mainVariables.homeVariables.isMatched = true;
                                    mainVariables.homeVariables.forMatchedText = false;
                                    modelSetState(() {});
                                  }
                                } else {
                                  mainVariables.homeVariables.isPasswordEmpty = true;
                                  mainVariables.homeVariables.isCorrectPassword = true;
                                  mainVariables.homeVariables.isMatched = true;
                                  mainVariables.homeVariables.forMatchedText = false;
                                  modelSetState(() {});
                                }
                                FocusManager.instance.primaryFocus?.unfocus();
                              },
                              onChanged: (value) {
                                if (value.isNotEmpty) {
                                  mainVariables.homeVariables.isPasswordEmpty = false;
                                  mainVariables.homeVariables.isCorrectPassword = true;
                                  mainVariables.homeVariables.isMatched = true;
                                  mainVariables.homeVariables.forMatchedText = false;
                                  mainVariables.homeVariables.counter = 0;
                                  mainVariables.homeVariables.upperCase = false;
                                  mainVariables.homeVariables.lowerCase = false;
                                  mainVariables.homeVariables.symbolCase = false;
                                  mainVariables.homeVariables.numberCase = false;
                                  mainVariables.homeVariables.lengthCase = false;
                                  for (int i = 0; i < value.length; i++) {
                                    if (mainVariables.homeVariables.lowerCase == false && value.contains(RegExp(r'[a-z]'))) {
                                      mainVariables.homeVariables.counter++;
                                      mainVariables.homeVariables.lowerCase = true;
                                    }
                                    if (mainVariables.homeVariables.upperCase == false && value.contains(RegExp(r'[A-Z]'))) {
                                      mainVariables.homeVariables.counter++;
                                      mainVariables.homeVariables.upperCase = true;
                                    }
                                    if (mainVariables.homeVariables.numberCase == false && value.contains(RegExp(r'[0-9]'))) {
                                      mainVariables.homeVariables.counter++;
                                      mainVariables.homeVariables.numberCase = true;
                                    }
                                    if (mainVariables.homeVariables.symbolCase == false && value.contains(RegExp(r'[!@#\$%&*()?£\-_=]'))) {
                                      mainVariables.homeVariables.counter++;
                                      mainVariables.homeVariables.symbolCase = true;
                                    }
                                    if (mainVariables.homeVariables.lengthCase == false && value.length > 7 && value.length <= 40) {
                                      mainVariables.homeVariables.counter++;
                                      mainVariables.homeVariables.lengthCase = true;
                                    }
                                  }
                                  mainVariables.homeVariables.passwordStrength = mainVariables.homeVariables.counter * 0.20;
                                  mainVariables.homeVariables.passwordStatus = mainVariables.homeVariables.statusList[mainVariables.homeVariables.counter - 1];
                                  mainVariables.homeVariables.progressColor = mainVariables.homeVariables.colorsList[mainVariables.homeVariables.counter - 1];
                                } else {
                                  mainVariables.homeVariables.isPasswordEmpty = true;
                                  mainVariables.homeVariables.isCorrectPassword = true;
                                  mainVariables.homeVariables.isMatched = true;
                                  mainVariables.homeVariables.forMatchedText = false;
                                  mainVariables.homeVariables.counter = 0;
                                  mainVariables.homeVariables.passwordStatus = "Very Week";
                                  mainVariables.homeVariables.passwordStrength = 0.0;
                                  mainVariables.homeVariables.progressColor = Colors.blue;
                                  mainVariables.homeVariables.upperCase = false;
                                  mainVariables.homeVariables.lowerCase = false;
                                  mainVariables.homeVariables.symbolCase = false;
                                  mainVariables.homeVariables.numberCase = false;
                                  mainVariables.homeVariables.lengthCase = false;
                                }
                                modelSetState(() {});
                              },
                              decoration: InputDecoration(
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
                                        context.read<RailNavigationBloc>().add(const PasswordToggleEvent(type: "new"));
                                        modelSetState(() {});
                                      },
                                      icon: mainVariables.homeVariables.newPasswordObscure ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility))),
                              style: TextStyle(fontWeight: FontWeight.w500, fontSize: mainFunctions.getTextSize(fontSize: 15)),
                            ),
                          ),
                          mainVariables.homeVariables.isPasswordEmpty
                              ? Text(
                                  "Password field is empty, Please enter strong password",
                                  style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 14), fontWeight: FontWeight.w500, color: Colors.red),
                                )
                              : const SizedBox(),
                          mainVariables.homeVariables.isCorrectPassword
                              ? const SizedBox()
                              : Text(
                                  "Entered password is ${mainVariables.homeVariables.passwordStatus}, Please follow the above instructions",
                                  style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 14), fontWeight: FontWeight.w500, color: Colors.red),
                                ),
                        ],
                      ),
                      mainVariables.homeVariables.newPasswordController.text.isEmpty
                          ? const SizedBox()
                          : SizedBox(
                              height: mainFunctions.getWidgetHeight(height: 15),
                            ),
                      mainVariables.homeVariables.newPasswordController.text.isEmpty
                          ? const SizedBox()
                          : Container(
                              width: mainFunctions.getWidgetWidth(width: 586),
                              padding: EdgeInsets.symmetric(
                                horizontal: mainFunctions.getWidgetWidth(width: 25),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Strength : ${mainVariables.homeVariables.passwordStatus}"),
                                  LinearProgressIndicator(
                                    value: mainVariables.homeVariables.passwordStrength,
                                    borderRadius: BorderRadius.circular(15),
                                    color: mainVariables.homeVariables.progressColor,
                                  ),
                                ],
                              ),
                            ),
                      SizedBox(height: mainFunctions.getWidgetHeight(height: 16)),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Confirm New Password",
                            style: TextStyle(fontWeight: FontWeight.w600, fontSize: mainFunctions.getTextSize(fontSize: 15), color: const Color(0xff111111)),
                          ),
                          SizedBox(
                            height: mainFunctions.getWidgetHeight(height: 10),
                          ),
                          SizedBox(
                            height: mainFunctions.getWidgetHeight(height: 44),
                            width: mainFunctions.getWidgetWidth(width: MediaQuery.of(context).orientation == Orientation.portrait ? mainFunctions.getWidgetWidth(width: 425) : mainFunctions.getWidgetWidth(width: 425)),
                            child: TextFormField(
                              controller: mainVariables.homeVariables.confirmPasswordController,
                              keyboardType: TextInputType.text,
                              obscureText: mainVariables.homeVariables.confirmPasswordObscure,
                              onTap: () {
                                if (mainVariables.homeVariables.confirmPasswordController.text != "") {
                                  if (mainVariables.homeVariables.newPasswordController.text != "") {
                                    mainVariables.homeVariables.isPasswordEmpty = false;
                                    mainVariables.homeVariables.isCorrectPassword = RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,40}$").hasMatch(mainVariables.homeVariables.newPasswordController.text);
                                    if (mainVariables.homeVariables.isCorrectPassword) {
                                      if (mainVariables.homeVariables.confirmPasswordController.text != "") {
                                        if (mainVariables.homeVariables.newPasswordController.text != mainVariables.homeVariables.confirmPasswordController.text) {
                                          mainVariables.homeVariables.isPasswordEmpty = false;
                                          mainVariables.homeVariables.isCorrectPassword = true;
                                          mainVariables.homeVariables.isMatched = false;
                                          mainVariables.homeVariables.forMatchedText = false;
                                          modelSetState(() {});
                                        } else {
                                          mainVariables.homeVariables.isPasswordEmpty = false;
                                          mainVariables.homeVariables.isCorrectPassword = true;
                                          mainVariables.homeVariables.isMatched = true;
                                          mainVariables.homeVariables.forMatchedText = true;
                                          modelSetState(() {});
                                        }
                                      } else {
                                        mainVariables.homeVariables.isPasswordEmpty = false;
                                        mainVariables.homeVariables.isCorrectPassword = true;
                                        mainVariables.homeVariables.isMatched = true;
                                        mainVariables.homeVariables.forMatchedText = false;
                                        modelSetState(() {});
                                      }
                                    } else {
                                      mainVariables.homeVariables.isPasswordEmpty = false;
                                      mainVariables.homeVariables.isCorrectPassword = false;
                                      mainVariables.homeVariables.isMatched = true;
                                      mainVariables.homeVariables.forMatchedText = false;
                                      modelSetState(() {});
                                    }
                                  } else {
                                    mainVariables.homeVariables.isPasswordEmpty = true;
                                    mainVariables.homeVariables.isCorrectPassword = true;
                                    mainVariables.homeVariables.isMatched = true;
                                    mainVariables.homeVariables.forMatchedText = false;
                                    modelSetState(() {});
                                  }
                                }
                              },
                              onTapOutside: (value) {
                                if (mainVariables.homeVariables.newPasswordController.text != "") {
                                  mainVariables.homeVariables.isPasswordEmpty = false;
                                  mainVariables.homeVariables.isCorrectPassword = RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,40}$").hasMatch(mainVariables.homeVariables.newPasswordController.text);
                                  if (mainVariables.homeVariables.isCorrectPassword) {
                                    if (mainVariables.homeVariables.confirmPasswordController.text != "") {
                                      if (mainVariables.homeVariables.newPasswordController.text != mainVariables.homeVariables.confirmPasswordController.text) {
                                        mainVariables.homeVariables.isPasswordEmpty = false;
                                        mainVariables.homeVariables.isCorrectPassword = true;
                                        mainVariables.homeVariables.isMatched = false;
                                        mainVariables.homeVariables.forMatchedText = false;
                                        modelSetState(() {});
                                      } else {
                                        mainVariables.homeVariables.isPasswordEmpty = false;
                                        mainVariables.homeVariables.isCorrectPassword = true;
                                        mainVariables.homeVariables.isMatched = true;
                                        mainVariables.homeVariables.forMatchedText = true;
                                        modelSetState(() {});
                                      }
                                    } else {
                                      mainVariables.homeVariables.isPasswordEmpty = false;
                                      mainVariables.homeVariables.isCorrectPassword = true;
                                      mainVariables.homeVariables.isMatched = true;
                                      mainVariables.homeVariables.forMatchedText = false;
                                      modelSetState(() {});
                                    }
                                  } else {
                                    mainVariables.homeVariables.isPasswordEmpty = false;
                                    mainVariables.homeVariables.isCorrectPassword = false;
                                    mainVariables.homeVariables.isMatched = true;
                                    mainVariables.homeVariables.forMatchedText = false;
                                    modelSetState(() {});
                                  }
                                } else {
                                  mainVariables.homeVariables.isPasswordEmpty = true;
                                  mainVariables.homeVariables.isCorrectPassword = true;
                                  mainVariables.homeVariables.isMatched = true;
                                  mainVariables.homeVariables.forMatchedText = false;
                                  modelSetState(() {});
                                }
                              },
                              onFieldSubmitted: (value) {
                                if (mainVariables.homeVariables.newPasswordController.text != "") {
                                  mainVariables.homeVariables.isPasswordEmpty = false;
                                  mainVariables.homeVariables.isCorrectPassword = RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,40}$").hasMatch(mainVariables.homeVariables.newPasswordController.text);
                                  if (mainVariables.homeVariables.isCorrectPassword) {
                                    if (mainVariables.homeVariables.confirmPasswordController.text != "") {
                                      if (mainVariables.homeVariables.newPasswordController.text != mainVariables.homeVariables.confirmPasswordController.text) {
                                        mainVariables.homeVariables.isPasswordEmpty = false;
                                        mainVariables.homeVariables.isCorrectPassword = true;
                                        mainVariables.homeVariables.isMatched = false;
                                        mainVariables.homeVariables.forMatchedText = false;
                                        modelSetState(() {});
                                      } else {
                                        mainVariables.homeVariables.isPasswordEmpty = false;
                                        mainVariables.homeVariables.isCorrectPassword = true;
                                        mainVariables.homeVariables.isMatched = true;
                                        mainVariables.homeVariables.forMatchedText = true;
                                        modelSetState(() {});
                                      }
                                    } else {
                                      mainVariables.homeVariables.isPasswordEmpty = false;
                                      mainVariables.homeVariables.isCorrectPassword = true;
                                      mainVariables.homeVariables.isMatched = true;
                                      mainVariables.homeVariables.forMatchedText = false;
                                      modelSetState(() {});
                                    }
                                  } else {
                                    mainVariables.homeVariables.isPasswordEmpty = false;
                                    mainVariables.homeVariables.isCorrectPassword = false;
                                    mainVariables.homeVariables.isMatched = true;
                                    mainVariables.homeVariables.forMatchedText = false;
                                    modelSetState(() {});
                                  }
                                } else {
                                  mainVariables.homeVariables.isPasswordEmpty = true;
                                  mainVariables.homeVariables.isCorrectPassword = true;
                                  mainVariables.homeVariables.isMatched = true;
                                  mainVariables.homeVariables.forMatchedText = false;
                                  modelSetState(() {});
                                }
                                FocusManager.instance.primaryFocus?.unfocus();
                              },
                              onEditingComplete: () {
                                if (mainVariables.homeVariables.newPasswordController.text != "") {
                                  mainVariables.homeVariables.isPasswordEmpty = false;
                                  mainVariables.homeVariables.isCorrectPassword = RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,40}$").hasMatch(mainVariables.homeVariables.newPasswordController.text);
                                  if (mainVariables.homeVariables.isCorrectPassword) {
                                    if (mainVariables.homeVariables.confirmPasswordController.text != "") {
                                      if (mainVariables.homeVariables.newPasswordController.text != mainVariables.homeVariables.confirmPasswordController.text) {
                                        mainVariables.homeVariables.isPasswordEmpty = false;
                                        mainVariables.homeVariables.isCorrectPassword = true;
                                        mainVariables.homeVariables.isMatched = false;
                                        mainVariables.homeVariables.forMatchedText = false;
                                        modelSetState(() {});
                                      } else {
                                        mainVariables.homeVariables.isPasswordEmpty = false;
                                        mainVariables.homeVariables.isCorrectPassword = true;
                                        mainVariables.homeVariables.isMatched = true;
                                        mainVariables.homeVariables.forMatchedText = true;
                                        modelSetState(() {});
                                      }
                                    } else {
                                      mainVariables.homeVariables.isPasswordEmpty = false;
                                      mainVariables.homeVariables.isCorrectPassword = true;
                                      mainVariables.homeVariables.isMatched = true;
                                      mainVariables.homeVariables.forMatchedText = false;
                                      modelSetState(() {});
                                    }
                                  } else {
                                    mainVariables.homeVariables.isPasswordEmpty = false;
                                    mainVariables.homeVariables.isCorrectPassword = false;
                                    mainVariables.homeVariables.isMatched = true;
                                    mainVariables.homeVariables.forMatchedText = false;
                                    modelSetState(() {});
                                  }
                                } else {
                                  mainVariables.homeVariables.isPasswordEmpty = true;
                                  mainVariables.homeVariables.isCorrectPassword = true;
                                  mainVariables.homeVariables.isMatched = true;
                                  mainVariables.homeVariables.forMatchedText = false;
                                  modelSetState(() {});
                                }
                                FocusManager.instance.primaryFocus?.unfocus();
                              },
                              onChanged: (value) {
                                if (mainVariables.homeVariables.newPasswordController.text != "") {
                                  mainVariables.homeVariables.isPasswordEmpty = false;
                                  mainVariables.homeVariables.isCorrectPassword = RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,40}$").hasMatch(mainVariables.homeVariables.newPasswordController.text);
                                  if (mainVariables.homeVariables.isCorrectPassword) {
                                    if (mainVariables.homeVariables.confirmPasswordController.text != "") {
                                      if (mainVariables.homeVariables.newPasswordController.text != mainVariables.homeVariables.confirmPasswordController.text) {
                                        mainVariables.homeVariables.isPasswordEmpty = false;
                                        mainVariables.homeVariables.isCorrectPassword = true;
                                        mainVariables.homeVariables.isMatched = false;
                                        mainVariables.homeVariables.forMatchedText = false;
                                        modelSetState(() {});
                                      } else {
                                        mainVariables.homeVariables.isPasswordEmpty = false;
                                        mainVariables.homeVariables.isCorrectPassword = true;
                                        mainVariables.homeVariables.isMatched = true;
                                        mainVariables.homeVariables.forMatchedText = true;
                                        modelSetState(() {});
                                      }
                                    } else {
                                      mainVariables.homeVariables.isPasswordEmpty = false;
                                      mainVariables.homeVariables.isCorrectPassword = true;
                                      mainVariables.homeVariables.isMatched = true;
                                      mainVariables.homeVariables.forMatchedText = false;
                                      modelSetState(() {});
                                    }
                                  } else {
                                    mainVariables.homeVariables.isPasswordEmpty = false;
                                    mainVariables.homeVariables.isCorrectPassword = false;
                                    mainVariables.homeVariables.isMatched = true;
                                    mainVariables.homeVariables.forMatchedText = false;
                                    modelSetState(() {});
                                  }
                                } else {
                                  mainVariables.homeVariables.isPasswordEmpty = true;
                                  mainVariables.homeVariables.isCorrectPassword = true;
                                  mainVariables.homeVariables.isMatched = true;
                                  mainVariables.homeVariables.forMatchedText = false;
                                  modelSetState(() {});
                                }
                              },
                              decoration: InputDecoration(
                                  hintText: "Re-Type your new password",
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
                                        context.read<RailNavigationBloc>().add(const PasswordToggleEvent(type: "confirm"));
                                        modelSetState(() {});
                                      },
                                      icon: mainVariables.homeVariables.confirmPasswordObscure ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility))),
                              style: TextStyle(fontWeight: FontWeight.w500, fontSize: mainFunctions.getTextSize(fontSize: 15)),
                            ),
                          ),
                          mainVariables.homeVariables.forMatchedText
                              ? Text(
                                  "passwords are perfectly matched",
                                  style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 14), fontWeight: FontWeight.w500, color: Colors.green),
                                )
                              : const SizedBox(),
                          mainVariables.homeVariables.isMatched
                              ? const SizedBox()
                              : Text(
                                  "passwords are not matched",
                                  style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 14), fontWeight: FontWeight.w500, color: Colors.red),
                                ),
                        ],
                      ),
                      SizedBox(height: mainFunctions.getWidgetHeight(height: 40)),
                      LoadingButton(
                        status: mainVariables.homeVariables.profileSavingLoader,
                        onTap: () async {
                          if (mainVariables.homeVariables.passwordStatus == "secure" && mainVariables.homeVariables.currentPasswordController.text.isNotEmpty && mainVariables.homeVariables.forMatchedText) {
                            mainVariables.homeVariables.profileSavingLoader = true;
                            await mainVariables.repoImpl.changePasswordFunction(query: {"currentPassword": mainVariables.homeVariables.currentPasswordController.text, "newPassword": mainVariables.homeVariables.newPasswordController.text}).onError((error, stackTrace) {
                              mainWidgets.flushBarWidget(context: context, message: error.toString());
                            }).then((value) async {
                              if (value != null) {
                                if (value["status"]) {
                                  mainWidgets.flushBarWidget(context: context, message: value["message"]);
                                  mainVariables.homeVariables.profileSavingLoader = false;
                                  Navigator.pop(context);
                                  mainWidgets.showAnimatedDialog(
                                    context: context,
                                    height: 352,
                                    width: 460,
                                    child: dialogContent(),
                                  );
                                  modelSetState(() {});
                                  mainVariables.homeVariables.currentPasswordController.clear();
                                  mainVariables.homeVariables.newPasswordController.clear();
                                  mainVariables.homeVariables.confirmPasswordController.clear();
                                  mainVariables.homeVariables.currentPasswordObscure = true;
                                  mainVariables.homeVariables.newPasswordObscure = true;
                                  mainVariables.homeVariables.confirmPasswordObscure = true;
                                  mainVariables.homeVariables.isMatched = true;
                                  mainVariables.homeVariables.forMatchedText = false;
                                  mainVariables.homeVariables.isCorrectPassword = true;
                                  mainVariables.homeVariables.passwordStatus = "Very Weak";
                                  mainVariables.homeVariables.passwordStrength = 0.0;
                                  mainVariables.homeVariables.progressColor = Colors.blue;
                                  mainVariables.homeVariables.counter = 0;
                                  mainVariables.homeVariables.isPasswordEmpty = false;
                                  mainVariables.homeVariables.passwordEmpty = false;
                                  mainVariables.homeVariables.lowerCase = false;
                                  mainVariables.homeVariables.upperCase = false;
                                  mainVariables.homeVariables.lengthCase = false;
                                  mainVariables.homeVariables.symbolCase = false;
                                  mainVariables.homeVariables.numberCase = false;
                                } else {
                                  mainVariables.homeVariables.profileSavingLoader = false;
                                  mainWidgets.flushBarWidget(context: context, message: value["message"]);
                                  modelSetState(() {});
                                }
                              } else {
                                mainVariables.homeVariables.profileSavingLoader = false;
                                mainWidgets.flushBarWidget(context: context, message: "Something went wrong");
                                modelSetState(() {});
                              }
                            });
                          } else if (mainVariables.homeVariables.currentPasswordController.text.isEmpty) {
                            mainVariables.homeVariables.passwordEmpty = true;
                            modelSetState(() {});
                          } else if (mainVariables.homeVariables.forMatchedText == false) {
                            if (mainVariables.homeVariables.newPasswordController.text.isEmpty) {
                              mainVariables.homeVariables.isPasswordEmpty = true;
                            } else {
                              if (mainVariables.homeVariables.newPasswordController.text == mainVariables.homeVariables.confirmPasswordController.text) {
                                mainVariables.homeVariables.isPasswordEmpty = false;
                                mainVariables.homeVariables.isMatched = false;
                                mainVariables.homeVariables.forMatchedText = true;
                              } else {
                                mainVariables.homeVariables.isPasswordEmpty = false;
                                mainVariables.homeVariables.isMatched = false;
                                mainVariables.homeVariables.forMatchedText = false;
                              }
                            }
                            modelSetState(() {});
                          } else if (mainVariables.homeVariables.passwordStatus != "secure") {
                            modelSetState(() {});
                          } else {
                            modelSetState(() {});
                          }
                        },
                        text: "Confirm",
                        height: 42,
                        width: 420,
                        fontSize: 15,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget signOutContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 52),
          child: Center(
            child: Text(
              'Sign Out',
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
          "You will be returned to the login screen.",
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
                  onPressed: () async {
                    mainVariables.railNavigationVariables.mainSelectedIndex = 0;
                    mainVariables.generalVariables.railNavigateBackIndex = 0;
                    mainVariables.generalVariables.railNavigateIndex = 0;
                    mainVariables.generalVariables.isLoggedIn = false;
                    mainVariables.generalVariables.userData = User.fromJson({});
                    mainVariables.generalVariables.currentPage.value = "";
                    mainVariables.generalVariables.selectedTransId = "";
                    mainVariables.generalVariables.selectedTransTempId = "";
                    mainVariables.generalVariables.selectedDisputeId = "";
                    mainVariables.generalVariables.selectedCheckListId = "";
                    mainVariables.generalVariables.selectedProductIndexForDispute = 0;
                    mainVariables.generalVariables.mainScreenWidget = const HomeScreen();
                    mainVariables.railNavigationVariables.mainSelectedIndex = 0;
                    mainFunctions.clearHiveData(context: context);
                    mainVariables.railNavigationVariables = RailNavigationVariables.fromJson({});
                    mainVariables.homeVariables = HomeVariables.fromJson({});
                    mainVariables.inventoryVariables = InventoryVariables.fromJson({});
                    mainVariables.stockDisputeVariables = StockDisputeVariables.fromJson({});
                    mainVariables.reportsVariables = ReportsVariables.fromJson({});
                    mainVariables.checkListVariables = CheckListVariables.fromJson({});
                    mainVariables.manageVariables = ManageVariables.fromJson({});
                    mainVariables.manualVariables = ManualVariables.fromJson({});
                    mainVariables.notificationVariables = NotificationVariables.fromJson({});
                    mainVariables.receivedStocksVariables = ReceivedStocksVariables.fromJson({});
                    mainVariables.stockMovementVariables = StockMovementVariables.fromJson({});
                    mainVariables.transitVariables = TransitVariables.fromJson({});
                    mainVariables.confirmMovementVariables = ConfirmMovementVariables.fromJson({});
                    mainVariables.addDisputeVariables = AddDisputeVariables.fromJson({});
                    Navigator.of(context, rootNavigator: true).pushNamed(LoginScreen.id);
                  },
                  child: Text(
                    "Sign Out",
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
