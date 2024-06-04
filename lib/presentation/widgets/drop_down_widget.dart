import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:previous/helper/constants/colors_resources.dart';
import 'package:previous/helper/utills/text_styles.dart';

import '../../commonWidget.dart';
import '../../helper/constants/dimentions_resources.dart';
import '../../helper/constants/string_resources.dart';

// ignore: must_be_immutable
class DropDownButton extends StatefulWidget {
  String defaultValue;
  dynamic value;
  String title;
  DropDownButton(
      {super.key,
      required this.defaultValue,
      required this.value,
      required this.title});

  @override
  State<DropDownButton> createState() => _DropDownButtonState();
}

class _DropDownButtonState extends State<DropDownButton> {
  List<String> paymentMethod = [
    'Choose method',
    'Cash on Delivery',
    'JazzCash',
    'EasyPaisa'
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(widget.title,
            style: TextStyle(
              letterSpacing: 1,
              fontFamily: StringResources.POPPINS_REGULAR,
              color: Colors.white,
              fontSize: DimensionsResource.FONT_SIZE_2X_EXTRA_MEDIUM.sp,
            )),
        StatefulBuilder(
          builder: (context, setState) => Dropdown(
              widget.defaultValue,
              paymentMethod
                  .map((method) => DropdownMenuItem(
                        value: method,
                        child: Text(
                          method,
                          style: CustomTextStyles.contentTextStyle(
                              ColorsResources.WHITE_COLOR),
                        ),
                      ))
                  .toList(),
              widget.value),
        )
      ],
    );
  }
}
