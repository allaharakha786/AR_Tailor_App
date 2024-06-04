import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:previous/businessLogic/blocs/homeScreenBloc/home_screen_bloc.dart';
import 'package:previous/businessLogic/blocs/homeScreenBloc/home_screen_states.dart';
import 'package:previous/businessLogic/blocs/profileInfoBloc/profile_events.dart';
import 'package:previous/helper/constants/colors_resources.dart';
import 'package:previous/helper/constants/dimentions_resources.dart';
import 'package:previous/helper/constants/screen_percentage.dart';
import 'package:previous/helper/constants/string_resources.dart';
import 'package:previous/helper/enums/status_enums.dart';
import 'package:previous/helper/utills/text_styles.dart';
import '../../businessLogic/blocs/homeScreenBloc/home_screen_events.dart';
import '../../businessLogic/blocs/profileInfoBloc/profile_bloc.dart';
import '../widgets/loading_indicator.dart';
import 'item_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ProfileInfoBloc profileBloc;
  late HomeScreenBloc homeScreenBloc;
  @override
  void initState() {
    profileBloc = BlocProvider.of<ProfileInfoBloc>(context);
    homeScreenBloc = BlocProvider.of<HomeScreenBloc>(context);
    profileBloc.add(ProfilePicGetEvent());
    homeScreenBloc.add(GetDressDataEvent());
    homeScreenBloc.add(GetSliderImagesEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size mediaQuerySize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: BlocListener<HomeScreenBloc, HomeScreenStates>(
          listener: (context, state) {},
          child: Container(
            color: ColorsResources.BLACK_COLOR,
            height: mediaQuerySize.height * ScreenPercentage.SCREEN_SIZE_100.h,
            width: mediaQuerySize.width * ScreenPercentage.SCREEN_SIZE_100.w,
            child: BlocBuilder<HomeScreenBloc, HomeScreenStates>(
              builder: (context, state) {
                if (state.states == StatusEnums.LOADING_STATE) {
                  return const Center(
                    child: CommonLoadingIndicator(),
                  );
                }
                if (state.states == StatusEnums.DRESS_LOADED_STATE ||
                    state.states == StatusEnums.SLIDER_IMAGES_LOADED_STATE) {
                  return SingleChildScrollView(
                    child: SizedBox(
                        height: mediaQuerySize.height *
                            ScreenPercentage.SCREEN_SIZE_100.h,
                        width: mediaQuerySize.width *
                            ScreenPercentage.SCREEN_SIZE_100.w,
                        child: Padding(
                          padding: const EdgeInsets.all(
                              DimensionsResource.PADDING_SIZE_EXTRA_SMALL),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: mediaQuerySize.width *
                                        ScreenPercentage.SCREEN_SIZE_5.w,
                                  ),
                                  Text(
                                    StringResources.HOMEPAGE,
                                    style: CustomTextStyles.titleTextStyle(
                                        ColorsResources.WHITE_70),
                                  ),
                                  Container(
                                      clipBehavior: Clip.antiAlias,
                                      height: mediaQuerySize.height *
                                          ScreenPercentage.SCREEN_SIZE_6.h,
                                      width: mediaQuerySize.width *
                                          ScreenPercentage.SCREEN_SIZE_15.w,
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle),
                                      child: profileBloc.state.profileImage[0]
                                              .data()['profileImage']
                                              .toString()
                                              .toLowerCase()
                                              .contains('http')
                                          ? Image.network(
                                              profileBloc.state.profileImage[0]
                                                  .data()['profileImage'],
                                              fit: BoxFit.cover,
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                if (error is HttpException) {
                                                  return Center(
                                                      child: Text(
                                                          '${StringResources.NETWORK_ERROR} ${error.message}'));
                                                } else {
                                                  return Center(
                                                      child: Text(
                                                          StringResources
                                                              .ERROR_MESSAGE));
                                                }
                                              },
                                              loadingBuilder: (context, child,
                                                  loadingProgress) {
                                                if (loadingProgress == null) {
                                                  return child;
                                                }
                                                return const Center(
                                                    child:
                                                        CircularProgressIndicator());
                                              },
                                            )
                                          : Icon(
                                              Icons.person,
                                              color: ColorsResources.WHITE_70,
                                            )),
                                ],
                              ),
                              Expanded(
                                flex: 2,
                                child: CarouselSlider(
                                    items: List.generate(
                                        state.sliderDataList.length, (index) {
                                      Map<String, dynamic> sliderData =
                                          state.sliderDataList[index].data();
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ItemDetailScreen(
                                                        imageUrl: sliderData[
                                                            'imageUrl'],
                                                        title:
                                                            sliderData['title'],
                                                        price:
                                                            sliderData['price'],
                                                        catagory: sliderData[
                                                            'catagory'],
                                                        details: sliderData[
                                                            'details'],
                                                      )));
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.only(
                                              left: DimensionsResource
                                                  .PADDING_SIZE_EXTRA_SMALL,
                                              right: DimensionsResource
                                                  .PADDING_SIZE_SMALL),
                                          decoration: BoxDecoration(
                                            color: ColorsResources.WHITE_12,
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(
                                                        DimensionsResource
                                                            .RADIUS_DEFAULT)),
                                          ),
                                          child: Image.network(
                                            state.sliderDataList[index]
                                                .data()['imageUrl'],
                                            fit: BoxFit.cover,
                                            loadingBuilder: (context, child,
                                                loadingProgress) {
                                              if (loadingProgress == null) {
                                                return child;
                                              }
                                              return const CommonLoadingIndicator();
                                            },
                                          ),
                                        ),
                                      );
                                    }),
                                    options: CarouselOptions(
                                        autoPlay: true,
                                        autoPlayInterval:
                                            const Duration(seconds: 3),
                                        height: mediaQuerySize.height *
                                            ScreenPercentage.SCREEN_SIZE_30.h,
                                        viewportFraction: 0.9)),
                              ),
                              Center(
                                child: Text(
                                  StringResources.TOP_PICKS,
                                  style: TextStyle(
                                      color: ColorsResources.WHITE_COLOR),
                                ),
                              ),
                              Expanded(
                                  flex: 3,
                                  child: Wrap(
                                    children: List.generate(
                                        state.dressDataList.length, (index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(
                                            DimensionsResource
                                                .PADDING_SIZE_SMALL),
                                        child: GestureDetector(
                                          onTap: () {
                                            Map<String, dynamic> dressData =
                                                state.dressDataList[index]
                                                    .data();
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ItemDetailScreen(
                                                    imageUrl:
                                                        dressData['imageUrl'],
                                                    title: dressData['title'],
                                                    price: dressData['price'],
                                                    catagory:
                                                        dressData['catagory'],
                                                    details:
                                                        dressData['details'],
                                                  ),
                                                ));
                                          },
                                          child: Container(
                                            height: mediaQuerySize.height *
                                                ScreenPercentage
                                                    .SCREEN_SIZE_20.h,
                                            width: mediaQuerySize.width *
                                                ScreenPercentage
                                                    .SCREEN_SIZE_42.w,
                                            decoration: BoxDecoration(
                                                color: ColorsResources.WHITE_12,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        DimensionsResource
                                                            .RADIUS_DEFAULT)),
                                            child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    flex: 3,
                                                    child: Container(
                                                      margin: const EdgeInsets
                                                          .only(
                                                          left: DimensionsResource
                                                              .PADDING_SIZE_SMALL,
                                                          top: DimensionsResource
                                                              .PADDING_SIZE_EXTRA_SMALL,
                                                          right: DimensionsResource
                                                              .PADDING_SIZE_SMALL),
                                                      decoration: BoxDecoration(
                                                          borderRadius: const BorderRadius
                                                              .all(
                                                              Radius.circular(
                                                                  DimensionsResource
                                                                      .RADIUS_DEFAULT)),
                                                          color: ColorsResources
                                                              .WHITE_12),
                                                      child: Image.network(
                                                        state.dressDataList[
                                                                index]
                                                            .data()['imageUrl'],
                                                        fit: BoxFit.cover,
                                                        loadingBuilder: (context,
                                                            child,
                                                            loadingProgress) {
                                                          if (loadingProgress ==
                                                              null) {
                                                            return child;
                                                          }
                                                          return const Center(
                                                              child:
                                                                  CircularProgressIndicator());
                                                        },
                                                        errorBuilder: (context,
                                                            error, stackTrace) {
                                                          if (error
                                                              is HttpException) {
                                                            return Center(
                                                                child: Text(
                                                                    '${StringResources.NETWORK_ERROR}  ${error.message}'));
                                                          } else {
                                                            return Center(
                                                                child: Text(
                                                              StringResources
                                                                  .ERROR_MESSAGE,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ));
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                  state.dressDataList[index]
                                                              .data()['title']
                                                              .length <
                                                          15
                                                      ? Expanded(
                                                          flex: 1,
                                                          child: Container(
                                                            margin: const EdgeInsets
                                                                .only(
                                                                left: DimensionsResource
                                                                    .PADDING_SIZE_EXTRA_SMALL,
                                                                right: DimensionsResource
                                                                    .PADDING_SIZE_EXTRA_SMALL),
                                                            child: FittedBox(
                                                              child: Text(
                                                                  state.dressDataList[
                                                                              index]
                                                                          .data()[
                                                                      'title'],
                                                                  style: CustomTextStyles
                                                                      .elevatedTextButtonStyle(
                                                                          ColorsResources
                                                                              .WHITE_70)),
                                                            ),
                                                          ),
                                                        )
                                                      : Expanded(
                                                          flex: 1,
                                                          child: Container(
                                                            margin: const EdgeInsets
                                                                .only(
                                                                left: DimensionsResource
                                                                    .PADDING_SIZE_EXTRA_SMALL,
                                                                right: DimensionsResource
                                                                    .PADDING_SIZE_EXTRA_SMALL),
                                                            child: FittedBox(
                                                              child: Text(
                                                                '${state.dressDataList[index].data()['title'].substring(0, 13)}..',
                                                                style: CustomTextStyles
                                                                    .contentTextStyle(
                                                                        ColorsResources
                                                                            .WHITE_70),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .only(
                                                            right: DimensionsResource
                                                                .PADDING_SIZE_DEFAULT,
                                                            left: DimensionsResource
                                                                .PADDING_SIZE_EXTRA_SMALL,
                                                          ),
                                                          child: FittedBox(
                                                            child: Text(
                                                              state.dressDataList[
                                                                          index]
                                                                      .data()[
                                                                  'catagory'],
                                                              style: CustomTextStyles
                                                                  .contentTextStyle(
                                                                      ColorsResources
                                                                          .WHITE_70),
                                                            ),
                                                          ),
                                                        )),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Align(
                                                        alignment: Alignment
                                                            .centerRight,
                                                        child: Container(
                                                          margin: const EdgeInsets
                                                              .only(
                                                              right: DimensionsResource
                                                                  .PADDING_SIZE_EXTRA_SMALL),
                                                          child: FittedBox(
                                                            child: Text(
                                                              '\$ ${state.dressDataList[index].data()['price']}',
                                                              style: CustomTextStyles
                                                                  .contentTextStyle(
                                                                      ColorsResources
                                                                          .AMBER_ACCENT),
                                                            ),
                                                          ),
                                                        )),
                                                  ),
                                                ]),
                                          ),
                                        ),
                                      );
                                    }),
                                  )),
                            ],
                          ),
                        )),
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
