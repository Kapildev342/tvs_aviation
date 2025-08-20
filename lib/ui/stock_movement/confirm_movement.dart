import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'package:table_sticky_headers/table_sticky_headers.dart';
import 'package:tvsaviation/bloc/confirm_movement/confirm_movement_bloc.dart';
import 'package:tvsaviation/bloc/rail_navigation/rail_navigation_bloc.dart';
import 'package:tvsaviation/resources/constants.dart';
import 'package:tvsaviation/resources/drop_down_lib/dropdown_textfield.dart';
import 'package:tvsaviation/resources/widgets.dart';

class ConfirmMovementScreen extends StatefulWidget {
  static const String id = "confirm_movement";
  const ConfirmMovementScreen({super.key});

  @override
  State<ConfirmMovementScreen> createState() => _ConfirmMovementScreenState();
}

class _ConfirmMovementScreenState extends State<ConfirmMovementScreen> {
  ScreenshotController screenshotController = ScreenshotController();
  GlobalKey<SfSignaturePadState> signaturePadKey = GlobalKey<SfSignaturePadState>();
  bool isSigned = false;
  ByteData? bytes;
  ByteData? bytes2;
  String? imageEncoded;
  String? imageEncoded2;
  bool tableExtension = false;
  int totalProducts = 0;
  int totalQuantity = 0;

  @override
  void initState() {
    mainVariables.stockMovementVariables.senderInfo.senderFromSectorChoose = mainVariables.stockMovementVariables.sendData.sectorFrom == "" ? const DropDownValueModel(name: "N/A", value: "") : mainVariables.stockMovementVariables.senderInfo.senderFromSectorChoose;
    mainVariables.stockMovementVariables.senderInfo.senderToSectorChoose = mainVariables.stockMovementVariables.sendData.sectorTo == "" ? const DropDownValueModel(name: "N/A", value: "") : mainVariables.stockMovementVariables.senderInfo.senderToSectorChoose;
    mainVariables.confirmMovementVariables.senderInfo.handlerNameController.text = "";
    mainVariables.confirmMovementVariables.senderInfo.handlerNumberController.text = "";
    mainVariables.confirmMovementVariables.searchBar.text = "";
    totalProducts = mainVariables.stockMovementVariables.sendData.inventories.length;
    for (int i = 0; i < mainVariables.stockMovementVariables.sendData.inventories.length; i++) {
      totalQuantity = (totalQuantity + mainVariables.stockMovementVariables.sendData.inventories[i].quantity).round();
    }
    super.initState();
  }

  Future<File> takeScreenshot() async {
    Uint8List? image = await screenshotController.capture();
    final pdf = pw.Document();
    final imageData = pw.MemoryImage(image!);
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Image(imageData),
          );
        },
      ),
    );
    Directory? downloadsDir = await mainFunctions.getDownloadsDirectory();
    String fileName = 'screenshot_${DateTime.now().millisecondsSinceEpoch}.pdf';
    String filePath = '${downloadsDir!.path}/$fileName';
    File file = File(filePath);
    setState(() {
      tableExtension = false;
    });
    await file.writeAsBytes(await pdf.save());
    return file;
  }

  bool onDraw({required StateSetter modelSet}) {
    modelSet(() {
      isSigned = true;
    });
    return false;
  }

  Future<void> validatingSignature({required bool handler}) async {
    ui.Image data = await signaturePadKey.currentState!.toImage();
    if (handler) {
      bytes = await data.toByteData(format: ui.ImageByteFormat.png);
      imageEncoded = base64.encode(bytes!.buffer.asUint8List());
      setState(() {});
    } else {
      bytes2 = await data.toByteData(format: ui.ImageByteFormat.png);
      imageEncoded2 = base64.encode(bytes2!.buffer.asUint8List());
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvoked: (value) {
          mainVariables.confirmMovementVariables.loader = false;
          mainVariables.generalVariables.railNavigateBackIndex = mainVariables.generalVariables.railNavigateIndex;
          mainVariables.generalVariables.railNavigateIndex = 10;
          context.read<RailNavigationBloc>().add(const RailNavigationSelectedWidgetEvent());
        },
        child: bodyWidget());
  }

  Widget bodyWidget() {
    return BlocListener<ConfirmMovementBloc, ConfirmMovementState>(
      listenWhen: (previous, current) {
        return previous != current;
      },
      listener: (BuildContext context, ConfirmMovementState confirm) {
        if (confirm is ConfirmMovementFailure) {
          mainWidgets.flushBarWidget(context: context, message: confirm.errorMessage);
        } else if (confirm is ConfirmMovementSuccess) {
          mainVariables.generalVariables.railNavigateBackIndex = mainVariables.generalVariables.railNavigateIndex;
          mainVariables.generalVariables.railNavigateIndex = 0;
          context.read<RailNavigationBloc>().add(const RailNavigationSelectedWidgetEvent());
          mainWidgets.flushBarWidget(context: context, message: confirm.message);
          mainVariables.stockMovementVariables.stockMovementExit = false;
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: mainFunctions.getWidgetHeight(height: 20), horizontal: mainFunctions.getWidgetWidth(width: 20)),
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
        child: SingleChildScrollView(
          child: Screenshot(
            controller: screenshotController,
            child: Column(
              children: [
                Container(
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
                        height: mainFunctions.getWidgetHeight(height: 8),
                      ),
                      InkWell(
                        onTap: () {
                          mainVariables.confirmMovementVariables.loader = false;
                          mainVariables.generalVariables.railNavigateBackIndex = mainVariables.generalVariables.railNavigateIndex;
                          mainVariables.generalVariables.railNavigateIndex = 10;
                          context.read<RailNavigationBloc>().add(const RailNavigationSelectedWidgetEvent());
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: mainFunctions.getWidgetWidth(width: 20)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.arrow_back_ios,
                                  ),
                                  Text(
                                    "Stock movement",
                                    style: mainTextStyle.normalTextStyle.copyWith(color: mainColors.headingBlueColor, fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              tableExtension
                                  ? SizedBox(
                                      height: mainFunctions.getWidgetHeight(height: 45),
                                      child: Center(
                                        child: Text(
                                          "downloading, please wait ...",
                                          style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                                        ),
                                      ),
                                    )
                                  : IconButton(
                                      onPressed: () {
                                        setState(() {
                                          tableExtension = true;
                                        });
                                        Future.delayed(const Duration(milliseconds: 1500), () async {
                                          File path = await takeScreenshot();
                                          if (mounted) {
                                            final box = context.findRenderObject() as RenderBox?;
                                            await Share.shareXFiles(
                                              [XFile(path.path)],
                                              sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
                                            );
                                          }
                                        });
                                      },
                                      icon: const Icon(Icons.share),
                                    )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: mainFunctions.getWidgetHeight(height: 8),
                      ),
                      const Divider(
                        height: 0,
                        thickness: 1,
                        color: Color(0xffD0D0D0),
                      ),
                      SizedBox(
                        height: mainFunctions.getWidgetHeight(height: 20),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: mainFunctions.getWidgetWidth(width: 28)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                                child: Container(
                              height: mainFunctions.getWidgetHeight(height: 302),
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: mainFunctions.getWidgetHeight(height: 40),
                                    width: mainFunctions.getWidgetWidth(width: 600),
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15),
                                      ),
                                      color: Color(0xff0C3788),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        left: mainFunctions.getWidgetWidth(width: 15),
                                        top: mainFunctions.getWidgetHeight(height: 7),
                                      ),
                                      child: Text(
                                        "Sender Info",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: mainFunctions.getTextSize(fontSize: 17),
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: mainFunctions.getWidgetWidth(width: 10),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(
                                          height: mainFunctions.getWidgetHeight(height: 60),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                "Crew Name ",
                                                style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 14), fontWeight: FontWeight.w600, color: const Color(0xff111111)),
                                              ),
                                              SizedBox(
                                                height: mainFunctions.getWidgetHeight(height: 38),
                                                child: TextFormField(
                                                    style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 13), fontWeight: FontWeight.w600, color: const Color(0xff111111), overflow: TextOverflow.ellipsis),
                                                    maxLines: 1,
                                                    initialValue: mainVariables.stockMovementVariables.senderInfo.crewHandlerController.text,
                                                    readOnly: true,
                                                    decoration: InputDecoration(
                                                      fillColor: const Color(0xffF7F7F7),
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
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: mainFunctions.getWidgetHeight(height: 5),
                                        ),
                                        SizedBox(
                                          height: mainFunctions.getWidgetHeight(height: 60),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                "Location",
                                                style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 14), fontWeight: FontWeight.w600, color: const Color(0xff111111)),
                                              ),
                                              SizedBox(
                                                height: mainFunctions.getWidgetHeight(height: 38),
                                                child: TextFormField(
                                                    style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 13), fontWeight: FontWeight.w600, color: const Color(0xff111111), overflow: TextOverflow.ellipsis),
                                                    maxLines: 1,
                                                    initialValue: mainVariables.stockMovementVariables.senderInfo.senderLocationChoose.name,
                                                    readOnly: true,
                                                    decoration: InputDecoration(
                                                      fillColor: const Color(0xffF7F7F7),
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
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: mainFunctions.getWidgetHeight(height: 5),
                                        ),
                                        SizedBox(
                                          height: mainFunctions.getWidgetHeight(height: 60),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                "Stock Type",
                                                style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 14), fontWeight: FontWeight.w600, color: const Color(0xff111111)),
                                              ),
                                              SizedBox(
                                                height: mainFunctions.getWidgetHeight(height: 38),
                                                child: TextFormField(
                                                  style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 13), fontWeight: FontWeight.w600, color: const Color(0xff111111), overflow: TextOverflow.ellipsis),
                                                  maxLines: 1,
                                                  initialValue: mainVariables.stockMovementVariables.senderInfo.senderStockTypeChoose.name,
                                                  readOnly: true,
                                                  decoration: InputDecoration(
                                                    fillColor: const Color(0xffF7F7F7),
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
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: mainFunctions.getWidgetHeight(height: 5),
                                        ),
                                        SizedBox(
                                          height: mainFunctions.getWidgetHeight(height: 60),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      "From Sector ",
                                                      style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 12), fontWeight: FontWeight.w600, color: const Color(0xff111111)),
                                                    ),
                                                    SizedBox(
                                                      height: mainFunctions.getWidgetHeight(height: 38),
                                                      child: TextFormField(
                                                          style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 13), fontWeight: FontWeight.w600, color: const Color(0xff111111), overflow: TextOverflow.ellipsis),
                                                          maxLines: 1,
                                                          minLines: 1,
                                                          initialValue: mainVariables.stockMovementVariables.senderInfo.senderFromSectorChoose.name,
                                                          readOnly: true,
                                                          decoration: InputDecoration(
                                                            fillColor: const Color(0xffF7F7F7),
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
                                                          )),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: mainFunctions.getWidgetWidth(width: 16),
                                              ),
                                              Expanded(
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      "To Sector ",
                                                      style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 14), fontWeight: FontWeight.w600, color: const Color(0xff111111)),
                                                    ),
                                                    SizedBox(
                                                      height: mainFunctions.getWidgetHeight(height: 38),
                                                      child: TextFormField(
                                                          style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 13), fontWeight: FontWeight.w600, color: const Color(0xff111111), overflow: TextOverflow.ellipsis),
                                                          maxLines: 1,
                                                          minLines: 1,
                                                          initialValue: mainVariables.stockMovementVariables.senderInfo.senderToSectorChoose.name,
                                                          readOnly: true,
                                                          decoration: InputDecoration(
                                                            fillColor: const Color(0xffF7F7F7),
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
                                                          )),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )),
                            SizedBox(
                              width: mainFunctions.getWidgetWidth(width: 28),
                            ),
                            Expanded(
                                child: Container(
                              height: mainFunctions.getWidgetHeight(height: 302),
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: mainFunctions.getWidgetHeight(height: 40),
                                    width: mainFunctions.getWidgetWidth(width: 600),
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15),
                                      ),
                                      color: Color(0xff377DFF),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        left: mainFunctions.getWidgetWidth(width: 15),
                                        top: mainFunctions.getWidgetHeight(height: 8),
                                      ),
                                      child: Text(
                                        "Receiver Info",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: mainFunctions.getTextSize(fontSize: 17),
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: mainFunctions.getWidgetWidth(width: 10),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(
                                          height: mainFunctions.getWidgetHeight(height: 60),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                "Crew / Handler ",
                                                style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 14), fontWeight: FontWeight.w600, color: const Color(0xff111111)),
                                              ),
                                              SizedBox(
                                                height: mainFunctions.getWidgetHeight(height: 38),
                                                child: TextFormField(
                                                    initialValue: mainVariables.stockMovementVariables.sendData.receiverType,
                                                    style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 13), fontWeight: FontWeight.w600, color: const Color(0xff111111), overflow: TextOverflow.ellipsis),
                                                    maxLines: 1,
                                                    readOnly: true,
                                                    decoration: InputDecoration(
                                                      fillColor: const Color(0xffF7F7F7),
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
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: mainFunctions.getWidgetHeight(height: 5),
                                        ),
                                        SizedBox(
                                          height: mainFunctions.getWidgetHeight(height: 60),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                "Crew / Handler Name ",
                                                style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 14), fontWeight: FontWeight.w600, color: const Color(0xff111111)),
                                              ),
                                              SizedBox(
                                                height: mainFunctions.getWidgetHeight(height: 38),
                                                child: TextFormField(
                                                    style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 13), fontWeight: FontWeight.w600, color: const Color(0xff111111), overflow: TextOverflow.ellipsis),
                                                    maxLines: 1,
                                                    initialValue: mainVariables.stockMovementVariables.receiverInfo.receiverType == "Crew" ? mainVariables.stockMovementVariables.receiverInfo.crewChoose.name : mainVariables.stockMovementVariables.receiverInfo.handlerChoose.name,
                                                    readOnly: true,
                                                    decoration: InputDecoration(
                                                      fillColor: const Color(0xffF7F7F7),
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
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: mainFunctions.getWidgetHeight(height: 5),
                                        ),
                                        SizedBox(
                                          height: mainFunctions.getWidgetHeight(height: 60),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                "Stock type ",
                                                style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 14), fontWeight: FontWeight.w600, color: const Color(0xff111111)),
                                              ),
                                              SizedBox(
                                                height: mainFunctions.getWidgetHeight(height: 38),
                                                child: TextFormField(
                                                    style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 13), fontWeight: FontWeight.w600, color: const Color(0xff111111), overflow: TextOverflow.ellipsis),
                                                    maxLines: 1,
                                                    minLines: 1,
                                                    initialValue: mainVariables.stockMovementVariables.receiverInfo.receiverStockTypeChoose.name,
                                                    readOnly: true,
                                                    decoration: InputDecoration(
                                                      fillColor: const Color(0xffF7F7F7),
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
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: mainFunctions.getWidgetHeight(height: 5),
                                        ),
                                        SizedBox(
                                          height: mainFunctions.getWidgetHeight(height: 60),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                "Location",
                                                style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 14), fontWeight: FontWeight.w600, color: const Color(0xff111111)),
                                              ),
                                              SizedBox(
                                                height: mainFunctions.getWidgetHeight(height: 38),
                                                child: TextFormField(
                                                    style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 13), fontWeight: FontWeight.w600, color: const Color(0xff111111), overflow: TextOverflow.ellipsis),
                                                    maxLines: 1,
                                                    initialValue: mainVariables.stockMovementVariables.receiverInfo.receiverLocationChoose.name,
                                                    readOnly: true,
                                                    decoration: InputDecoration(
                                                      fillColor: const Color(0xffF7F7F7),
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
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: mainFunctions.getWidgetHeight(height: 10),
                      ),
                      mainVariables.stockMovementVariables.sendData.receiverType == "Crew"
                          ? const SizedBox()
                          : Container(
                              height: mainFunctions.getWidgetHeight(height: 152),
                              margin: EdgeInsets.symmetric(horizontal: mainFunctions.getWidgetWidth(width: 28)),
                              padding: EdgeInsets.symmetric(horizontal: mainFunctions.getWidgetWidth(width: 10)),
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
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(
                                          height: mainFunctions.getWidgetHeight(height: 60),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                "Handler's Name",
                                                style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 14), fontWeight: FontWeight.w600, color: const Color(0xff111111)),
                                              ),
                                              SizedBox(
                                                height: mainFunctions.getWidgetHeight(height: 38),
                                                child: TextFormField(
                                                  controller: mainVariables.confirmMovementVariables.senderInfo.handlerNameController,
                                                  style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 13), fontWeight: FontWeight.w600, color: const Color(0xff111111), overflow: TextOverflow.ellipsis),
                                                  maxLines: 1,
                                                  decoration: InputDecoration(
                                                    fillColor: const Color(0xffFFFFFF),
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
                                                    hintText: "Enter handler’s name",
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
                                        SizedBox(
                                          height: mainFunctions.getWidgetHeight(height: 5),
                                        ),
                                        SizedBox(
                                          height: mainFunctions.getWidgetHeight(height: 60),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                "Handler's Contact Number",
                                                style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 14), fontWeight: FontWeight.w600, color: const Color(0xff111111)),
                                              ),
                                              SizedBox(
                                                height: mainFunctions.getWidgetHeight(height: 38),
                                                child: TextFormField(
                                                  controller: mainVariables.confirmMovementVariables.senderInfo.handlerNumberController,
                                                  keyboardType: TextInputType.number,
                                                  style: TextStyle(
                                                    fontSize: mainFunctions.getTextSize(fontSize: 13),
                                                    fontWeight: FontWeight.w600,
                                                    color: const Color(0xff111111),
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                  maxLines: 1,
                                                  decoration: InputDecoration(
                                                    fillColor: const Color(0xffFFFFFF),
                                                    filled: true,
                                                    contentPadding: EdgeInsets.only(left: mainFunctions.getWidgetWidth(width: 12)),
                                                    border: OutlineInputBorder(
                                                      borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                                                      borderRadius: BorderRadius.circular(12),
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                      borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                                                      borderRadius: BorderRadius.circular(12),
                                                    ),
                                                    enabledBorder: OutlineInputBorder(
                                                      borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                                                      borderRadius: BorderRadius.circular(12),
                                                    ),
                                                    disabledBorder: OutlineInputBorder(
                                                      borderSide: const BorderSide(color: Color(0xffD7D5E2), width: 1),
                                                      borderRadius: BorderRadius.circular(12),
                                                    ),
                                                    hintText: "Enter handler’s contact number",
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
                                        SizedBox(
                                          height: mainFunctions.getWidgetHeight(height: 5),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: mainFunctions.getWidgetWidth(width: 28),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: mainFunctions.getWidgetHeight(height: 12)),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Handler Sign",
                                                  style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 13), fontWeight: FontWeight.w600, color: const Color(0xff111111)),
                                                ),
                                                Stack(
                                                  alignment: Alignment.topRight,
                                                  children: [
                                                    DottedBorder(
                                                      borderType: BorderType.RRect,
                                                      radius: const Radius.circular(12),
                                                      padding: const EdgeInsets.all(5),
                                                      child: bytes != null
                                                          ? SizedBox(
                                                              width: mainVariables.generalVariables.width <= 650 ? mainFunctions.getWidgetWidth(width: 74) : mainFunctions.getWidgetWidth(width: 100),
                                                              height: mainFunctions.getWidgetHeight(height: 95),
                                                              child: Image.memory(
                                                                bytes!.buffer.asUint8List(),
                                                                fit: BoxFit.fill,
                                                              ),
                                                            )
                                                          : InkWell(
                                                              onTap: () {
                                                                mainWidgets.showAnimatedDialog(
                                                                  context: context,
                                                                  height: 357,
                                                                  width: 560,
                                                                  child: dialogContent(handler: true),
                                                                );
                                                              },
                                                              child: Container(
                                                                width: mainVariables.generalVariables.width <= 650 ? mainFunctions.getWidgetWidth(width: 74) : mainFunctions.getWidgetWidth(width: 100),
                                                                height: mainFunctions.getWidgetHeight(height: 95),
                                                                decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(15),
                                                                ),
                                                                child: Center(
                                                                    child: Column(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                                  mainAxisSize: MainAxisSize.min,
                                                                  children: [
                                                                    Image.asset(
                                                                      "assets/home/sign.png",
                                                                      height: mainFunctions.getWidgetHeight(height: 24),
                                                                      width: mainFunctions.getWidgetWidth(width: 24),
                                                                    ),
                                                                    Text(
                                                                      "Tap here",
                                                                      style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 10), fontWeight: FontWeight.w400, color: const Color(0xff393939)),
                                                                    ),
                                                                  ],
                                                                )),
                                                              ),
                                                            ),
                                                    ),
                                                    bytes != null
                                                        ? InkWell(
                                                            onTap: () {
                                                              setState(() {
                                                                bytes = null;
                                                                isSigned = false;
                                                              });
                                                            },
                                                            child: const Icon(Icons.remove_circle))
                                                        : const SizedBox()
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: mainFunctions.getWidgetWidth(width: 10),
                                          ),
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Crew Sign",
                                                  style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 13), fontWeight: FontWeight.w600, color: const Color(0xff111111)),
                                                ),
                                                Stack(
                                                  alignment: Alignment.topRight,
                                                  children: [
                                                    DottedBorder(
                                                      borderType: BorderType.RRect,
                                                      radius: const Radius.circular(12),
                                                      padding: const EdgeInsets.all(5),
                                                      child: bytes2 != null
                                                          ? SizedBox(
                                                              width: mainVariables.generalVariables.width <= 650 ? mainFunctions.getWidgetWidth(width: 74) : mainFunctions.getWidgetWidth(width: 100),
                                                              height: mainFunctions.getWidgetHeight(height: 95),
                                                              child: Image.memory(
                                                                bytes2!.buffer.asUint8List(),
                                                                fit: BoxFit.fill,
                                                              ),
                                                            )
                                                          : InkWell(
                                                              onTap: () {
                                                                mainWidgets.showAnimatedDialog(
                                                                  context: context,
                                                                  height: 357,
                                                                  width: 560,
                                                                  child: dialogContent(handler: false),
                                                                );
                                                              },
                                                              child: Container(
                                                                width: mainVariables.generalVariables.width <= 650 ? mainFunctions.getWidgetWidth(width: 74) : mainFunctions.getWidgetWidth(width: 100),
                                                                height: mainFunctions.getWidgetHeight(height: 95),
                                                                decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(15),
                                                                ),
                                                                child: Center(
                                                                  child: Column(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                                    mainAxisSize: MainAxisSize.min,
                                                                    children: [
                                                                      Image.asset(
                                                                        "assets/home/sign.png",
                                                                        height: mainFunctions.getWidgetHeight(height: 24),
                                                                        width: mainFunctions.getWidgetWidth(width: 24),
                                                                      ),
                                                                      Text(
                                                                        "Tap here",
                                                                        style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 10), fontWeight: FontWeight.w400, color: const Color(0xff393939)),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                    ),
                                                    bytes2 != null
                                                        ? InkWell(
                                                            onTap: () {
                                                              setState(() {
                                                                bytes2 = null;
                                                                isSigned = false;
                                                              });
                                                            },
                                                            child: const Icon(Icons.remove_circle))
                                                        : const SizedBox()
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                    ],
                  ),
                ),
                SizedBox(
                  height: mainFunctions.getWidgetHeight(height: 8),
                ),
                Container(
                  height: mainFunctions.getWidgetHeight(
                      height: (((tableExtension
                                      ? mainVariables.confirmMovementVariables.stockMovementInventory.tableData.length < 3
                                          ? 2.75
                                          : mainVariables.confirmMovementVariables.stockMovementInventory.tableData.length
                                      : mainVariables.stockMovementVariables.sendData.receiverType == "Crew"
                                          ? 8.5
                                          : 4.5) +
                                  1) *
                              40) +
                          76),
                  padding: EdgeInsets.symmetric(
                    horizontal: mainFunctions.getWidgetHeight(height: 12),
                    vertical: mainFunctions.getWidgetWidth(width: 12),
                  ),
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
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "Total Products : $totalProducts | Total Qty : $totalQuantity",
                              style: TextStyle(
                                fontSize: mainFunctions.getTextSize(fontSize: 15),
                                color: const Color(0xff111111),
                                fontWeight: FontWeight.w600,
                              ),
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
                        height: mainFunctions.getWidgetHeight(
                            height: (((tableExtension
                                        ? mainVariables.confirmMovementVariables.stockMovementInventory.tableData.length < 3
                                            ? 2.75
                                            : mainVariables.confirmMovementVariables.stockMovementInventory.tableData.length
                                        : mainVariables.stockMovementVariables.sendData.receiverType == "Crew"
                                            ? 8.5
                                            : 4.5) +
                                    1) *
                                40)),
                        child: StickyHeadersTable(
                          columnsLength: mainVariables.confirmMovementVariables.stockMovementInventory.tableHeading.length,
                          rowsLength: mainVariables.confirmMovementVariables.stockMovementInventory.tableData.length,
                          showHorizontalScrollbar: false,
                          showVerticalScrollbar: false,
                          columnsTitleBuilder: (int columnIndex) {
                            return Center(
                              child: Text(
                                mainVariables.confirmMovementVariables.stockMovementInventory.tableHeading[columnIndex],
                                maxLines: 2,
                                style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 12), overflow: TextOverflow.ellipsis, fontWeight: FontWeight.w600),
                                textAlign: TextAlign.center,
                              ),
                            );
                          },
                          rowsTitleBuilder: (int rowIndex) {
                            return Center(
                              child: Text(
                                (rowIndex + 1) < 10 ? "0${rowIndex + 1}" : "${rowIndex + 1}",
                                maxLines: 2,
                                style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 12), overflow: TextOverflow.ellipsis, fontWeight: FontWeight.normal),
                              ),
                            );
                          },
                          contentCellBuilder: (int columnIndex, int rowIndex) {
                            return columnIndex == 0
                                ? const SizedBox()
                                : columnIndex == 6
                                    ? Center(
                                        child: Text(
                                          mainVariables.confirmMovementVariables.stockMovementInventory.tableData[rowIndex][columnIndex + 1],
                                          maxLines: 2,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 12), overflow: TextOverflow.ellipsis, fontWeight: FontWeight.normal),
                                        ),
                                      )
                                    : Center(
                                        child: Text(
                                          mainVariables.confirmMovementVariables.stockMovementInventory.tableData[rowIndex][columnIndex],
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
                                      mainFunctions.getWidgetWidth(width: 0),
                                      mainFunctions.getWidgetWidth(width: 140),
                                      mainFunctions.getWidgetWidth(width: 140),
                                      mainFunctions.getWidgetWidth(width: 130),
                                      mainFunctions.getWidgetWidth(width: 130),
                                      mainFunctions.getWidgetWidth(width: 80),
                                    ]
                                  : [
                                      mainFunctions.getWidgetHeight(height: 0),
                                      mainFunctions.getWidgetHeight(height: 0),
                                      mainFunctions.getWidgetHeight(height: 190),
                                      mainFunctions.getWidgetHeight(height: 190),
                                      mainFunctions.getWidgetHeight(height: 190),
                                      mainFunctions.getWidgetHeight(height: 190),
                                      mainFunctions.getWidgetHeight(height: 140),
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
                  height: mainFunctions.getWidgetHeight(height: 15),
                ),
                SizedBox(
                  height: mainFunctions.getWidgetHeight(height: 106),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: mainFunctions.getWidgetHeight(height: 12), vertical: mainFunctions.getWidgetWidth(width: 12)),
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
                      children: [
                        SizedBox(
                          height: mainFunctions.getWidgetHeight(height: 24),
                          child: Text(
                            "Remarks",
                            style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 20), color: const Color(0xff0C3788), fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(
                          height: mainFunctions.getWidgetHeight(height: 8),
                        ),
                        SizedBox(
                          height: mainFunctions.getWidgetHeight(height: 50),
                          child: TextFormField(
                            style: TextStyle(fontSize: mainFunctions.getTextSize(fontSize: 13), fontWeight: FontWeight.w600, color: const Color(0xff111111), overflow: TextOverflow.ellipsis),
                            maxLines: 1,
                            controller: mainVariables.confirmMovementVariables.searchBar,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                              fillColor: const Color(0xffFFFFFF),
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
                ),
                SizedBox(
                  height: mainFunctions.getWidgetHeight(height: 15),
                ),
                LoadingButton(
                  status: mainVariables.confirmMovementVariables.loader,
                  height: 42,
                  onTap: () {
                    setState(() {
                      mainVariables.confirmMovementVariables.loader = true;
                    });
                    mainVariables.stockMovementVariables.sendData.handlerName = mainVariables.confirmMovementVariables.senderInfo.handlerNameController.text;
                    mainVariables.stockMovementVariables.sendData.handlerPhoneNo = mainVariables.confirmMovementVariables.senderInfo.handlerNumberController.text;
                    mainVariables.stockMovementVariables.sendData.handlerSignature = imageEncoded ?? "";
                    mainVariables.stockMovementVariables.sendData.crewSignature = imageEncoded2 ?? "";
                    mainVariables.stockMovementVariables.sendData.remarks = mainVariables.confirmMovementVariables.searchBar.text;
                    context.read<ConfirmMovementBloc>().add(ConfirmMovementCreateEvent(modelSetState: setState));
                  },
                  text: 'Send',
                  fontSize: 16,
                  width: mainFunctions.getWidgetWidth(width: 132),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget dialogContent({required bool handler}) {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter modelSetState) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: mainFunctions.getWidgetWidth(width: 20),
            vertical: mainFunctions.getWidgetHeight(height: 20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "collect signature",
                style: TextStyle(
                  fontSize: mainFunctions.getTextSize(fontSize: 14),
                  color: const Color(0xff111111),
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: mainFunctions.getWidgetHeight(height: 11),
              ),
              Container(
                height: mainFunctions.getWidgetHeight(height: 233),
                width: mainFunctions.getWidgetWidth(width: 1132),
                decoration: const BoxDecoration(boxShadow: [BoxShadow(blurRadius: 4.0, spreadRadius: 0.0, color: Color(0xffDCE2E8))]),
                child: SfSignaturePad(key: signaturePadKey, onDraw: (offset, date) => onDraw(modelSet: modelSetState), strokeColor: mainColors.blackColor, backgroundColor: Colors.white, minimumStrokeWidth: 1.0, maximumStrokeWidth: 4.0),
              ),
              SizedBox(
                height: mainFunctions.getWidgetHeight(height: 8),
              ),
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isSigned ? const Color(0xffF1F6FF) : Colors.grey.shade200,
                      elevation: 0.0,
                      splashFactory: NoSplash.splashFactory,
                      shadowColor: Colors.transparent,
                    ),
                    onPressed: isSigned
                        ? () {
                            signaturePadKey.currentState!.clear();
                            modelSetState(() {
                              isSigned = false;
                            });
                          }
                        : () {},
                    child: Text(
                      "Clear",
                      style: TextStyle(color: isSigned ? const Color(0xff0C3788) : Colors.white),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffFFFFFF),
                          elevation: 0.0,
                          splashFactory: NoSplash.splashFactory,
                          shadowColor: Colors.transparent,
                        ),
                        onPressed: () {
                          setState(() {
                            isSigned = false;
                          });
                          signaturePadKey.currentState!.clear();
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Cancel",
                          style: TextStyle(color: Color(0xff0C3788)),
                        ),
                      ),
                      SizedBox(
                        width: mainFunctions.getWidgetWidth(
                          width: 10,
                        ),
                      ),
                      InkWell(
                        splashFactory: NoSplash.splashFactory,
                        splashColor: Colors.transparent,
                        radius: 0,
                        onTap: isSigned
                            ? () async {
                                Navigator.pop(context);
                                await validatingSignature(handler: handler);
                              }
                            : () {},
                        child: Container(
                          width: mainFunctions.getWidgetHeight(height: 75),
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: mainFunctions.getWidgetWidth(width: 5), vertical: mainFunctions.getWidgetHeight(height: 5)),
                          margin: EdgeInsets.symmetric(vertical: mainFunctions.getWidgetHeight(height: 2)),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  isSigned ? const Color(0XFF0C3788) : Colors.grey.shade200,
                                  isSigned ? const Color(0XFFBC0044) : Colors.grey.shade200,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(15)),
                          child: Text("Save", textAlign: TextAlign.center, style: TextStyle(color: const Color(0xffffffff), fontSize: mainFunctions.getTextSize(fontSize: 14), fontWeight: FontWeight.w600)),
                        ),
                      )
                    ],
                  ),
                ],
              )),
              SizedBox(
                height: mainFunctions.getWidgetHeight(height: 8),
              ),
            ],
          ),
        );
      },
    );
  }
}
