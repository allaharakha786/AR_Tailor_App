import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:previous/helper/constants/colors_resources.dart';
import 'package:previous/helper/constants/image_resources.dart';
import 'package:previous/helper/constants/screen_percentage.dart';

// ignore: must_be_immutable
class BackGroundDesign extends StatelessWidget {
  Widget? child;
  BackGroundDesign({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    Size mediaQuerySize = MediaQuery.of(context).size;
    return Container(
      height: mediaQuerySize.height * ScreenPercentage.SCREEN_SIZE_100.h,
      width: mediaQuerySize.width * ScreenPercentage.SCREEN_SIZE_100.w,
      decoration: BoxDecoration(
        color: ColorsResources.BLACK_COLOR,
        backgroundBlendMode: BlendMode.srcOver,
        image: DecorationImage(
            colorFilter:
                ColorFilter.mode(ColorsResources.BLACK_54, BlendMode.color),
            opacity: 0.04,
            fit: BoxFit.fill,
            image: AssetImage(
              ImageResources.BACKGROUND_IMAGE,
            )),
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [ColorsResources.BLACK_COLOR, ColorsResources.BLACK_87]),
        boxShadow: [
          BoxShadow(
              color: ColorsResources.GREY_COLOR,
              spreadRadius: 1,
              blurRadius: 4.5,
              offset: const Offset(0, 0))
        ],
      ),
      child: child,
    );
  }
}
