import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:previous/helper/constants/colors_resources.dart';

import '../../helper/constants/dimentions_resources.dart';
import '../../helper/constants/screen_percentage.dart';
import 'decorated_container.dart';

class CommonBackButton extends StatelessWidget {
  const CommonBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    Size mediaQuerySize = MediaQuery.of(context).size;

    return DecoratedContainer(
      height: ScreenPercentage.SCREEN_SIZE_6,
      width: ScreenPercentage.SCREEN_SIZE_15,
      child: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Center(
          child: Padding(
            padding: const EdgeInsets.only(
                left: DimensionsResource.PADDING_SIZE_EXTRA_SMALL),
            child: Icon(
              size: mediaQuerySize.height * ScreenPercentage.SCREEN_SIZE_4.h,
              Icons.arrow_back_ios,
              color: ColorsResources.AMBER_ACCENT,
            ),
          ),
        ),
      ),
    );
  }
}
