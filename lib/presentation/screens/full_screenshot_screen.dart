import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:previous/helper/constants/colors_resources.dart';
import 'package:previous/helper/constants/screen_percentage.dart';

import '../../helper/constants/dimentions_resources.dart';
import '../../helper/utills/text_styles.dart';
import '../widgets/decorated_container.dart';

// ignore: must_be_immutable
class FullScreenshotScreen extends StatelessWidget {
  String imagePath;
  String imageTitle;
  FullScreenshotScreen(
      {super.key, required this.imagePath, required this.imageTitle});

  @override
  Widget build(BuildContext context) {
    Size mediaQuerySize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
            height: mediaQuerySize.height * ScreenPercentage.SCREEN_SIZE_100.h,
            width: mediaQuerySize.width * ScreenPercentage.SCREEN_SIZE_100.w,
            color: ColorsResources.BLACK_COLOR,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: DimensionsResource.PADDING_SIZE_SMALL,
                    right: DimensionsResource.PADDING_SIZE_SMALL),
                child: Column(
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      DecoratedContainer(
                        height: ScreenPercentage.SCREEN_SIZE_6,
                        width: ScreenPercentage.SCREEN_SIZE_15,
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: DimensionsResource
                                      .PADDING_SIZE_EXTRA_SMALL),
                              child: Icon(
                                size: mediaQuerySize.height *
                                    ScreenPercentage.SCREEN_SIZE_4.h,
                                Icons.arrow_back_ios,
                                color: ColorsResources.AMBER_ACCENT,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: mediaQuerySize.width *
                            ScreenPercentage.SCREEN_SIZE_15.w,
                      ),
                      imagePath.length < 20
                          ? Expanded(
                              child: Text(
                                imagePath.split('/').last,
                                style: CustomTextStyles.titleTextStyle(
                                    ColorsResources.WHITE_70),
                              ),
                            )
                          : Expanded(
                              child: Text(
                                '${imagePath.split('/').last.substring(0, 20)}... ',
                                style: CustomTextStyles.titleTextStyle(
                                    ColorsResources.WHITE_70),
                              ),
                            )
                    ]),
                    SizedBox(
                      height: mediaQuerySize.height *
                          ScreenPercentage.SCREEN_SIZE_1.h,
                    ),
                    Image.network(
                      imagePath,
                      fit: BoxFit.contain,
                    )
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
