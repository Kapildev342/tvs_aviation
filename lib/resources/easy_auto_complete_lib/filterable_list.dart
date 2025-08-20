import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvsaviation/bloc/manage/manage_bloc.dart';
import 'package:tvsaviation/bloc/rail_navigation/rail_navigation_bloc.dart';
import 'package:tvsaviation/resources/constants.dart';
import 'package:tvsaviation/resources/drop_down_lib/dropdown_textfield.dart';

class FilterableList extends StatefulWidget {
  final List<DropDownValueModel> items;
  final Function(DropDownValueModel) onItemTapped;
  final double elevation;
  final double maxListHeight;
  final TextStyle suggestionTextStyle;
  final Color? suggestionBackgroundColor;
  final bool loading;
  final String buttonString;
  final int selectedIndex;
  final Function closeFunction;
  final Widget Function(String data)? suggestionBuilder;
  final Widget? progressIndicatorBuilder;

  const FilterableList(
      {super.key,
      required this.items,
      required this.onItemTapped,
      required this.buttonString,
      required this.selectedIndex,
      required this.closeFunction,
      this.suggestionBuilder,
      this.elevation = 5,
      this.maxListHeight = 150,
      this.suggestionTextStyle = const TextStyle(),
      this.suggestionBackgroundColor,
      this.loading = false,
      this.progressIndicatorBuilder});

  @override
  State<FilterableList> createState() => _FilterableListState();
}

class _FilterableListState extends State<FilterableList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: widget.maxListHeight),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            blurRadius: 4.0,
            spreadRadius: 0.0,
            color: Colors.grey.shade300,
          ),
        ],
      ),
      child: Visibility(
        visible: widget.items.isNotEmpty || widget.loading,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.all(5),
                itemCount: widget.loading ? 1 : widget.items.length,
                itemBuilder: (context, index) {
                  if (widget.loading) {
                    return Container(
                        alignment: Alignment.center, padding: const EdgeInsets.all(10), child: Visibility(visible: widget.progressIndicatorBuilder != null, replacement: const CircularProgressIndicator(), child: widget.progressIndicatorBuilder!));
                  }

                  if (widget.suggestionBuilder != null) {
                    return InkWell(child: widget.suggestionBuilder!(widget.items[index].name), onTap: () => widget.onItemTapped(widget.items[index]));
                  }

                  return Material(
                      color: Colors.transparent,
                      child: InkWell(
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(
                                  horizontal: mainFunctions.getWidgetWidth(width: 10),
                                  vertical: mainFunctions.getWidgetWidth(width: 10),
                                ),
                                child: Text(widget.items[index].name, style: widget.suggestionTextStyle),
                              ),
                              Divider(
                                height: 0,
                                thickness: 1,
                                color: Colors.grey.shade300,
                              )
                            ],
                          ),
                          onTap: () => widget.onItemTapped(widget.items[index])));
                },
              ),
            ),
            widget.buttonString == ""
                ? const SizedBox()
                : Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        widget.closeFunction();
                        mainVariables.manageVariables.manageSelectedBackIndex = mainVariables.manageVariables.manageSelectedIndex;
                        context.read<ManageBloc>().add(ManagePageChangingEvent(index: widget.selectedIndex, withinScreen: "within"));
                        mainVariables.generalVariables.railNavigateBackIndex = mainVariables.generalVariables.railNavigateIndex;
                        mainVariables.generalVariables.railNavigateIndex = 6;
                        mainVariables.railNavigationVariables.mainSelectedIndex = 6;
                        context.read<RailNavigationBloc>().add(const RailNavigationSelectedWidgetEvent());
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: mainFunctions.getWidgetHeight(height: 8)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: mainFunctions.getWidgetWidth(width: 15),
                            ),
                            Image.asset(
                              "assets/reports/settings_icon.png",
                              height: mainFunctions.getWidgetHeight(height: 20),
                              width: mainFunctions.getWidgetWidth(width: 20),
                            ),
                            SizedBox(
                              width: mainFunctions.getWidgetWidth(width: 30),
                            ),
                            Text(
                              widget.buttonString,
                              style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 13), color: const Color(0xff007BFE), fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
