import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:previous/businessLogic/blocs/ordersBloc/order_bloc.dart';
import 'package:previous/businessLogic/blocs/ordersBloc/order_events.dart';
import 'package:previous/businessLogic/blocs/ordersBloc/order_states.dart';
import 'package:previous/helper/constants/colors_resources.dart';
import 'package:previous/helper/constants/dimentions_resources.dart';
import 'package:previous/helper/constants/screen_percentage.dart';
import 'package:previous/helper/constants/string_resources.dart';
import 'package:previous/helper/enums/status_enums.dart';
import 'package:previous/helper/utills/text_styles.dart';
import 'package:previous/presentation/widgets/alert_dialog.dart';
import 'package:previous/presentation/widgets/common_button.dart';

import '../widgets/loading_indicator.dart';
import 'order_details.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  FirebaseAuth firebaseInstance = FirebaseAuth.instance;
  @override
  void initState() {
    BlocProvider.of<OrderBloc>(context).add(GetOrdersEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size mediaQuerySize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: BlocListener<OrderBloc, OrderStates>(
            listener: (context, state) {
              if (state.states == StatusEnums.ERROR_STATE) {
                ScaffoldMessenger.of(context).clearSnackBars();
                AwesomeDialogAlert.showDialogAlert(
                  context,
                  DialogType.error,
                  StringResources.ERROR_TEXT,
                  state.errorMessage,
                  () => Navigator.pop(context),
                );
              }
            },
            child: Container(
              height:
                  mediaQuerySize.height * ScreenPercentage.SCREEN_SIZE_100.h,
              width: mediaQuerySize.width * ScreenPercentage.SCREEN_SIZE_100.w,
              color: ColorsResources.BLACK_COLOR,
              child: BlocBuilder<OrderBloc, OrderStates>(
                builder: (context, state) {
                  if (state.states == StatusEnums.LOADING_STATE) {
                    const Center(
                      child: CommonLoadingIndicator(),
                    );
                  }
                  if (state.states == StatusEnums.ORDERS_LOADED_STATE) {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(
                            StringResources.ORDER_HISTORY,
                          ),
                          state.dataList.isEmpty
                              ? Text(StringResources.NO_ORDER)
                              : Column(
                                  children: List.generate(state.dataList.length,
                                      (index) {
                                    String status =
                                        state.dataList[index].data()['status'];
                                    return Padding(
                                      padding: const EdgeInsets.all(
                                          DimensionsResource
                                              .PADDING_SIZE_EXTRA_SMALL),
                                      child: Container(
                                        height: mediaQuerySize.height *
                                            ScreenPercentage.SCREEN_SIZE_34.h,
                                        width: mediaQuerySize.width *
                                            ScreenPercentage.SCREEN_SIZE_100.w,
                                        decoration: BoxDecoration(
                                            color: ColorsResources.WHITE_12,
                                            borderRadius: BorderRadius.circular(
                                                DimensionsResource
                                                    .RADIUS_DEFAULT)),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: mediaQuerySize.height *
                                                  ScreenPercentage
                                                      .SCREEN_SIZE_12.h,
                                              width: mediaQuerySize.width *
                                                  ScreenPercentage
                                                      .SCREEN_SIZE_100,
                                              child: Padding(
                                                padding: const EdgeInsets.all(
                                                    DimensionsResource
                                                        .PADDING_SIZE_EXTRA_SMALL),
                                                child: FittedBox(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Icon(
                                                        status
                                                                .toLowerCase()
                                                                .contains(
                                                                    'pending')
                                                            ? Icons.pending
                                                            : Icons.done,
                                                        color: status
                                                                .toLowerCase()
                                                                .contains(
                                                                    'pending')
                                                            ? ColorsResources
                                                                .BLUE_COLOR
                                                            : ColorsResources
                                                                .GREEN_COLOR,
                                                        size: mediaQuerySize
                                                                .height *
                                                            ScreenPercentage
                                                                .SCREEN_SIZE_5
                                                                .h,
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets
                                                            .all(
                                                            DimensionsResource
                                                                .PADDING_SIZE_DEFAULT),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                                '${StringResources.PRODUCT_NAME}  ${state.dataList[index].data()['title']}',
                                                                style: CustomTextStyles
                                                                    .contentTextStyle(
                                                                        ColorsResources
                                                                            .WHITE_COLOR)),
                                                            const SizedBox(
                                                              height: 5,
                                                            ),
                                                            Text(
                                                              '${StringResources.ORDER_TIME_} ${state.dataList[index].data()['orderTime']} ',
                                                              style: CustomTextStyles
                                                                  .contentTextStyle(
                                                                      ColorsResources
                                                                          .WHITE_COLOR),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(
                                                  DimensionsResource
                                                      .PADDING_SIZE_EXTRA_SMALL),
                                              child: Row(
                                                children: [
                                                  Text(StringResources.PRICE,
                                                      style: CustomTextStyles
                                                          .contentTextStyle(
                                                              ColorsResources
                                                                  .WHITE_COLOR)),
                                                  const Spacer(),
                                                  Text(
                                                      ' ${state.dataList[index].data()['price']} PKR',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: ColorsResources
                                                              .WHITE_COLOR)),
                                                ],
                                              ),
                                            ),
                                            Divider(
                                              color:
                                                  ColorsResources.WHITE_COLOR,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(
                                                  DimensionsResource
                                                      .PADDING_SIZE_EXTRA_SMALL),
                                              child: Row(
                                                children: [
                                                  Text(StringResources.STATUS,
                                                      style: CustomTextStyles
                                                          .contentTextStyle(
                                                              ColorsResources
                                                                  .WHITE_COLOR)),
                                                  const Spacer(),
                                                  Text(
                                                      ' ${state.dataList[index].data()['status']}',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: ColorsResources
                                                              .WHITE_COLOR)),
                                                ],
                                              ),
                                            ),
                                            CommonButton(
                                                text: StringResources
                                                    .VIEW_DETAILS,
                                                onTap: () {
                                                  Map<String, dynamic> data =
                                                      state.dataList[index]
                                                          .data();
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            OrderDetailsScreen(
                                                                data: data,
                                                                docId: state
                                                                    .dataList[
                                                                        index]
                                                                    .id),
                                                      ));
                                                },
                                                width: mediaQuerySize.width *
                                                    ScreenPercentage
                                                        .SCREEN_SIZE_35.w,
                                                isloading: false)
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                                )
                        ],
                      ),
                    );
                  }
                  return Container();
                },
              ),
            )),
      ),
    );
  }
}
