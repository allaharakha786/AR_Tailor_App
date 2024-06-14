import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:previous/helper/constants/colors_resources.dart';
import 'package:previous/helper/constants/dimentions_resources.dart';
import 'package:previous/helper/constants/screen_percentage.dart';
import 'package:previous/helper/utills/text_styles.dart';

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
        color: Colors.black,
        child: Container(
          height: mediaQuerySize.height * ScreenPercentage.SCREEN_SIZE_40.h,
          width: mediaQuerySize.width * ScreenPercentage.SCREEN_SIZE_95.w,
          decoration: BoxDecoration(
              color: ColorsResources.WHITE_24,
              borderRadius: BorderRadius.all(
                  Radius.circular(DimensionsResource.RADIUS_EXTRA_LARGE))),
          child: Column(
            children: [
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.all(
                      DimensionsResource.PADDING_SIZE_EXTRA_SMALL),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          DimensionsResource.RADIUS_EXTRA_LARGE),
                      image: DecorationImage(
                          fit: BoxFit.cover, image: AssetImage(imageUrl)),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: DimensionsResource.PADDING_SIZE_EXTRA_LARGE,
                      right: DimensionsResource.PADDING_SIZE_EXTRA_LARGE),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(detailsText,
                        style: CustomTextStyles.contentTextStyle(
                            ColorsResources.WHITE_70)),
                  ),
                ),
              ),
              Expanded(
                child: Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: DimensionsResource.PADDING_SIZE_EXTRA_SMALL),
                      child: TextButton(
                          style: ButtonStyle(
                            foregroundColor: MaterialStatePropertyAll(
                                ColorsResources.AMBER_ACCENT),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(StringResources.OK)),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
