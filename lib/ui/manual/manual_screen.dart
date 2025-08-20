import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:tvsaviation/bloc/manual/manual_bloc.dart';
import 'package:tvsaviation/bloc/rail_navigation/rail_navigation_bloc.dart';
import 'package:tvsaviation/resources/constants.dart';

class ManualScreen extends StatefulWidget {
  static const String id = "manual";

  const ManualScreen({super.key});

  @override
  State<ManualScreen> createState() => _ManualScreenState();
}

class _ManualScreenState extends State<ManualScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ManualBloc>().add(const ManualInitialEvent());
  }

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
    return BlocConsumer<ManualBloc, ManualState>(
      listener: (BuildContext context, ManualState manual) {},
      builder: (BuildContext context, ManualState manual) {
        if (manual is ManualLoaded) {
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
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                PDFView(
                  filePath: mainVariables.manualVariables.filePath,
                ),
                mainVariables.generalVariables.userData.role == "admin"
                    ? Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: mainFunctions.getWidgetWidth(width: 8),
                          vertical: mainFunctions.getWidgetHeight(height: 8),
                        ),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xffBC0044)),
                            onPressed: () async {
                              context.read<ManualBloc>().add(ManualChangingEvent(context: context));
                            },
                            child: Text(
                              "Change",
                              style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 12), color: Colors.white, fontWeight: FontWeight.w600),
                            )),
                      )
                    : const SizedBox()
              ],
            ),
          );
        } else if (manual is ManualLoading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
