import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:previous/helper/constants/colors_resources.dart';
import 'package:previous/helper/constants/dimentions_resources.dart';
import 'package:previous/helper/constants/screen_percentage.dart';
import 'package:previous/helper/extenstions/validation_extension.dart';
import 'package:previous/helper/utills/alert_dialog.dart';
import 'package:previous/helper/utills/text_styles.dart';
import 'package:previous/presentation/screens/review_summary_screen.dart';
import 'package:previous/presentation/widgets/common_textfield.dart';
import 'package:previous/presentation/widgets/sizedbox_padding.dart';

import '../../helper/constants/string_resources.dart';
import '../../helper/data/list_data.dart';
import '../widgets/common_backbutton.dart';

// ignore: must_be_immutable
class AddMeasurementScreen extends StatefulWidget {
  String imageUrl;
  String title;
  String price;
  AddMeasurementScreen(
      {super.key,
      required this.imageUrl,
      required this.price,
      required this.title});

  @override
  State<AddMeasurementScreen> createState() => _AddMeasurementScreenState();
}

class _AddMeasurementScreenState extends State<AddMeasurementScreen> {
  final GlobalKey<FormState> _form = GlobalKey();

  List<TextEditingController> controllers = [];

  @override
  void initState() {
    for (int i = 0; i < 9; i++) {
      controllers.add(TextEditingController());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                if (_form.currentState!.validate()) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReviewSummaryScreen(
                            measurementList: controllers,
                            title: widget.title,
                            price: widget.price,
                            imageUrl: widget.imageUrl),
                      ));
                }
              }),
          body: Container(
            color: ColorsResources.BLACK_COLOR,
            height: mediaQuerySize.height * ScreenPercentage.SCREEN_SIZE_100.h,
            width: mediaQuerySize.width.w,
            child: Padding(
              padding: const EdgeInsets.all(
                DimensionsResource.PADDING_SIZE_SMALL,
              ),
              child: Form(
                key: _form,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CommonBackButton(),
                          Padding(
                            padding: EdgeInsets.only(
                                right: mediaQuerySize.width *
                                    ScreenPercentage.SCREEN_SIZE_25.w),
                            child: Text(
                              StringResources.ADD_MEASUREMENT,
                              style: CustomTextStyles.titleTextStyle(
                                  ColorsResources.WHITE_70),
                            ),
                          )
                        ],
                      ),
                      const SizedBoxPadding(),
                      Text(
                        StringResources.MEASUREMENT_IN_INCHES,
                        style: TextStyle(color: ColorsResources.WHITE_COLOR),
                      ),
                      const SizedBoxPadding(),
                      SingleChildScrollView(
                        child: Column(
                          children: List.generate(controllers.length, (index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  top: DimensionsResource.PADDING_SIZE_SMALL),
                              child: CommonTextField(
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value!.fieldValidation()) {
                                    return StringResources
                                        .EMPTY_FIELD_VALIDATION_MESSAGE;
                                  } else if (value.numericValidation()) {
                                    return StringResources.NUMERIC_VALIDATION;
                                  }
                                  return null;
                                },
                                isSuffix: true,
                                controller: controllers[index],
                                suffixIcon: Icon(
                                  Icons.info,
                                  color: ColorsResources.WHITE_70,
                                ),
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => DetailsAlertDialog(
                                        detailsText: ListData
                                            .measurementDiscriptionList[index],
                                        imageUrl: ListData.gifUrlsList[index]),
                                  );
                                },
                                hintText: ListData.measurementTitles[index],
                                isBorder: true,
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
