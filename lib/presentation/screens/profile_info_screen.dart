import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:previous/businessLogic/blocs/profileInfoBloc/profile_bloc.dart';
import 'package:previous/businessLogic/blocs/profileInfoBloc/profile_states.dart';
import 'package:previous/helper/constants/colors_resources.dart';
import 'package:previous/helper/constants/dimentions_resources.dart';
import 'package:previous/helper/constants/screen_percentage.dart';
import 'package:previous/helper/constants/string_resources.dart';
import 'package:previous/helper/data/list_data.dart';
import 'package:previous/helper/enums/status_enums.dart';
import 'package:previous/helper/utills/text_styles.dart';
import 'package:previous/presentation/screens/login_screen.dart';
import 'package:previous/presentation/screens/update_profile_info.dart';
import 'package:previous/presentation/widgets/alert_dialog.dart';
import 'package:previous/presentation/widgets/common_button.dart';
import 'package:previous/presentation/widgets/common_network_image.dart';

import '../../businessLogic/blocs/profileInfoBloc/profile_events.dart';
import '../widgets/loading_indicator.dart';

class ProfileInfoScreen extends StatefulWidget {
  const ProfileInfoScreen({super.key});

  @override
  State<ProfileInfoScreen> createState() => _ProfileInfoScreenState();
}

class _ProfileInfoScreenState extends State<ProfileInfoScreen> {
  late ProfileInfoBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<ProfileInfoBloc>(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size mediaQuerySize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: BlocListener<ProfileInfoBloc, ProfileInfoStates>(
          listener: (context, state) async {
            if (state.states == StatusEnums.ERROR_STATE) {
              ScaffoldMessenger.of(context).clearSnackBars();
              AwesomeDialogAlert.showDialogAlert(context, DialogType.error,
                  StringResources.ERROR_TEXT, state.errorMessage, () {});
            }
            if (state.states == StatusEnums.PROFILE_IMAGE_UPDATED_STATE) {
              Fluttertoast.cancel();
              Fluttertoast.showToast(msg: StringResources.PROFILE_INFO_UPDATED)
                  .then((value) {
                bloc.add(ProfilePicGetEvent());

                bloc.add(GetProfileDetailsEvent());
              });
            }

            if (state.states == StatusEnums.PROFILE_PIC_UPLOADING_STATE) {
              Fluttertoast.showToast(msg: StringResources.UPLOADING_IMAGE);
            }
          },
          child: Container(
            color: ColorsResources.BLACK_COLOR,
            height: mediaQuerySize.height * ScreenPercentage.SCREEN_SIZE_100.h,
            width: mediaQuerySize.width * ScreenPercentage.SCREEN_SIZE_100.w,
            child: BlocBuilder<ProfileInfoBloc, ProfileInfoStates>(
              builder: (context, state) {
                if (state.states == StatusEnums.LOADING_STATE) {
                  return const Center(child: CommonLoadingIndicator());
                }
                if (state.states == StatusEnums.PROFILE_INFO_LOADED_STATE ||
                    state.states == StatusEnums.PROFILE_PIC_GETTED_STATE) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(
                          DimensionsResource.PADDING_SIZE_SMALL),
                      child: Column(
                        children: [
                          state.dataList[0].data()['name'] != null
                              ? Text(
                                  'Hi! ${state.dataList[0].data()['name']}',
                                  style: CustomTextStyles.titleTextStyle(
                                      ColorsResources.WHITE_70),
                                )
                              : const SizedBox(),
                          SizedBox(
                            height: mediaQuerySize.height *
                                ScreenPercentage.SCREEN_SIZE_13.h,
                            width: mediaQuerySize.width *
                                ScreenPercentage.SCREEN_SIZE_27.w,
                            child: Stack(
                              children: [
                                Center(
                                  child: Container(
                                      height: mediaQuerySize.height *
                                          ScreenPercentage.SCREEN_SIZE_20.h,
                                      width: mediaQuerySize.width *
                                          ScreenPercentage.SCREEN_SIZE_30.w,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1,
                                              color: ColorsResources.WHITE_24),
                                          color: ColorsResources.BLACK_COLOR,
                                          shape: BoxShape.circle),
                                      clipBehavior: Clip.antiAlias,
                                      child: state.profileImage[0]
                                              .data()['profileImage']
                                              .toString()
                                              .isEmpty
                                          ? Icon(
                                              Icons.person,
                                              color:
                                                  ColorsResources.WHITE_COLOR,
                                            )
                                          : CommonNetworkImage(
                                              imagePath: state.profileImage[0]
                                                  .data()['profileImage'],
                                            )),
                                ),
                                Align(
                                  alignment: Alignment(
                                      mediaQuerySize.height * 0.0016.h,
                                      mediaQuerySize.height * 0.0012.h),
                                  child: CircleAvatar(
                                    maxRadius: mediaQuerySize.height *
                                        ScreenPercentage.SCREEN_SIZE_2.h,
                                    backgroundColor:
                                        ColorsResources.WHITE_COLOR,
                                    child: FittedBox(
                                      child: IconButton(
                                          onPressed: () {
                                            bloc.add(UpdateProfileImageEvent());
                                          },
                                          icon: Icon(
                                            Icons.edit,
                                            color: ColorsResources.BLACK_COLOR,
                                          )),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Text(StringResources.ACCOUNT_INFO),
                          Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                                onPressed: () {
                                  Map<String, dynamic> data =
                                      state.dataList[0].data();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              UpdateProfileInfo(
                                                profileData: [
                                                  data['name'],
                                                  data['phone'],
                                                  data['email'],
                                                  data['address']
                                                ],
                                              )));
                                },
                                icon: Icon(
                                  Icons.edit,
                                  color: ColorsResources.AMBER_ACCENT,
                                )),
                          ),
                          Column(
                            children: List.generate(4, (index) {
                              Map<String, dynamic> data =
                                  state.dataList[0].data();
                              List<String> dataList = [
                                data['name'],
                                data['phone'],
                                data['email'],
                                data['address']
                              ];

                              return ListTile(
                                leading: Icon(
                                  ListData.profileInfoIconsList[index],
                                  color: ColorsResources.WHITE_70,
                                ),
                                title: Text(
                                  ListData.profileInfoTitlesList[index],
                                  style: CustomTextStyles.contentTextStyle(
                                      ColorsResources.WHITE_70),
                                ),
                                subtitle: Text(
                                  dataList[index],
                                  style: CustomTextStyles.detailsTextStyle(
                                      ColorsResources.AMBER_ACCENT),
                                ),
                              );
                            }),
                          ),
                          CommonButton(
                              isloading: false,
                              text: StringResources.LOGOUT,
                              onTap: () {
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.warning,
                                  headerAnimationLoop: false,
                                  animType: AnimType.bottomSlide,
                                  dismissOnBackKeyPress: false,
                                  dismissOnTouchOutside: false,
                                  title: StringResources.LOGOUT_ALERT,
                                  btnCancelOnPress: () {},
                                  desc: StringResources.LOGOUT_ASK,
                                  descTextStyle:
                                      CustomTextStyles.contentTextStyle(
                                          ColorsResources.BLACK_COLOR),
                                  buttonsTextStyle: TextStyle(
                                      color: ColorsResources.BLACK_COLOR),
                                  btnOkOnPress: () async {
                                    await FirebaseAuth.instance.signOut();
                                    // ignore: use_build_context_synchronously
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginScreen(),
                                        ));
                                  },
                                ).show();
                              },
                              width: mediaQuerySize.width *
                                  ScreenPercentage.SCREEN_SIZE_30.w)
                        ],
                      ),
                    ),
                  );
                }
                return Container();
              },
            ),
          ),
        ),
      ),
    );
  }
}
