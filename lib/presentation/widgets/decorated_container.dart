import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:previous/helper/constants/colors_resources.dart';

import '../../helper/constants/dimentions_resources.dart';

// ignore: must_be_immutable
class DecoratedContainer extends StatelessWidget {
  double height;
  double width;
  Widget child;

  DecoratedContainer(
      {super.key,
      required this.height,
      required this.width,
      required this.child});

  @override
  Widget build(BuildContext context) {
    Size mediaQuerySize = MediaQuery.of(context).size;
    return Container(
        height: mediaQuerySize.height * height.h,
        width: mediaQuerySize.width * width.w,
        decoration: BoxDecoration(
            color: ColorsResources.WHITE_12,
            borderRadius:
                BorderRadius.circular(DimensionsResource.RADIUS_DEFAULT)),
        child: child);
  }
}
