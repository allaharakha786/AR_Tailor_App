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
import 'package:previous/presentation/widgets/alert_dialog.dart';

import '../../helper/constants/image_resources.dart';
import '../widgets/background_design.dart';
import 'package:country_code_picker/country_code_picker.dart';

import '../widgets/common_button.dart';
import '../widgets/common_textfield.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController phoneController = TextEditingController();

  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController addressController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Size mediaQuerySize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          body: BlocListener<AuthBloc, AuthStates>(
        listener: (context, state) {
          if (state.states == StatusEnums.SINGED_UP_STATE) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ));
          } else if (state.states == StatusEnums.ERROR_STATE) {
            ScaffoldMessenger.of(context).clearSnackBars();
            AwesomeDialogAlert.showDialogAlert(context, DialogType.error,
                StringResources.ERROR_TEXT, state.errorMessage, () {});
          }
        },
        child: BlocBuilder<AuthBloc, AuthStates>(
          builder: (context, state) => BackGroundDesign(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: DimensionsResource.PADDING_SIZE_EXTRA_LARGE),
                      child: Image.asset(
                          fit: BoxFit.contain, ImageResources.APP_LOGO),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: mediaQuerySize.width *
                            ScreenPercentage.SCREEN_SIZE_40.w,
                        child: FittedBox(
                          child: Text(StringResources.CREATE_ACCOUNT,
                              style: CustomTextStyles.titleTextStyle(
                                  ColorsResources.WHITE_COLOR)),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: DimensionsResource.PADDING_SIZE_EXTRA_SMALL,
                          right: DimensionsResource.PADDING_SIZE_EXTRA_SMALL),
                      child: Container(
                        height: mediaQuerySize.height *
                            ScreenPercentage.SCREEN_SIZE_60.h,
                        width: mediaQuerySize.width *
                            ScreenPercentage.SCREEN_SIZE_100.w,
                        decoration: BoxDecoration(
                            color: ColorsResources.WHITE_12,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(
                                    DimensionsResource.RADIUS_DEFAULT),
                                topRight: Radius.circular(
                                    DimensionsResource.RADIUS_DEFAULT))),
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(
                                DimensionsResource.PADDING_SIZE_SMALL),
                            child: Column(
                              children: [
                                CommonTextField(
                                    validator: (value) {
                                      if (value!.fieldValidation()) {
                                        return StringResources
                                            .EMPTY_FIELD_VALIDATION_MESSAGE;
                                      }
                                      return null;
                                    },
                                    controller: nameController,
                                    hintText: StringResources.NAME,
                                    prefixIcon: const Icon(Icons.person)),
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
                                  prefixIcon: const Icon(Icons.email),
                                ),
                                CommonTextField(
                                  validator: (value) {
                                    if (value!.fieldValidation()) {
                                      return StringResources
                                          .EMPTY_FIELD_VALIDATION_MESSAGE;
                                    } else if (value.phoneValidation()) {
                                      return StringResources
                                          .PHONE_VALIDATION_MESSAGE;
                                    }
                                    return null;
                                  },
                                  controller: phoneController,
                                  hintText: StringResources.PHONE,
                                  prefixIcon: CountryCodePicker(
                                    enabled: true,
                                    textStyle: TextStyle(
                                        color: ColorsResources.WHITE_70),
                                    dialogTextStyle: TextStyle(
                                        color: ColorsResources.WHITE_70),
                                    onChanged: (value) {
                                      BlocProvider.of<AuthBloc>(context).add(
                                          CountryCodeEvent(countryCode: value));
                                    },
                                    initialSelection: 'US',
                                    showCountryOnly: false,
                                    hideSearch: true,
                                    boxDecoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      color: ColorsResources.BLACK_87,
                                    ),
                                    showOnlyCountryWhenClosed: false,
                                    alignLeft: false,
                                    dialogBackgroundColor:
                                        ColorsResources.BLACK_54,
                                  ),
                                ),
                                CommonTextField(
                                    validator: (value) {
                                      if (value!.fieldValidation()) {
                                        return StringResources
                                            .EMPTY_FIELD_VALIDATION_MESSAGE;
                                      }
                                      return null;
                                    },
                                    controller: addressController,
                                    hintText: StringResources.ADDRESS,
                                    prefixIcon:
                                        const Icon(Icons.local_activity)),
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
                                  controller: passwordController,
                                  onTap: () {
                                    state.showPassword
                                        ? BlocProvider.of<AuthBloc>(context)
                                            .add(HidePasswordEvent())
                                        : BlocProvider.of<AuthBloc>(context)
                                            .add(ShowPasswordEvent());
                                  },
                                  hintText: StringResources.PASSWORD,
                                  isSuffix: true,
                                  prefixIcon: const Icon(Icons.password),
                                  suffixIcon: Icon(
                                    state.showPassword
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: ColorsResources.WHITE_70,
                                  ),
                                ),
                                CommonButton(
                                  width: MediaQuery.of(context).size.width *
                                      ScreenPercentage.SCREEN_SIZE_32.w,
                                  text: StringResources.SIGN_UP,
                                  isloading: state.isLoading,
                                  onTap: () {
                                    if (_formKey.currentState!.validate()) {
                                      BlocProvider.of<AuthBloc>(context).add(
                                          SignUpEvent(
                                              nameController:
                                                  nameController.text,
                                              emailController:
                                                  emailController.text,
                                              phoneController:
                                                  state.countryCode +
                                                      phoneController.text,
                                              addressController:
                                                  addressController.text,
                                              passwordController:
                                                  passwordController.text));
                                    }
                                  },
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      StringResources.ALREADY_ACCOUNT,
                                      style: CustomTextStyles.contentTextStyle(
                                          ColorsResources.WHITE_70),
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const LoginScreen(),
                                              ));
                                        },
                                        child: Text(
                                          StringResources.LOGIN,
                                          style: CustomTextStyles
                                              .textButtonStyle(),
                                        ))
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
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
