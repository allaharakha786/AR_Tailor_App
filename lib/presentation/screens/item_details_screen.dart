import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:previous/helper/constants/colors_resources.dart';
import 'package:previous/helper/constants/dimentions_resources.dart';
import 'package:previous/helper/constants/string_resources.dart';
import 'package:previous/helper/utills/text_styles.dart';
import 'package:previous/presentation/screens/add_measurement_screen.dart';
import 'package:previous/presentation/widgets/common_backbutton.dart';
import 'package:previous/presentation/widgets/common_button.dart';
import 'package:previous/presentation/widgets/sizedbox_padding.dart';

import '../../helper/constants/screen_percentage.dart';

// ignore: must_be_immutable
class ItemDetailScreen extends StatelessWidget {
  String imageUrl;
  String title;
  String price;
  String catagory;
  String details;
  ItemDetailScreen({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.catagory,
    required this.details,
  });

  @override
  Widget build(BuildContext context) {
    Size mediaQuerySize = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
            body: Container(
      height: mediaQuerySize.height * ScreenPercentage.SCREEN_SIZE_100.h,
      width: mediaQuerySize.width * ScreenPercentage.SCREEN_SIZE_100.w,
      color: ColorsResources.BLACK_COLOR,
      child: Padding(
        padding: const EdgeInsets.all(DimensionsResource.PADDING_SIZE_SMALL),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CommonBackButton(),
                  SizedBox(
                    width: mediaQuerySize.width *
                        ScreenPercentage.SCREEN_SIZE_10.w,
                  ),
                  Expanded(
                      child: title.length < 25
                          ? Text(
                              title,
                              style: CustomTextStyles.titleTextStyle(
                                  ColorsResources.WHITE_70),
                            )
                          : Text(
                              '${title.substring(0, 25)}...',
                              style: CustomTextStyles.titleTextStyle(
                                  ColorsResources.WHITE_70),
                            ))
                ],
              ),
              const SizedBoxPadding(),
              Container(
                height:
                    mediaQuerySize.height * ScreenPercentage.SCREEN_SIZE_30.h,
                width:
                    mediaQuerySize.width * ScreenPercentage.SCREEN_SIZE_100.w,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover, image: NetworkImage(imageUrl)),
                    color: ColorsResources.WHITE_12,
                    borderRadius: const BorderRadius.all(
                        Radius.circular(DimensionsResource.RADIUS_DEFAULT))),
              ),
              Text(
                title,
                style: CustomTextStyles.elevatedTextButtonStyle(
                    ColorsResources.WHITE_COLOR),
              ),
              Text(catagory,
                  style: CustomTextStyles.contentTextStyle(
                      ColorsResources.WHITE_70)),
              Text(
                '\$ $price',
                style: CustomTextStyles.elevatedTextButtonStyle(
                    ColorsResources.AMBER_ACCENT),
              ),
              Align(
                  alignment: Alignment.center,
                  child: Text(
                    StringResources.DETAILS,
                    style: CustomTextStyles.elevatedTextButtonStyle(
                        ColorsResources.WHITE_COLOR),
                  )),
              Text(
                details,
                style:
                    CustomTextStyles.contentTextStyle(ColorsResources.WHITE_70),
              ),
              Align(
                alignment: Alignment.center,
                child: CommonButton(
                  width: MediaQuery.of(context).size.width *
                      ScreenPercentage.SCREEN_SIZE_65.w,
                  text: StringResources.ADD_MEASUREMENT,
                  isloading: false,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddMeasurementScreen(
                              title: title, imageUrl: imageUrl, price: price),
                        ));
                  },
                ),
              )
            ],
          ),
        ),
      ),
    )));
  }
}
