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
import 'package:previous/presentation/screens/forget_password_screen.dart';
import 'package:previous/presentation/widgets/alert_dialog.dart';
import 'package:previous/presentation/widgets/common_textfield.dart';
import '../../helper/constants/image_resources.dart';
import '../../helper/constants/string_resources.dart';
import '../../helper/enums/status_enums.dart';
import '../../helper/utills/text_styles.dart';
import '../widgets/background_design.dart';
import '../widgets/common_button.dart';
import 'bottom_navigation_bar.dart';
import 'signup_screen.dart';
import '../../helper/extenstions/validation_extension.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late AuthBloc bloc;
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey();
  @override
  void initState() {
    bloc = BlocProvider.of<AuthBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size mediaQuerySize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          body: BlocListener<AuthBloc, AuthStates>(
        listener: (context, state) {
          if (state.states == StatusEnums.LOGGED_IN_STATE) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const BottomNavigationBarScreen(),
                ));
          }
          if (state.states == StatusEnums.ERROR_STATE) {
            ScaffoldMessenger.of(context).clearSnackBars();
            AwesomeDialogAlert.showDialogAlert(context, DialogType.error,
                StringResources.ERROR_TEXT, state.errorMessage, () {});
          }
        },
        child: BlocBuilder<AuthBloc, AuthStates>(
          builder: (context, state) => BackGroundDesign(
            child: Form(
              key: _form,
              child: Column(children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: DimensionsResource.PADDING_SIZE_EXTRA_LARGE),
                    child: SizedBox(
                        height: mediaQuerySize.height *
                            ScreenPercentage.SCREEN_SIZE_17.h,
                        child: Image.asset(
                            fit: BoxFit.contain, ImageResources.APP_LOGO)),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    width: mediaQuerySize.width *
                        ScreenPercentage.SCREEN_SIZE_40.w,
                    child: FittedBox(
                      child: Text(StringResources.WELCOME_BACK,
                          style: CustomTextStyles.titleTextStyle(
                              ColorsResources.WHITE_COLOR)),
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: DimensionsResource.PADDING_SIZE_EXTRA_SMALL,
                        right: DimensionsResource.PADDING_SIZE_EXTRA_SMALL),
                    child: Container(
                      height: mediaQuerySize.height *
                          ScreenPercentage.SCREEN_SIZE_45.h,
                      width: mediaQuerySize.width *
                          ScreenPercentage.SCREEN_SIZE_100.w,
                      decoration: BoxDecoration(
                          color: ColorsResources.WHITE_12,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(
                                  DimensionsResource.PADDING_SIZE_DEFAULT),
                              topRight: Radius.circular(
                                  DimensionsResource.PADDING_SIZE_DEFAULT))),
                      child: Padding(
                        padding: const EdgeInsets.all(
                            DimensionsResource.PADDING_SIZE_DEFAULT),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              CommonTextField(
                                  validator: (value) {
                                    if (value!.fieldValidation()) {
                                      return StringResources
                                          .EMPTY_FIELD_VALIDATION_MESSAGE;
                                    } else if (value.emailValidation()) {
                                      return StringResources
                                          .EMAIL_VALIDATION_MESSAGE;
                                    }
                                    return null;
                                  },
                                  controller: emailController,
                                  hintText: StringResources.EMAIL,
                                  prefixIcon: const Icon(Icons.email)),
                              CommonTextField(
                                obscureText: state.showPassword,
                                validator: (value) {
                                  if (value!.fieldValidation()) {
                                    return StringResources
                                        .EMPTY_FIELD_VALIDATION_MESSAGE;
                                  } else if (value.passwordValidation()) {
                                    return StringResources
                                        .PASSWORD_VALIDATION_MESSAGE;
                                  }
                                  return null;
                                },
                                isSuffix: true,
                                suffixIcon: Icon(
                                  state.showPassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: ColorsResources.WHITE_70,
                                ),
                                onTap: () {
                                  state.showPassword
                                      ? BlocProvider.of<AuthBloc>(context)
                                          .add(HidePasswordEvent())
                                      : BlocProvider.of<AuthBloc>(context)
                                          .add(ShowPasswordEvent());
                                },
                                controller: passwordController,
                                hintText: StringResources.PASSWORD,
                                prefixIcon: const Icon(Icons.password),
                              ),
                              CommonButton(
                                isloading: state.isLoading,
                                width: MediaQuery.of(context).size.width *
                                    ScreenPercentage.SCREEN_SIZE_32.w,
                                text: StringResources.LOGIN,
                                onTap: () async {
                                  if (_form.currentState!.validate()) {
                                    bloc.add(LoginEvent(
                                        email: emailController.text,
                                        password: passwordController.text));
                                  }
                                },
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(StringResources.DONT_ACCOUNT,
                                      style: CustomTextStyles.contentTextStyle(
                                          ColorsResources.WHITE_70)),
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          left: DimensionsResource
                                              .PADDING_SIZE_SMALL),
                                      child: TextButton(
                                          onPressed: () {
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const SignupScreen(),
                                                ));
                                          },
                                          child: Text(StringResources.SIGN_UP,
                                              style: CustomTextStyles
                                                  .textButtonStyle())))
                                ],
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const ForgetPasswordScreen(),
                                          ));
                                    },
                                    child: Text(StringResources.RESET_PASSWORD,
                                        style: CustomTextStyles
                                            .textButtonStyle())),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ),
      )),
    );
  }
}
