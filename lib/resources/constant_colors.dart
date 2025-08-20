import 'package:flutter/material.dart';
import 'package:tvsaviation/resources/constants.dart';

class ConstantColors {
  Color headingBlueColor = const Color(0xFF0C3788);
  Color normalTextColor = const Color(0xFF303030);
  Color normalLabelColor = const Color(0xFF111111);
  Color smallTextColor = const Color(0xFF0C3788);
  Color whiteColor = const Color(0xFFFFFFFF);
  Color blackColor = const Color(0xFF000000);
  Color transparentColor = Colors.transparent;
}

class ConstantTextStyle {
  TextStyle headingBlueTextStyle = TextStyle(
    fontSize: mainFunctions.getTextSize(fontSize: 28),
    fontWeight: FontWeight.w600,
  );
  TextStyle normalTextStyle = TextStyle(
    fontSize: mainFunctions.getTextSize(fontSize: 22),
    fontWeight: FontWeight.w500,
  );
  TextStyle drawerHeaderTextStyle = TextStyle(
    fontSize: mainFunctions.getTextSize(fontSize: 18),
    fontWeight: FontWeight.w600,
    color: mainColors.whiteColor,
  );
  TextStyle drawerLabelTextStyle = TextStyle(
    fontSize: mainFunctions.getTextSize(fontSize: 14),
    fontWeight: FontWeight.w500,
    color: mainColors.whiteColor,
  );
  TextStyle smallTextStyle = TextStyle(
    fontSize: mainFunctions.getTextSize(fontSize: 16),
    fontWeight: FontWeight.w600,
  );
  TextStyle labelTextStyle = TextStyle(
    fontSize: mainFunctions.getTextSize(fontSize: 12),
    fontWeight: FontWeight.w500,
    color: mainColors.whiteColor,
  );
}
