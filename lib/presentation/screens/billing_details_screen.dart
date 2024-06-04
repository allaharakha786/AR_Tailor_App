import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:previous/businessLogic/blocs/ordersBloc/order_bloc.dart';
import 'package:previous/businessLogic/blocs/ordersBloc/order_events.dart';
import 'package:previous/businessLogic/blocs/ordersBloc/order_states.dart';
import 'package:previous/helper/constants/image_resources.dart';
import 'package:previous/helper/constants/string_resources.dart';
import 'package:previous/helper/enums/status_enums.dart';
import 'package:previous/helper/extenstions/validation_extension.dart';
import 'package:previous/presentation/widgets/alert_dialog.dart';
import 'package:previous/presentation/widgets/loading_indicator.dart';

import '../../helper/constants/colors_resources.dart';
import '../../helper/constants/dimentions_resources.dart';
import '../../helper/constants/screen_percentage.dart';
import '../../helper/data/list_data.dart';
import '../../helper/utills/text_styles.dart';
import '../widgets/common_button.dart';
import '../widgets/common_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../widgets/sizedbox_padding.dart';
import 'bottom_navigation_bar.dart';

// ignore: must_be_immutable
class BillingDetailsScreen extends StatefulWidget {
  String price;
  String title;
  String defaultValue;
  List<TextEditingController> measurementList = [];

  BillingDetailsScreen(
      {super.key,
      required this.title,
      required this.price,
      required this.defaultValue,
      required this.measurementList});

  @override
  State<BillingDetailsScreen> createState() => _BillingDetailsScreenState();
}

class _BillingDetailsScreenState extends State<BillingDetailsScreen> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  List<IconData?> tilesIcons = [Icons.person, Icons.account_box, Icons.payment];
  List jazzcashSubtitleList = [];
  List easypaisaSubtitleList = [];
  List<String> tileTitlesList = [];
  FirebaseAuth firebaseInstance = FirebaseAuth.instance;
  FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;
  TextEditingController transactionId = TextEditingController();

  @override
  void initState() {
    super.initState();
    jazzcashSubtitleList = ['Allah Rakha', '03098988136', widget.price];
    easypaisaSubtitleList = ['Manzoor Ahmad', '03427330589', widget.price];
    tileTitlesList = ListData.billingTitleList;
    BlocProvider.of<OrderBloc>(context).add(ClearImagePathEvent());
  }

  @override
  Widget build(BuildContext context) {
    Size mediaQuerySize = MediaQuery.of(context).size;

    return BlocListener<OrderBloc, OrderStates>(
      listener: (context, state) {
        if (state.states == StatusEnums.ORDERS_ADDED_STATE) {
          AwesomeDialogAlert.showDialogAlert(
            context,
            DialogType.success,
            StringResources.ORDER_PLACED,
            StringResources.ORDER_PLACED_DISCRIPTION,
            () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const BottomNavigationBarScreen(),
                )),
          );
        }
        if (state.states == StatusEnums.ERROR_STATE) {
          // ignore: void_checks
          return AwesomeDialogAlert.showDialogAlert(
              context,
              DialogType.error,
              StringResources.ERROR_TEXT,
              state.errorMessage,
              () => Navigator.pop(context));
        }
      },
      child: BlocBuilder<OrderBloc, OrderStates>(
        builder: (context, state) => Form(
          key: _form,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height:
                      mediaQuerySize.height * ScreenPercentage.SCREEN_SIZE_20.h,
                  width:
                      mediaQuerySize.width * ScreenPercentage.SCREEN_SIZE_100.w,
                  child: FittedBox(
                    child: Image.asset(
                        widget.defaultValue.toLowerCase().contains('jazz')
                            ? ImageResources.JAZZCASH_ICON
                            : ImageResources.EASYPAISA_ICON,
                        fit: BoxFit.contain),
                  ),
                ),
                const SizedBoxPadding(),
                Center(
                    child: SizedBox(
                  width:
                      mediaQuerySize.width * ScreenPercentage.SCREEN_SIZE_70.w,
                  child: FittedBox(
                    child: Text(
                      StringResources.BILLING_DETAILS,
                      style: CustomTextStyles.textButtonStyle(),
                    ),
                  ),
                )),
                Column(
                  children: List.generate(
                      tilesIcons.length,
                      (index) => Column(
                            children: [
                              ListTile(
                                leading: Icon(
                                  tilesIcons[index],
                                  color: ColorsResources.WHITE_70,
                                ),
                                title: Text(
                                  tileTitlesList[index],
                                  style: TextStyle(
                                      color: ColorsResources.WHITE_70),
                                ),
                                subtitle: Text(widget.defaultValue
                                        .toLowerCase()
                                        .contains('jazz')
                                    ? jazzcashSubtitleList[index]
                                    : easypaisaSubtitleList[index]),
                              ),
                              Divider(
                                color: ColorsResources.WHITE_24,
                                height: 0,
                              )
                            ],
                          )),
                ),
                const SizedBoxPadding(),
                Center(
                    child: SizedBox(
                  width:
                      mediaQuerySize.width * ScreenPercentage.SCREEN_SIZE_80.w,
                  child: FittedBox(
                    child: Text(
                      StringResources.MENUAL_PAYMENT_INSTRUCTION,
                      style: CustomTextStyles.elevatedTextButtonStyle(
                          ColorsResources.WHITE_COLOR),
                    ),
                  ),
                )),
                widget.defaultValue.toLowerCase().contains('easy')
                    ? Text(
                        "1:  Open your Easypaisa Mobile App\n2: Go to the 'Send Money' section\n3: Choose EasyPaisa account\n4: Enter the amount of ${widget.price} to pay\n5: Review the details and confirm the payment",
                      )
                    : Text(
                        "1:  Open your JazzCash Mobile App\n2: Go to the 'Send Money' section\n3: Enter the amount of ${widget.price} to pay\n4: Review the details and confirm the payment",
                      ),
                const Divider(),
                Text(StringResources.BILLING_NOTE),
                state.imagePath.isEmpty
                    ? StatefulBuilder(
                        builder: (context, setState) => Center(
                          child: CommonButton(
                              text: StringResources.UPLOAD_SCREENSHOT,
                              onTap: () {
                                BlocProvider.of<OrderBloc>(context)
                                    .add(UploadScreenshotEvent());
                              },
                              width: mediaQuerySize.width *
                                  ScreenPercentage.SCREEN_SIZE_75.w,
                              isloading: false),
                        ),
                      )
                    : StatefulBuilder(
                        builder: (context, setState) => Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: DimensionsResource
                                      .PADDING_SIZE_EXTRA_SMALL,
                                  bottom: DimensionsResource
                                      .PADDING_SIZE_EXTRA_SMALL),
                              child: Container(
                                height: mediaQuerySize.height *
                                    ScreenPercentage.SCREEN_SIZE_30.h,
                                width: mediaQuerySize.width *
                                    ScreenPercentage.SCREEN_SIZE_100.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      DimensionsResource.RADIUS_DEFAULT),
                                ),
                                child: Image.network(
                                  state.imagePath,
                                  fit: BoxFit.cover,
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    }
                                    return const Center(
                                      child: CommonLoadingIndicator(),
                                    );
                                  },
                                ),
                              ),
                            ),
                            Text(state.imageTitle)
                          ],
                        ),
                      ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: DimensionsResource.PADDING_SIZE_EXTRA_SMALL),
                  child: CommonTextField(
                    controller: transactionId,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.fieldValidation()) {
                        return StringResources.EMPTY_FIELD_VALIDATION_MESSAGE;
                      }
                      if (value.numericValidation()) {
                        return StringResources.NUMERIC_VALIDATION;
                      }
                      return null;
                    },
                    prefixIcon: const Icon(Icons.view_compact_rounded),
                    isBorder: true,
                    hintText: StringResources.ENTER_TD,
                  ),
                ),
                Center(
                  child: CommonButton(
                      text: StringResources.PLACE_ORDER,
                      onTap: () async {
                        if (_form.currentState!.validate()) {
                          state.imagePath.isEmpty
                              ? AwesomeDialogAlert.showDialogAlert(
                                  context,
                                  DialogType.warning,
                                  'Warning',
                                  StringResources.SELECT_SCREENSHOT,
                                  () {})
                              : BlocProvider.of<OrderBloc>(context)
                                  .add(AddOrderEvent(orderData: [
                                  widget.measurementList[0].text,
                                  widget.measurementList[1].text,
                                  widget.measurementList[2].text,
                                  widget.measurementList[3].text,
                                  widget.measurementList[4].text,
                                  widget.measurementList[5].text,
                                  widget.measurementList[6].text,
                                  widget.measurementList[7].text,
                                  widget.measurementList[8].text,
                                  widget.price,
                                  widget.title,
                                  widget.defaultValue,
                                  transactionId.text,
                                  state.imagePath,
                                  StringResources.PENDING,
                                  state.imageTitle
                                ]));
                        }
                      },
                      width: mediaQuerySize.width *
                          ScreenPercentage.SCREEN_SIZE_50.w,
                      isloading: state.isLoading),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
