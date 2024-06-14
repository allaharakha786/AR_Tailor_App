import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:previous/businessLogic/blocs/authBloc/auth_bloc.dart';
import 'package:previous/businessLogic/blocs/homeScreenBloc/home_screen_bloc.dart';
import 'package:previous/businessLogic/blocs/bottomNavigationBloc/bottom_navigation_bloc.dart';
import 'package:previous/businessLogic/blocs/ordersBloc/order_bloc.dart';
import 'package:previous/businessLogic/blocs/profileInfoBloc/profile_bloc.dart';
import 'package:previous/helper/constants/colors_resources.dart';

import 'package:previous/presentation/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: 'AIzaSyB7qo36HOmtuqEGEaGLsg2OX-sNhrrw5_U',
              appId: '1:11809106901:android:7dd8f2c9ae7f38ae796b5c',
              messagingSenderId: '11809106901',
              projectId: 'oerassssssssssssssss',
              storageBucket: "oerassssssssssssssss.appspot.com"))
      : await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: 'AIzaSyB7qo36HOmtuqEGEaGLsg2OX-sNhrrw5_U',
              appId: '1:11809106901:android:7dd8f2c9ae7f38ae796b5c',
              messagingSenderId: '11809106901',
              projectId: 'oerassssssssssssssss',
              storageBucket: "oerassssssssssssssss.appspot.com"));
  runApp(const MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Size mediaQuerySize = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ScreenUtilInit(
        minTextAdapt: true,
        splitScreenMode: true,
        designSize: Size(mediaQuerySize.width, mediaQuerySize.height),
        builder: (context, child) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => AuthBloc(),
              ),
              BlocProvider(
                create: (context) => HomeScreenBloc(),
              ),
              BlocProvider(
                create: (context) => BottomNavigationBloc(),
              ),
              BlocProvider(
                create: (context) => OrderBloc(),
              ),
              BlocProvider(
                create: (context) => ProfileInfoBloc(),
              )
            ],
            child: MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                    textTheme: TextTheme(
                        bodyMedium: TextStyle(color: ColorsResources.WHITE_70),
                        bodySmall: TextStyle(color: ColorsResources.WHITE_70),
                        bodyLarge: TextStyle(color: ColorsResources.WHITE_70))),
                home: SplashScreen())),
      ),
    );
  }
}
