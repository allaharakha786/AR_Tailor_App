import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:previous/businessLogic/blocs/authBloc/auth_bloc.dart';
import 'package:previous/businessLogic/blocs/authBloc/auth_events.dart';
import 'package:previous/businessLogic/blocs/authBloc/auth_states.dart';
import 'package:previous/helper/constants/colors_resources.dart';
import 'package:previous/helper/constants/dimentions_resources.dart';
import 'package:previous/helper/constants/screen_percentage.dart';
import 'package:previous/helper/constants/string_resources.dart';
import 'package:previous/helper/enums/status_enums.dart';
import 'package:previous/helper/extenstions/validation_extension.dart';
import 'package:previous/helper/utills/text_styles.dart';
import 'package:previous/presentation/screens/login_screen.dart';
import 'package:previous/presentation/screens/reset_code_sent_screen.dart';
import 'package:previous/presentation/widgets/alert_dialog.dart';
import 'package:previous/presentation/widgets/common_button.dart';
import 'package:previous/presentation/widgets/sizedbox_padding.dart';

import '../widgets/common_backbutton.dart';
import '../widgets/common_textfield.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final GlobalKey<FormState> _key = GlobalKey();

  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size mediaQuerySize = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: BlocListener<AuthBloc, AuthStates>(
          listener: (context, state) {
            if (state.states == StatusEnums.PASSWORD_RESETTED_STATE) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ResetCodeSentScreen(email: emailController.text),
                  ));
            }
            if (state.states == StatusEnums.ERROR_STATE) {
              ScaffoldMessenger.of(context).clearSnackBars();

              AwesomeDialogAlert.showDialogAlert(context, DialogType.error,
                  StringResources.ERROR_TEXT, state.errorMessage, () {
                Navigator.pop(context);
              });
            }
          },
          child: BlocBuilder<AuthBloc, AuthStates>(
            builder: (context, state) => Container(
              height:
                  mediaQuerySize.height * ScreenPercentage.SCREEN_SIZE_100.h,
              width: mediaQuerySize.width * ScreenPercentage.SCREEN_SIZE_100.w,
              color: ColorsResources.BLACK_COLOR,
              child: Padding(
                padding:
                    const EdgeInsets.all(DimensionsResource.PADDING_SIZE_SMALL),
                child: Form(
                  key: _key,
                  child: ListView(children: [
                    Row(
                      children: [
                        const CommonBackButton(),
                        SizedBox(
                          width: mediaQuerySize.width *
                              ScreenPercentage.SCREEN_SIZE_15.w,
                        ),
                        Text(
                          StringResources.ACCOUNT_RECOVERY,
                          style: CustomTextStyles.titleTextStyle(
                              ColorsResources.WHITE_70),
                        )
                      ],
                    ),
                    SizedBox(
                      height: mediaQuerySize.height *
                          ScreenPercentage.SCREEN_SIZE_5.h,
                    ),
                    Icon(
                      size: mediaQuerySize.height *
                          ScreenPercentage.SCREEN_SIZE_10.h,
                      Icons.lock,
                      color: ColorsResources.AMBER_ACCENT,
                    ),
                    const SizedBoxPadding(),
                    SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(StringResources.FORGET_PASSWORD,
                              style: CustomTextStyles.customStyle()),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: DimensionsResource.PADDING_SIZE_DEFAULT,
                                right: DimensionsResource.PADDING_SIZE_DEFAULT,
                                top: DimensionsResource
                                    .PADDING_SIZE_EXTRA_SMALL),
                            child: Text(
                                textAlign: TextAlign.center,
                                StringResources.FORGET_PASSWORD_DISCRIPTION),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: mediaQuerySize.height *
                          ScreenPercentage.SCREEN_SIZE_3.h,
                    ),
                    CommonTextField(
                      isBorder: true,
                      hintText: StringResources.EMAIL,
                      prefixIcon: const Icon(Icons.email),
                      controller: emailController,
                      validator: (value) {
                        if (value!.fieldValidation()) {
                          return StringResources.EMPTY_FIELD_VALIDATION_MESSAGE;
                        }
                        if (value.emailValidation()) {
                          return StringResources.EMAIL_VALIDATION_MESSAGE;
                        }
                        return null;
                      },
                    ),
                    CommonButton(
                      onTap: () {
                        if (_key.currentState!.validate()) {
                          BlocProvider.of<AuthBloc>(context).add(
                              ResetPasswordEvent(email: emailController.text));
                        }
                      },
                      isloading: state.isLoading,
                      text: StringResources.SEND,
                      width: mediaQuerySize.width *
                          ScreenPercentage.SCREEN_SIZE_35.w,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(StringResources.REMEMBER_PASSWORD),
                        TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginScreen(),
                                  ));
                            },
                            child: Text(
                              StringResources.LOGIN,
                              style: TextStyle(
                                  color: ColorsResources.AMBER_ACCENT),
                            ))
                      ],
                    )
                  ]),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
