import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shimmer/shimmer.dart';
import 'package:table_sticky_headers/table_sticky_headers.dart';
import 'package:tvsaviation/bloc/inventory/inventory_bloc.dart';
import 'package:tvsaviation/bloc/manage/manage_bloc.dart';
import 'package:tvsaviation/bloc/rail_navigation/rail_navigation_bloc.dart';
import 'package:tvsaviation/data/hive/location/location_data.dart';
import 'package:tvsaviation/data/model/api_model/cart_details_model.dart';
import 'package:tvsaviation/resources/constants.dart';
import 'package:tvsaviation/resources/drop_down_lib/dropdown_textfield.dart';

class InventoryScreen extends StatefulWidget {
  static const String id = "inventory";
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> with TickerProviderStateMixin {
  TabController? tabController;
  Timer? timer;
  Timer? increasingTimer;
  int increasingData = 0;

  @override
  void dispose() {
    if (increasingTimer != null) {
      increasingTimer!.cancel();
      increasingTimer = null;
    }
    super.dispose();
  }

  Future<CartDetailsModel> getCartFunction() async {
    return CartDetailsModel.fromJson(
        await mainVariables.repoImpl.getCart(query: {"locationId": mainVariables.inventoryVariables.selectedLocationId}));
  }

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this, initialIndex: mainVariables.inventoryVariables.tabControllerIndex);
    context.read<InventoryBloc>().add(InventoryInitialEvent(modelSetState: setState, context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (value) {
        if (context.read<InventoryBloc>().updatedInventoryCartList.isNotEmpty) {
          mainWidgets.showAnimatedDialog(
            context: context,
            height: 200,
            width: 460,
            child: dialogCartContent(context: context),
          );
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
          context.read<RailNavigationBloc>().add(const RailNavigationSelectedWidgetEvent());
        }
      },
      child: context.read<InventoryBloc>().cartPageEnabled
          ? cartScreenWidget()
          : mainVariables.inventoryVariables.loader
              ? Stack(
                  children: [
                    bodyWidget(),
                    Positioned(
                      bottom: 15,
                      left: mainFunctions.getWidgetWidth(width: 150),
                      child: InkWell(
                        onTap: () {
                          mainVariables.generalVariables.currentPage.value = "inventory";
                          context.read<ManageBloc>().add(const ManagePageChangingEvent(index: 0, withinScreen: "inventory"));
                          mainVariables.generalVariables.railNavigateBackIndex = mainVariables.generalVariables.railNavigateIndex;
                          mainVariables.generalVariables.railNavigateIndex = 6;
                          mainVariables.railNavigationVariables.mainSelectedIndex = 6;
                          context.read<RailNavigationBloc>().add(const RailNavigationSelectedWidgetEvent());
                        },
                        child: Container(
                          height: mainFunctions.getWidgetHeight(height: 50),
                          width: mainFunctions.getWidgetWidth(width: 50),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage("assets/inventory/float.png"),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ),
                    mainVariables.homeVariables.homeLocationSelectedIndex != -1
                        ? BlocBuilder<InventoryBloc, InventoryState>(builder: (BuildContext context, InventoryState state) {
                            return state is InventoryLoaded
                                ? context.read<InventoryBloc>().updatedInventoryCartList.isNotEmpty
                                    ? Positioned(
                                        bottom: 15,
                                        right: mainFunctions.getWidgetWidth(width: 15),
                                        child: InkWell(
                                          onTap: () {
                                            context
                                                .read<InventoryBloc>()
                                                .add(UpdateCartEvent(modelSetState: setState, context: context));
                                          },
                                          child: Container(
                                            height: mainFunctions.getWidgetHeight(height: 60),
                                            width: mainFunctions.getWidgetWidth(width: 220),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: mainFunctions.getWidgetWidth(width: 5),
                                                vertical: mainFunctions.getWidgetHeight(height: 5)),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(40),
                                              gradient: const LinearGradient(
                                                  colors: [Color(0xff0C3788), Color(0xffBC0044)],
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.centerRight),
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      height: mainFunctions.getWidgetHeight(height: 50),
                                                      width: mainFunctions.getWidgetWidth(width: 50),
                                                      decoration: const BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          image: DecorationImage(
                                                              image: AssetImage("assets/inventory/cart_icon.png"), fit: BoxFit.fill)),
                                                    ),
                                                    SizedBox(
                                                      width: mainFunctions.getWidgetWidth(width: 8),
                                                    ),
                                                    SizedBox(
                                                      height: mainFunctions.getWidgetHeight(height: 50),
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            "Update Cart",
                                                            style: TextStyle(
                                                                fontSize: mainFunctions.getTextSize(fontSize: 13),
                                                                fontWeight: FontWeight.w600,
                                                                color: Colors.white),
                                                          ),
                                                          SizedBox(
                                                            height: mainFunctions.getWidgetHeight(height: 2),
                                                          ),
                                                          Text(
                                                            "${context.read<InventoryBloc>().updatedInventoryCartList.length} Products, ${List.generate(context.read<InventoryBloc>().updatedInventoryCartList.length, (i) => context.read<InventoryBloc>().updatedInventoryCartList[i]["quantityDelta"]).reduce((a, b) => a + b)} Units",
                                                            style: TextStyle(
                                                                fontSize: mainFunctions.getTextSize(fontSize: 10),
                                                                fontWeight: FontWeight.w400,
                                                                color: Colors.white),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: mainFunctions.getWidgetWidth(width: 8),
                                                    ),
                                                    const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16)
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    : context.read<InventoryBloc>().cartDetailsModel.cart.items.isNotEmpty
                                        ? Positioned(
                                            bottom: 15,
                                            right: mainFunctions.getWidgetWidth(width: 15),
                                            child: InkWell(
                                              onTap: () {
                                                context.read<InventoryBloc>().cartPageEnabled =
                                                    !context.read<InventoryBloc>().cartPageEnabled;
                                                context.read<InventoryBloc>().cartRemarksController = TextEditingController();
                                                setState(() {});
                                              },
                                              child: Container(
                                                height: mainFunctions.getWidgetHeight(height: 60),
                                                width: mainFunctions.getWidgetWidth(width: 220),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: mainFunctions.getWidgetWidth(width: 5),
                                                    vertical: mainFunctions.getWidgetHeight(height: 5)),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(40),
                                                  gradient: const LinearGradient(
                                                      colors: [Color(0xff0C3788), Color(0xffBC0044)],
                                                      begin: Alignment.centerLeft,
                                                      end: Alignment.centerRight),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Container(
                                                          height: mainFunctions.getWidgetHeight(height: 50),
                                                          width: mainFunctions.getWidgetWidth(width: 50),
                                                          decoration: const BoxDecoration(
                                                              shape: BoxShape.circle,
                                                              image: DecorationImage(
                                                                  image: AssetImage("assets/inventory/cart_icon.png"),
                                                                  fit: BoxFit.fill)),
                                                        ),
                                                        SizedBox(
                                                          width: mainFunctions.getWidgetWidth(width: 8),
                                                        ),
                                                        SizedBox(
                                                          height: mainFunctions.getWidgetHeight(height: 50),
                                                          child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Text(
                                                                "View Cart",
                                                                style: TextStyle(
                                                                    fontSize: mainFunctions.getTextSize(fontSize: 13),
                                                                    fontWeight: FontWeight.w600,
                                                                    color: Colors.white),
                                                              ),
                                                              SizedBox(
                                                                height: mainFunctions.getWidgetHeight(height: 2),
                                                              ),
                                                              Text(
                                                                "${context.read<InventoryBloc>().cartDetailsModel.cart.items.length} Products, ${List.generate(context.read<InventoryBloc>().cartDetailsModel.cart.items.length, (i) => context.read<InventoryBloc>().cartDetailsModel.cart.items[i].quantityAdded).reduce((a, b) => a + b)} Units",
                                                                style: TextStyle(
                                                                    fontSize: mainFunctions.getTextSize(fontSize: 10),
                                                                    fontWeight: FontWeight.w400,
                                                                    color: Colors.white),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: mainFunctions.getWidgetWidth(width: 8),
                                                        ),
                                                        const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16)
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
                                        : const SizedBox()
                                : const SizedBox();
                          })
                        : const SizedBox(),
                  ],
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
    );
  }

  Widget bodyWidget() {
    return Row(
      children: [
        inventoryDrawerWidget(),
        expandedMainWidget(),
      ],
    );
  }

  Widget inventoryDrawerWidget() {
    return Container(
      height: mainFunctions.getWidgetHeight(height: 1112),
      width: mainFunctions.getWidgetWidth(width: 219),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(15), bottomLeft: Radius.circular(15)),
        color: Color(0xff0C3788),
      ),
      child: Column(
        children: [
          drawerHeaderWidget(),
          Expanded(child: drawerWidgetsList()),
        ],
      ),
    );
  }

  Widget expandedMainWidget() {
    return Flexible(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: mainFunctions.getWidgetHeight(height: 136),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(15),
              ),
              color: Color(0xff0C3788),
            ),
            child: Column(
              children: [
                tabBarWidget(),
                chipsWidget(),
              ],
            ),
          ),
          mainVariables.inventoryVariables.products.isEmpty
              ? const SizedBox()
              : Container(
                  width: mainFunctions.getWidgetWidth(width: mainVariables.generalVariables.height),
                  padding: EdgeInsets.symmetric(
                      vertical: mainFunctions.getWidgetHeight(height: 7), horizontal: mainFunctions.getWidgetWidth(width: 15)),
                  color: mainColors.whiteColor,
                  child: Text(
                    mainVariables.inventoryVariables.selectedProductName.toUpperCase(),
                    style: TextStyle(
                      fontSize: mainFunctions.getTextSize(fontSize: 20),
                      fontWeight: FontWeight.w600,
                      color: mainColors.headingBlueColor,
                    ),
                  ),
                ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xffF4F4F4),
              ),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    headerWidget(),
                    mainVariables.homeVariables.homeLocationSelectedIndex == -1 ? locationsWidget() : const SizedBox(),
                    transitWidget(),
                    productDetailsWidget(),
                    shortageWidget(),
                    SizedBox(
                      height: mainFunctions.getWidgetHeight(height: 12),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget drawerHeaderWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: mainFunctions.getWidgetHeight(height: 16)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: mainFunctions.getWidgetWidth(width: 10)),
          child: SizedBox(
            height: mainFunctions.getWidgetHeight(height: 23),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    context.read<InventoryBloc>().isGlobalSearchEnabled = !context.read<InventoryBloc>().isGlobalSearchEnabled;
                    if (context.read<InventoryBloc>().isGlobalSearchEnabled) {
                      context.read<InventoryBloc>().searchGroupedList.clear();
                      context.read<InventoryBloc>().stockTypeIndexSelected = 0;
                      context.read<InventoryBloc>().categoryIndexSelected = 0;
                      context.read<InventoryBloc>().add(InventorySearchEvent(modelSetState: setState));
                    } else {
                      mainVariables.inventoryVariables.searchBar.clear();
                      context.read<InventoryBloc>().add(InventorySearchDataEvent(modelSetState: setState));
                    }
                    setState(() {});
                  },
                  child: context.read<InventoryBloc>().isGlobalSearchEnabled
                      ? Shimmer.fromColors(
                          enabled: context.read<InventoryBloc>().isGlobalSearchEnabled,
                          baseColor: Colors.yellow,
                          highlightColor: Colors.white,
                          child: Text(
                            "Inventory",
                            style: TextStyle(
                                fontSize: mainFunctions.getTextSize(fontSize: 18),
                                fontWeight: FontWeight.w600,
                                color: mainColors.whiteColor),
                          ),
                        )
                      : Text(
                          "Inventory",
                          style: TextStyle(
                              fontSize: mainFunctions.getTextSize(fontSize: 18),
                              fontWeight: FontWeight.w600,
                              color: mainColors.whiteColor),
                        ),
                ),
                PopupMenuButton<String>(
                  padding: EdgeInsets.zero,
                  icon: Container(
                    height: mainFunctions.getWidgetHeight(height: 22),
                    width: mainFunctions.getWidgetWidth(width: 22),
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/inventory/sort.png"),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  onSelected: (value) {
                    mainVariables.inventoryVariables.selectedFilterType = value;
                    context.read<InventoryBloc>().add(InventoryChangeEvent(modelSetState: setState));
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: mainVariables.inventoryVariables.filterTypeList[0].value,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(mainVariables.inventoryVariables.filterTypeList[0].name),
                          Icon(
                            Icons.check,
                            color: mainVariables.inventoryVariables.selectedFilterType ==
                                    mainVariables.inventoryVariables.filterTypeList[0].value
                                ? Colors.black
                                : Colors.transparent,
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: mainVariables.inventoryVariables.filterTypeList[1].value,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(mainVariables.inventoryVariables.filterTypeList[1].name),
                          Icon(
                            Icons.check,
                            color: mainVariables.inventoryVariables.selectedFilterType ==
                                    mainVariables.inventoryVariables.filterTypeList[1].value
                                ? Colors.black
                                : Colors.transparent,
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: mainVariables.inventoryVariables.filterTypeList[2].value,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(mainVariables.inventoryVariables.filterTypeList[2].name),
                          Icon(
                            Icons.check,
                            color: mainVariables.inventoryVariables.selectedFilterType ==
                                    mainVariables.inventoryVariables.filterTypeList[2].value
                                ? Colors.black
                                : Colors.transparent,
                          ),
                        ],
                      ),
                    ),
                  ],
                  offset: const Offset(10, 30),
                  color: Colors.white,
                  elevation: 2,
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: mainFunctions.getWidgetHeight(height: 7)),
        const Divider(
          thickness: 2,
          height: 0,
          color: Color(0xff00256B),
        ),
        SizedBox(height: mainFunctions.getWidgetHeight(height: 8)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: mainFunctions.getWidgetWidth(width: 10)),
          child: SizedBox(
            height: mainFunctions.getWidgetHeight(height: 36),
            child: TextFormField(
              cursorColor: Colors.green,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              style: TextStyle(
                fontSize: mainFunctions.getTextSize(fontSize: mainFunctions.getTextSize(fontSize: 15)),
                color: Colors.white,
              ),
              controller: mainVariables.inventoryVariables.searchBar,
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) async {
                if (timer?.isActive ?? false) timer?.cancel();
                timer = Timer(const Duration(milliseconds: 500), () {
                  if (value.isNotEmpty) {
                    if (context.read<InventoryBloc>().isGlobalSearchEnabled) {
                      mainVariables.inventoryVariables.selectedListIndex = 0;
                      context.read<InventoryBloc>().stockTypeIndexSelected = 0;
                      context.read<InventoryBloc>().categoryIndexSelected = 0;
                      context.read<InventoryBloc>().add(InventorySearchEvent(modelSetState: setState));
                    } else {
                      context.read<InventoryBloc>().add(InventoryChangeEvent(modelSetState: setState));
                    }
                  } else {
                    if (context.read<InventoryBloc>().isGlobalSearchEnabled) {
                      mainVariables.inventoryVariables.searchBar.clear();
                      context.read<InventoryBloc>().add(InventorySearchEvent(modelSetState: setState));
                    } else {
                      context.read<InventoryBloc>().add(InventoryChangeEvent(modelSetState: setState));
                    }
                  }
                });
              },
              decoration: InputDecoration(
                suffixIcon: mainVariables.inventoryVariables.searchBar.text.isNotEmpty
                    ? GestureDetector(
                        onTap: () {
                          if (context.read<InventoryBloc>().isGlobalSearchEnabled) {
                            mainVariables.inventoryVariables.searchBar.clear();
                            context.read<InventoryBloc>().add(InventorySearchDataEvent(modelSetState: setState));
                          } else {
                            mainVariables.inventoryVariables.searchBar.clear();
                            context.read<InventoryBloc>().add(InventoryChangeEvent(modelSetState: setState));
                          }
                        },
                        child: Icon(Icons.cancel, size: 22, color: mainColors.whiteColor),
                      )
                    : const SizedBox(),
                prefixIcon: const Icon(
                  Icons.search,
                  size: 20,
                  color: Color(0xffEBEBF5),
                ),
                contentPadding: EdgeInsets.zero,
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xFFD8D8D8), width: 0.1),
                  borderRadius: BorderRadius.circular(7),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xFFD8D8D8), width: 0.1),
                  borderRadius: BorderRadius.circular(7),
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xFFD8D8D8), width: 0.1),
                  borderRadius: BorderRadius.circular(7),
                ),
                hintStyle: TextStyle(
                    color: const Color(0XFFEBEBF5), fontSize: mainFunctions.getTextSize(fontSize: 14), fontWeight: FontWeight.w400),
                fillColor: mainColors.whiteColor.withOpacity(0.26),
                filled: true,
                hintText: context.read<InventoryBloc>().isGlobalSearchEnabled ? 'Global Search' : 'Search',
              ),
            ),
          ),
        ),
        SizedBox(height: mainFunctions.getWidgetHeight(height: 14)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: mainFunctions.getWidgetWidth(width: 10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: mainFunctions.getWidgetHeight(height: 8),
                    width: mainFunctions.getWidgetWidth(width: 8),
                    decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xffFFE500)),
                  ),
                  SizedBox(
                    width: mainFunctions.getWidgetWidth(width: 8),
                  ),
                  Text(
                    "Low stock ",
                    style: TextStyle(
                      fontSize: mainFunctions.getTextSize(fontSize: 12),
                      fontWeight: FontWeight.w600,
                      color: mainColors.whiteColor,
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: mainFunctions.getWidgetHeight(height: 8),
                    width: mainFunctions.getWidgetWidth(width: 8),
                    decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xffFF3131)),
                  ),
                  SizedBox(
                    width: mainFunctions.getWidgetWidth(width: 8),
                  ),
                  Text(
                    "Expiry ",
                    style: TextStyle(
                      fontSize: mainFunctions.getTextSize(fontSize: 12),
                      fontWeight: FontWeight.w600,
                      color: mainColors.whiteColor,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: mainFunctions.getWidgetHeight(height: 14)),
      ],
    );
  }

  Widget drawerWidgetsList() {
    return BlocConsumer<InventoryBloc, InventoryState>(
      listener: (BuildContext context, InventoryState inventory) {
        tabController!.index = mainVariables.inventoryVariables.tabControllerIndex;
        setState(() {});
      },
      builder: (BuildContext context, InventoryState inventory) {
        if (inventory is InventoryLoaded) {
          return mainVariables.inventoryVariables.products.isEmpty
              ? Padding(
                  padding: EdgeInsets.only(top: mainFunctions.getWidgetHeight(height: 25)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/inventory/no_message.png",
                        height: mainFunctions.getWidgetHeight(height: 100),
                        width: mainFunctions.getWidgetWidth(width: 100),
                        fit: BoxFit.fill,
                        color: Colors.grey.shade50,
                      ),
                      SizedBox(
                        height: mainFunctions.getWidgetHeight(height: 15),
                      ),
                      Text(
                        "Product List is Empty",
                        style: TextStyle(color: mainColors.whiteColor),
                      ),
                    ],
                  ),
                )
              : context.read<InventoryBloc>().isGlobalSearchEnabled
                  ? ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: context.read<InventoryBloc>().searchGroupedList.length,
                      itemBuilder: (BuildContext context, int stockTypeIndex) {
                        List<String> keysList = ["current_stock", "food_items_&_disposables", "unused_stock"];
                        return Column(
                          children: [
                            ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                itemCount: context.read<InventoryBloc>().searchGroupedList[stockTypeIndex].length,
                                itemBuilder: (BuildContext context, int categoryIndex) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      categoryIndex == 0
                                          ? SizedBox(
                                              height: mainFunctions.getWidgetHeight(height: 12),
                                            )
                                          : const SizedBox(),
                                      categoryIndex == 0
                                          ? Container(
                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: Colors.white10),
                                              margin: EdgeInsets.only(
                                                  left: mainFunctions.getWidgetWidth(width: 12),
                                                  right: mainFunctions.getWidgetWidth(width: 12)),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: mainFunctions.getWidgetWidth(width: 6),
                                                  vertical: mainFunctions.getWidgetHeight(height: 5)),
                                              child: Text(
                                                "${mainVariables.inventoryVariables.tabsWidgetList[keysList.indexOf(context.read<InventoryBloc>().searchGroupedList[stockTypeIndex][categoryIndex].stockType.toLowerCase())].text} >> ${context.read<InventoryBloc>().searchGroupedList[stockTypeIndex][categoryIndex].categoryName.toLowerCase().capitalizeFirst}",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white,
                                                    fontSize: mainFunctions.getTextSize(fontSize: 10)),
                                              ),
                                            )
                                          : const SizedBox(),
                                      categoryIndex == 0
                                          ? SizedBox(
                                              height: mainFunctions.getWidgetHeight(height: 12),
                                            )
                                          : const SizedBox(),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            mainVariables.inventoryVariables.selectedListIndex = 0;
                                            context.read<InventoryBloc>().stockTypeIndexSelected = stockTypeIndex;
                                            context.read<InventoryBloc>().categoryIndexSelected = categoryIndex;
                                            mainVariables.inventoryVariables.selectedProductId = context
                                                .read<InventoryBloc>()
                                                .searchGroupedList[stockTypeIndex][categoryIndex]
                                                .productId;
                                            mainVariables.inventoryVariables.selectedProductName = context
                                                .read<InventoryBloc>()
                                                .searchGroupedList[stockTypeIndex][categoryIndex]
                                                .productName;

                                            context.read<InventoryBloc>().add(
                                                  InventoryUpdateDataEvent(modelSetState: setState),
                                                );
                                          });
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(vertical: mainFunctions.getWidgetHeight(height: 4)),
                                          width: mainFunctions.getWidgetWidth(width: 219),
                                          color: context.read<InventoryBloc>().stockTypeIndexSelected == stockTypeIndex &&
                                                  context.read<InventoryBloc>().categoryIndexSelected == categoryIndex
                                              ? const Color(0xffF4F4F4)
                                              : Colors.transparent,
                                          margin: EdgeInsets.only(bottom: mainFunctions.getWidgetHeight(height: 12)),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(width: mainFunctions.getWidgetWidth(width: 16)),
                                              context.read<InventoryBloc>().searchGroupedList[stockTypeIndex][categoryIndex].filter ==
                                                      "low_stock"
                                                  ? Container(
                                                      height: mainFunctions.getWidgetHeight(height: 8),
                                                      width: mainFunctions.getWidgetWidth(width: 8),
                                                      decoration:
                                                          const BoxDecoration(shape: BoxShape.circle, color: Color(0xffFFE500)),
                                                    )
                                                  : context
                                                              .read<InventoryBloc>()
                                                              .searchGroupedList[stockTypeIndex][categoryIndex]
                                                              .filter ==
                                                          "expiry"
                                                      ? Container(
                                                          height: mainFunctions.getWidgetHeight(height: 8),
                                                          width: mainFunctions.getWidgetWidth(width: 8),
                                                          decoration:
                                                              const BoxDecoration(shape: BoxShape.circle, color: Color(0xffFF3131)),
                                                        )
                                                      : Container(
                                                          height: mainFunctions.getWidgetHeight(height: 8),
                                                          width: mainFunctions.getWidgetWidth(width: 8),
                                                          decoration: BoxDecoration(
                                                              shape: BoxShape.circle,
                                                              color: context.read<InventoryBloc>().stockTypeIndexSelected ==
                                                                          stockTypeIndex &&
                                                                      context.read<InventoryBloc>().categoryIndexSelected ==
                                                                          categoryIndex
                                                                  ? const Color(0xff0C3788)
                                                                  : Colors.white),
                                                        ),
                                              SizedBox(width: mainFunctions.getWidgetWidth(width: 8)),
                                              Expanded(
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      context
                                                          .read<InventoryBloc>()
                                                          .searchGroupedList[stockTypeIndex][categoryIndex]
                                                          .productName,
                                                      style: TextStyle(
                                                          fontSize: mainFunctions.getTextSize(fontSize: 15),
                                                          fontWeight: FontWeight.w500,
                                                          color: context.read<InventoryBloc>().stockTypeIndexSelected ==
                                                                      stockTypeIndex &&
                                                                  context.read<InventoryBloc>().categoryIndexSelected == categoryIndex
                                                              ? mainColors.blackColor
                                                              : mainColors.whiteColor,
                                                          overflow: TextOverflow.ellipsis),
                                                      maxLines: 1,
                                                    ),
                                                    Text(
                                                      context
                                                          .read<InventoryBloc>()
                                                          .searchGroupedList[stockTypeIndex][categoryIndex]
                                                          .brandType,
                                                      style: TextStyle(
                                                          fontSize: mainFunctions.getTextSize(fontSize: 10),
                                                          fontWeight: FontWeight.w500,
                                                          color: context.read<InventoryBloc>().stockTypeIndexSelected ==
                                                                      stockTypeIndex &&
                                                                  context.read<InventoryBloc>().categoryIndexSelected == categoryIndex
                                                              ? mainColors.blackColor
                                                              : mainColors.whiteColor,
                                                          overflow: TextOverflow.ellipsis),
                                                      maxLines: 1,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(width: mainFunctions.getWidgetWidth(width: 16)),
                                              Text(
                                                context
                                                    .read<InventoryBloc>()
                                                    .searchGroupedList[stockTypeIndex][categoryIndex]
                                                    .totalQuantity
                                                    .toString(),
                                                style: TextStyle(
                                                  fontSize: mainFunctions.getTextSize(fontSize: 16),
                                                  fontWeight: FontWeight.w500,
                                                  color: context.read<InventoryBloc>().stockTypeIndexSelected == stockTypeIndex &&
                                                          context.read<InventoryBloc>().categoryIndexSelected == categoryIndex
                                                      ? mainColors.blackColor
                                                      : mainColors.whiteColor,
                                                ),
                                              ),
                                              SizedBox(width: mainFunctions.getWidgetWidth(width: 16)),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                            const Divider(
                              height: 0,
                              thickness: 0.5,
                              color: Colors.white38,
                            )
                          ],
                        );
                      })
                  : ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: mainVariables.inventoryVariables.products.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              mainVariables.inventoryVariables.selectedListIndex = index;
                              context.read<InventoryBloc>().add(
                                    InventoryDataEvent(
                                      modelSetState: setState,
                                      productId: mainVariables.inventoryVariables.products[index].productId,
                                      productName: mainVariables.inventoryVariables.products[index].productName,
                                      productHasExpiry: mainVariables.inventoryVariables.products[index].hasExpiry,
                                    ),
                                  );
                            });
                          },
                          child: Container(
                            height: mainFunctions.getWidgetHeight(height: 44),
                            width: mainFunctions.getWidgetWidth(width: 219),
                            color: index == mainVariables.inventoryVariables.selectedListIndex
                                ? const Color(0xffF4F4F4)
                                : Colors.transparent,
                            margin: EdgeInsets.only(bottom: mainFunctions.getWidgetHeight(height: 12)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(width: mainFunctions.getWidgetWidth(width: 16)),
                                mainVariables.inventoryVariables.products[index].filter == "low_stock"
                                    ? Container(
                                        height: mainFunctions.getWidgetHeight(height: 8),
                                        width: mainFunctions.getWidgetWidth(width: 8),
                                        decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xffFFE500)),
                                      )
                                    : mainVariables.inventoryVariables.products[index].filter == "expiry"
                                        ? Container(
                                            height: mainFunctions.getWidgetHeight(height: 8),
                                            width: mainFunctions.getWidgetWidth(width: 8),
                                            decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xffFF3131)),
                                          )
                                        : Container(
                                            height: mainFunctions.getWidgetHeight(height: 8),
                                            width: mainFunctions.getWidgetWidth(width: 8),
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: index == mainVariables.inventoryVariables.selectedListIndex
                                                    ? const Color(0xff0C3788)
                                                    : Colors.white),
                                          ),
                                SizedBox(width: mainFunctions.getWidgetWidth(width: 8)),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        mainVariables.inventoryVariables.products[index].productName,
                                        style: TextStyle(
                                            fontSize: mainFunctions.getTextSize(fontSize: 15),
                                            fontWeight: FontWeight.w500,
                                            color: index == mainVariables.inventoryVariables.selectedListIndex
                                                ? mainColors.blackColor
                                                : mainColors.whiteColor,
                                            overflow: TextOverflow.ellipsis),
                                        maxLines: 1,
                                      ),
                                      Text(
                                        mainVariables.inventoryVariables.products[index].brandType,
                                        style: TextStyle(
                                            fontSize: mainFunctions.getTextSize(fontSize: 10),
                                            fontWeight: FontWeight.w500,
                                            color: index == mainVariables.inventoryVariables.selectedListIndex
                                                ? mainColors.blackColor
                                                : mainColors.whiteColor,
                                            overflow: TextOverflow.ellipsis),
                                        maxLines: 1,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: mainFunctions.getWidgetWidth(width: 16)),
                                Text(
                                  mainVariables.inventoryVariables.products[index].totalQuantity.toString(),
                                  style: TextStyle(
                                    fontSize: mainFunctions.getTextSize(fontSize: 16),
                                    fontWeight: FontWeight.w500,
                                    color: index == mainVariables.inventoryVariables.selectedListIndex
                                        ? mainColors.blackColor
                                        : mainColors.whiteColor,
                                  ),
                                ),
                                SizedBox(width: mainFunctions.getWidgetWidth(width: 16)),
                              ],
                            ),
                          ),
                        );
                      });
        } else if (inventory is InventoryLoading) {
          return ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                return Shimmer.fromColors(
                  baseColor: const Color(0xff0C3788),
                  highlightColor: Colors.white10,
                  child: Container(
                    height: mainFunctions.getWidgetHeight(height: 44),
                    width: mainFunctions.getWidgetWidth(width: 219),
                    color: Colors.grey.shade100,
                    margin: EdgeInsets.only(bottom: mainFunctions.getWidgetHeight(height: 12)),
                  ),
                );
              });
        } else if (inventory is InventoryError) {
          return mainVariables.inventoryVariables.products.isEmpty
              ? Padding(
                  padding: EdgeInsets.only(top: mainFunctions.getWidgetHeight(height: 25)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/inventory/no_message.png",
                        height: mainFunctions.getWidgetHeight(height: 100),
                        width: mainFunctions.getWidgetWidth(width: 100),
                        fit: BoxFit.fill,
                        color: Colors.grey.shade50,
                      ),
                      SizedBox(
                        height: mainFunctions.getWidgetHeight(height: 15),
                      ),
                      Text(
                        "Product List is Empty",
                        style: TextStyle(color: mainColors.whiteColor),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: mainVariables.inventoryVariables.products.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          mainVariables.inventoryVariables.selectedListIndex = index;
                          context.read<InventoryBloc>().add(
                                InventoryDataEvent(
                                  modelSetState: setState,
                                  productId: mainVariables.inventoryVariables.products[index].productId,
                                  productName: mainVariables.inventoryVariables.products[index].productName,
                                  productHasExpiry: mainVariables.inventoryVariables.products[index].hasExpiry,
                                ),
                              );
                        });
                      },
                      child: Container(
                        height: mainFunctions.getWidgetHeight(height: 44),
                        width: mainFunctions.getWidgetWidth(width: 219),
                        color:
                            index == mainVariables.inventoryVariables.selectedListIndex ? const Color(0xffF4F4F4) : Colors.transparent,
                        margin: EdgeInsets.only(bottom: mainFunctions.getWidgetHeight(height: 12)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(width: mainFunctions.getWidgetWidth(width: 16)),
                            mainVariables.inventoryVariables.products[index].filter == "low_stock"
                                ? Container(
                                    height: mainFunctions.getWidgetHeight(height: 8),
                                    width: mainFunctions.getWidgetWidth(width: 8),
                                    decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xffFFE500)),
                                  )
                                : mainVariables.inventoryVariables.products[index].filter == "expiry"
                                    ? Container(
                                        height: mainFunctions.getWidgetHeight(height: 8),
                                        width: mainFunctions.getWidgetWidth(width: 8),
                                        decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xffFF3131)),
                                      )
                                    : Container(
                                        height: mainFunctions.getWidgetHeight(height: 8),
                                        width: mainFunctions.getWidgetWidth(width: 8),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: index == mainVariables.inventoryVariables.selectedListIndex
                                                ? const Color(0xff0C3788)
                                                : Colors.white),
                                      ),
                            SizedBox(width: mainFunctions.getWidgetWidth(width: 8)),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    mainVariables.inventoryVariables.products[index].productName,
                                    style: TextStyle(
                                        fontSize: mainFunctions.getTextSize(fontSize: 15),
                                        fontWeight: FontWeight.w500,
                                        color: index == mainVariables.inventoryVariables.selectedListIndex
                                            ? mainColors.blackColor
                                            : mainColors.whiteColor,
                                        overflow: TextOverflow.ellipsis),
                                    maxLines: 1,
                                  ),
                                  Text(
                                    mainVariables.inventoryVariables.products[index].brandType,
                                    style: TextStyle(
                                        fontSize: mainFunctions.getTextSize(fontSize: 10),
                                        fontWeight: FontWeight.w500,
                                        color: index == mainVariables.inventoryVariables.selectedListIndex
                                            ? mainColors.blackColor
                                            : mainColors.whiteColor,
                                        overflow: TextOverflow.ellipsis),
                                    maxLines: 1,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: mainFunctions.getWidgetWidth(width: 16)),
                            Text(
                              mainVariables.inventoryVariables.products[index].totalQuantity.toString(),
                              style: TextStyle(
                                fontSize: mainFunctions.getTextSize(fontSize: 16),
                                fontWeight: FontWeight.w500,
                                color: index == mainVariables.inventoryVariables.selectedListIndex
                                    ? mainColors.blackColor
                                    : mainColors.whiteColor,
                              ),
                            ),
                            SizedBox(width: mainFunctions.getWidgetWidth(width: 16)),
                          ],
                        ),
                      ),
                    );
                  });
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Widget tabBarWidget() {
    return Column(
      children: [
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 20),
        ),
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 24),
          child: TabBar(
              labelPadding:
                  EdgeInsets.only(right: mainFunctions.getWidgetWidth(width: 22), left: mainFunctions.getWidgetWidth(width: 2)),
              indicatorSize: TabBarIndicatorSize.label,
              indicatorColor: mainColors.whiteColor,
              indicatorWeight: 1,
              isScrollable: true,
              dividerHeight: 1,
              dividerColor: mainColors.whiteColor.withOpacity(0.3),
              tabAlignment: TabAlignment.start,
              onTap: (value) {
                mainVariables.inventoryVariables.tabControllerIndex = value;
                mainVariables.inventoryVariables.tabsEnableList.clear();
                mainVariables.inventoryVariables.tabsEnableList = List.generate(3, (index) => false);
                mainVariables.inventoryVariables.tabsEnableList[value] = true;
                List<String> keysList = ["current_stock", "food_items_&_disposables", "unused_stock"];
                mainVariables.inventoryVariables.selectedStockTypeId = keysList[value];
                mainVariables.inventoryVariables.tabPressed = true;
                setState(() {});
                context.read<InventoryBloc>().add(InventoryChangeEvent(modelSetState: setState));
              },
              controller: tabController,
              tabs: [
                Text(mainVariables.inventoryVariables.tabsWidgetList[0].text,
                    style: TextStyle(
                      color: mainVariables.inventoryVariables.tabsEnableList[0]
                          ? const Color(0xffD3D3D3)
                          : const Color(0xffD3D3D3).withOpacity(0.5),
                      fontSize: mainFunctions.getTextSize(fontSize: 15),
                      fontWeight: FontWeight.w600,
                    )),
                Text(mainVariables.inventoryVariables.tabsWidgetList[1].text,
                    style: TextStyle(
                      color: mainVariables.inventoryVariables.tabsEnableList[1]
                          ? const Color(0xffD3D3D3)
                          : const Color(0xffD3D3D3).withOpacity(0.5),
                      fontSize: mainFunctions.getTextSize(fontSize: 15),
                      fontWeight: FontWeight.w600,
                    )),
                Text(mainVariables.inventoryVariables.tabsWidgetList[2].text,
                    style: TextStyle(
                      color: mainVariables.inventoryVariables.tabsEnableList[2]
                          ? const Color(0xffD3D3D3)
                          : const Color(0xffD3D3D3).withOpacity(0.5),
                      fontSize: mainFunctions.getTextSize(fontSize: 15),
                      fontWeight: FontWeight.w600,
                    )),
              ]),
        ),
      ],
    );
  }

  Widget chipsWidget() {
    return Expanded(
      child: SingleChildScrollView(
        child: Obx(
          () => SizedBox(
            width: mainFunctions.getWidgetWidth(width: 1132),
            child: Wrap(
              alignment: WrapAlignment.start,
              children: buildChoiceList(),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> buildChoiceList() {
    List<Widget> choices = <Widget>[];
    for (DropDownValueModel item in mainVariables.inventoryVariables.categoryDropDownList) {
      choices.add(Container(
        height: mainFunctions.getWidgetHeight(height: 30),
        padding: EdgeInsets.only(
          left: mainFunctions.getWidgetWidth(width: 12),
          right: mainFunctions.getWidgetWidth(width: 12),
          top: mainFunctions.getWidgetHeight(height: 5),
          bottom: mainFunctions.getWidgetHeight(height: 0),
        ),
        margin: EdgeInsets.symmetric(
            horizontal: mainFunctions.getWidgetWidth(width: 6), vertical: mainFunctions.getWidgetHeight(height: 7)),
        decoration: BoxDecoration(
            color: mainVariables.inventoryVariables.selectedChoiceChip.value.name == item.name
                ? mainColors.whiteColor
                : const Color(0xffE7E7E7),
            borderRadius: BorderRadius.circular(30)),
        child: InkWell(
          onTap: () {
            setState(() {
              mainVariables.inventoryVariables.selectedChoiceChip.value = item;
              context.read<InventoryBloc>().add(InventoryChangeEvent(modelSetState: setState));
            });
          },
          child: Text(
            item.name.capitalizeFirst!,
            style: TextStyle(
                fontSize: mainFunctions.getTextSize(fontSize: 13),
                fontWeight: FontWeight.w500,
                color: mainVariables.inventoryVariables.selectedChoiceChip.value.name == item.name
                    ? const Color(0xff111111)
                    : const Color(0xff979797),
                fontFamily: "Figtree"),
          ),
        ),
      ));
    }
    return choices;
  }

  Widget headerWidget() {
    return InkWell(
      onTap: mainVariables.homeVariables.homeLocationSelectedIndex != -1
          ? () {
              if (context.read<InventoryBloc>().updatedInventoryCartList.isNotEmpty) {
                mainWidgets.showAnimatedDialog(
                  context: context,
                  height: 200,
                  width: 460,
                  child: dialogCartContent(context: context),
                );
              } else {
                mainVariables.generalVariables.railNavigateBackIndex = mainVariables.generalVariables.railNavigateIndex;
                mainVariables.generalVariables.railNavigateIndex = 0;
                mainVariables.railNavigationVariables.mainSelectedIndex = 0;
                mainVariables.homeVariables.homeLocationSelectedIndex = -1;
                mainVariables.inventoryVariables.tabControllerIndex = 0;
                mainVariables.inventoryVariables.tabsEnableList.clear();
                mainVariables.inventoryVariables.tabsEnableList = List.generate(3, (index) => false);
                mainVariables.inventoryVariables.tabsEnableList[0] = true;
                mainVariables.homeVariables.quickLinksEnabled = false;
                context.read<RailNavigationBloc>().add(const RailNavigationSelectedWidgetEvent());
              }
            }
          : mainVariables.homeVariables.quickLinksEnabled
              ? () {
                  mainVariables.generalVariables.railNavigateBackIndex = mainVariables.generalVariables.railNavigateIndex;
                  mainVariables.generalVariables.railNavigateIndex = 0;
                  mainVariables.railNavigationVariables.mainSelectedIndex = 0;
                  mainVariables.homeVariables.homeLocationSelectedIndex = -1;
                  mainVariables.inventoryVariables.tabControllerIndex = 0;
                  mainVariables.inventoryVariables.tabsEnableList.clear();
                  mainVariables.inventoryVariables.tabsEnableList = List.generate(3, (index) => false);
                  mainVariables.inventoryVariables.tabsEnableList[0] = true;
                  mainVariables.homeVariables.quickLinksEnabled = false;
                  context.read<RailNavigationBloc>().add(const RailNavigationSelectedWidgetEvent());
                }
              : () {},
      child: SizedBox(
        height: mainFunctions.getWidgetHeight(height: 44),
        child: Padding(
          padding: EdgeInsets.only(left: mainFunctions.getWidgetWidth(width: 20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              mainVariables.homeVariables.homeLocationSelectedIndex != -1
                  ? const Icon(
                      Icons.arrow_back_ios,
                    )
                  : mainVariables.homeVariables.quickLinksEnabled
                      ? const Icon(
                          Icons.arrow_back_ios,
                        )
                      : const SizedBox(),
              Text(
                mainVariables.homeVariables.homeLocationSelectedIndex != -1
                    ? mainVariables.homeVariables.locationList[mainVariables.homeVariables.homeLocationSelectedIndex]
                    : mainVariables.homeVariables.quickLinksEnabled
                        ? mainVariables.homeVariables.quickLinksList[mainVariables.inventoryVariables.tabControllerIndex].text
                        : "Inventory",
                style: mainTextStyle.normalTextStyle.copyWith(color: const Color(0xff111111), fontWeight: FontWeight.w600),
              ),
              const Spacer(),
              context.read<InventoryBloc>().updatedInventoryCartList.isNotEmpty
                  ? const SizedBox()
                  : IconButton(
                      onPressed: () {
                        mainVariables.generalVariables.railNavigateBackIndex = mainVariables.generalVariables.railNavigateIndex;
                        mainVariables.generalVariables.railNavigateIndex = 8;
                        context.read<RailNavigationBloc>().add(const RailNavigationSelectedWidgetEvent());
                      },
                      icon: const Icon(Icons.notifications_active_sharp),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget locationsWidget() {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: mainFunctions.getWidgetWidth(width: 8),
        vertical: mainFunctions.getWidgetHeight(height: 5),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: mainFunctions.getWidgetWidth(width: 12),
        vertical: mainFunctions.getWidgetHeight(height: 12),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: mainColors.whiteColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Location",
            style: TextStyle(
              fontSize: mainFunctions.getTextSize(fontSize: 20),
              fontWeight: FontWeight.w600,
              color: mainColors.headingBlueColor,
            ),
          ),
          SizedBox(
            height: mainFunctions.getWidgetHeight(height: 10),
          ),
          SizedBox(
            height: mainFunctions.getWidgetHeight(height: 190),
            child: Scrollbar(
              child: ValueListenableBuilder(
                valueListenable: Hive.box<LocationResponse>('locations').listenable(),
                builder: (context, Box<LocationResponse> box, data) {
                  if (box.values.isEmpty) {
                    return const Center(child: Text('No data available'));
                  }
                  return GridView.builder(
                    itemCount: box.values.length,
                    padding: EdgeInsets.zero,
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:
                          MediaQuery.of(context).orientation == Orientation.portrait && mainVariables.generalVariables.width < 700
                              ? 2
                              : 3,
                      mainAxisSpacing: mainFunctions.getWidgetHeight(height: 18),
                      crossAxisSpacing: mainFunctions.getWidgetWidth(width: 21),
                      mainAxisExtent: mainFunctions.getWidgetHeight(height: 86),
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      LocationResponse location = box.getAt(index) ?? LocationResponse.fromJson({});
                      return Container(
                        height: mainFunctions.getWidgetHeight(height: 86),
                        width: mainFunctions.getWidgetWidth(width: 144),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: const Color(0xffEAF1FF)),
                        padding: EdgeInsets.only(
                            left: mainFunctions.getWidgetWidth(width: 14),
                            top: mainFunctions.getWidgetHeight(height: 12),
                            right: mainFunctions.getWidgetWidth(width: 12)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: mainFunctions.getWidgetHeight(height: 32),
                                  width: mainFunctions.getWidgetWidth(width: 32),
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
                                BlocBuilder<InventoryBloc, InventoryState>(builder: (BuildContext context, InventoryState inventory) {
                                  if (inventory is InventoryLoaded) {
                                    return mainVariables.inventoryVariables.locationCount[index] == 0
                                        ? const SizedBox()
                                        : Container(
                                            height: mainFunctions.getWidgetHeight(height: 20),
                                            width: mainFunctions.getWidgetWidth(width: 35),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(30),
                                              color: const Color(0xff0C3788),
                                            ),
                                            child: Center(
                                              child: Text(
                                                mainVariables.inventoryVariables.locationCount[index].toString(),
                                                style: mainTextStyle.labelTextStyle.copyWith(
                                                  fontWeight: FontWeight.w500,
                                                  color: const Color(0xffF4F4F4),
                                                  fontSize: mainFunctions.getTextSize(fontSize: 14),
                                                ),
                                              ),
                                            ),
                                          );
                                  } else if (inventory is InventoryLoading) {
                                    return Shimmer.fromColors(
                                      baseColor: Colors.grey.shade200,
                                      highlightColor: Colors.white,
                                      child: Container(
                                        height: mainFunctions.getWidgetHeight(height: 20),
                                        width: mainFunctions.getWidgetWidth(width: 28),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(30),
                                          color: const Color(0xff0C3788),
                                        ),
                                      ),
                                    );
                                  } else {
                                    return const SizedBox();
                                  }
                                })
                              ],
                            ),
                            SizedBox(height: mainFunctions.getWidgetHeight(height: 14)),
                            Text(
                              location.name,
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: mainFunctions.getTextSize(fontSize: 11),
                                fontWeight: FontWeight.w600,
                                color: const Color(0xff111111),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget transitWidget() {
    return Container(
      width: mainFunctions.getWidgetWidth(width: mainVariables.generalVariables.width),
      margin: EdgeInsets.symmetric(
        horizontal: mainFunctions.getWidgetWidth(width: 8),
        vertical: mainFunctions.getWidgetHeight(height: 5),
      ),
      padding: EdgeInsets.only(
        left: mainFunctions.getWidgetWidth(width: 12),
        top: mainFunctions.getWidgetHeight(height: 12),
        bottom: mainFunctions.getWidgetHeight(height: 12),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: mainColors.whiteColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Transit",
            style: TextStyle(
              fontSize: mainFunctions.getTextSize(fontSize: 20),
              fontWeight: FontWeight.w600,
              color: mainColors.headingBlueColor,
            ),
          ),
          SizedBox(
            height: mainFunctions.getWidgetHeight(height: 10),
          ),
          SizedBox(
            height: mainFunctions.getWidgetHeight(height: 165),
            child: BlocBuilder<InventoryBloc, InventoryState>(
              builder: (BuildContext context, InventoryState inventory) {
                if (inventory is InventoryLoaded) {
                  return mainVariables.inventoryVariables.transitList.isEmpty
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
                      : ListView.builder(
                          itemCount: mainVariables.inventoryVariables.transitList.length,
                          padding: EdgeInsets.zero,
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              width: mainFunctions.getWidgetWidth(width: 182),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xffF7F7F7),
                              ),
                              padding: EdgeInsets.only(
                                  left: mainFunctions.getWidgetWidth(width: 7),
                                  top: mainFunctions.getWidgetHeight(height: 12),
                                  right: mainFunctions.getWidgetWidth(width: 7)),
                              margin: EdgeInsets.only(right: mainFunctions.getWidgetWidth(width: 20)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            mainVariables.inventoryVariables.transitList[index].transId,
                                            style: TextStyle(
                                              fontSize: mainFunctions.getTextSize(fontSize: 13),
                                              fontWeight: FontWeight.w500,
                                              color: const Color(0xff111111),
                                            ),
                                          ),
                                          SizedBox(
                                            width: mainFunctions.getWidgetWidth(width: 140),
                                            child: Text(
                                              mainVariables.inventoryVariables.transitList[index].senderName.toLowerCase() == "n/a"
                                                  ? "General"
                                                  : mainVariables.inventoryVariables.transitList[index].senderName,
                                              maxLines: 1,
                                              style: TextStyle(
                                                fontSize: mainFunctions.getTextSize(fontSize: 12),
                                                fontWeight: FontWeight.w500,
                                                color: const Color(0xff666666),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      mainVariables.inventoryVariables.transitList[index].quantity == 0
                                          ? const SizedBox()
                                          : Container(
                                              height: mainFunctions.getWidgetHeight(height: 20),
                                              width: mainFunctions.getWidgetWidth(width: 28),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(30),
                                                color: const Color(0xff0C3788),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  mainVariables.inventoryVariables.transitList[index].quantity.toString(),
                                                  style: mainTextStyle.labelTextStyle.copyWith(
                                                      fontWeight: FontWeight.w500,
                                                      color: const Color(0xffF4F4F4),
                                                      fontSize: mainFunctions.getTextSize(fontSize: 16)),
                                                ),
                                              ),
                                            )
                                    ],
                                  ),
                                  SizedBox(
                                    height: mainFunctions.getWidgetHeight(height: 10),
                                  ),
                                  Text(
                                    mainVariables.inventoryVariables.transitList[index].senderLocation,
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontSize: mainFunctions.getTextSize(fontSize: 19),
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xff191919),
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                  Container(
                                    height: mainFunctions.getWidgetHeight(height: 42),
                                    width: mainFunctions.getWidgetWidth(width: 15),
                                    decoration: const BoxDecoration(
                                        image: DecorationImage(
                                      image: AssetImage("assets/inventory/transit.png"),
                                      fit: BoxFit.fill,
                                    )),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          mainVariables.inventoryVariables.transitList[index].receiverLocation,
                                          maxLines: 1,
                                          style: TextStyle(
                                            fontSize: mainFunctions.getTextSize(fontSize: 19),
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xff191919),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            mainFunctions.dateFormat(
                                                date: mainVariables.inventoryVariables.transitList[index].date == ""
                                                    ? "${DateTime.now()}"
                                                    : mainVariables.inventoryVariables.transitList[index].date),
                                            style: TextStyle(
                                              fontSize: mainFunctions.getTextSize(fontSize: 11),
                                              fontWeight: FontWeight.w500,
                                              color: const Color(0xff111111),
                                            ),
                                          ),
                                          Text(
                                            mainFunctions.timeFormat(
                                                date: mainVariables.inventoryVariables.transitList[index].date == ""
                                                    ? "${DateTime.now()}"
                                                    : mainVariables.inventoryVariables.transitList[index].date),
                                            style: TextStyle(
                                              fontSize: mainFunctions.getTextSize(fontSize: 10),
                                              fontWeight: FontWeight.w500,
                                              color: const Color(0xffFF3131),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                } else if (inventory is InventoryLoading) {
                  return ListView.builder(
                    itemCount: 5,
                    padding: EdgeInsets.zero,
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey.shade200,
                        highlightColor: Colors.white,
                        child: Container(
                          width: mainFunctions.getWidgetWidth(width: 182),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xffF7F7F7),
                          ),
                          padding: EdgeInsets.only(
                              left: mainFunctions.getWidgetWidth(width: 7),
                              top: mainFunctions.getWidgetHeight(height: 12),
                              right: mainFunctions.getWidgetWidth(width: 7)),
                          margin: EdgeInsets.only(right: mainFunctions.getWidgetWidth(width: 20)),
                        ),
                      );
                    },
                  );
                } else if (inventory is InventoryError) {
                  return ListView.builder(
                    itemCount: 5,
                    padding: EdgeInsets.zero,
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey.shade200,
                        highlightColor: Colors.white,
                        child: Container(
                          width: mainFunctions.getWidgetWidth(width: 182),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xffF7F7F7),
                          ),
                          padding: EdgeInsets.only(
                              left: mainFunctions.getWidgetWidth(width: 7),
                              top: mainFunctions.getWidgetHeight(height: 12),
                              right: mainFunctions.getWidgetWidth(width: 7)),
                          margin: EdgeInsets.only(right: mainFunctions.getWidgetWidth(width: 20)),
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
        ],
      ),
    );
  }

  Widget productDetailsWidget() {
    return Container(
      height: mainFunctions.getWidgetHeight(height: 210),
      margin: EdgeInsets.symmetric(
        horizontal: mainFunctions.getWidgetWidth(width: 8),
        vertical: mainFunctions.getWidgetHeight(height: 5),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: mainColors.whiteColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: mainFunctions.getWidgetHeight(height: 10),
              horizontal: mainFunctions.getWidgetWidth(width: 12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    "Product Details",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: mainFunctions.getTextSize(fontSize: 20),
                        color: mainColors.headingBlueColor,
                        overflow: TextOverflow.ellipsis),
                    maxLines: 1,
                  ),
                ),
                mainVariables.inventoryVariables.productDataList.isEmpty
                    ? const SizedBox()
                    : mainVariables.homeVariables.homeLocationSelectedIndex != -1
                        ? InkWell(
                            onTap: () {
                              mainVariables.inventoryVariables.minimumController.text =
                                  mainVariables.inventoryVariables.minimumLevelCount.toString();
                              mainWidgets.showAlertDialog(
                                  context: context,
                                  content: minimumLevelContent(
                                      minLevel: mainVariables.inventoryVariables.minimumLevelCount, modelSetState: setState),
                                  isDismissible: true);
                            },
                            child: Text(
                              "Minimum level : ${mainVariables.inventoryVariables.minimumLevelCount}",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: mainFunctions.getTextSize(fontSize: 16),
                                color: const Color(0xff007BFE),
                              ),
                            ),
                          )
                        : const SizedBox(),
              ],
            ),
          ),
          const Divider(
            height: 0,
            thickness: 1,
            color: Color(0xffD9D9D9),
          ),
          Expanded(
            child: BlocBuilder<InventoryBloc, InventoryState>(
              builder: (BuildContext context, InventoryState inventory) {
                if (inventory is InventoryLoaded) {
                  return mainVariables.inventoryVariables.productDataList.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/inventory/no_message.png",
                                height: mainFunctions.getWidgetHeight(height: 90),
                                width: mainFunctions.getWidgetWidth(width: 90),
                                fit: BoxFit.fill,
                                color: Colors.grey.shade200,
                              ),
                              SizedBox(
                                height: mainFunctions.getWidgetHeight(height: 15),
                              ),
                              const Text("Product Details List is Empty"),
                            ],
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.symmetric(horizontal: mainFunctions.getWidgetWidth(width: 15)),
                          child: StickyHeadersTable(
                            columnsLength: mainVariables.inventoryVariables.productListHeading.length,
                            rowsLength: mainVariables.inventoryVariables.productDataList.length,
                            showVerticalScrollbar: false,
                            showHorizontalScrollbar: true,
                            columnsTitleBuilder: (int columnIndex) {
                              return Center(
                                child: Text(
                                  columnIndex == 4
                                      ? mainVariables.homeVariables.homeLocationSelectedIndex != -1
                                          ? mainVariables.inventoryVariables.productListHeading[columnIndex]
                                          : ""
                                      : mainVariables.inventoryVariables.selectedProductHasExpiry
                                          ? mainVariables.inventoryVariables.productExpiryListHeading[columnIndex]
                                          : mainVariables.inventoryVariables.productListHeading[columnIndex],
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontSize: mainFunctions.getTextSize(fontSize: 12),
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.w600),
                                  textAlign: TextAlign.center,
                                ),
                              );
                            },
                            rowsTitleBuilder: (int rowIndex) {
                              return Center(
                                child: Text(
                                  rowIndex + 1 < 10 ? "0${rowIndex + 1}" : "${rowIndex + 1}",
                                  maxLines: 2,
                                  style: TextStyle(
                                      fontSize: mainFunctions.getTextSize(fontSize: 12),
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.normal),
                                ),
                              );
                            },
                            contentCellBuilder: (int columnIndex, int rowIndex) {
                              return columnIndex == 4
                                  ? mainVariables.homeVariables.homeLocationSelectedIndex != -1
                                      ? Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            GestureDetector(
                                              onTap: () async {
                                                if (!(num.parse(mainVariables.inventoryVariables.productDataList[rowIndex][6]) == 0)) {
                                                  mainVariables.inventoryVariables.productDataList[rowIndex][6] =
                                                      (num.parse(mainVariables.inventoryVariables.productDataList[rowIndex][6]) - 1)
                                                          .toString();
                                                  mainVariables.inventoryVariables.productDataList[rowIndex][3] =
                                                      (num.parse(mainVariables.inventoryVariables.productDataList[rowIndex][3]) + 1)
                                                          .toString();
                                                  if (context.read<InventoryBloc>().updatedInventoryCartList.isNotEmpty) {
                                                    if (context
                                                        .read<InventoryBloc>()
                                                        .updatedInventoryIdsList
                                                        .contains(mainVariables.inventoryVariables.productDataList[rowIndex][5])) {
                                                      int inventoryIndex = context
                                                          .read<InventoryBloc>()
                                                          .updatedInventoryCartList
                                                          .indexWhere((e) =>
                                                              e["inventoryId"] ==
                                                              mainVariables.inventoryVariables.productDataList[rowIndex][5]);
                                                      context.read<InventoryBloc>().updatedInventoryCartList[inventoryIndex]
                                                          ["quantityDelta"] = context
                                                              .read<InventoryBloc>()
                                                              .updatedInventoryCartList[inventoryIndex]["quantityDelta"] -
                                                          1;
                                                    } else {
                                                      context.read<InventoryBloc>().updatedInventoryCartList.add({
                                                        "inventoryId": mainVariables.inventoryVariables.productDataList[rowIndex][5],
                                                        "quantityDelta": -1
                                                      });
                                                    }
                                                  } else {
                                                    context.read<InventoryBloc>().updatedInventoryCartList.add({
                                                      "inventoryId": mainVariables.inventoryVariables.productDataList[rowIndex][5],
                                                      "quantityDelta": -1
                                                    });
                                                  }
                                                  context
                                                      .read<InventoryBloc>()
                                                      .updatedInventoryCartList
                                                      .removeWhere((e) => e["quantityDelta"] == 0);
                                                  context.read<InventoryBloc>().updatedInventoryIdsList = List.generate(
                                                      context.read<InventoryBloc>().updatedInventoryCartList.length,
                                                      (i) => context.read<InventoryBloc>().updatedInventoryCartList[i]["inventoryId"]);
                                                  setState(() {});
                                                }
                                              },
                                              onLongPressStart: (_) {
                                                increasingTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
                                                  if (!(num.parse(mainVariables.inventoryVariables.productDataList[rowIndex][6]) ==
                                                      0)) {
                                                    mainVariables.inventoryVariables.productDataList[rowIndex][6] =
                                                        (num.parse(mainVariables.inventoryVariables.productDataList[rowIndex][6]) - 1)
                                                            .toString();
                                                    mainVariables.inventoryVariables.productDataList[rowIndex][3] =
                                                        (num.parse(mainVariables.inventoryVariables.productDataList[rowIndex][3]) + 1)
                                                            .toString();
                                                    if (context.read<InventoryBloc>().updatedInventoryCartList.isNotEmpty) {
                                                      if (context
                                                          .read<InventoryBloc>()
                                                          .updatedInventoryIdsList
                                                          .contains(mainVariables.inventoryVariables.productDataList[rowIndex][5])) {
                                                        int inventoryIndex = context
                                                            .read<InventoryBloc>()
                                                            .updatedInventoryCartList
                                                            .indexWhere((e) =>
                                                                e["inventoryId"] ==
                                                                mainVariables.inventoryVariables.productDataList[rowIndex][5]);
                                                        context.read<InventoryBloc>().updatedInventoryCartList[inventoryIndex]
                                                            ["quantityDelta"] = context
                                                                .read<InventoryBloc>()
                                                                .updatedInventoryCartList[inventoryIndex]["quantityDelta"] -
                                                            1;
                                                      } else {
                                                        context.read<InventoryBloc>().updatedInventoryCartList.add({
                                                          "inventoryId": mainVariables.inventoryVariables.productDataList[rowIndex][5],
                                                          "quantityDelta": -1
                                                        });
                                                      }
                                                    } else {
                                                      context.read<InventoryBloc>().updatedInventoryCartList.add({
                                                        "inventoryId": mainVariables.inventoryVariables.productDataList[rowIndex][5],
                                                        "quantityDelta": -1
                                                      });
                                                    }
                                                    context
                                                        .read<InventoryBloc>()
                                                        .updatedInventoryCartList
                                                        .removeWhere((e) => e["quantityDelta"] == 0);
                                                    context.read<InventoryBloc>().updatedInventoryIdsList = List.generate(
                                                        context.read<InventoryBloc>().updatedInventoryCartList.length,
                                                        (i) =>
                                                            context.read<InventoryBloc>().updatedInventoryCartList[i]["inventoryId"]);
                                                    setState(() {});
                                                  }
                                                });
                                                setState(() {});
                                              },
                                              onLongPressEnd: (_) {
                                                if (increasingTimer != null) {
                                                  increasingTimer!.cancel();
                                                  increasingTimer = null;
                                                }
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
                                                    Icons.remove,
                                                    color: Colors.white,
                                                    size: 15,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Text(
                                              mainVariables.inventoryVariables.productDataList[rowIndex][6],
                                              maxLines: 1,
                                              style: TextStyle(
                                                  fontSize: mainFunctions.getTextSize(fontSize: 12),
                                                  overflow: TextOverflow.ellipsis,
                                                  fontWeight: FontWeight.normal),
                                            ),
                                            GestureDetector(
                                              onTap: () async {
                                                if (!(num.parse(mainVariables.inventoryVariables.productDataList[rowIndex][3]) == 0)) {
                                                  mainVariables.inventoryVariables.productDataList[rowIndex][6] =
                                                      (num.parse(mainVariables.inventoryVariables.productDataList[rowIndex][6]) + 1)
                                                          .toString();
                                                  mainVariables.inventoryVariables.productDataList[rowIndex][3] =
                                                      (num.parse(mainVariables.inventoryVariables.productDataList[rowIndex][3]) - 1)
                                                          .toString();
                                                  if (context.read<InventoryBloc>().updatedInventoryCartList.isNotEmpty) {
                                                    if (context
                                                        .read<InventoryBloc>()
                                                        .updatedInventoryIdsList
                                                        .contains(mainVariables.inventoryVariables.productDataList[rowIndex][5])) {
                                                      int inventoryIndex = context
                                                          .read<InventoryBloc>()
                                                          .updatedInventoryCartList
                                                          .indexWhere((e) =>
                                                              e["inventoryId"] ==
                                                              mainVariables.inventoryVariables.productDataList[rowIndex][5]);
                                                      context.read<InventoryBloc>().updatedInventoryCartList[inventoryIndex]
                                                          ["quantityDelta"] = context
                                                              .read<InventoryBloc>()
                                                              .updatedInventoryCartList[inventoryIndex]["quantityDelta"] +
                                                          1;
                                                    } else {
                                                      context.read<InventoryBloc>().updatedInventoryCartList.add({
                                                        "inventoryId": mainVariables.inventoryVariables.productDataList[rowIndex][5],
                                                        "quantityDelta": 1
                                                      });
                                                    }
                                                  } else {
                                                    context.read<InventoryBloc>().updatedInventoryCartList.add({
                                                      "inventoryId": mainVariables.inventoryVariables.productDataList[rowIndex][5],
                                                      "quantityDelta": 1
                                                    });
                                                  }
                                                  context
                                                      .read<InventoryBloc>()
                                                      .updatedInventoryCartList
                                                      .removeWhere((e) => e["quantityDelta"] == 0);
                                                  context.read<InventoryBloc>().updatedInventoryIdsList = List.generate(
                                                      context.read<InventoryBloc>().updatedInventoryCartList.length,
                                                      (i) => context.read<InventoryBloc>().updatedInventoryCartList[i]["inventoryId"]);
                                                  setState(() {});
                                                }
                                              },
                                              onLongPressStart: (_) {
                                                increasingTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
                                                  if (!(num.parse(mainVariables.inventoryVariables.productDataList[rowIndex][3]) ==
                                                      0)) {
                                                    mainVariables.inventoryVariables.productDataList[rowIndex][6] =
                                                        (num.parse(mainVariables.inventoryVariables.productDataList[rowIndex][6]) + 1)
                                                            .toString();
                                                    mainVariables.inventoryVariables.productDataList[rowIndex][3] =
                                                        (num.parse(mainVariables.inventoryVariables.productDataList[rowIndex][3]) - 1)
                                                            .toString();
                                                    if (context.read<InventoryBloc>().updatedInventoryCartList.isNotEmpty) {
                                                      if (context
                                                          .read<InventoryBloc>()
                                                          .updatedInventoryIdsList
                                                          .contains(mainVariables.inventoryVariables.productDataList[rowIndex][5])) {
                                                        int inventoryIndex = context
                                                            .read<InventoryBloc>()
                                                            .updatedInventoryCartList
                                                            .indexWhere((e) =>
                                                                e["inventoryId"] ==
                                                                mainVariables.inventoryVariables.productDataList[rowIndex][5]);
                                                        context.read<InventoryBloc>().updatedInventoryCartList[inventoryIndex]
                                                            ["quantityDelta"] = context
                                                                .read<InventoryBloc>()
                                                                .updatedInventoryCartList[inventoryIndex]["quantityDelta"] +
                                                            1;
                                                      } else {
                                                        context.read<InventoryBloc>().updatedInventoryCartList.add({
                                                          "inventoryId": mainVariables.inventoryVariables.productDataList[rowIndex][5],
                                                          "quantityDelta": 1
                                                        });
                                                      }
                                                    } else {
                                                      context.read<InventoryBloc>().updatedInventoryCartList.add({
                                                        "inventoryId": mainVariables.inventoryVariables.productDataList[rowIndex][5],
                                                        "quantityDelta": 1
                                                      });
                                                    }
                                                    context
                                                        .read<InventoryBloc>()
                                                        .updatedInventoryCartList
                                                        .removeWhere((e) => e["quantityDelta"] == 0);
                                                    context.read<InventoryBloc>().updatedInventoryIdsList = List.generate(
                                                        context.read<InventoryBloc>().updatedInventoryCartList.length,
                                                        (i) =>
                                                            context.read<InventoryBloc>().updatedInventoryCartList[i]["inventoryId"]);
                                                    setState(() {});
                                                  }
                                                });
                                                setState(() {});
                                              },
                                              onLongPressEnd: (_) {
                                                if (increasingTimer != null) {
                                                  increasingTimer!.cancel();
                                                  increasingTimer = null;
                                                }
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
                                      : const SizedBox()
                                  : columnIndex == 1
                                      ? SizedBox(
                                          width: mainFunctions.getWidgetWidth(width: 100),
                                          child: Center(
                                            child: Text(
                                              mainVariables.inventoryVariables.productDataList[rowIndex][columnIndex],
                                              maxLines: 2,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: mainFunctions.getTextSize(fontSize: 12),
                                                  overflow: TextOverflow.ellipsis,
                                                  fontWeight: FontWeight.normal),
                                            ),
                                          ),
                                        )
                                      : columnIndex == 3
                                          ? Center(
                                              child: Text(
                                                mainVariables.inventoryVariables.productDataList[rowIndex][3],
                                                /*context
                                                        .read<InventoryBloc>()
                                                        .updatedInventoryIdsList
                                                        .contains(mainVariables.inventoryVariables.productDataList[rowIndex][5])
                                                    ? (num.parse(mainVariables.inventoryVariables.productDataList[rowIndex]
                                                                [columnIndex]) -
                                                            num.parse(context
                                                                .read<InventoryBloc>()
                                                                .updatedInventoryCartList[context
                                                                    .read<InventoryBloc>()
                                                                    .updatedInventoryCartList
                                                                    .indexWhere((e) =>
                                                                        e["inventoryId"] ==
                                                                        mainVariables.inventoryVariables.productDataList[rowIndex]
                                                                            [5])]["quantityDelta"]
                                                                .toString()))
                                                        .toString()
                                                    : mainVariables.inventoryVariables.productDataList[rowIndex][columnIndex]*/
                                                maxLines: 2,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: mainFunctions.getTextSize(fontSize: 12),
                                                    overflow: TextOverflow.ellipsis,
                                                    fontWeight: FontWeight.normal),
                                              ),
                                            )
                                          : Center(
                                              child: Text(
                                                mainVariables.inventoryVariables.productDataList[rowIndex][columnIndex],
                                                maxLines: 2,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: mainFunctions.getTextSize(fontSize: 12),
                                                    overflow: TextOverflow.ellipsis,
                                                    fontWeight: FontWeight.normal),
                                              ),
                                            );
                            },
                            legendCell: Text(
                              "S.No",
                              maxLines: 1,
                              style: TextStyle(
                                  fontSize: mainFunctions.getTextSize(fontSize: 12),
                                  overflow: TextOverflow.ellipsis,
                                  fontWeight: FontWeight.w600),
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
                                      mainFunctions.getWidgetWidth(
                                          width: mainVariables.homeVariables.homeLocationSelectedIndex != -1 ? 85 : 110),
                                      mainFunctions.getWidgetWidth(
                                          width: mainVariables.homeVariables.homeLocationSelectedIndex != -1 ? 85 : 110),
                                      mainFunctions.getWidgetWidth(
                                          width: mainVariables.homeVariables.homeLocationSelectedIndex != -1 ? 85 : 110),
                                      mainFunctions.getWidgetWidth(
                                          width: mainVariables.homeVariables.homeLocationSelectedIndex != -1 ? 85 : 110),
                                      mainFunctions.getWidgetWidth(
                                          width: mainVariables.homeVariables.homeLocationSelectedIndex != -1 ? 85 : 0),
                                    ]
                                  : [
                                      mainFunctions.getWidgetHeight(
                                          height: mainVariables.homeVariables.homeLocationSelectedIndex != -1 ? 140 : 180),
                                      mainFunctions.getWidgetHeight(
                                          height: mainVariables.homeVariables.homeLocationSelectedIndex != -1 ? 140 : 180),
                                      mainFunctions.getWidgetHeight(
                                          height: mainVariables.homeVariables.homeLocationSelectedIndex != -1 ? 140 : 180),
                                      mainFunctions.getWidgetHeight(
                                          height: mainVariables.homeVariables.homeLocationSelectedIndex != -1 ? 140 : 180),
                                      mainFunctions.getWidgetHeight(
                                          height: mainVariables.homeVariables.homeLocationSelectedIndex != -1 ? 140 : 0),
                                    ],
                              contentCellHeight: 40,
                              stickyLegendWidth: 40,
                              stickyLegendHeight: 40,
                            ),
                          ),
                        );
                } else if (inventory is InventoryLoading) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: mainFunctions.getWidgetWidth(width: 15)),
                    child: StickyHeadersTable(
                      columnsLength: mainVariables.inventoryVariables.productListHeading.length,
                      rowsLength: 10,
                      showVerticalScrollbar: false,
                      showHorizontalScrollbar: true,
                      columnsTitleBuilder: (int columnIndex) {
                        return Center(
                          child: Text(
                            columnIndex == 4
                                ? mainVariables.homeVariables.homeLocationSelectedIndex != -1 &&
                                        mainVariables.inventoryVariables.tabControllerIndex == 1
                                    ? mainVariables.inventoryVariables.productListHeading[columnIndex]
                                    : ""
                                : mainVariables.inventoryVariables.selectedProductHasExpiry
                                    ? mainVariables.inventoryVariables.productExpiryListHeading[columnIndex]
                                    : mainVariables.inventoryVariables.productListHeading[columnIndex],
                            maxLines: 2,
                            style: TextStyle(
                                fontSize: mainFunctions.getTextSize(fontSize: 12),
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center,
                          ),
                        );
                      },
                      rowsTitleBuilder: (int rowIndex) {
                        return Center(
                          child: Text(
                            (rowIndex + 1) < 10 ? "0${rowIndex + 1}" : "${rowIndex + 1}",
                            maxLines: 2,
                            style: TextStyle(
                                fontSize: mainFunctions.getTextSize(fontSize: 12),
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.normal),
                          ),
                        );
                      },
                      contentCellBuilder: (int columnIndex, int rowIndex) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey.shade200,
                          highlightColor: Colors.white,
                          child: Center(
                            child: Text(
                              "Loading...",
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: mainFunctions.getTextSize(fontSize: 12),
                                  overflow: TextOverflow.ellipsis,
                                  fontWeight: FontWeight.normal),
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
                            fontWeight: FontWeight.w600),
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
                                mainFunctions.getWidgetWidth(
                                    width: mainVariables.homeVariables.homeLocationSelectedIndex != -1 &&
                                            mainVariables.inventoryVariables.tabControllerIndex == 1
                                        ? 85
                                        : 110),
                                mainFunctions.getWidgetWidth(
                                    width: mainVariables.homeVariables.homeLocationSelectedIndex != -1 &&
                                            mainVariables.inventoryVariables.tabControllerIndex == 1
                                        ? 85
                                        : 110),
                                mainFunctions.getWidgetWidth(
                                    width: mainVariables.homeVariables.homeLocationSelectedIndex != -1 &&
                                            mainVariables.inventoryVariables.tabControllerIndex == 1
                                        ? 85
                                        : 110),
                                mainFunctions.getWidgetWidth(
                                    width: mainVariables.homeVariables.homeLocationSelectedIndex != -1 &&
                                            mainVariables.inventoryVariables.tabControllerIndex == 1
                                        ? 85
                                        : 110),
                                mainFunctions.getWidgetWidth(
                                    width: mainVariables.homeVariables.homeLocationSelectedIndex != -1 &&
                                            mainVariables.inventoryVariables.tabControllerIndex == 1
                                        ? 85
                                        : 0),
                              ]
                            : [
                                mainFunctions.getWidgetHeight(
                                    height: mainVariables.homeVariables.homeLocationSelectedIndex != -1 &&
                                            mainVariables.inventoryVariables.tabControllerIndex == 1
                                        ? 140
                                        : 180),
                                mainFunctions.getWidgetHeight(
                                    height: mainVariables.homeVariables.homeLocationSelectedIndex != -1 &&
                                            mainVariables.inventoryVariables.tabControllerIndex == 1
                                        ? 140
                                        : 180),
                                mainFunctions.getWidgetHeight(
                                    height: mainVariables.homeVariables.homeLocationSelectedIndex != -1 &&
                                            mainVariables.inventoryVariables.tabControllerIndex == 1
                                        ? 140
                                        : 180),
                                mainFunctions.getWidgetHeight(
                                    height: mainVariables.homeVariables.homeLocationSelectedIndex != -1 &&
                                            mainVariables.inventoryVariables.tabControllerIndex == 1
                                        ? 140
                                        : 180),
                                mainFunctions.getWidgetHeight(
                                    height: mainVariables.homeVariables.homeLocationSelectedIndex != -1 &&
                                            mainVariables.inventoryVariables.tabControllerIndex == 1
                                        ? 140
                                        : 0),
                              ],
                        contentCellHeight: 40,
                        stickyLegendWidth: 40,
                        stickyLegendHeight: 40,
                      ),
                    ),
                  );
                } else if (inventory is InventoryError) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: mainFunctions.getWidgetWidth(width: 15)),
                    child: StickyHeadersTable(
                      columnsLength: mainVariables.inventoryVariables.productListHeading.length,
                      rowsLength: 10,
                      showVerticalScrollbar: false,
                      showHorizontalScrollbar: true,
                      columnsTitleBuilder: (int columnIndex) {
                        return Center(
                          child: Text(
                            columnIndex == 4
                                ? mainVariables.homeVariables.homeLocationSelectedIndex != -1 &&
                                        mainVariables.inventoryVariables.tabControllerIndex == 1
                                    ? mainVariables.inventoryVariables.productListHeading[columnIndex]
                                    : ""
                                : mainVariables.inventoryVariables.selectedProductHasExpiry
                                    ? mainVariables.inventoryVariables.productExpiryListHeading[columnIndex]
                                    : mainVariables.inventoryVariables.productListHeading[columnIndex],
                            maxLines: 2,
                            style: TextStyle(
                                fontSize: mainFunctions.getTextSize(fontSize: 12),
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center,
                          ),
                        );
                      },
                      rowsTitleBuilder: (int rowIndex) {
                        return Center(
                          child: Text(
                            (rowIndex + 1) < 10 ? "0${rowIndex + 1}" : "${rowIndex + 1}",
                            maxLines: 2,
                            style: TextStyle(
                                fontSize: mainFunctions.getTextSize(fontSize: 12),
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.normal),
                          ),
                        );
                      },
                      contentCellBuilder: (int columnIndex, int rowIndex) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey.shade200,
                          highlightColor: Colors.white,
                          child: Center(
                            child: Text(
                              "Loading...",
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: mainFunctions.getTextSize(fontSize: 12),
                                  overflow: TextOverflow.ellipsis,
                                  fontWeight: FontWeight.normal),
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
                            fontWeight: FontWeight.w600),
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
                                mainFunctions.getWidgetWidth(
                                    width: mainVariables.homeVariables.homeLocationSelectedIndex != -1 &&
                                            mainVariables.inventoryVariables.tabControllerIndex == 1
                                        ? 85
                                        : 110),
                                mainFunctions.getWidgetWidth(
                                    width: mainVariables.homeVariables.homeLocationSelectedIndex != -1 &&
                                            mainVariables.inventoryVariables.tabControllerIndex == 1
                                        ? 85
                                        : 110),
                                mainFunctions.getWidgetWidth(
                                    width: mainVariables.homeVariables.homeLocationSelectedIndex != -1 &&
                                            mainVariables.inventoryVariables.tabControllerIndex == 1
                                        ? 85
                                        : 110),
                                mainFunctions.getWidgetWidth(
                                    width: mainVariables.homeVariables.homeLocationSelectedIndex != -1 &&
                                            mainVariables.inventoryVariables.tabControllerIndex == 1
                                        ? 85
                                        : 110),
                                mainFunctions.getWidgetWidth(
                                    width: mainVariables.homeVariables.homeLocationSelectedIndex != -1 &&
                                            mainVariables.inventoryVariables.tabControllerIndex == 1
                                        ? 85
                                        : 0),
                              ]
                            : [
                                mainFunctions.getWidgetHeight(
                                    height: mainVariables.homeVariables.homeLocationSelectedIndex != -1 &&
                                            mainVariables.inventoryVariables.tabControllerIndex == 1
                                        ? 140
                                        : 180),
                                mainFunctions.getWidgetHeight(
                                    height: mainVariables.homeVariables.homeLocationSelectedIndex != -1 &&
                                            mainVariables.inventoryVariables.tabControllerIndex == 1
                                        ? 140
                                        : 180),
                                mainFunctions.getWidgetHeight(
                                    height: mainVariables.homeVariables.homeLocationSelectedIndex != -1 &&
                                            mainVariables.inventoryVariables.tabControllerIndex == 1
                                        ? 140
                                        : 180),
                                mainFunctions.getWidgetHeight(
                                    height: mainVariables.homeVariables.homeLocationSelectedIndex != -1 &&
                                            mainVariables.inventoryVariables.tabControllerIndex == 1
                                        ? 140
                                        : 180),
                                mainFunctions.getWidgetHeight(
                                    height: mainVariables.homeVariables.homeLocationSelectedIndex != -1 &&
                                            mainVariables.inventoryVariables.tabControllerIndex == 1
                                        ? 140
                                        : 0),
                              ],
                        contentCellHeight: 40,
                        stickyLegendWidth: 40,
                        stickyLegendHeight: 40,
                      ),
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          )
        ],
      ),
    );
  }

  Widget shortageWidget() {
    return Container(
      height: mainFunctions.getWidgetHeight(height: 210),
      margin: EdgeInsets.symmetric(
        horizontal: mainFunctions.getWidgetWidth(width: 8),
        vertical: mainFunctions.getWidgetHeight(height: 5),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: mainColors.whiteColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: mainFunctions.getWidgetHeight(height: 10),
              horizontal: mainFunctions.getWidgetWidth(width: 12),
            ),
            child: Text(
              "Shortage",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: mainFunctions.getTextSize(fontSize: 20),
                color: mainColors.headingBlueColor,
              ),
            ),
          ),
          const Divider(
            height: 0,
            thickness: 1,
            color: Color(0xffD9D9D9),
          ),
          Expanded(
            child: BlocBuilder<InventoryBloc, InventoryState>(
              builder: (BuildContext context, InventoryState inventory) {
                if (inventory is InventoryLoaded) {
                  return mainVariables.inventoryVariables.shortageDataList.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/inventory/no_message.png",
                                height: mainFunctions.getWidgetHeight(height: 90),
                                width: mainFunctions.getWidgetWidth(width: 90),
                                fit: BoxFit.fill,
                                color: Colors.grey.shade200,
                              ),
                              SizedBox(
                                height: mainFunctions.getWidgetHeight(height: 15),
                              ),
                              const Text("Shortage details List is Empty"),
                            ],
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.symmetric(horizontal: mainFunctions.getWidgetWidth(width: 15)),
                          child: StickyHeadersTable(
                            showVerticalScrollbar: false,
                            showHorizontalScrollbar: true,
                            columnsLength: mainVariables.inventoryVariables.shortageListHeading.length,
                            rowsLength: mainVariables.inventoryVariables.shortageDataList.length,
                            columnsTitleBuilder: (int columnIndex) {
                              return Center(
                                child: Text(
                                  mainVariables.inventoryVariables.shortageListHeading[columnIndex],
                                  maxLines: 2,
                                  style: TextStyle(
                                      fontSize: mainFunctions.getTextSize(fontSize: 12),
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.w600),
                                  textAlign: TextAlign.center,
                                ),
                              );
                            },
                            rowsTitleBuilder: (int rowIndex) {
                              return Center(
                                child: Text(
                                  (rowIndex + 1) < 10 ? "0${rowIndex + 1}" : "${rowIndex + 1}",
                                  maxLines: 2,
                                  style: TextStyle(
                                      fontSize: mainFunctions.getTextSize(fontSize: 12),
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.normal),
                                ),
                              );
                            },
                            contentCellBuilder: (int columnIndex, int rowIndex) {
                              return columnIndex == 0
                                  ? InkWell(
                                      onTap: () {
                                        mainVariables.generalVariables.currentPage.value = "inventory";
                                        mainVariables.addDisputeVariables.loader = false;
                                        mainVariables.generalVariables.selectedDisputeId =
                                            mainVariables.inventoryVariables.shortageDataList[rowIndex][columnIndex + 5];
                                        mainVariables.generalVariables.railNavigateBackIndex =
                                            mainVariables.generalVariables.railNavigateIndex;
                                        mainVariables.generalVariables.railNavigateIndex = 13;
                                        context.read<RailNavigationBloc>().add(const RailNavigationSelectedWidgetEvent());
                                      },
                                      child: Center(
                                          child: Text(
                                        mainVariables.inventoryVariables.shortageDataList[rowIndex][columnIndex],
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: mainFunctions.getTextSize(fontSize: 12),
                                            overflow: TextOverflow.ellipsis,
                                            fontWeight: FontWeight.normal,
                                            color: const Color(0xff007BFE)),
                                      )),
                                    )
                                  : Center(
                                      child: Text(
                                        mainVariables.inventoryVariables.shortageDataList[rowIndex][columnIndex],
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: mainFunctions.getTextSize(fontSize: 12),
                                            overflow: TextOverflow.ellipsis,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    );
                            },
                            legendCell: Text(
                              "S.No",
                              maxLines: 1,
                              style: TextStyle(
                                  fontSize: mainFunctions.getTextSize(fontSize: 12),
                                  overflow: TextOverflow.ellipsis,
                                  fontWeight: FontWeight.w600),
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
                                      mainFunctions.getWidgetWidth(width: 95),
                                      mainFunctions.getWidgetWidth(width: 95),
                                      mainFunctions.getWidgetWidth(width: 95),
                                      mainFunctions.getWidgetWidth(width: 95),
                                      mainFunctions.getWidgetWidth(width: 35),
                                    ]
                                  : [
                                      mainFunctions.getWidgetHeight(height: 160),
                                      mainFunctions.getWidgetHeight(height: 160),
                                      mainFunctions.getWidgetHeight(height: 160),
                                      mainFunctions.getWidgetHeight(height: 160),
                                      mainFunctions.getWidgetHeight(height: 70),
                                    ],
                              contentCellHeight: 40,
                              stickyLegendWidth: 40,
                              stickyLegendHeight: 40,
                            ),
                          ),
                        );
                } else if (inventory is InventoryLoading) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: mainFunctions.getWidgetWidth(width: 15)),
                    child: StickyHeadersTable(
                      showVerticalScrollbar: false,
                      showHorizontalScrollbar: true,
                      columnsLength: mainVariables.inventoryVariables.shortageListHeading.length,
                      rowsLength: 10,
                      columnsTitleBuilder: (int columnIndex) {
                        return Center(
                          child: Text(
                            mainVariables.inventoryVariables.shortageListHeading[columnIndex],
                            maxLines: 2,
                            style: TextStyle(
                                fontSize: mainFunctions.getTextSize(fontSize: 12),
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center,
                          ),
                        );
                      },
                      rowsTitleBuilder: (int rowIndex) {
                        return Center(
                          child: Text(
                            (rowIndex + 1) < 10 ? "0${rowIndex + 1}" : "${rowIndex + 1}",
                            maxLines: 2,
                            style: TextStyle(
                                fontSize: mainFunctions.getTextSize(fontSize: 12),
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.normal),
                          ),
                        );
                      },
                      contentCellBuilder: (int columnIndex, int rowIndex) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey.shade200,
                          highlightColor: Colors.white,
                          child: Center(
                            child: Text(
                              "Loading...",
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: mainFunctions.getTextSize(fontSize: 12),
                                  overflow: TextOverflow.ellipsis,
                                  fontWeight: FontWeight.normal),
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
                            fontWeight: FontWeight.w600),
                      ),
                      cellAlignments: const CellAlignments.fixed(
                        contentCellAlignment: Alignment.center,
                        stickyColumnAlignment: Alignment.center,
                        stickyRowAlignment: Alignment.center,
                        stickyLegendAlignment: Alignment.center,
                      ),
                      cellDimensions: CellDimensions.fixed(
                        contentCellWidth: mainFunctions.getWidgetWidth(
                            width: MediaQuery.of(context).orientation == Orientation.portrait
                                ? mainFunctions.getWidgetWidth(width: 68)
                                : mainFunctions.getWidgetWidth(width: 160)),
                        contentCellHeight: mainFunctions.getWidgetHeight(height: 40),
                        stickyLegendWidth: mainFunctions.getWidgetWidth(width: 40),
                        stickyLegendHeight: mainFunctions.getWidgetHeight(height: 40),
                      ),
                    ),
                  );
                } else if (inventory is InventoryError) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: mainFunctions.getWidgetWidth(width: 15)),
                    child: StickyHeadersTable(
                      showVerticalScrollbar: false,
                      showHorizontalScrollbar: true,
                      columnsLength: mainVariables.inventoryVariables.shortageListHeading.length,
                      rowsLength: 10,
                      columnsTitleBuilder: (int columnIndex) {
                        return Center(
                          child: Text(
                            mainVariables.inventoryVariables.shortageListHeading[columnIndex],
                            maxLines: 2,
                            style: TextStyle(
                                fontSize: mainFunctions.getTextSize(fontSize: 12),
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center,
                          ),
                        );
                      },
                      rowsTitleBuilder: (int rowIndex) {
                        return Center(
                          child: Text(
                            (rowIndex + 1) < 10 ? "0${rowIndex + 1}" : "${rowIndex + 1}",
                            maxLines: 2,
                            style: TextStyle(
                                fontSize: mainFunctions.getTextSize(fontSize: 12),
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.normal),
                          ),
                        );
                      },
                      contentCellBuilder: (int columnIndex, int rowIndex) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey.shade200,
                          highlightColor: Colors.white,
                          child: Center(
                            child: Text(
                              "Loading...",
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: mainFunctions.getTextSize(fontSize: 12),
                                  overflow: TextOverflow.ellipsis,
                                  fontWeight: FontWeight.normal),
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
                            fontWeight: FontWeight.w600),
                      ),
                      cellAlignments: const CellAlignments.fixed(
                        contentCellAlignment: Alignment.center,
                        stickyColumnAlignment: Alignment.center,
                        stickyRowAlignment: Alignment.center,
                        stickyLegendAlignment: Alignment.center,
                      ),
                      cellDimensions: CellDimensions.fixed(
                        contentCellWidth: mainFunctions.getWidgetWidth(
                            width: MediaQuery.of(context).orientation == Orientation.portrait
                                ? mainFunctions.getWidgetWidth(width: 68)
                                : mainFunctions.getWidgetWidth(width: 160)),
                        contentCellHeight: mainFunctions.getWidgetHeight(height: 40),
                        stickyLegendWidth: mainFunctions.getWidgetWidth(width: 40),
                        stickyLegendHeight: mainFunctions.getWidgetHeight(height: 40),
                      ),
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget minimumLevelContent({required int minLevel, required StateSetter modelSetState}) {
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
            "Minimum level",
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
            child: TextFormField(
              controller: mainVariables.inventoryVariables.minimumController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Add Minimum level",
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
          SizedBox(
            height: mainFunctions.getWidgetHeight(height: 22),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () async {
                  if (mainVariables.inventoryVariables.minimumController.text.isEmpty) {
                    mainWidgets.flushBarWidget(context: context, message: "Please fill the Minimum Level value");
                  } else {
                    Navigator.pop(context);
                    context.read<InventoryBloc>().add(MinimumLevelUpdateEvent(
                        updateLevel: int.parse(mainVariables.inventoryVariables.minimumController.text), modelSetState: setState));
                  }
                },
                child: Container(
                  width: mainFunctions.getWidgetHeight(height: 120),
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
                      Text('Confirm',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: const Color(0xffffffff),
                              fontSize: mainFunctions.getTextSize(fontSize: 14),
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
              ),
              Text(
                "Minimum level : $minLevel",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: mainFunctions.getTextSize(fontSize: 12),
                  color: const Color(0xffF85359),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget quantityUpdateContent({required int index, required StateSetter modelSetState}) {
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
            "Consumed Qty",
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
            child: TextFormField(
              controller: mainVariables.inventoryVariables.quantityController,
              keyboardType: TextInputType.number,
              onTap: () {
                if ((int.parse(mainVariables.inventoryVariables.quantityController.text)) == 0) {
                  mainVariables.inventoryVariables.quantityController.clear();
                }
              },
              decoration: InputDecoration(
                hintText: "Add Consumed Qty",
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
          SizedBox(
            height: mainFunctions.getWidgetHeight(height: 22),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () async {
                  if (mainVariables.inventoryVariables.quantityController.text.isEmpty) {
                    mainWidgets.flushBarWidget(context: context, message: "Please fill the quantity value");
                  } else if (int.parse(mainVariables.inventoryVariables.quantityController.text) >
                      int.parse(mainVariables.inventoryVariables.productDataList[index][3])) {
                    mainWidgets.flushBarWidget(context: context, message: "Quantities insufficient in this location");
                  } else {
                    Navigator.pop(context);
                    context.read<InventoryBloc>().add(QuantityUpdateEvent(
                          modelSetState: setState,
                          index: index,
                        ));
                  }
                },
                child: Container(
                  width: mainFunctions.getWidgetHeight(height: 120),
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
                      Text('Confirm',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: const Color(0xffffffff),
                              fontSize: mainFunctions.getTextSize(fontSize: 14),
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
              ),
              Text(
                "Current Qty : ${mainVariables.inventoryVariables.productDataList[index][3]}",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: mainFunctions.getTextSize(fontSize: 12),
                  color: const Color(0xffF85359),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget cartScreenWidget() {
    return FutureBuilder(
        future: getCartFunction(),
        builder: (BuildContext context, AsyncSnapshot snapShot) {
          if (snapShot.hasData) {
            List<Item> items = snapShot.data.cart.items;
            num totalQuantity = List.generate(items.length, (i) => items[i].quantityAdded).reduce((a, b) => a + b);
            return Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(
                      vertical: mainFunctions.getWidgetHeight(height: 20), horizontal: mainFunctions.getWidgetWidth(width: 20)),
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
                                context.read<InventoryBloc>().cartPageEnabled = !context.read<InventoryBloc>().cartPageEnabled;
                                setState(() {});
                              },
                              child: const Icon(
                                Icons.arrow_back_ios,
                                color: Color(0xff0C3788),
                              ),
                            ),
                            Text(
                              "Cart",
                              style: mainTextStyle.normalTextStyle
                                  .copyWith(color: mainColors.headingBlueColor, fontWeight: FontWeight.w600),
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
                      SizedBox(
                        height: mainFunctions.getWidgetHeight(height: 16),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: mainFunctions.getWidgetHeight(height: 12), vertical: mainFunctions.getWidgetWidth(width: 12)),
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
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    "Total Products : ${items.length} | Total Qty: $totalQuantity",
                                    style: TextStyle(
                                        fontSize: mainFunctions.getTextSize(fontSize: 15),
                                        color: const Color(0xff111111),
                                        fontWeight: FontWeight.w600),
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
                              height: 250,
                              child: StickyHeadersTable(
                                columnsLength: mainVariables.receivedStocksVariables.receivedStocksInventory.tableHeading.length,
                                rowsLength: items.length,
                                showHorizontalScrollbar: false,
                                showVerticalScrollbar: false,
                                columnsTitleBuilder: (int columnIndex) {
                                  return Center(
                                    child: Text(
                                      mainVariables.receivedStocksVariables.receivedStocksInventory.tableHeading[columnIndex],
                                      maxLines: 2,
                                      style: TextStyle(
                                          fontSize: mainFunctions.getTextSize(fontSize: 12),
                                          overflow: TextOverflow.ellipsis,
                                          fontWeight: FontWeight.w600),
                                      textAlign: TextAlign.center,
                                    ),
                                  );
                                },
                                rowsTitleBuilder: (int rowIndex) {
                                  return Center(
                                    child: Text(
                                      (rowIndex + 1) < 10 ? "0${rowIndex + 1}" : "${rowIndex + 1}",
                                      maxLines: 2,
                                      style: TextStyle(
                                          fontSize: mainFunctions.getTextSize(fontSize: 12),
                                          overflow: TextOverflow.ellipsis,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  );
                                },
                                contentCellBuilder: (int columnIndex, int rowIndex) {
                                  return columnIndex == 2
                                      ? Center(
                                          child: Text(
                                            items[rowIndex].inventorySnapshot.productDetails.productName,
                                            maxLines: 2,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: mainFunctions.getTextSize(fontSize: 12),
                                                overflow: TextOverflow.ellipsis,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        )
                                      : columnIndex == 3
                                          ? Center(
                                              child: Text(
                                                items[rowIndex].inventorySnapshot.productDetails.brandType,
                                                maxLines: 2,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: mainFunctions.getTextSize(fontSize: 12),
                                                    overflow: TextOverflow.ellipsis,
                                                    fontWeight: FontWeight.normal),
                                              ),
                                            )
                                          : columnIndex == 4
                                              ? Center(
                                                  child: Text(
                                                    items[rowIndex].inventorySnapshot.purchaseDate,
                                                    maxLines: 2,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: mainFunctions.getTextSize(fontSize: 12),
                                                        overflow: TextOverflow.ellipsis,
                                                        fontWeight: FontWeight.normal),
                                                  ),
                                                )
                                              : columnIndex == 5
                                                  ? Center(
                                                      child: Text(
                                                        items[rowIndex].inventorySnapshot.expiryDate,
                                                        maxLines: 2,
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                            fontSize: mainFunctions.getTextSize(fontSize: 12),
                                                            overflow: TextOverflow.ellipsis,
                                                            fontWeight: FontWeight.normal),
                                                      ),
                                                    )
                                                  : columnIndex == 6
                                                      ? Center(
                                                          child: Text(
                                                            items[rowIndex].quantityAdded.toString(),
                                                            maxLines: 2,
                                                            textAlign: TextAlign.center,
                                                            style: TextStyle(
                                                                fontSize: mainFunctions.getTextSize(fontSize: 12),
                                                                overflow: TextOverflow.ellipsis,
                                                                fontWeight: FontWeight.normal),
                                                          ),
                                                        )
                                                      : const SizedBox();
                                },
                                legendCell: Text(
                                  "S.No",
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontSize: mainFunctions.getTextSize(fontSize: 12),
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.w600),
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
                      SizedBox(
                        height: mainFunctions.getWidgetHeight(height: 20),
                      ),
                      SizedBox(
                        height: mainFunctions.getWidgetHeight(height: 106),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: mainFunctions.getWidgetHeight(height: 12),
                              vertical: mainFunctions.getWidgetWidth(width: 12)),
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
                                        "Remarks",
                                        style: TextStyle(
                                            fontSize: mainFunctions.getTextSize(fontSize: 20),
                                            color: const Color(0xff0C3788),
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    SizedBox(
                                      height: mainFunctions.getWidgetHeight(height: 8),
                                    ),
                                    SizedBox(
                                      height: mainFunctions.getWidgetHeight(height: 50),
                                      child: TextFormField(
                                        style: TextStyle(
                                            fontSize: mainFunctions.getTextSize(fontSize: 13),
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xff111111),
                                            overflow: TextOverflow.ellipsis),
                                        maxLines: 2,
                                        controller: context.read<InventoryBloc>().cartRemarksController,
                                        keyboardType: TextInputType.text,
                                        textInputAction: TextInputAction.done,
                                        decoration: InputDecoration(
                                          fillColor: const Color(0xffFFFFFF),
                                          filled: true,
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: mainFunctions.getWidgetWidth(width: 12),
                                              vertical: mainFunctions.getWidgetHeight(height: 12)),
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
                    ],
                  ),
                ),
                SizedBox(
                  height: mainFunctions.getWidgetHeight(height: 88),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                        onTap: () async {
                          mainWidgets.showAnimatedDialog(
                            context: context,
                            height: 200,
                            width: 460,
                            child: dialogCartActionsContent(
                                context: context,
                                type: "expired",
                                productCont: items.length,
                                itemsCount: totalQuantity,
                                function: () {
                                  context.read<InventoryBloc>().add(CartActionEvent(
                                      cardId: snapShot.data.cart.id,
                                      action: "expired",
                                      remarks: context.read<InventoryBloc>().cartRemarksController.text,
                                      context: context,
                                      modelSetState: setState));
                                }),
                          );
                        },
                        child: Container(
                          width: mainFunctions.getWidgetWidth(width: 132),
                          height: mainFunctions.getWidgetHeight(height: 42),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: const Color(0xffFF9500),
                          ),
                          child: Center(
                            child: Text(
                              "Expired",
                              style: TextStyle(
                                  fontSize: mainFunctions.getTextSize(fontSize: 16), fontWeight: FontWeight.w600, color: Colors.white),
                            ),
                          ),
                        )),
                    SizedBox(width: mainFunctions.getWidgetWidth(width: 37)),
                    InkWell(
                        onTap: () async {
                          mainWidgets.showAnimatedDialog(
                            context: context,
                            height: 200,
                            width: 460,
                            child: dialogCartActionsContent(
                                context: context,
                                type: "consumed",
                                productCont: items.length,
                                itemsCount: totalQuantity,
                                function: () {
                                  context.read<InventoryBloc>().add(CartActionEvent(
                                      cardId: snapShot.data.cart.id,
                                      action: "consumed",
                                      remarks: context.read<InventoryBloc>().cartRemarksController.text,
                                      context: context,
                                      modelSetState: setState));
                                }),
                          );
                        },
                        child: Container(
                          width: mainFunctions.getWidgetWidth(width: 132),
                          height: mainFunctions.getWidgetHeight(height: 42),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: const LinearGradient(
                                colors: [Color(0xff0C3788), Color(0xffBC0044)],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight),
                          ),
                          child: Center(
                            child: Text(
                              "Consumed",
                              style: TextStyle(
                                  fontSize: mainFunctions.getTextSize(fontSize: 16), fontWeight: FontWeight.w600, color: Colors.white),
                            ),
                          ),
                        )),
                    SizedBox(width: mainFunctions.getWidgetWidth(width: 37)),
                    InkWell(
                        onTap: () async {
                          mainWidgets.showAnimatedDialog(
                            context: context,
                            height: 200,
                            width: 460,
                            child: dialogCartActionsContent(
                                context: context,
                                type: "deleted",
                                productCont: items.length,
                                itemsCount: totalQuantity,
                                function: () {
                                  context.read<InventoryBloc>().add(CartActionEvent(
                                      cardId: snapShot.data.cart.id,
                                      action: "deleted",
                                      remarks: context.read<InventoryBloc>().cartRemarksController.text,
                                      context: context,
                                      modelSetState: setState));
                                }),
                          );
                        },
                        child: Container(
                          width: mainFunctions.getWidgetWidth(width: 132),
                          height: mainFunctions.getWidgetHeight(height: 42),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: const Color(0xffF12B00),
                          ),
                          child: Center(
                            child: Text(
                              "Delete",
                              style: TextStyle(
                                  fontSize: mainFunctions.getTextSize(fontSize: 16), fontWeight: FontWeight.w600, color: Colors.white),
                            ),
                          ),
                        )),
                  ],
                ),
                SizedBox(
                  height: mainFunctions.getWidgetHeight(height: 16),
                ),
              ],
            );
          } else {
            return Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(
                      vertical: mainFunctions.getWidgetHeight(height: 20), horizontal: mainFunctions.getWidgetWidth(width: 20)),
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
                                context.read<InventoryBloc>().cartPageEnabled = !context.read<InventoryBloc>().cartPageEnabled;
                                setState(() {});
                              },
                              child: const Icon(
                                Icons.arrow_back_ios,
                                color: Color(0xff0C3788),
                              ),
                            ),
                            Text(
                              "Cart",
                              style: mainTextStyle.normalTextStyle
                                  .copyWith(color: mainColors.headingBlueColor, fontWeight: FontWeight.w600),
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
                      SizedBox(
                        height: mainFunctions.getWidgetHeight(height: 16),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: mainFunctions.getWidgetHeight(height: 12), vertical: mainFunctions.getWidgetWidth(width: 12)),
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
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(
                              color: Color(0xffD9D9D9),
                              thickness: 1.0,
                              height: 0,
                            ),
                            const SizedBox(
                              height: 250,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: mainFunctions.getWidgetHeight(height: 20),
                      ),
                      SizedBox(
                        height: mainFunctions.getWidgetHeight(height: 106),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: mainFunctions.getWidgetHeight(height: 12),
                              vertical: mainFunctions.getWidgetWidth(width: 12)),
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
                                        "remarks",
                                        style: TextStyle(
                                            fontSize: mainFunctions.getTextSize(fontSize: 20),
                                            color: const Color(0xff0C3788),
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    SizedBox(
                                      height: mainFunctions.getWidgetHeight(height: 8),
                                    ),
                                    SizedBox(
                                      height: mainFunctions.getWidgetHeight(height: 50),
                                      child: TextFormField(
                                        style: TextStyle(
                                            fontSize: mainFunctions.getTextSize(fontSize: 13),
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xff111111),
                                            overflow: TextOverflow.ellipsis),
                                        maxLines: 2,
                                        controller: context.read<InventoryBloc>().cartRemarksController,
                                        keyboardType: TextInputType.text,
                                        textInputAction: TextInputAction.done,
                                        readOnly: true,
                                        decoration: InputDecoration(
                                          fillColor: const Color(0xffFFFFFF),
                                          filled: true,
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: mainFunctions.getWidgetWidth(width: 12),
                                              vertical: mainFunctions.getWidgetHeight(height: 12)),
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
                    ],
                  ),
                ),
              ],
            );
          }
        });
  }

  Widget dialogCartActionsContent(
      {required BuildContext context,
      required String type,
      required int productCont,
      required num itemsCount,
      required Function function}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 12),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: Text(
                  type=="deleted"?"Delete":type=="consumed"?"Consume":"Expire",
                  style: TextStyle(
                      fontSize: mainFunctions.getTextSize(fontSize: 20), fontWeight: FontWeight.w600, color: const Color(0xff111111)),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 12),
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
                height: mainFunctions.getWidgetHeight(height: 16),
              ),
              Text(
                "Total Products : $productCont | Total Qty: $itemsCount",
                style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 16), fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: mainFunctions.getWidgetHeight(height: 16),
              ),
            ],
          ),
        ),
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 16),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                    width: mainFunctions.getWidgetWidth(width: 150),
                    height: mainFunctions.getWidgetHeight(height: 50),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: LinearGradient(colors: [Colors.red.withOpacity(0.6), Colors.red.withOpacity(1.0)])),
                    child: const Center(
                        child: Text(
                      "Cancel",
                      style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
                    )))),
            SizedBox(
              width: mainFunctions.getWidgetWidth(width: 16),
            ),
            InkWell(
                onTap: () {
                  function();
                  Navigator.pop(context);
                },
                child: Container(
                  width: mainFunctions.getWidgetWidth(width: 150),
                  height: mainFunctions.getWidgetHeight(height: 50),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: LinearGradient(colors: [Colors.green.withOpacity(0.6), Colors.green.withOpacity(1.0)])),
                  child: const Center(
                    child: Text(
                      "Confirm",
                      style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
                    ),
                  ),
                )),
            SizedBox(
              width: mainFunctions.getWidgetWidth(width: 16),
            ),
          ],
        ),
        SizedBox(
          height: mainFunctions.getWidgetHeight(height: 16),
        ),
      ],
    );
  }
}

Widget dialogCartContent({required BuildContext context}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      SizedBox(
        height: mainFunctions.getWidgetHeight(height: 12),
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: Text(
                "Cart",
                style: TextStyle(
                    fontSize: mainFunctions.getTextSize(fontSize: 20), fontWeight: FontWeight.w600, color: const Color(0xff111111)),
              ),
            ),
          ),
        ],
      ),
      SizedBox(
        height: mainFunctions.getWidgetHeight(height: 12),
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
              height: mainFunctions.getWidgetHeight(height: 16),
            ),
            Text(
              "Your cart hasn’t been updated yet",
              style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 16), fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: mainFunctions.getWidgetHeight(height: 16),
            ),
          ],
        ),
      ),
      SizedBox(
        height: mainFunctions.getWidgetHeight(height: 16),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                  width: mainFunctions.getWidgetWidth(width: 150),
                  height: mainFunctions.getWidgetHeight(height: 50),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: LinearGradient(colors: [Colors.red.withOpacity(0.6), Colors.red.withOpacity(1.0)])),
                  child: const Center(
                      child: Text(
                    "Cancel",
                    style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
                  )))),
          SizedBox(
            width: mainFunctions.getWidgetWidth(width: 16),
          ),
          InkWell(
              onTap: () {
                Navigator.pop(context);
                mainVariables.generalVariables.railNavigateBackIndex = mainVariables.generalVariables.railNavigateIndex;
                mainVariables.generalVariables.railNavigateIndex = 0;
                mainVariables.railNavigationVariables.mainSelectedIndex = 0;
                mainVariables.homeVariables.homeLocationSelectedIndex = -1;
                mainVariables.inventoryVariables.tabControllerIndex = 0;
                mainVariables.inventoryVariables.tabsEnableList.clear();
                mainVariables.inventoryVariables.tabsEnableList = List.generate(3, (index) => false);
                mainVariables.inventoryVariables.tabsEnableList[0] = true;
                mainVariables.homeVariables.quickLinksEnabled = false;
                context.read<RailNavigationBloc>().add(const RailNavigationSelectedWidgetEvent());
              },
              child: Container(
                width: mainFunctions.getWidgetWidth(width: 150),
                height: mainFunctions.getWidgetHeight(height: 50),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(colors: [Colors.green.withOpacity(0.6), Colors.green.withOpacity(1.0)])),
                child: const Center(
                  child: Text(
                    "Confirm",
                    style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
                  ),
                ),
              )),
          SizedBox(
            width: mainFunctions.getWidgetWidth(width: 16),
          ),
        ],
      ),
      SizedBox(
        height: mainFunctions.getWidgetHeight(height: 16),
      ),
    ],
  );
}
