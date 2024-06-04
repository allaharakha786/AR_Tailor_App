import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:previous/helper/constants/colors_resources.dart';
import 'package:previous/helper/constants/dimentions_resources.dart';
import 'package:previous/helper/constants/screen_percentage.dart';
import 'package:previous/helper/utills/text_styles.dart';
import 'package:previous/presentation/screens/login_screen.dart';
import 'package:previous/presentation/widgets/common_button.dart';
import 'package:previous/presentation/widgets/sizedbox_padding.dart';

import '../../helper/constants/string_resources.dart';

// ignore: must_be_immutable
class ResetCodeSentScreen extends StatelessWidget {
  String email;
  ResetCodeSentScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    Size mediaQuerySize = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Container(
          height: mediaQuerySize.height * ScreenPercentage.SCREEN_SIZE_100.h,
          width: mediaQuerySize.width * ScreenPercentage.SCREEN_SIZE_100.w,
          color: ColorsResources.BLACK_COLOR,
          child: Padding(
            padding:
                const EdgeInsets.all(DimensionsResource.PADDING_SIZE_DEFAULT),
            child: ListView(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: CircleAvatar(
                    backgroundColor: ColorsResources.WHITE_12,
                    child: IconButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ));
                        },
                        icon: Icon(
                          Icons.close,
                          color: ColorsResources.WHITE_COLOR,
                        )),
                  ),
                ),
                SizedBox(
                  height:
                      mediaQuerySize.height * ScreenPercentage.SCREEN_SIZE_7.h,
                ),
                Icon(
                  size:
                      mediaQuerySize.width * ScreenPercentage.SCREEN_SIZE_35.w,
                  Icons.mark_email_read,
                  color: ColorsResources.GREEN_COLOR,
                ),
                SizedBox(
                  height:
                      mediaQuerySize.height * ScreenPercentage.SCREEN_SIZE_4.h,
                ),
                Text(
                    textAlign: TextAlign.center,
                    StringResources.EMAIL_SENT,
                    style: CustomTextStyles.customStyle()),
                Text(
                    textAlign: TextAlign.center,
                    'we have sent an email to $email with a link to reset your password.'),
                const SizedBoxPadding(),
                Padding(
                  padding: const EdgeInsets.only(
                      left: DimensionsResource.PADDING_SIZE_EXTRA_LARGE,
                      right: DimensionsResource.PADDING_SIZE_EXTRA_LARGE),
                  child: CommonButton(
                      text: StringResources.OPEN_EMAIL_APP,
                      onTap: () {},
                      width: mediaQuerySize.width *
                          ScreenPercentage.SCREEN_SIZE_80.w,
                      isloading: false),
                ),
                const SizedBoxPadding(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(StringResources.EMAIL_NOT_RECEIVED),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          StringResources.RESEND,
                          style: TextStyle(color: ColorsResources.WHITE_COLOR),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
