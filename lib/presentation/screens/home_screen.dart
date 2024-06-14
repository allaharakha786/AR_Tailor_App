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
import 'package:previous/presentation/widgets/common_network_image.dart';
import 'package:previous/presentation/widgets/decorated_container.dart';
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
                  return SizedBox(
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                        ScreenPercentage.SCREEN_SIZE_10.h,
                                    width: mediaQuerySize.width *
                                        ScreenPercentage.SCREEN_SIZE_15.w,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle),
                                    child: profileBloc.state.profileImage[0]
                                            .data()['profileImage']
                                            .toString()
                                            .toLowerCase()
                                            .contains('http')
                                        ? CommonNetworkImage(
                                            imagePath: profileBloc
                                                .state.profileImage[0]
                                                .data()['profileImage'],
                                          )
                                        : Icon(
                                            Icons.person,
                                            color: ColorsResources.WHITE_70,
                                          )),
                              ],
                            ),
                            Expanded(
                              flex: 4,
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
                                                      details:
                                                          sliderData['details'],
                                                    )));
                                      },
                                      child: Container(
                                          clipBehavior: Clip.antiAlias,
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
                                          child: CommonNetworkImage(
                                            childWidget:
                                                const CommonLoadingIndicator(),
                                            imagePath: state
                                                .sliderDataList[index]
                                                .data()['imageUrl'],
                                          )),
                                    );
                                  }),
                                  options: CarouselOptions(
                                      autoPlay: true,
                                      autoPlayInterval:
                                          const Duration(seconds: 3),
                                      height: mediaQuerySize.height *
                                          ScreenPercentage.SCREEN_SIZE_50.h,
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
                              flex: 7,
                              child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: DimensionsResource
                                          .PADDING_SIZE_SMALL),
                                  child: SingleChildScrollView(
                                    child: Wrap(
                                      direction: Axis.horizontal,
                                      children: List.generate(
                                          state.dressDataList.length, (index) {
                                        dynamic data =
                                            state.dressDataList[index];
                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ItemDetailScreen(
                                                    catagory:
                                                        state.dressDataList[
                                                            index]['catagory'],
                                                    imageUrl:
                                                        state.dressDataList[
                                                            index]['imageUrl'],
                                                    details:
                                                        state.dressDataList[
                                                            index]['details'],
                                                    price: state.dressDataList[
                                                        index]['price'],
                                                    title: state.dressDataList[
                                                        index]['title'],
                                                  ),
                                                ));
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(
                                                DimensionsResource
                                                    .PADDING_SIZE_EXTRA_SMALL),
                                            child: DecoratedContainer(
                                                height: ScreenPercentage
                                                    .SCREEN_SIZE_25,
                                                width: ScreenPercentage
                                                    .SCREEN_SIZE_44,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      DimensionsResource
                                                          .PADDING_SIZE_EXTRA_SMALL),
                                                  child: Column(
                                                    children: [
                                                      Expanded(
                                                        flex: 5,
                                                        child: DecoratedContainer(
                                                            color:
                                                                ColorsResources
                                                                    .WHITE_24,
                                                            height: ScreenPercentage
                                                                .SCREEN_SIZE_15,
                                                            width: ScreenPercentage
                                                                .SCREEN_SIZE_38,
                                                            child: CommonNetworkImage(
                                                                imagePath: state
                                                                            .dressDataList[
                                                                        index][
                                                                    'imageUrl'])),
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          ' ${data['title'].toString().length < 16 ? data['title'] : '${data['title'].toString().substring(0, 15)}...'} ',
                                                          style: CustomTextStyles
                                                              .contentTextStyle(
                                                                  ColorsResources
                                                                      .WHITE_COLOR),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Align(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Text(
                                                              data['catagory'],
                                                            )),
                                                      ),
                                                      Expanded(
                                                        child: Align(
                                                            alignment: Alignment
                                                                .centerRight,
                                                            child: Text(
                                                              '${data['price']} ${StringResources.PKR}',
                                                              style: CustomTextStyles
                                                                  .contentTextStyle(
                                                                      ColorsResources
                                                                          .AMBER_ACCENT),
                                                            )),
                                                      )
                                                    ],
                                                  ),
                                                )),
                                          ),
                                        );
                                      }),
                                    ),
                                  )),
                            )
                          ],
                        ),
                      ));
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
