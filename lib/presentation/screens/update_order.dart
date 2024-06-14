import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:previous/businessLogic/blocs/ordersBloc/order_bloc.dart';
import 'package:previous/businessLogic/blocs/ordersBloc/order_events.dart';
import 'package:previous/businessLogic/blocs/ordersBloc/order_states.dart';
import 'package:previous/helper/constants/colors_resources.dart';
import 'package:previous/helper/constants/dimentions_resources.dart';
import 'package:previous/helper/constants/screen_percentage.dart';
import 'package:previous/helper/enums/status_enums.dart';
import 'package:previous/helper/extenstions/validation_extension.dart';
import 'package:previous/helper/utills/alert_dialog.dart';
import 'package:previous/helper/utills/text_styles.dart';
import 'package:previous/presentation/screens/bottom_navigation_bar.dart';
import 'package:previous/presentation/widgets/common_backbutton.dart';
import 'package:previous/presentation/widgets/common_button.dart';
import 'package:previous/presentation/widgets/common_textfield.dart';
import 'package:previous/presentation/widgets/sizedbox_padding.dart';

import '../../helper/constants/string_resources.dart';
import '../../helper/data/list_data.dart';
import '../widgets/alert_dialog.dart';

// ignore: must_be_immutable
class UpdateOrderScreen extends StatefulWidget {
  List<String> controllersValues;
  dynamic docId;
  String title;
  UpdateOrderScreen(
      {super.key,
      required this.controllersValues,
      required this.docId,
      required this.title});

  @override
  State<UpdateOrderScreen> createState() => _UpdateOrderScreenState();
}

class _UpdateOrderScreenState extends State<UpdateOrderScreen> {
  final GlobalKey<FormState> _form = GlobalKey();

  List<TextEditingController> controllers = [];
  FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;

  @override
  void initState() {
    for (int i = 0; i < 9; i++) {
      controllers.add(TextEditingController());
      controllers[i].text = widget.controllersValues[i];
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size mediaQuerySize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: mediaQuerySize.height,
          width: mediaQuerySize.width,
          color: ColorsResources.AMBER_ACCENT,
          child: BlocListener<OrderBloc, OrderStates>(
            listener: (context, state) {
              if (state.states == StatusEnums.ORDER_UPDATED_STATE) {
                AwesomeDialogAlert.showDialogAlert(
                    context,
                    DialogType.success,
                    StringResources.ORDER_UPDATED,
                    StringResources.ORDER_UPDATED_DISCRIPTION, () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BottomNavigationBarScreen(),
                      ));
                });
              }
            },
            child: Form(
              key: _form,
              child: Container(
                color: ColorsResources.BLACK_COLOR,
                height:
                    mediaQuerySize.height * ScreenPercentage.SCREEN_SIZE_100.h,
                width:
                    mediaQuerySize.width * ScreenPercentage.SCREEN_SIZE_100.w,
                child: Padding(
                  padding: const EdgeInsets.only(
                      bottom: DimensionsResource.PADDING_SIZE_DEFAULT),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(
                          DimensionsResource.PADDING_SIZE_EXTRA_SMALL),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const CommonBackButton(),
                              SizedBox(
                                width: mediaQuerySize.width *
                                    ScreenPercentage.SCREEN_SIZE_13.w,
                              ),
                              Expanded(
                                child: Text(
                                  widget.title,
                                  style: CustomTextStyles.titleTextStyle(
                                      ColorsResources.WHITE_70),
                                ),
                              )
                            ],
                          ),
                          const SizedBoxPadding(),
                          Text(
                            StringResources.UPDATE_MEASUREMENT,
                            style: CustomTextStyles.titleTextStyle(
                                ColorsResources.WHITE_COLOR),
                          ),
                          const SizedBoxPadding(),
                          SingleChildScrollView(
                            child: Column(
                              children:
                                  List.generate(controllers.length, (index) {
                                return Padding(
                                  padding: const EdgeInsets.all(
                                      DimensionsResource
                                          .PADDING_SIZE_EXTRA_SMALL),
                                  child: CommonTextField(
                                    isSuffix: true,
                                    suffixIcon: Icon(
                                      Icons.visibility,
                                      color: ColorsResources.WHITE_70,
                                    ),
                                    keyboardType: TextInputType.number,
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => DetailsAlertDialog(
                                            detailsText: ListData
                                                    .measurementDiscriptionList[
                                                index],
                                            imageUrl:
                                                ListData.gifUrlsList[index]),
                                      );
                                    },
                                    hintText: ListData.measurementTitles[index],
                                    validator: (value) {
                                      if (value!.fieldValidation()) {
                                        return StringResources
                                            .EMPTY_FIELD_VALIDATION_MESSAGE;
                                      } else if (value.numericValidation()) {
                                        return StringResources
                                            .NUMERIC_VALIDATION;
                                      }
                                      return null;
                                    },
                                    isBorder: true,
                                    controller: controllers[index],
                                  ),
                                );
                              }),
                            ),
                          ),
                          CommonButton(
                              text: StringResources.UPDATE,
                              onTap: () async {
                                if (_form.currentState!.validate()) {
                                  BlocProvider.of<OrderBloc>(context).add(
                                      UpdateOrderEvent(
                                          docId: widget.docId,
                                          dataList: [
                                        controllers[0].text,
                                        controllers[1].text,
                                        controllers[2].text,
                                        controllers[3].text,
                                        controllers[4].text,
                                        controllers[5].text,
                                        controllers[6].text,
                                        controllers[7].text,
                                        controllers[8].text,
                                      ]));
                                }
                              },
                              width: mediaQuerySize.width *
                                  ScreenPercentage.SCREEN_SIZE_50.w,
                              isloading: false)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
