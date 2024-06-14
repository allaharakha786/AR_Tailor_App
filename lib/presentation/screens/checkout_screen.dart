import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:previous/businessLogic/blocs/ordersBloc/order_bloc.dart';
import 'package:previous/businessLogic/blocs/ordersBloc/order_events.dart';
import 'package:previous/helper/constants/colors_resources.dart';
import 'package:previous/helper/constants/screen_percentage.dart';
import 'package:previous/helper/constants/string_resources.dart';
import 'package:previous/helper/enums/status_enums.dart';
import 'package:previous/presentation/screens/bottom_navigation_bar.dart';
import 'package:previous/presentation/widgets/alert_dialog.dart';
import 'package:previous/presentation/widgets/common_backbutton.dart';
import 'package:previous/presentation/widgets/common_button.dart';

import '../../businessLogic/blocs/ordersBloc/order_states.dart';
import '../../helper/constants/dimentions_resources.dart';
import '../../helper/utills/text_styles.dart';
import '../widgets/drop_down_widget.dart';

import 'billing_details_screen.dart';

// ignore: must_be_immutable
class PaymentMethods extends StatefulWidget {
  String price;
  String title;
  String imageUrl;
  List<TextEditingController> measurementList = [];

  PaymentMethods(
      {super.key,
      required this.price,
      required this.imageUrl,
      required this.title,
      required this.measurementList});

  @override
  State<PaymentMethods> createState() => _PaymentMethodsState();
}

class _PaymentMethodsState extends State<PaymentMethods> {
  late OrderBloc bloc;
  late String imagePath;
  late String imageTitle;
  TextEditingController transactionIdController = TextEditingController();

  List<IconData?> tilesIcons = [Icons.person, Icons.account_box, Icons.payment];
  @override
  void initState() {
    bloc = BlocProvider.of<OrderBloc>(context);
    imagePath = bloc.state.imagePath;
    imageTitle = bloc.state.imageTitle;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size mediaQuerySize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: ColorsResources.BLACK_COLOR,
          height: mediaQuerySize.height * ScreenPercentage.SCREEN_SIZE_100.h,
          width: mediaQuerySize.width * ScreenPercentage.SCREEN_SIZE_100.w,
          child: BlocBuilder<OrderBloc, OrderStates>(
            builder: (context, state) => SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.all(DimensionsResource.PADDING_SIZE_SMALL),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Expanded(child: CommonBackButton()),
                        Expanded(
                          flex: 6,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  right: DimensionsResource
                                      .PADDING_SIZE_EXTRA_LARGE),
                              child: Text(
                                StringResources.CHECK_OUT,
                                style: CustomTextStyles.titleTextStyle(
                                    ColorsResources.WHITE_70),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    StatefulBuilder(
                      builder: (context, setState) => DropDownButton(
                        defaultValue: state.defualtValue,
                        value: (value) {
                          BlocProvider.of<OrderBloc>(context)
                              .add(DropDownEvent(defualtValue: value));
                        },
                        title: StringResources.CHOOSE_PAYMENT_METHOD,
                      ),
                    ),
                    state.defualtValue.toLowerCase().contains('delivery')
                        ? BlocListener<OrderBloc, OrderStates>(
                            listener: (context, state) {
                              if (state.states ==
                                  StatusEnums.ORDERS_ADDED_STATE) {
                                // ignore: void_checks
                                return AwesomeDialogAlert.showDialogAlert(
                                    context,
                                    DialogType.success,
                                    StringResources.ORDER_PLACED,
                                    StringResources.ORDER_PLACED_DISCRIPTION,
                                    () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const BottomNavigationBarScreen(),
                                      ));
                                });
                              }
                              if (state.states == StatusEnums.ERROR_STATE) {
                                ScaffoldMessenger.of(context).clearSnackBars();
                                AwesomeDialogAlert.showDialogAlert(
                                    context,
                                    DialogType.error,
                                    StringResources.ERROR_TEXT,
                                    state.errorMessage, () {
                                  Navigator.pop(context);
                                });
                              }
                            },
                            child: BlocBuilder<OrderBloc, OrderStates>(
                              builder: (context, state) => Padding(
                                padding: const EdgeInsets.all(DimensionsResource
                                    .PADDING_SIZE_EXTRA_SMALL),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      textAlign: TextAlign.center,
                                      StringResources.CASH_ON_DELIVERY_DETAILS,
                                    ),
                                    CommonButton(
                                        text: StringResources.PLACE_ORDER,
                                        onTap: () async {
                                          BlocProvider.of<OrderBloc>(context)
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
                                            state.defualtValue,
                                            '',
                                            '',
                                            '',
                                            ''
                                          ]));
                                        },
                                        width: mediaQuerySize.width *
                                            ScreenPercentage.SCREEN_SIZE_50.w,
                                        isloading: state.isLoading)
                                  ],
                                ),
                              ),
                            ),
                          )
                        : state.defualtValue.toLowerCase().contains('choose')
                            ? Text(StringResources.CHOOSE_ANY_METHOD)
                            : BillingDetailsScreen(
                                title: widget.title,
                                measurementList: widget.measurementList,
                                defaultValue: state.defualtValue,
                                price: widget.price,
                              )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
