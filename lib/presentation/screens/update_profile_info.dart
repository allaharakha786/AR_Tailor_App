import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:previous/businessLogic/blocs/profileInfoBloc/profile_bloc.dart';
import 'package:previous/businessLogic/blocs/profileInfoBloc/profile_events.dart';
import 'package:previous/businessLogic/blocs/profileInfoBloc/profile_states.dart';
import 'package:previous/helper/constants/screen_percentage.dart';
import 'package:previous/helper/constants/string_resources.dart';
import 'package:previous/helper/enums/status_enums.dart';
import 'package:previous/presentation/screens/bottom_navigation_bar.dart';
import 'package:previous/presentation/widgets/alert_dialog.dart';
import 'package:previous/presentation/widgets/common_backbutton.dart';
import 'package:previous/presentation/widgets/common_button.dart';
import 'package:previous/presentation/widgets/common_textfield.dart';

import '../../helper/constants/colors_resources.dart';
import '../../helper/constants/dimentions_resources.dart';

// ignore: must_be_immutable
class UpdateProfileInfo extends StatefulWidget {
  List<String> profileData;
  UpdateProfileInfo({super.key, required this.profileData});

  @override
  State<UpdateProfileInfo> createState() => _UpdateProfileInfoState();
}

class _UpdateProfileInfoState extends State<UpdateProfileInfo> {
  late List<TextEditingController> controller = [];
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  void initState() {
    for (int i = 0; i < 4; i++) {
      controller.add(TextEditingController());
      controller[i].text = widget.profileData[i];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size mediaQuerySize = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: BlocListener<ProfileInfoBloc, ProfileInfoStates>(
          listener: (context, state) {
            if (state.states == StatusEnums.PROFILE_INFO_UPDATED_STATE) {
              AwesomeDialogAlert.showDialogAlert(
                  context,
                  DialogType.success,
                  StringResources.PROFILE_UPDATED,
                  StringResources.PROFILE_UPDATED_DISCRIPTION, () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BottomNavigationBarScreen(),
                    ));
              });
            }
          },
          child: BlocBuilder<ProfileInfoBloc, ProfileInfoStates>(
            builder: (context, state) => Form(
              key: _key,
              child: Container(
                  height: mediaQuerySize.height *
                      ScreenPercentage.SCREEN_SIZE_100.h,
                  width:
                      mediaQuerySize.width * ScreenPercentage.SCREEN_SIZE_100.w,
                  color: ColorsResources.BLACK_COLOR,
                  child: Padding(
                    padding: const EdgeInsets.all(
                        DimensionsResource.PADDING_SIZE_DEFAULT),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Expanded(child: CommonBackButton()),
                                Expanded(
                                    flex: 6,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          right: DimensionsResource
                                              .PADDING_SIZE_EXTRA_LARGE),
                                      child: Center(
                                          child: Text(
                                              StringResources.EDIT_PROFILE)),
                                    )),
                              ]),
                          Column(
                              children: List.generate(4, (index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  top: DimensionsResource.PADDING_SIZE_SMALL),
                              child: CommonTextField(
                                readOnly: [false, false, true, false][index],
                                controller: controller[index],
                                prefixIcon: [
                                  const Icon(Icons.person),
                                  const Icon(Icons.call),
                                  const Icon(Icons.email),
                                  const Icon(Icons.location_history)
                                ][index],
                                keyboardType: TextInputType.text,
                                hintText: [
                                  'Name',
                                  'Mobile',
                                  'Email',
                                  'Address'
                                ][index],
                                isSuffix: false,
                                isBorder: true,
                              ),
                            );
                          })),
                          CommonButton(
                              text: StringResources.UPDATE,
                              onTap: () {
                                if (_key.currentState!.validate()) {
                                  BlocProvider.of<ProfileInfoBloc>(context).add(
                                      UpdateProfileInfoEvent(profileInfo: [
                                    controller[0].text,
                                    controller[1].text,
                                    controller[3].text
                                  ]));
                                  BlocProvider.of<ProfileInfoBloc>(context)
                                      .add(GetProfileDetailsEvent());
                                }
                              },
                              width: mediaQuerySize.width *
                                  ScreenPercentage.SCREEN_SIZE_40.w,
                              isloading: state.isLoading)
                        ],
                      ),
                    ),
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
