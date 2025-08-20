import 'dart:async';

import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tvsaviation/resources/constants.dart';

class IconProperty {
  final IconData? icon;
  final Color? color;
  final double? size;
  IconProperty({this.icon, this.color, this.size});
}

class CheckBoxProperty {
  final MouseCursor? mouseCursor;
  final Color? activeColor;
  final WidgetStateProperty<Color?>? fillColor;
  final Color? checkColor;
  final bool triState;
  final MaterialTapTargetSize? materialTapTargetSize;
  final VisualDensity? visualDensity;
  final Color? focusColor;
  final Color? hoverColor;
  final WidgetStateProperty<Color?>? overlayColor;
  final double? splashRadius;
  final FocusNode? focusNode;
  final bool autofocus;
  final OutlinedBorder? shape;
  final BorderSide? side;
  static const double width = 18.0;
  CheckBoxProperty({
    this.triState = false,
    this.mouseCursor,
    this.activeColor,
    this.fillColor,
    this.checkColor,
    this.focusColor,
    this.hoverColor,
    this.overlayColor,
    this.splashRadius,
    this.materialTapTargetSize,
    this.visualDensity,
    this.focusNode,
    this.autofocus = false,
    this.shape,
    this.side,
  });
}

class DropDownTextField extends StatefulWidget {
  const DropDownTextField({
    super.key,
    this.controller,
    required this.initialValue,
    required this.dropDownList,
    this.key1,
    this.key2,
    this.key3,
    this.key4,
    this.key5,
    this.key6,
    this.key7,
    this.key8,
    this.key9,
    this.key10,
    this.key11,
    this.key12,
    this.key13,
    this.key14,
    this.key15,
    this.padding,
    this.textStyle,
    this.enabled,
    this.onChanged,
    this.onFieldChanged,
    this.validator,
    this.isEnabled = true,
    this.enableSearch = false,
    this.readOnly = false,
    this.dropdownRadius = 12,
    this.textFieldDecoration,
    this.dropDownIconProperty,
    this.dropDownItemCount = 6,
    this.searchTextStyle,
    this.searchFocusNode,
    this.textFieldFocusNode,
    this.searchAutofocus = false,
    this.searchDecoration,
    this.searchShowCursor,
    this.searchKeyboardType,
    this.listSpace = 0,
    this.clearOption = true,
    this.clearIconProperty,
    this.listPadding,
    this.listTextStyle,
    this.keyboardType,
    this.autoValidateMode,
    this.suffixIconConstraints,
    this.hintText,
    this.isSector,
    this.isSectorRight,
  })  : assert(
          !(controller != null),
          "you cannot add both initialValue and singleController,\nset initial value using controller \n\tEg: SingleValueDropDownController(data:initial value) ",
        ),
        assert(!(!readOnly && enableSearch), "readOnly!=true or enableSearch=true both condition does not work"),
        assert(
          !(controller != null && controller is! SingleValueDropDownController),
          "controller must be type of SingleValueDropDownController",
        ),
        checkBoxProperty = null,
        isMultiSelection = false,
        singleController = controller,
        multiController = null,
        displayCompleteItem = false,
        submitButtonColor = null,
        submitButtonText = null,
        submitButtonTextStyle = null;
  const DropDownTextField.multiSelection({
    super.key,
    this.controller,
    this.displayCompleteItem = false,
    required this.initialValue,
    required this.dropDownList,
    this.key1,
    this.key2,
    this.key3,
    this.key4,
    this.key5,
    this.key6,
    this.key7,
    this.key8,
    this.key9,
    this.key10,
    this.key11,
    this.key12,
    this.key13,
    this.key14,
    this.key15,
    this.padding,
    this.textStyle,
    this.enabled,
    this.onChanged,
    this.onFieldChanged,
    this.validator,
    this.isEnabled = true,
    this.dropdownRadius = 12,
    this.dropDownIconProperty,
    this.textFieldDecoration,
    this.dropDownItemCount = 6,
    this.searchFocusNode,
    this.textFieldFocusNode,
    this.listSpace = 0,
    this.clearOption = true,
    this.clearIconProperty,
    this.submitButtonColor,
    this.submitButtonText,
    this.submitButtonTextStyle,
    this.listPadding,
    this.listTextStyle,
    this.checkBoxProperty,
    this.autoValidateMode,
    this.suffixIconConstraints,
    this.hintText,
    this.isSector,
    this.isSectorRight,
  })  : assert(controller == null, "you cannot add both initialValue and multiController\nset initial value using controller\n\tMultiValueDropDownController(data:initial value)"),
        assert(
          !(controller != null && controller is! MultiValueDropDownController),
          "controller must be type of MultiValueDropDownController",
        ),
        multiController = controller,
        isMultiSelection = true,
        enableSearch = false,
        readOnly = false,
        searchTextStyle = null,
        searchAutofocus = false,
        searchKeyboardType = null,
        searchShowCursor = null,
        singleController = null,
        searchDecoration = null,
        keyboardType = null;

  final GlobalKey<DropDownTextFieldState>? key1;
  final GlobalKey<DropDownTextFieldState>? key2;
  final GlobalKey<DropDownTextFieldState>? key3;
  final GlobalKey<DropDownTextFieldState>? key4;
  final GlobalKey<DropDownTextFieldState>? key5;
  final GlobalKey<DropDownTextFieldState>? key6;
  final GlobalKey<DropDownTextFieldState>? key7;
  final GlobalKey<DropDownTextFieldState>? key8;
  final GlobalKey<DropDownTextFieldState>? key9;
  final GlobalKey<DropDownTextFieldState>? key10;
  final GlobalKey<DropDownTextFieldState>? key11;
  final GlobalKey<DropDownTextFieldState>? key12;
  final GlobalKey<DropDownTextFieldState>? key13;
  final GlobalKey<DropDownTextFieldState>? key14;
  final GlobalKey<DropDownTextFieldState>? key15;
  final dynamic controller;
  final SingleValueDropDownController? singleController;
  final MultiValueDropDownController? multiController;
  final double dropdownRadius;
  final DropDownValueModel initialValue;
  final List<DropDownValueModel> dropDownList;
  final ValueSetter? onChanged;
  final Function? onFieldChanged;
  final bool isMultiSelection;
  final TextStyle? textStyle;
  final bool? enabled;
  final EdgeInsets? padding;
  final InputDecoration? textFieldDecoration;
  final IconProperty? dropDownIconProperty;
  final bool isEnabled;
  final FormFieldValidator<String>? validator;
  final bool enableSearch;
  final bool readOnly;
  final bool displayCompleteItem;
  final int dropDownItemCount;
  final FocusNode? searchFocusNode;
  final FocusNode? textFieldFocusNode;
  final TextStyle? searchTextStyle;
  final InputDecoration? searchDecoration;
  final TextInputType? searchKeyboardType;
  final bool searchAutofocus;
  final bool? searchShowCursor;
  final bool clearOption;
  final IconProperty? clearIconProperty;
  final double listSpace;
  final ListPadding? listPadding;
  final String? submitButtonText;
  final Color? submitButtonColor;
  final TextStyle? submitButtonTextStyle;
  final TextStyle? listTextStyle;
  final TextInputType? keyboardType;
  final AutovalidateMode? autoValidateMode;
  final CheckBoxProperty? checkBoxProperty;
  final String? hintText;
  final bool? isSector;
  final bool? isSectorRight;
  final BoxConstraints? suffixIconConstraints;

  @override
  State<DropDownTextField> createState() => DropDownTextFieldState();
}

class DropDownTextFieldState extends State<DropDownTextField> with TickerProviderStateMixin {
  static final Animatable<double> _easeInTween = CurveTween(curve: Curves.easeIn);
  late String _hintText;
  late bool _isExpanded;
  OverlayEntry? _entry;
  OverlayEntry? _entry2;
  OverlayEntry? _barrierOverlay;
  final _layerLink = LayerLink();
  late AnimationController _controllerAnimation;
  late Animation<double> _heightFactor;
  List<bool> _multiSelectionValue = [];
  late double _height;
  late List<DropDownValueModel> _dropDownList;
  late int _maxListItem;
  late double _searchWidgetHeight;
  late bool _isOutsideClickOverlay;
  late bool _isScrollPadding;
  final int _duration = 150;
  late Offset _offset;
  late bool _searchAutofocus;
  late bool _isPortrait;
  late double _listTileHeight;
  late double _keyboardHeight;
  late TextStyle _listTileTextStyle;
  late ListPadding _listPadding;
  late TextDirection _currentDirection;
  late RxList<DropDownValueModel> newDropDownList;
  final TextEditingController searchCnt = TextEditingController();
  late FocusNode searchFocusNode;
  late FocusNode textFieldFocusNode;
  Function onFieldChanged = () {};
  //GlobalKey overlayKey = GlobalKey();

  @override
  void initState() {
    searchCnt.text = widget.initialValue.name;
    onFieldChanged = widget.onFieldChanged ?? () {};
    newDropDownList = widget.dropDownList.toSet().toList().obs;
    _keyboardHeight = 450;
    _searchAutofocus = false;
    _isScrollPadding = false;
    _isOutsideClickOverlay = false;
    searchFocusNode = widget.searchFocusNode ?? FocusNode();
    textFieldFocusNode = widget.textFieldFocusNode ?? FocusNode();
    _isExpanded = false;
    _controllerAnimation = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: _duration),
    );
    _heightFactor = _controllerAnimation.drive(_easeInTween);
    _searchWidgetHeight = 60;
    _hintText = widget.hintText ?? "";
    searchFocusNode.addListener(() {
      if (!searchFocusNode.hasFocus && !textFieldFocusNode.hasFocus && _isExpanded && !widget.isMultiSelection) {
        _isExpanded = !_isExpanded;
        hideOverlay();
      }
    });
    textFieldFocusNode.addListener(() {
      if (!searchFocusNode.hasFocus && !textFieldFocusNode.hasFocus && _isExpanded) {
        _isExpanded = !_isExpanded;
        hideOverlay();
        if (!widget.readOnly && widget.singleController?.dropDownValue?.name != searchCnt.text) {
          setState(() {
            searchCnt.clear();
          });
        }
      }
    });
    widget.singleController?.addListener(() {
      if (widget.singleController?.dropDownValue == null) {
        clearFun();
      }
    });
    widget.multiController?.addListener(() {
      if (widget.multiController?.dropDownValueList == null) {
        clearFun();
      }
    });
    for (int i = 0; i < widget.dropDownList.length; i++) {
      _multiSelectionValue.add(false);
    }
    _dropDownList = List.from(widget.dropDownList);
    var index = _dropDownList.indexWhere((element) => element.name.trim() == widget.initialValue.name);
    if (index != -1) {
      searchCnt.text = widget.initialValue.name;
    }
    updateFunction();
    super.initState();
  }

  Size _textWidgetSize(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(text: TextSpan(text: text, style: style), maxLines: 1, textDirection: TextDirection.ltr)..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size;
  }

  updateFunction({DropDownTextField? oldWidget}) {
    Function eq = const DeepCollectionEquality().equals;
    _dropDownList = List.from(widget.dropDownList);
    _listPadding = widget.listPadding ?? ListPadding();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      searchCnt.text = widget.initialValue.name;
      if (widget.isMultiSelection) {
        if (oldWidget != null && !eq(oldWidget.dropDownList, _dropDownList)) {
          _multiSelectionValue = [];
          searchCnt.text = "";
          for (int i = 0; i < _dropDownList.length; i++) {
            _multiSelectionValue.add(false);
          }
        }
        if (widget.multiController != null) {
          if (oldWidget != null && oldWidget.multiController?.dropDownValueList != null) {}
          if (widget.multiController?.dropDownValueList != null) {
            _multiSelectionValue = [];
            for (int i = 0; i < _dropDownList.length; i++) {
              _multiSelectionValue.add(false);
            }
            for (int i = 0; i < widget.multiController!.dropDownValueList!.length; i++) {
              var index = _dropDownList.indexWhere((element) => element == widget.multiController!.dropDownValueList![i]);
              if (index != -1) {
                _multiSelectionValue[index] = true;
              }
            }

            if (oldWidget?.displayCompleteItem != widget.displayCompleteItem) {
              List<String> names = (widget.multiController?.dropDownValueList ?? []).map((dataModel) => dataModel.name).toList();

              int count = _multiSelectionValue.where((element) => element).toList().length;
              searchCnt.text = (count == 0
                  ? ""
                  : widget.displayCompleteItem
                      ? names.join(",")
                      : "$count item selected");
            }
          } else {
            _multiSelectionValue = [];
            searchCnt.text = "";
            for (int i = 0; i < _dropDownList.length; i++) {
              _multiSelectionValue.add(false);
            }
          }
        }
      } else {
        if (widget.singleController != null) {
          if (widget.singleController!.dropDownValue != null) {
            searchCnt.text = widget.singleController!.dropDownValue!.name;
          } else {
            searchCnt.clear();
          }
        }
      }
      _listTileTextStyle = (widget.listTextStyle ?? Theme.of(context).textTheme.titleMedium)!;
      _listTileHeight = _textWidgetSize("dummy Text", _listTileTextStyle).height + _listPadding.top + _listPadding.bottom;
      _maxListItem = widget.dropDownItemCount;

      _height = (!widget.isMultiSelection
              ? (_dropDownList.length < _maxListItem ? _dropDownList.length * _listTileHeight : _listTileHeight * _maxListItem.toDouble())
              : _dropDownList.length < _maxListItem
                  ? _dropDownList.length * _listTileHeight
                  : _listTileHeight * _maxListItem.toDouble()) +
          10;
    });
  }

  @override
  void didUpdateWidget(covariant DropDownTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    updateFunction(oldWidget: oldWidget);
  }

  void scrollDownScreen() {
    mainVariables.stockMovementVariables.scrollController.animateTo(
      200,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    if (widget.searchFocusNode == null) searchFocusNode.dispose();
    if (widget.textFieldFocusNode == null) textFieldFocusNode.dispose();
    if (_controllerAnimation.isAnimating) {
      _controllerAnimation.stop();
    }
    _controllerAnimation.dispose();
    searchCnt.dispose();
    super.dispose();
  }

  clearFun() {
    if (_isExpanded) {
      _isExpanded = !_isExpanded;
      hideOverlay();
    }
    searchCnt.clear();
    if (widget.isMultiSelection) {
      if (widget.multiController != null) {
        widget.multiController!.clearDropDown();
      }
      if (widget.onChanged != null) {
        widget.onChanged!([]);
      }

      _multiSelectionValue = [];
      for (int i = 0; i < _dropDownList.length; i++) {
        _multiSelectionValue.add(false);
      }
    } else {
      if (widget.singleController != null) {
        widget.singleController!.clearDropDown();
      }
      if (widget.onChanged != null) {
        widget.onChanged!("");
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    _isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    _currentDirection = Directionality.of(context);
    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible) {
        if (!isKeyboardVisible && _isExpanded && _isScrollPadding) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            shiftOverlayEntry2to1();
          });
        }
        return CompositedTransformTarget(
          link: _layerLink,
          child: TextFormField(
              controller: searchCnt,
              focusNode: textFieldFocusNode,
              keyboardType: widget.keyboardType,
              autovalidateMode: widget.autoValidateMode,
              style: widget.textStyle,
              enabled: widget.enabled ?? true,
              readOnly: widget.readOnly,
              onTap: () {
                _searchAutofocus = widget.searchAutofocus;
                if (!_isExpanded) {
                  if (widget.key1 != null) {
                    if (widget.key1!.currentState!.searchCnt.text.isNotEmpty) {
                      List<bool> data = mainVariables.stockMovementVariables.senderInfo.locationDropDownList.map((element) => element.name == widget.key1!.currentState!.searchCnt.text).toList();
                      if (data.contains(true)) {
                      } else {
                        widget.key1!.currentState!.searchCnt.clear();
                        widget.key1!.currentState!.newDropDownList.value = mainVariables.stockMovementVariables.senderInfo.locationDropDownList.toSet().toList();
                      }
                    }
                  }
                  if (widget.key2 != null) {
                    if (widget.key2!.currentState!.searchCnt.text.isNotEmpty) {
                      List<bool> data = mainVariables.stockMovementVariables.senderInfo.stockTypeDropDownList.map((element) => element.name == widget.key2!.currentState!.searchCnt.text).toList();
                      if (data.contains(true)) {
                      } else {
                        widget.key2!.currentState!.searchCnt.clear();
                        widget.key2!.currentState!.newDropDownList.value = mainVariables.stockMovementVariables.senderInfo.stockTypeDropDownList.toSet().toList();
                      }
                    }
                  }
                  if (widget.key3 != null) {
                    if (widget.key3!.currentState!.searchCnt.text.isNotEmpty) {
                      List<bool> data = mainVariables.stockMovementVariables.senderInfo.sectorDropDownList.map((element) => element.name == widget.key3!.currentState!.searchCnt.text).toList();
                      if (data.contains(true)) {
                      } else {
                        widget.key3!.currentState!.searchCnt.clear();
                        widget.key3!.currentState!.newDropDownList.value = mainVariables.stockMovementVariables.senderInfo.sectorDropDownList.toSet().toList();
                      }
                    }
                  }
                  if (widget.key4 != null) {
                    if (widget.key4!.currentState!.searchCnt.text.isNotEmpty) {
                      List<bool> data = mainVariables.stockMovementVariables.senderInfo.sectorDropDownList.map((element) => element.name == widget.key4!.currentState!.searchCnt.text).toList();
                      if (data.contains(true)) {
                      } else {
                        widget.key4!.currentState!.searchCnt.clear();
                        widget.key4!.currentState!.newDropDownList.value = mainVariables.stockMovementVariables.senderInfo.sectorDropDownList.toSet().toList();
                      }
                    }
                  }
                  if (widget.key5 != null) {
                    if (widget.key5!.currentState!.searchCnt.text.isNotEmpty) {
                      List<bool> data = [].map((element) => element.name == widget.key5!.currentState!.searchCnt.text).toList();
                      if (data.contains(true)) {
                      } else {
                        widget.key5!.currentState!.searchCnt.clear();
                        widget.key5!.currentState!.newDropDownList.value = <DropDownValueModel>{}.toList();
                      }
                    }
                  }
                  if (widget.key6 != null) {
                    if (widget.key6!.currentState!.searchCnt.text.isNotEmpty) {
                      List<bool> data = mainVariables.stockMovementVariables.receiverInfo.handlerDropDownList.map((element) => element.name == widget.key6!.currentState!.searchCnt.text).toList();
                      if (data.contains(true)) {
                      } else {
                        widget.key6!.currentState!.searchCnt.clear();
                        widget.key6!.currentState!.newDropDownList.value = mainVariables.stockMovementVariables.receiverInfo.handlerDropDownList.toSet().toList();
                      }
                    }
                  }
                  if (widget.key7 != null) {
                    if (widget.key7!.currentState!.searchCnt.text.isNotEmpty) {
                      List<bool> data = [].map((element) => element.name == widget.key7!.currentState!.searchCnt.text).toList();
                      if (data.contains(true)) {
                      } else {
                        widget.key7!.currentState!.searchCnt.clear();
                        widget.key7!.currentState!.newDropDownList.value = <DropDownValueModel>{}.toList();
                      }
                    }
                  }
                  if (widget.key8 != null) {
                    if (widget.key8!.currentState!.searchCnt.text.isNotEmpty) {
                      List<bool> data = mainVariables.stockMovementVariables.senderInfo.stockTypeDropDownList.map((element) => element.name == widget.key8!.currentState!.searchCnt.text).toList();
                      if (data.contains(true)) {
                      } else {
                        widget.key8!.currentState!.searchCnt.clear();
                        widget.key8!.currentState!.newDropDownList.value = mainVariables.stockMovementVariables.senderInfo.stockTypeDropDownList.toSet().toList();
                      }
                    }
                  }
                  if (widget.key9 != null) {
                    if (widget.key9!.currentState!.searchCnt.text.isNotEmpty) {
                      List<bool> data = [].map((element) => element.name == widget.key9!.currentState!.searchCnt.text).toList();
                      if (data.contains(true)) {
                      } else {
                        widget.key9!.currentState!.searchCnt.clear();
                        widget.key9!.currentState!.newDropDownList.value = <DropDownValueModel>{}.toList();
                      }
                    }
                  }
                  if (widget.key10 != null) {
                    if (widget.key10!.currentState!.searchCnt.text.isNotEmpty) {
                      List<bool> data = mainVariables.stockMovementVariables.senderInfo.locationDropDownList.map((element) => element.name == widget.key10!.currentState!.searchCnt.text).toList();
                      if (data.contains(true)) {
                      } else {
                        widget.key10!.currentState!.searchCnt.clear();
                        widget.key10!.currentState!.newDropDownList.value = mainVariables.stockMovementVariables.senderInfo.locationDropDownList.toSet().toList();
                      }
                    }
                  }
                  if (widget.key11 != null) {
                    if (widget.key11!.currentState!.searchCnt.text.isNotEmpty) {
                      List<bool> data = mainVariables.stockMovementVariables.senderInfo.locationDropDownList.map((element) => element.name == widget.key11!.currentState!.searchCnt.text).toList();
                      if (data.contains(true)) {
                      } else {
                        widget.key11!.currentState!.searchCnt.clear();
                        widget.key11!.currentState!.newDropDownList.value = mainVariables.stockMovementVariables.senderInfo.locationDropDownList.toSet().toList();
                      }
                    }
                  }
                  if (widget.key12 != null) {
                    if (widget.key12!.currentState!.searchCnt.text.isNotEmpty) {
                      List<bool> data = mainVariables.stockDisputeVariables.disputeDropDownList.map((element) => element.name == widget.key12!.currentState!.searchCnt.text).toList();
                      if (data.contains(true)) {
                      } else {
                        widget.key12!.currentState!.searchCnt.clear();
                        widget.key12!.currentState!.newDropDownList.value = mainVariables.stockDisputeVariables.disputeDropDownList.toSet().toList();
                      }
                    }
                  }
                  if (widget.key13 != null) {
                    if (widget.key13!.currentState!.searchCnt.text.isNotEmpty) {
                      List<bool> data = mainVariables.stockMovementVariables.senderInfo.locationDropDownList.map((element) => element.name == widget.key13!.currentState!.searchCnt.text).toList();
                      if (data.contains(true)) {
                      } else {
                        widget.key13!.currentState!.searchCnt.clear();
                        widget.key13!.currentState!.newDropDownList.value = mainVariables.stockMovementVariables.senderInfo.locationDropDownList.toSet().toList();
                      }
                    }
                  }
                  if (widget.key14 != null) {
                    if (widget.key14!.currentState!.searchCnt.text.isNotEmpty) {
                      List<bool> data = mainVariables.stockMovementVariables.senderInfo.sectorDropDownList.map((element) => element.name == widget.key14!.currentState!.searchCnt.text).toList();
                      if (data.contains(true)) {
                      } else {
                        widget.key14!.currentState!.searchCnt.clear();
                        widget.key14!.currentState!.newDropDownList.value = mainVariables.stockMovementVariables.senderInfo.sectorDropDownList.toSet().toList();
                      }
                    }
                  }
                  if (widget.key15 != null) {
                    if (widget.key15!.currentState!.searchCnt.text.isNotEmpty) {
                      List<bool> data = mainVariables.stockMovementVariables.senderInfo.sectorDropDownList.map((element) => element.name == widget.key15!.currentState!.searchCnt.text).toList();
                      if (data.contains(true)) {
                      } else {
                        widget.key15!.currentState!.searchCnt.clear();
                        widget.key15!.currentState!.newDropDownList.value = mainVariables.stockMovementVariables.senderInfo.sectorDropDownList.toSet().toList();
                      }
                    }
                  }
                  if (_dropDownList.isNotEmpty) {
                    mainVariables.stockMovementVariables.onTappedRegion.value = true;
                    _showOverlay();
                    MediaQuery.of(context).orientation == Orientation.portrait ? () {} : scrollDownScreen();
                  }
                } else {
                  textFieldFocusNode.unfocus();
                  searchCnt.clear();
                  newDropDownList.value = widget.dropDownList;
                  mainVariables.stockMovementVariables.onTappedRegion.value = false;
                  hideOverlay();
                  onFieldChanged();
                }
              },
              onChanged: (String value) {
                if (value.isEmpty) {
                  newDropDownList.value = widget.dropDownList;
                  hideOverlay();
                } else {
                  newDropDownList.value = widget.dropDownList.where((item) {
                    if (item.iata == null) {
                      return item.name.toLowerCase().startsWith(value.toLowerCase());
                    } else {
                      return item.name.toLowerCase().startsWith(value.toLowerCase()) || item.iata!.toLowerCase().startsWith(value.toLowerCase()) || item.airportName!.toLowerCase().startsWith(value.toLowerCase());
                    }
                  }).toList();
                  _showOverlay();
                }
              },
              onFieldSubmitted: (val) {
                textFieldFocusNode.unfocus();
                searchCnt.clear();
                newDropDownList.value = widget.dropDownList;
                hideOverlay();
                onFieldChanged();
              },
              decoration: InputDecoration(
                fillColor: (widget.enabled ?? true) ? const Color(0xffFFFFFF) : Colors.grey.shade300,
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
                hintText: _hintText,
                hintStyle: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 11), fontWeight: FontWeight.w400, color: (widget.enabled ?? true) ? Colors.black26 : Colors.black26, overflow: TextOverflow.ellipsis),
                suffixIcon: searchCnt.text.isNotEmpty
                    ? InkWell(
                        onTap: () {
                          textFieldFocusNode.unfocus();
                          searchCnt.clear();
                          newDropDownList.value = widget.dropDownList;
                          hideOverlay();
                          onFieldChanged();
                        },
                        child: const Icon(
                          Icons.clear,
                          color: Colors.black,
                          size: 15,
                        ),
                      )
                    : (widget.enabled ?? true)
                        ? const Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.black,
                            size: 20,
                          )
                        : const SizedBox(),
                suffixIconConstraints: widget.suffixIconConstraints ?? const BoxConstraints(minWidth: 48, minHeight: 48),
              )),
        );
      },
    );
  }

  Future<void> _showOverlay() async {
    _controllerAnimation.forward();
    _isExpanded = true;
    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    _offset = renderBox.localToGlobal(Offset.zero);
    double posFromTop = _offset.dy;
    double posFromBot = MediaQuery.of(context).size.height - posFromTop;
    double dropdownListHeight = _height + (widget.enableSearch ? _searchWidgetHeight : 0) + widget.listSpace;
    double ht = dropdownListHeight + 120;
    if (_searchAutofocus && !(posFromBot < ht) && posFromBot < _keyboardHeight && !_isScrollPadding && _isPortrait) {
      _isScrollPadding = true;
    }
    _isOutsideClickOverlay = _isScrollPadding || (widget.readOnly && dropdownListHeight > (posFromTop - MediaQuery.of(context).padding.top - 15) && posFromBot < ht);
    final double topPaddingHeight = _isOutsideClickOverlay ? (dropdownListHeight - (posFromTop - MediaQuery.of(context).padding.top - 15)) : 0;

    final double htPos = posFromBot < ht
        ? size.height - 100 + topPaddingHeight
        : _isScrollPadding
            ? size.height - (_keyboardHeight - posFromBot)
            : size.height;
    if (_isOutsideClickOverlay) {
      _openOutSideClickOverlay(context);
    }
    _entry = OverlayEntry(
      builder: (context) => Positioned(
          width: widget.isSector == null ? size.width : size.width * 2.25,
          child: CompositedTransformFollower(
              targetAnchor: posFromBot < ht ? Alignment.bottomCenter : Alignment.topCenter,
              followerAnchor: posFromBot < ht ? Alignment.bottomCenter : Alignment.topCenter,
              link: _layerLink,
              showWhenUnlinked: false,
              offset: widget.isSector == null
                  ? Offset(
                      0,
                      posFromBot < ht ? htPos - widget.listSpace : htPos + widget.listSpace,
                    )
                  : Offset(
                      (widget.isSectorRight ?? false) ? -75 : 75,
                      posFromBot < ht ? htPos - widget.listSpace : htPos + widget.listSpace,
                    ),
              child: AnimatedBuilder(
                animation: _controllerAnimation.view,
                builder: buildOverlay,
              ))),
    );
    _entry2 = OverlayEntry(
      builder: (context) => Positioned(
          width: size.width,
          child: CompositedTransformFollower(
              targetAnchor: Alignment.bottomCenter,
              followerAnchor: Alignment.bottomCenter,
              link: _layerLink,
              showWhenUnlinked: false,
              offset: Offset(
                0,
                htPos,
              ),
              child: AnimatedBuilder(
                animation: _controllerAnimation.view,
                builder: buildOverlay,
              ))),
    );
    overlay.insert(_isScrollPadding ? _entry2! : _entry!);
  }

  _openOutSideClickOverlay(BuildContext context) {
    final overlay2 = Overlay.of(context);
    _barrierOverlay = OverlayEntry(builder: (context) {
      final size = MediaQuery.of(context).size;
      return GestureDetector(
        onTap: () {
          hideOverlay();
        },
        child: Container(
          width: size.width,
          height: size.height,
          color: Colors.transparent,
        ),
      );
    });
    overlay2.insert(_barrierOverlay!);
  }

  void hideOverlay() {
    if (!_isScrollPadding) {}
    _controllerAnimation.reverse().then<void>((void value) {
      if (_entry != null && _entry!.mounted) {
        _entry?.remove();
        _entry = null;
      }
      if (_entry2 != null && _entry2!.mounted) {
        _entry2?.remove();
        _entry2 = null;
      }

      if (_barrierOverlay != null && _barrierOverlay!.mounted) {
        _barrierOverlay?.remove();
        _barrierOverlay = null;
        _isOutsideClickOverlay = false;
      }
      _isScrollPadding = false;
      _isExpanded = false;
    });
    textFieldFocusNode.unfocus();
  }

  void shiftOverlayEntry1to2() {
    _entry?.remove();
    _entry = null;
    if (_barrierOverlay != null && _barrierOverlay!.mounted) {
      _barrierOverlay?.remove();
      _barrierOverlay = null;
      _isOutsideClickOverlay = false;
    }
    _isScrollPadding = true;
    _showOverlay();
    textFieldFocusNode.requestFocus();

    Future.delayed(Duration(milliseconds: _duration), () {
      searchFocusNode.requestFocus();
    });
  }

  void shiftOverlayEntry2to1() {
    _searchAutofocus = false;
    _entry2?.remove();
    _entry2 = null;
    if (_barrierOverlay != null && _barrierOverlay!.mounted) {
      _barrierOverlay?.remove();
      _barrierOverlay = null;
      _isOutsideClickOverlay = false;
    }
    _controllerAnimation.reset();
    _isScrollPadding = false;
    _showOverlay();
    textFieldFocusNode.requestFocus();
  }

  Widget buildOverlay(context, child) {
    return Directionality(
      textDirection: _currentDirection,
      child: ClipRect(
        child: Align(
          heightFactor: _heightFactor.value,
          child: Material(
            //key: overlayKey,
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 5),
              child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(widget.dropdownRadius)),
                    boxShadow: [
                      BoxShadow(color: Colors.grey.shade500, blurRadius: 4, spreadRadius: 0),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: _height,
                        child: Scrollbar(
                          child: Obx(() => newDropDownList.isEmpty
                              ? const Center(
                                  child: Text("No match results found"),
                                )
                              : ListView.builder(
                                  padding: EdgeInsets.zero,
                                  itemCount: newDropDownList.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return Padding(
                                      padding: EdgeInsets.only(right: 10, left: 10, bottom: index == newDropDownList.length - 1 ? _listPadding.bottom : _listPadding.bottom / 2, top: index == 0 ? _listPadding.top : _listPadding.top / 2),
                                      child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              searchCnt.text = newDropDownList[index].name;
                                              _isExpanded = !_isExpanded;
                                            });
                                            if (widget.singleController != null) {
                                              widget.singleController!.setDropDown(newDropDownList[index]);
                                            }
                                            if (widget.onChanged != null) {
                                              widget.onChanged!(newDropDownList[index]);
                                            }
                                            hideOverlay();
                                          },
                                          child: widget.isSector == null
                                              ? Text(newDropDownList[index].name, style: widget.listTextStyle)
                                              : Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    RichText(
                                                      textAlign: TextAlign.start,
                                                      text: TextSpan(children: <TextSpan>[
                                                        TextSpan(
                                                          text: "${newDropDownList[index].name}, ",
                                                          style: TextStyle(
                                                            fontWeight: FontWeight.w600,
                                                            fontSize: mainFunctions.getTextSize(fontSize: 13),
                                                            color: const Color(0xff111111),
                                                            fontFamily: "Figtree",
                                                          ),
                                                        ),
                                                        TextSpan(
                                                          text: "${newDropDownList[index].iata}",
                                                          style: TextStyle(
                                                            fontWeight: FontWeight.w600,
                                                            fontSize: mainFunctions.getTextSize(fontSize: 13),
                                                            color: const Color(0xff111111),
                                                            fontFamily: "Figtree",
                                                          ),
                                                        ),
                                                      ]),
                                                    ),
                                                    RichText(
                                                      textAlign: TextAlign.start,
                                                      text: TextSpan(children: <TextSpan>[
                                                        TextSpan(
                                                          text: "${newDropDownList[index].city}, ",
                                                          style: TextStyle(
                                                            fontWeight: FontWeight.w500,
                                                            fontSize: mainFunctions.getTextSize(fontSize: 12),
                                                            color: const Color(0xff5C5C5C),
                                                            fontFamily: "Figtree",
                                                          ),
                                                        ),
                                                        TextSpan(
                                                          text: "${newDropDownList[index].airportName}",
                                                          style: TextStyle(
                                                            fontWeight: FontWeight.w500,
                                                            fontSize: mainFunctions.getTextSize(fontSize: 12),
                                                            color: const Color(0xff5C5C5C),
                                                            fontFamily: "Figtree",
                                                          ),
                                                        ),
                                                      ]),
                                                    ),
                                                  ],
                                                )),
                                    );
                                  },
                                )),
                        ),
                      ),
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }
}

class DropDownValueModel extends Equatable {
  final String name;
  final String value;
  final String? iata;
  final String? airportName;
  final String? city;

  const DropDownValueModel({required this.name, required this.value, this.iata, this.airportName, this.city});

  factory DropDownValueModel.fromJson(Map<String, dynamic> json) => DropDownValueModel(
        name: json["name"] ?? "",
        value: json["value"] ?? "",
        iata: json["iata"] ?? "",
        airportName: json["airport_name"] ?? "",
        city: json["city"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "value": value,
        "iata": iata,
        "airport_name": airportName,
        "city": city,
      };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DropDownValueModel && other.value == value && other.name == name;
  }

  @override
  int get hashCode => value.hashCode ^ name.hashCode;

  @override
  List<Object> get props => [name, value];
}

class SingleValueDropDownController extends ChangeNotifier {
  DropDownValueModel? dropDownValue;
  SingleValueDropDownController({DropDownValueModel? data}) {
    setDropDown(data);
  }
  setDropDown(DropDownValueModel? model) {
    if (dropDownValue != model) {
      dropDownValue = model;
      notifyListeners();
    }
  }

  clearDropDown() {
    if (dropDownValue != null) {
      dropDownValue = null;
      notifyListeners();
    }
  }
}

class MultiValueDropDownController extends ChangeNotifier {
  List<DropDownValueModel>? dropDownValueList;
  MultiValueDropDownController({List<DropDownValueModel>? data}) {
    setDropDown(data);
  }
  setDropDown(List<DropDownValueModel>? modelList) {
    List<DropDownValueModel>? lst;
    if (modelList != null && modelList.isNotEmpty) {
      List<DropDownValueModel> list = [];
      for (DropDownValueModel item in modelList) {
        if (!list.contains(item)) {
          list.add(item);
        }
      }
      lst = list;
    }
    Function unOrdDeepEq = const DeepCollectionEquality.unordered().equals;

    if (!unOrdDeepEq(lst, dropDownValueList)) {
      dropDownValueList = lst;
      notifyListeners();
    }
  }

  clearDropDown() {
    if (dropDownValueList != null) {
      dropDownValueList = null;
      notifyListeners();
    }
  }
}

class ListPadding {
  double top;
  double bottom;
  ListPadding({this.top = 15, this.bottom = 15});
}

class KeyboardVisibilityBuilder extends StatefulWidget {
  final Widget Function(
    BuildContext context,
    bool isKeyboardVisible,
  ) builder;
  const KeyboardVisibilityBuilder({
    super.key,
    required this.builder,
  });
  @override
  State<KeyboardVisibilityBuilder> createState() => _KeyboardVisibilityBuilderState();
}

class _KeyboardVisibilityBuilderState extends State<KeyboardVisibilityBuilder> with WidgetsBindingObserver {
  var _isKeyboardVisible = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final newValue = bottomInset > 0.0;
    if (newValue != _isKeyboardVisible) {
      setState(() {
        _isKeyboardVisible = newValue;
      });
    }
  }

  @override
  Widget build(BuildContext context) => widget.builder(
        context,
        _isKeyboardVisible,
      );
}
