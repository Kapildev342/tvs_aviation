import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tvsaviation/resources/constants.dart';
import 'package:tvsaviation/resources/drop_down_lib/dropdown_textfield.dart';

import 'filterable_list.dart';

class EasyAutocomplete extends StatefulWidget {
  final List<DropDownValueModel>? suggestions;
  final Future<List<DropDownValueModel>> Function(String searchValue)? asyncSuggestions;
  final TextEditingController? controller;
  final InputDecoration decoration;
  final String? labelText;
  final String hintText;
  final String? buttonString;
  final int? selectedIndex;
  final double? textFieldHeight;
  final double? textFieldWidth;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final List<TextInputFormatter> inputFormatter;
  final String? initialValue;
  final TextCapitalization textCapitalization;
  final bool autofocus;
  final TextInputType keyboardType;
  final FocusNode? focusNode;
  final Color? cursorColor;
  final TextStyle inputTextStyle;
  final TextStyle suggestionTextStyle;
  final Color? suggestionBackgroundColor;
  final Duration debounceDuration;
  final Widget Function(String data)? suggestionBuilder;
  final Widget? progressIndicatorBuilder;
  final String? Function(String?)? validator;
  final bool? enabled;
  final bool? readOnly;
  const EasyAutocomplete({
    super.key,
    this.suggestions,
    this.asyncSuggestions,
    this.suggestionBuilder,
    this.progressIndicatorBuilder,
    this.controller,
    this.buttonString,
    this.selectedIndex,
    this.textFieldHeight,
    this.textFieldWidth,
    this.labelText,
    required this.hintText,
    this.decoration = const InputDecoration(),
    this.onChanged,
    this.onSubmitted,
    this.inputFormatter = const [],
    this.initialValue,
    this.autofocus = false,
    this.textCapitalization = TextCapitalization.sentences,
    this.keyboardType = TextInputType.text,
    this.focusNode,
    this.cursorColor,
    this.inputTextStyle = const TextStyle(overflow: TextOverflow.ellipsis, fontSize: 12),
    this.suggestionTextStyle = const TextStyle(overflow: TextOverflow.ellipsis, fontSize: 12),
    this.suggestionBackgroundColor,
    this.debounceDuration = const Duration(milliseconds: 400),
    this.validator,
    this.enabled,
    this.readOnly,
  })  : assert(onChanged != null || controller != null, 'onChanged and controller parameters cannot be both null at the same time'),
        assert(!(controller != null && initialValue != null), 'controller and initialValue cannot be used at the same time'),
        assert(suggestions != null && asyncSuggestions == null || suggestions == null && asyncSuggestions != null, 'suggestions and asyncSuggestions cannot be both null or have values at the same time');

  @override
  State<EasyAutocomplete> createState() => EasyAutocompleteState();
}

class EasyAutocompleteState extends State<EasyAutocomplete> {
  final LayerLink _layerLink = LayerLink();
  late TextEditingController specialController;
  bool _hasOpenedOverlay = false;
  bool _isLoading = false;
  List<DropDownValueModel> suggestions = [];
  Timer? debounce;
  String previousAsyncSearchText = '';
  late FocusNode focusNode;
  OverlayEntry? overlayEntry;

  @override
  void initState() {
    super.initState();
    focusNode = widget.focusNode ?? FocusNode();
    specialController = widget.controller ?? TextEditingController(text: widget.initialValue ?? '');
    specialController.addListener(() => updateSuggestions(specialController.text));
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        openOverlay();
      } else if (kIsWeb) {
        Future.delayed(const Duration(milliseconds: 150)).then((_) => closeOverlay());
      } else {
        closeOverlay();
      }
    });
  }

  void openOverlay() {
    if (overlayEntry == null) {
      RenderBox renderBox = context.findRenderObject() as RenderBox;
      var size = renderBox.size;
      var offset = renderBox.localToGlobal(Offset.zero);
      overlayEntry ??= OverlayEntry(
          builder: (context) => Positioned(
              left: offset.dx,
              top: offset.dy + size.height + 5.0,
              width: size.width,
              child: CompositedTransformFollower(
                  link: _layerLink,
                  showWhenUnlinked: false,
                  offset: Offset(0.0, size.height + 5.0),
                  child: FilterableList(
                    loading: _isLoading,
                    suggestionBuilder: widget.suggestionBuilder,
                    progressIndicatorBuilder: widget.progressIndicatorBuilder,
                    items: suggestions,
                    suggestionTextStyle: widget.suggestionTextStyle,
                    suggestionBackgroundColor: widget.suggestionBackgroundColor,
                    onItemTapped: (value) {
                      specialController.value = TextEditingValue(text: value.name, selection: TextSelection.collapsed(offset: value.name.length));
                      widget.onChanged?.call(value.value);
                      widget.onSubmitted?.call(value.value);
                      closeOverlay();
                      focusNode.unfocus();
                    },
                    buttonString: widget.buttonString ?? "",
                    selectedIndex: widget.selectedIndex ?? 0,
                    closeFunction: () {
                      closeOverlay();
                      focusNode.unfocus();
                    },
                  ))));
    }
    if (!_hasOpenedOverlay) {
      Overlay.of(context).insert(overlayEntry!);
      setState(() => _hasOpenedOverlay = true);
    }
  }

  Future<void> updateSuggestions(String input) async {
    rebuildOverlay();
    if (widget.suggestions != null) {
      suggestions = widget.suggestions!.where((element) {
        return element.name.toLowerCase().contains(input.toLowerCase());
      }).toList();
      rebuildOverlay();
    } else if (widget.asyncSuggestions != null) {
      if (previousAsyncSearchText == input && input.isNotEmpty) return;

      if (debounce != null && debounce!.isActive) debounce!.cancel();

      setState(() {
        _isLoading = true;
        previousAsyncSearchText = input;
      });

      debounce = Timer(widget.debounceDuration, () async {
        suggestions = await widget.asyncSuggestions!(input);
        setState(() => _isLoading = false);
        rebuildOverlay();
      });
    }
  }

  void rebuildOverlay() {
    if (overlayEntry != null) {
      overlayEntry!.markNeedsBuild();
    }
  }

  void closeOverlay() {
    if (_hasOpenedOverlay) {
      overlayEntry!.remove();
      setState(() {
        _hasOpenedOverlay = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
        link: _layerLink,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            widget.labelText == null
                ? const SizedBox()
                : Text(
                    widget.labelText ?? "",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: mainFunctions.getTextSize(fontSize: 15), color: const Color(0xff111111)),
                  ),
            widget.labelText == null
                ? const SizedBox()
                : SizedBox(
                    height: mainFunctions.getWidgetHeight(height: 10),
                  ),
            SizedBox(
              height: widget.textFieldHeight ?? 44,
              width: widget.textFieldWidth ?? 292,
              child: TextFormField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: mainFunctions.getWidgetWidth(width: 15)),
                    hintText: widget.hintText,
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
                    suffixIcon: specialController.text.isEmpty
                        ? const Icon(Icons.keyboard_arrow_down)
                        : IconButton(
                            onPressed: () {
                              specialController.clear();
                              mainVariables.manageVariables.addInventory.optimumController.text = "0";
                              mainVariables.manageVariables.addInventory.purchaseMonthController.text = "";
                              mainVariables.manageVariables.addInventory.isChecked = false;
                              setState(() {});
                            },
                            icon: const Icon(
                              Icons.clear,
                              size: 20,
                            )),
                  ),
                  controller: specialController,
                  inputFormatters: widget.inputFormatter,
                  autofocus: widget.autofocus,
                  focusNode: focusNode,
                  textCapitalization: widget.textCapitalization,
                  keyboardType: widget.keyboardType,
                  cursorColor: widget.cursorColor ?? Colors.blue,
                  style: widget.inputTextStyle,
                  enabled: widget.enabled ?? true,
                  readOnly: widget.readOnly ?? false,
                  maxLines: 1,
                  onTap: () {
                    if (_hasOpenedOverlay) {
                      closeOverlay();
                      focusNode.unfocus();
                    }
                  },
                  onChanged: (value) => widget.onChanged?.call(value),
                  onFieldSubmitted: (value) {
                    widget.onSubmitted?.call(value);
                    closeOverlay();
                    focusNode.unfocus();
                  },
                  onEditingComplete: () => closeOverlay(),
                  validator: widget.validator != null ? (value) => widget.validator!(value) : null),
            ),
          ],
        ));
  }

  @override
  void dispose() {
    if (overlayEntry != null) overlayEntry!.dispose();
    if (widget.controller == null) {
      specialController.removeListener(() => updateSuggestions(specialController.text));
      specialController.dispose();
    }
    if (debounce != null) debounce?.cancel();
    if (widget.focusNode == null) {
      focusNode.removeListener(() {
        if (focusNode.hasFocus) {
          openOverlay();
        } else {
          closeOverlay();
        }
      });
      focusNode.dispose();
      _hasOpenedOverlay = false;
    }
    super.dispose();
  }
}
