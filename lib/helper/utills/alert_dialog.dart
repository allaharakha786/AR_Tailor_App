import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:previous/helper/constants/colors_resources.dart';
import 'package:previous/helper/constants/dimentions_resources.dart';
import 'package:previous/helper/constants/screen_percentage.dart';

import '../constants/string_resources.dart';

// ignore: must_be_immutable
class DetailsAlertDialog extends StatelessWidget {
  String imageUrl;
  String detailsText;
  DetailsAlertDialog(
      {super.key, required this.detailsText, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    Size mediaQuerySize = MediaQuery.of(context).size;
    return AlertDialog(
      backgroundColor: Colors.transparent,
      contentPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.zero,
      content: Container(
        height: mediaQuerySize.height * ScreenPercentage.SCREEN_SIZE_40.h,
        width: mediaQuerySize.width * ScreenPercentage.SCREEN_SIZE_95.w,
        decoration: BoxDecoration(
            color: ColorsResources.WHITE_COLOR,
            borderRadius: BorderRadius.all(
                Radius.circular(DimensionsResource.RADIUS_EXTRA_LARGE))),
        child: ListView(
          shrinkWrap: true,
          children: [
            Container(
              height: mediaQuerySize.height * ScreenPercentage.SCREEN_SIZE_28.h,
              width: mediaQuerySize.width * ScreenPercentage.SCREEN_SIZE_95.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                    DimensionsResource.RADIUS_EXTRA_LARGE),
                image: DecorationImage(
                    fit: BoxFit.cover, image: AssetImage(imageUrl)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: DimensionsResource.PADDING_SIZE_EXTRA_LARGE,
                  right: DimensionsResource.PADDING_SIZE_EXTRA_LARGE),
              child: Align(
                alignment: Alignment.center,
                child: Text(detailsText,
                    style: TextStyle(fontFamily: StringResources.SEGO_REGULAR)),
              ),
            ),
            Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: DimensionsResource.PADDING_SIZE_EXTRA_SMALL),
                  child: TextButton(
                      style: ButtonStyle(
                        foregroundColor: MaterialStatePropertyAll(
                            ColorsResources.BLACK_COLOR),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(StringResources.OK)),
                ))
          ],
        ),
      ),
    );
  }
}
