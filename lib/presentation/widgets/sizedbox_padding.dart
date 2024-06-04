import 'package:flutter/cupertino.dart';

import '../../helper/constants/screen_percentage.dart';

class SizedBoxPadding extends StatelessWidget {
  const SizedBoxPadding({super.key});

  @override
  Widget build(BuildContext context) {
    Size mediaQuerySize = MediaQuery.of(context).size;
    return SizedBox(
      height: mediaQuerySize.height * ScreenPercentage.SCREEN_SIZE_1,
    );
  }
}
