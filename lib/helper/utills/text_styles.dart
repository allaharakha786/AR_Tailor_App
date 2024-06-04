import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/colors_resources.dart';
import '../constants/dimentions_resources.dart';
import '../constants/string_resources.dart';

class CustomTextStyles {
  static TextStyle detailsTextStyle(Color color) {
    return TextStyle(
        fontFamily: StringResources.SEGO_REGULAR,
        fontWeight: FontWeight.bold,
        fontSize: DimensionsResource.FONT_SIZE_SMALL.sp,
        color: color);
  }

  static TextStyle titleTextStyle(Color color) {
    return TextStyle(
        fontFamily: StringResources.SEGO_REGULAR,
        fontWeight: FontWeight.bold,
        fontSize: DimensionsResource.FONT_SIZE_MEDIUM.sp,
        color: color);
  }

  static TextStyle elevatedTextButtonStyle(Color color) {
    return TextStyle(
        letterSpacing: 1,
        fontFamily: StringResources.POPPINS_REGULAR,
        color: color,
        fontSize: DimensionsResource.FONT_SIZE_2X_EXTRA_MEDIUM.sp);
  }

  static TextStyle customStyle() {
    return TextStyle(
        fontWeight: FontWeight.bold,
        color: ColorsResources.WHITE_COLOR,
        fontSize: DimensionsResource.FONT_SIZE_2X_EXTRA_LARGE.sp);
  }

  static TextStyle textButtonStyle() {
    return TextStyle(
        letterSpacing: 1,
        fontFamily: StringResources.POPPINS_REGULAR,
        color: ColorsResources.WHITE_COLOR,
        fontSize: DimensionsResource.FONT_SIZE_SMALL.sp);
  }

  static TextStyle contentTextStyle(Color color) {
    return TextStyle(
        fontSize: DimensionsResource.FONT_SIZE_MEDIUM.sp,
        color: color,
        fontFamily: StringResources.SEGO_REGULAR);
  }
}
