import 'dart:io';

import 'package:barcode_scan2/model/scan_options.dart';
import 'package:barcode_scan2/platform_wrapper.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tvsaviation/data/hive/category/category_data.dart';
import 'package:tvsaviation/data/hive/crew/crew_data.dart';
import 'package:tvsaviation/data/hive/handler/handler_data.dart';
import 'package:tvsaviation/data/hive/location/location_data.dart';
import 'package:tvsaviation/data/hive/sector/sector_data.dart';
import 'package:tvsaviation/data/hive/stock_type/stock_type_data.dart';
import 'package:tvsaviation/resources/constants.dart';

class Functions {
  double getWidgetHeight({required double height}) {
    double variableHeightValue = 1112 / height;
    return mainVariables.generalVariables.height / variableHeightValue;
  }

  double getWidgetWidth({required double width}) {
    double variableWidthValue = 834 / width;
    return mainVariables.generalVariables.width / variableWidthValue;
  }

  double getTextSize({required double fontSize}) {
    return mainVariables.generalVariables.text!.scale(fontSize);
  }

  String dateTimeFormat({required String date}) {
    try {
      DateTime dateTime = DateTime.parse(date);
      DateFormat dateFormat = DateFormat("dd-MM-yyyy HH:mm");
      String formattedDate = dateFormat.format(dateTime.toLocal());
      return formattedDate;
    } catch (e) {
      return date;
    }
  }

  String dateFormat({required String date}) {
    try {
      DateTime dateTime = DateTime.parse(date);
      DateFormat dateFormat = DateFormat("dd-MM-yyyy");
      String formattedDate = dateFormat.format(dateTime.toLocal());
      return formattedDate;
    } catch (e) {
      return date;
    }
  }

  String dateTimeFormatFileName({required String date}) {
    try {
      DateTime dateTime = DateTime.parse(date);
      DateFormat dateFormat = DateFormat("dd_MM_yyyy_HH_mm_ss");
      String formattedDate = dateFormat.format(dateTime.toLocal());
      return formattedDate;
    } catch (e) {
      return date;
    }
  }

  String timeFormat({required String date}) {
    try {
      DateTime dateTime = DateTime.parse(date);
      DateFormat dateFormat = DateFormat("hh:mm a");
      String formattedDate = dateFormat.format(dateTime.toLocal());
      return formattedDate;
    } catch (e) {
      return date;
    }
  }

  Future<String> barCodeScan({required BuildContext context}) async {
    if (Platform.isIOS) {
      var status = await Permission.camera.status;
      if (status.isDenied) {
        await Permission.camera.request();
        var status = await Permission.camera.status;
        if (status.isGranted) {
          var options = const ScanOptions();
          var result = await BarcodeScanner.scan(options: options);
          if (kDebugMode) {}
          return result.rawContent;
        } else {
          mainWidgets.showAnimatedDialog(
            context: context,
            height: 170,
            width: 460,
            child: mainWidgets.dialogContent(context: context, type: "camera"),
          );
          // openAppSettings();
          return "";
        }
      } else if (status.isGranted) {
        var options = const ScanOptions();
        var result = await BarcodeScanner.scan(options: options);
        if (kDebugMode) {
          print("result : $result");
        }
        return result.rawContent;
      } else if (status.isPermanentlyDenied) {
        mainWidgets.showAnimatedDialog(
          context: context,
          height: 170,
          width: 460,
          child: mainWidgets.dialogContent(context: context, type: "camera"),
        );
        // openAppSettings();
        return "";
      } else {
        mainWidgets.showAnimatedDialog(
          context: context,
          height: 170,
          width: 460,
          child: mainWidgets.dialogContent(context: context, type: "camera"),
        );
        //openAppSettings();
        return "";
      }
    } else {
      var status = await Permission.camera.status;
      if (status.isDenied) {
        await Permission.camera.request();
        var status = await Permission.camera.status;
        if (status.isGranted) {
          var options = const ScanOptions();
          var result = await BarcodeScanner.scan(options: options);
          if (kDebugMode) {
            print("result : $result");
          }
          return result.rawContent;
        } else {
          mainWidgets.showAnimatedDialog(
            context: context,
            height: 170,
            width: 460,
            child: mainWidgets.dialogContent(context: context, type: "camera"),
          );
          // openAppSettings();
          return "";
        }
      } else if (status.isGranted) {
        var options = const ScanOptions();
        var result = await BarcodeScanner.scan(options: options);
        if (kDebugMode) {}
        return result.rawContent;
      } else if (status.isPermanentlyDenied) {
        mainWidgets.showAnimatedDialog(
          context: context,
          height: 170,
          width: 460,
          child: mainWidgets.dialogContent(context: context, type: "camera"),
        );
        //  openAppSettings();
        return "";
      } else {
        mainWidgets.showAnimatedDialog(
          context: context,
          height: 170,
          width: 460,
          child: mainWidgets.dialogContent(context: context, type: "camera"),
        );
        //openAppSettings();
        return "";
      }
    }
  }

  Future<String> pickFiles({required bool isPdf, required BuildContext context}) async {
    FilePickerResult? result;
    var status = await Permission.storage.status;
    if (status.isDenied) {
      await Permission.storage.request();
      var status = await Permission.storage.status;
      if (status.isGranted) {
        result = await FilePicker.platform.pickFiles(
          allowedExtensions: isPdf ? ['pdf'] : ['csv'],
          type: FileType.custom,
          withData: true,
        );
        if (result == null) {
          return "";
        } else {
          return result.files.single.path ?? "";
        }
      } else {
        //openAppSettings();
        mainWidgets.showAnimatedDialog(
          context: context,
          height: 352,
          width: 460,
          child: mainWidgets.dialogContent(context: context, type: "files"),
        );
        return "";
      }
    } else if (status.isGranted) {
      result = await FilePicker.platform.pickFiles(
        allowedExtensions: isPdf ? ['pdf'] : ['csv'],
        type: FileType.custom,
        withData: true,
      );
      if (result == null) {
        return "";
      } else {
        return result.files.single.path ?? "";
      }
    } else if (status.isPermanentlyDenied) {
      //openAppSettings();
      mainWidgets.showAnimatedDialog(
        context: context,
        height: 352,
        width: 460,
        child: mainWidgets.dialogContent(context: context, type: "files"),
      );
      return "";
    } else {
      //openAppSettings();
      mainWidgets.showAnimatedDialog(
        context: context,
        height: 352,
        width: 460,
        child: mainWidgets.dialogContent(context: context, type: "files"),
      );
      return "";
    }
  }

  Future<XFile?> galleryImage({required BuildContext context}) async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      PermissionStatus status = await Permission.storage.status;
      if (status.isDenied) {
        await Permission.storage.request();
        var status = await Permission.storage.status;
        if (status.isGranted) {
          XFile? image = await ImagePicker().pickImage(
            source: ImageSource.gallery,
            maxWidth: 1800,
            maxHeight: 1800,
          );
          return image;
        } else {
          // openAppSettings();
          /* mainWidgets.showAnimatedDialog(
            context: context,
            height: 352,
            width: 460,
            child: mainWidgets.dialogContent(context: context, type: "gallery"),
          );*/
          return null;
        }
      } else if (status.isGranted) {
        XFile? image = await ImagePicker().pickImage(
          source: ImageSource.gallery,
          maxWidth: 1800,
          maxHeight: 1800,
        );
        return image;
      } else if (status.isPermanentlyDenied) {
        //  openAppSettings();
        /*mainWidgets.showAnimatedDialog(
          context: context,
          height: 352,
          width: 460,
          child: mainWidgets.dialogContent(context: context, type: "gallery"),
        );*/
        return null;
      } else {
        // openAppSettings();
        /*mainWidgets.showAnimatedDialog(
          context: context,
          height: 352,
          width: 460,
          child: mainWidgets.dialogContent(context: context, type: "gallery"),
        );*/
        return null;
      }
    } else {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      if (androidInfo.version.sdkInt >= 33) {
        PermissionStatus status = await Permission.photos.status;
        if (status.isDenied) {
          await Permission.photos.request();
          var status = await Permission.photos.status;
          if (status.isGranted) {
            XFile? image = await ImagePicker().pickImage(
              source: ImageSource.gallery,
              maxWidth: 1800,
              maxHeight: 1800,
            );
            return image;
          } else {
            /*mainWidgets.showAnimatedDialog(
              context: context,
              height: 352,
              width: 460,
              child: mainWidgets.dialogContent(context: context, type: "gallery"),
            );*/
            // openAppSettings();
            return null;
          }
        } else if (status.isGranted) {
          XFile? image = await ImagePicker().pickImage(
            source: ImageSource.gallery,
            maxWidth: 1800,
            maxHeight: 1800,
          );
          return image;
        } else if (status.isPermanentlyDenied) {
          /* mainWidgets.showAnimatedDialog(
            context: context,
            height: 352,
            width: 460,
            child: mainWidgets.dialogContent(context: context, type: "gallery"),
          );*/
          // openAppSettings();
          return null;
        } else {
          /*mainWidgets.showAnimatedDialog(
            context: context,
            height: 352,
            width: 460,
            child: mainWidgets.dialogContent(context: context, type: "gallery"),
          );*/
          //openAppSettings();
          return null;
        }
      } else {
        PermissionStatus status = await Permission.storage.status;
        if (status.isDenied) {
          await Permission.storage.request();
          var status = await Permission.storage.status;
          if (status.isGranted) {
            XFile? image = await ImagePicker().pickImage(
              source: ImageSource.gallery,
              maxWidth: 1800,
              maxHeight: 1800,
            );
            return image;
          } else {
            /*mainWidgets.showAnimatedDialog(
              context: context,
              height: 352,
              width: 460,
              child: mainWidgets.dialogContent(context: context, type: "gallery"),
            );*/
            // openAppSettings();
            return null;
          }
        } else if (status.isGranted) {
          XFile? image = await ImagePicker().pickImage(
            source: ImageSource.gallery,
            maxWidth: 1800,
            maxHeight: 1800,
          );
          return image;
        } else if (status.isPermanentlyDenied) {
          /*mainWidgets.showAnimatedDialog(
            context: context,
            height: 352,
            width: 460,
            child: mainWidgets.dialogContent(context: context, type: "gallery"),
          );*/
          // openAppSettings();
          return null;
        } else {
          /*mainWidgets.showAnimatedDialog(
            context: context,
            height: 352,
            width: 460,
            child: mainWidgets.dialogContent(context: context, type: "gallery"),
          );*/
          //openAppSettings();
          return null;
        }
      }
    }
  }

  Future<XFile?> cameraImage({required BuildContext context}) async {
    if (Platform.isIOS) {
      var status = await Permission.camera.status;
      if (status.isDenied) {
        await Permission.camera.request();
        var status = await Permission.camera.status;
        if (status.isGranted) {
          XFile? image = await ImagePicker().pickImage(
            source: ImageSource.camera,
            maxWidth: 1800,
            maxHeight: 1800,
          );
          return image;
        } else {
          mainWidgets.showAnimatedDialog(
            context: context,
            height: 352,
            width: 460,
            child: mainWidgets.dialogContent(context: context, type: "camera"),
          );
          // openAppSettings();
          return null;
        }
      } else if (status.isGranted) {
        final image = await ImagePicker().pickImage(
          source: ImageSource.camera,
          maxWidth: 1800,
          maxHeight: 1800,
        );
        return image;
      } else if (status.isPermanentlyDenied) {
        mainWidgets.showAnimatedDialog(
          context: context,
          height: 352,
          width: 460,
          child: mainWidgets.dialogContent(context: context, type: "camera"),
        );
        // openAppSettings();
        return null;
      } else {
        mainWidgets.showAnimatedDialog(
          context: context,
          height: 352,
          width: 460,
          child: mainWidgets.dialogContent(context: context, type: "camera"),
        );
        //openAppSettings();
        return null;
      }
    } else {
      var status = await Permission.camera.status;
      if (status.isDenied) {
        await Permission.camera.request();
        var status = await Permission.camera.status;
        if (status.isGranted) {
          XFile? image = await ImagePicker().pickImage(
            source: ImageSource.camera,
            maxWidth: 1800,
            maxHeight: 1800,
          );
          return image;
        } else {
          mainWidgets.showAnimatedDialog(
            context: context,
            height: 352,
            width: 460,
            child: mainWidgets.dialogContent(context: context, type: "camera"),
          );
          // openAppSettings();
          return null;
        }
      } else if (status.isGranted) {
        final image = await ImagePicker().pickImage(
          source: ImageSource.camera,
          maxWidth: 1800,
          maxHeight: 1800,
        );
        return image;
      } else if (status.isPermanentlyDenied) {
        mainWidgets.showAnimatedDialog(
          context: context,
          height: 352,
          width: 460,
          child: mainWidgets.dialogContent(context: context, type: "camera"),
        );
        //  openAppSettings();
        return null;
      } else {
        mainWidgets.showAnimatedDialog(
          context: context,
          height: 352,
          width: 460,
          child: mainWidgets.dialogContent(context: context, type: "camera"),
        );
        //openAppSettings();
        return null;
      }
    }
  }

  Future<void> clearHiveData({required BuildContext context}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await mainVariables.repoImpl.getLogout().onError((error, stackTrace) {
      mainWidgets.flushBarWidget(context: context, message: error.toString());
    }).then((value) async {});
    var box = await Hive.openBox('boxData');
    var locationBox = await Hive.openBox<LocationResponse>('locations');
    var stockTypeBox = await Hive.openBox<StockTypeResponse>('stockType');
    var categoryBox = await Hive.openBox<CategoryResponse>('category');
    var crewBox = await Hive.openBox<CrewResponse>('crew');
    var sectorBox = await Hive.openBox<SectorResponse>('sector');
    var handlerBox = await Hive.openBox<HandlerResponse>('handler');
    await box.clear();
    await locationBox.clear();
    await stockTypeBox.clear();
    await categoryBox.clear();
    await crewBox.clear();
    await sectorBox.clear();
    await handlerBox.clear();
    await prefs.remove('dialog_time');
    await prefs.clear();
    mainVariables.generalVariables.userToken = "";
  }

  countFiltersTransit() {
    int count = 0;
    if (mainVariables.transitVariables.locationSelectEnabledList.contains(true)) {
      if (mainVariables.transitVariables.locationSelectEnabledList.contains(false)) {
        for (var element in mainVariables.transitVariables.locationSelectEnabledList) {
          if (element) {
            count++;
          }
        }
      } else {
        count = -1;
      }
    } else {
      count = 0;
    }
    if (count == -1) {
      if (mainVariables.transitVariables.filterController.text != "") {
        mainVariables.transitVariables.selectedCount.value = "All";
      } else {
        mainVariables.transitVariables.selectedCount.value = mainVariables.transitVariables.locationSelectEnabledList.length.toString();
      }
    } else if (count == 0) {
      if (mainVariables.transitVariables.filterController.text != "") {
        mainVariables.transitVariables.selectedCount.value = "1";
      } else {
        mainVariables.transitVariables.selectedCount.value = "None";
      }
    } else {
      if (mainVariables.transitVariables.filterController.text != "") {
        mainVariables.transitVariables.selectedCount.value = "${count + 1}";
      } else {
        mainVariables.transitVariables.selectedCount.value = "$count";
      }
    }
  }

  countFilters() {
    int count = 0;
    if (mainVariables.reportsVariables.locationSelectEnabledList.contains(true)) {
      if (mainVariables.reportsVariables.locationSelectEnabledList.contains(false)) {
        for (var element in mainVariables.reportsVariables.locationSelectEnabledList) {
          if (element) {
            count++;
          }
        }
      } else {
        count = -1;
      }
    } else {
      count = 0;
    }
    if (count == -1) {
      if (mainVariables.reportsVariables.filterController.text != "") {
        mainVariables.reportsVariables.selectedCount.value = "All";
      } else {
        mainVariables.reportsVariables.selectedCount.value = mainVariables.reportsVariables.locationSelectEnabledList.length.toString();
      }
    } else if (count == 0) {
      if (mainVariables.reportsVariables.filterController.text != "") {
        mainVariables.reportsVariables.selectedCount.value = "1";
      } else {
        mainVariables.reportsVariables.selectedCount.value = "None";
      }
    } else {
      if (mainVariables.reportsVariables.filterController.text != "") {
        mainVariables.reportsVariables.selectedCount.value = "${count + 1}";
      } else {
        mainVariables.reportsVariables.selectedCount.value = "$count";
      }
    }
  }

  Future<Directory?> getDownloadsDirectory() async {
    if (Platform.isAndroid) {
      return Directory('/storage/emulated/0/Download');
    } else {
      Directory documentsDir = await getApplicationDocumentsDirectory();
      String documentsPath = documentsDir.path;
      Directory folderDir = Directory('$documentsPath/TVS_Reports');
      if (!await folderDir.exists()) {
        await folderDir.create(recursive: true);
      }
      return folderDir;
    }
  }

  unFocusOverLayEntryFunction() {
    if (mainVariables.manageVariables.addInventory.locationControllerFocusNode.hasFocus) {
      mainVariables.manageVariables.addInventory.locationControllerFocusNode.unfocus();
    }
    if (mainVariables.manageVariables.addInventory.productBrandControllerFocusNode.hasFocus) {
      mainVariables.manageVariables.addInventory.productBrandControllerFocusNode.unfocus();
    }
    if (mainVariables.manageVariables.addInventory.stockTypeControllerFocusNode.hasFocus) {
      mainVariables.manageVariables.addInventory.stockTypeControllerFocusNode.unfocus();
    }
    if (mainVariables.manageVariables.addProduct.brandControllerFocusNode.hasFocus) {
      mainVariables.manageVariables.addProduct.brandControllerFocusNode.unfocus();
    }
    if (mainVariables.manageVariables.addProduct.categoryControllerFocusNode.hasFocus) {
      mainVariables.manageVariables.addProduct.categoryControllerFocusNode.unfocus();
    }
    if (mainVariables.manageVariables.addProduct.brandEditControllerFocusNode.hasFocus) {
      mainVariables.manageVariables.addProduct.brandEditControllerFocusNode.unfocus();
    }
    if (mainVariables.manageVariables.addProduct.categoryEditControllerFocusNode.hasFocus) {
      mainVariables.manageVariables.addProduct.categoryEditControllerFocusNode.unfocus();
    }
  }
}
