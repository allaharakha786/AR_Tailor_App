import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:previous/helper/constants/dimentions_resources.dart';
import 'package:previous/helper/constants/screen_percentage.dart';
import 'package:previous/helper/constants/string_resources.dart';
import 'package:previous/helper/utills/text_styles.dart';
import 'package:previous/presentation/screens/checkout_screen.dart';
import 'package:previous/presentation/widgets/decorated_container.dart';
import 'package:previous/presentation/widgets/sizedbox_padding.dart';

import '../../helper/constants/colors_resources.dart';
import '../../helper/data/list_data.dart';

// ignore: must_be_immutable
class ReviewSummaryScreen extends StatefulWidget {
  String price;
  String title;
  String imageUrl;
  List<TextEditingController> measurementList = [];

  ReviewSummaryScreen(
      {super.key,
      required this.imageUrl,
      required this.price,
      required this.title,
      required this.measurementList});

  @override
  State<ReviewSummaryScreen> createState() => _ReviewSummaryScreenState();
}

class _ReviewSummaryScreenState extends State<ReviewSummaryScreen> {
  @override
  Widget build(BuildContext context) {
    List orderDetails = [widget.title, '1', widget.price];

    Size mediaQuerySize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
            backgroundColor: ColorsResources.BLACK_COLOR,
            child: Icon(
              Icons.arrow_forward_ios,
              color: ColorsResources.AMBER_ACCENT,
            ),
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentMethods(
                      imageUrl: widget.imageUrl,
                      measurementList: widget.measurementList,
                      price: widget.price,
                      title: widget.title,
                    ),
                  ));
            }),
        body: Container(
          color: ColorsResources.BLACK_COLOR,
          height: mediaQuerySize.height * ScreenPercentage.SCREEN_SIZE_100.h,
          width: mediaQuerySize.width * ScreenPercentage.SCREEN_SIZE_100.w,
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.all(DimensionsResource.PADDING_SIZE_SMALL),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
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
                    Padding(
                      padding: EdgeInsets.only(
                          right: mediaQuerySize.width *
                              ScreenPercentage.SCREEN_SIZE_30.w),
                      child: Text(
                        StringResources.REVIEW_DETAILS,
                        style: CustomTextStyles.titleTextStyle(
                            ColorsResources.WHITE_70),
                      ),
                    )
                  ],
                ),
                const SizedBoxPadding(),
                Text(
                  StringResources.YOUR_MEASUREMENT,
                  style: CustomTextStyles.elevatedTextButtonStyle(
                      ColorsResources.WHITE_COLOR),
                ),
                const SizedBoxPadding(),
                DecoratedContainer(
                  height: ScreenPercentage.SCREEN_SIZE_97,
                  width: ScreenPercentage.SCREEN_SIZE_100,
                  child: Padding(
                    padding: const EdgeInsets.all(
                        DimensionsResource.PADDING_SIZE_SMALL),
                    child: SingleChildScrollView(
                      child: Column(
                        children: List.generate(
                            ListData.iconsOfMeasurementList.length,
                            (index) => Column(
                                  children: [
                                    ListTile(
                                      leading: Image.asset(
                                        scale: 15,
                                        ListData.iconsOfMeasurementList[index],
                                        color: ColorsResources.WHITE_70,
                                      ),
                                      title: Text(
                                        ListData.titlesOfMeasurementList[index],
                                        style: TextStyle(
                                            color: ColorsResources.WHITE_70),
                                      ),
                                      subtitle: Text(
                                          '${widget.measurementList[index].text} ""'),
                                    ),
                                    Divider(
                                      color: ColorsResources.WHITE_12,
                                      height: 0,
                                    )
                                  ],
                                )),
                      ),
                    ),
                  ),
                ),
                const SizedBoxPadding(),
                Text(
                  StringResources.YOUR_ORDER_DETAILS,
                  style: CustomTextStyles.elevatedTextButtonStyle(
                      ColorsResources.WHITE_COLOR),
                ),
                const SizedBoxPadding(),
                DecoratedContainer(
                    height: ScreenPercentage.SCREEN_SIZE_41,
                    width: ScreenPercentage.SCREEN_SIZE_100,
                    child: SingleChildScrollView(
                      child: Column(
                        children: List.generate(
                            ListData.iconOfOrderList.length,
                            (index) => Padding(
                                  padding: const EdgeInsets.all(
                                      DimensionsResource.PADDING_SIZE_SMALL),
                                  child: Column(
                                    children: [
                                      ListTile(
                                        leading: Icon(
                                          ListData.iconOfOrderList[index],
                                          color: ColorsResources.WHITE_70,
                                        ),
                                        title: Text(
                                          ListData.titlesOfOrderList[index],
                                          style:
                                              CustomTextStyles.detailsTextStyle(
                                                  ColorsResources.WHITE_70),
                                        ),
                                        subtitle: Text(orderDetails[index]),
                                      ),
                                      Divider(
                                        color: ColorsResources.WHITE_12,
                                        height: 0,
                                      )
                                    ],
                                  ),
                                )),
                      ),
                    ))
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
