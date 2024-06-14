import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:previous/helper/constants/colors_resources.dart';
import 'package:previous/helper/constants/dimentions_resources.dart';
import 'package:previous/helper/constants/screen_percentage.dart';
import 'package:previous/helper/constants/string_resources.dart';
import 'package:previous/helper/utills/text_styles.dart';
import 'package:previous/presentation/screens/update_order.dart';
import 'package:previous/presentation/widgets/common_backbutton.dart';

import '../../helper/data/list_data.dart';
import '../widgets/decorated_container.dart';
import '../widgets/sizedbox_padding.dart';
import 'full_screenshot_screen.dart';

// ignore: must_be_immutable
class OrderDetailsScreen extends StatelessWidget {
  Map<String, dynamic> data;

  dynamic docId;
  OrderDetailsScreen({super.key, required this.data, required this.docId});

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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CommonBackButton(),
                    SizedBox(
                      width: mediaQuerySize.width *
                          ScreenPercentage.SCREEN_SIZE_10.w,
                    ),
                    Expanded(
                      child: Text(
                        data['title'],
                        style: CustomTextStyles.titleTextStyle(
                            ColorsResources.WHITE_70),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          List<String> controllerValues = [
                            data['chestSize'],
                            data['waistSize'],
                            data['hipsSize'],
                            data['inseamSize'],
                            data['thighSize'],
                            data['armSize'],
                            data['shoulderSize'],
                            data['neckSize'],
                            data['sleeveSize']
                          ];
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UpdateOrderScreen(
                                    title: data['title'],
                                    docId: docId,
                                    controllersValues: controllerValues),
                              ));
                        },
                        icon: Icon(
                          Icons.edit,
                          color: ColorsResources.AMBER_ACCENT,
                        ))
                  ],
                ),
                const SizedBoxPadding(),
                Text(
                  StringResources.ORDER_DETAILS,
                  style: CustomTextStyles.titleTextStyle(
                      ColorsResources.WHITE_COLOR),
                ),
                const SizedBoxPadding(),
                DecoratedContainer(
                  height: ScreenPercentage.SCREEN_SIZE_21,
                  width: ScreenPercentage.SCREEN_SIZE_100,
                  child: Padding(
                    padding: const EdgeInsets.all(
                        DimensionsResource.PADDING_SIZE_DEFAULT),
                    child: Column(
                      children: List.generate(3, (index) {
                        List<String> title = [
                          StringResources.ORDER_CREATED,
                          StringResources.ORDER_TIME_,
                          StringResources.PAYMENT_METHOD
                        ];
                        List details = [
                          data['orderDate'],
                          data['orderTime'],
                          data['paymentMethod']
                        ];

                        return Expanded(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    title[index],
                                  ),
                                  Text(
                                    details[index],
                                    style: CustomTextStyles.detailsTextStyle(
                                        ColorsResources.AMBER_ACCENT),
                                  )
                                ],
                              ),
                              Divider(
                                color: ColorsResources.WHITE_24,
                              )
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                ),
                const SizedBoxPadding(),
                Text(
                  StringResources.STATUS,
                  style: CustomTextStyles.titleTextStyle(
                      ColorsResources.WHITE_COLOR),
                ),
                const SizedBoxPadding(),
                DecoratedContainer(
                  height: data['paymentMethod'].toLowerCase().contains('on')
                      ? ScreenPercentage.SCREEN_SIZE_7
                      : ScreenPercentage.SCREEN_SIZE_13,
                  width: ScreenPercentage.SCREEN_SIZE_100,
                  child: Padding(
                    padding: const EdgeInsets.all(
                        DimensionsResource.PADDING_SIZE_DEFAULT),
                    child: Column(
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(StringResources.ORDER_STATUS),
                              Text(
                                data['status'],
                                style: CustomTextStyles.detailsTextStyle(
                                    ColorsResources.AMBER_ACCENT),
                              )
                            ],
                          ),
                        ),
                        data['paymentMethod'].toLowerCase().contains('on')
                            ? const SizedBox()
                            : Divider(
                                color: ColorsResources.WHITE_12,
                              ),
                        data['paymentMethod'].toLowerCase().contains('on')
                            ? const SizedBox()
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    StringResources.PAYMENT_STATUS,
                                  ),
                                  Text(
                                    data['paymentStatus'],
                                    style: CustomTextStyles.detailsTextStyle(
                                        ColorsResources.AMBER_ACCENT),
                                  )
                                ],
                              )
                      ],
                    ),
                  ),
                ),
                const SizedBoxPadding(),
                Text(
                  StringResources.MEASUREMENT_DETAILS,
                  style: CustomTextStyles.titleTextStyle(
                      ColorsResources.WHITE_COLOR),
                ),
                const SizedBoxPadding(),
                DecoratedContainer(
                  height: ScreenPercentage.SCREEN_SIZE_52,
                  width: ScreenPercentage.SCREEN_SIZE_100,
                  child: Padding(
                    padding: const EdgeInsets.all(
                        DimensionsResource.PADDING_SIZE_DEFAULT),
                    child: Column(
                      children: List.generate(9, (index) {
                        List measurementDetails = [
                          data['chestSize'],
                          data['waistSize'],
                          data['hipsSize'],
                          data['inseamSize'],
                          data['thighSize'],
                          data['armSize'],
                          data['shoulderSize'],
                          data['neckSize'],
                          data['sleeveSize'],
                        ];

                        return Expanded(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    ListData.measurementTitles[index],
                                  ),
                                  Text(
                                    measurementDetails[index],
                                    style: CustomTextStyles.detailsTextStyle(
                                        ColorsResources.AMBER_ACCENT),
                                  )
                                ],
                              ),
                              Divider(
                                color: ColorsResources.WHITE_24,
                              )
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                ),
                const SizedBoxPadding(),
                data['transactionId'].toString().isNotEmpty
                    ? Text(
                        StringResources.TRANSACTION_ID,
                        style: CustomTextStyles.titleTextStyle(
                            ColorsResources.WHITE_COLOR),
                      )
                    : const SizedBox(),
                const SizedBoxPadding(),
                data['transactionId'].toString().isNotEmpty
                    ? DecoratedContainer(
                        height: ScreenPercentage.SCREEN_SIZE_7,
                        width: ScreenPercentage.SCREEN_SIZE_100,
                        child: Padding(
                          padding: const EdgeInsets.all(
                              DimensionsResource.PADDING_SIZE_DEFAULT),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                StringResources.ID,
                              ),
                              Text(
                                data['transactionId'],
                                style: CustomTextStyles.detailsTextStyle(
                                    ColorsResources.AMBER_ACCENT),
                              )
                            ],
                          ),
                        ),
                      )
                    : const SizedBox(),
                const SizedBoxPadding(),
                data['screenshot'].contains('noImage')
                    ? const SizedBox()
                    : Text(
                        StringResources.SCREENSHOT,
                        style: CustomTextStyles.titleTextStyle(
                            ColorsResources.WHITE_COLOR),
                      ),
                const SizedBoxPadding(),
                data['screenshot'].contains('noImage')
                    ? const SizedBox()
                    : GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FullScreenshotScreen(
                                  imageTitle: data['imageTitle'],
                                  imagePath: data['screenshot']),
                            )),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                StringResources.TAP_SCREENSHOT,
                                style: CustomTextStyles.titleTextStyle(
                                    ColorsResources.WHITE_COLOR),
                              ),
                            ),
                            Opacity(
                              opacity: 0.3,
                              child: Container(
                                height: mediaQuerySize.height *
                                    ScreenPercentage.SCREEN_SIZE_25.h,
                                width: mediaQuerySize.width *
                                    ScreenPercentage.SCREEN_SIZE_100.w,
                                decoration: BoxDecoration(
                                  color: ColorsResources.WHITE_12,
                                  borderRadius: BorderRadius.circular(
                                      DimensionsResource.RADIUS_DEFAULT),
                                ),
                                child: Image.network(
                                  data['screenshot'],
                                  fit: BoxFit.cover,
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    }
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
