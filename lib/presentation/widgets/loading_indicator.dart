import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:previous/helper/constants/screen_percentage.dart';

import '../../helper/constants/colors_resources.dart';

class CommonLoadingIndicator extends StatelessWidget {
  const CommonLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    Size mediaQuerySize = MediaQuery.of(context).size;

    return SpinKitThreeInOut(
      size: mediaQuerySize.width * ScreenPercentage.SCREEN_SIZE_10.w,
      color: ColorsResources.AMBER_ACCENT,
    );
  }
}
