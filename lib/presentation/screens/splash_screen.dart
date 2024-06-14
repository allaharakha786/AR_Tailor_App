import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:previous/helper/constants/colors_resources.dart';
import 'package:previous/helper/constants/dimentions_resources.dart';
import 'package:previous/helper/constants/image_resources.dart';
import 'package:previous/helper/constants/screen_percentage.dart';
import 'package:previous/helper/constants/string_resources.dart';
import 'package:previous/presentation/screens/bottom_navigation_bar.dart';
import 'package:previous/presentation/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  FirebaseAuth firebaseInstance = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    splashMethod();
  }

  splashMethod() async {
    await Future.delayed(const Duration(seconds: 3));
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => firebaseInstance.currentUser?.uid == null
              ? const LoginScreen()
              : const BottomNavigationBarScreen(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    Size mediaQuerySize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: ColorsResources.BLACK_COLOR,
        height: mediaQuerySize.height * ScreenPercentage.SCREEN_SIZE_100.h,
        width: mediaQuerySize.width * ScreenPercentage.SCREEN_SIZE_100.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                height:
                    mediaQuerySize.height * ScreenPercentage.SCREEN_SIZE_25.h,
                child: Image.asset(ImageResources.APP_LOGO)),
            Text(
              StringResources.AR_TAILOR_APP,
              style: TextStyle(
                  fontFamily: StringResources.CHELA_REGULAR,
                  fontSize: DimensionsResource.FONT_SIZE_LARGE,
                  color: ColorsResources.WHITE_COLOR,
                  letterSpacing: 4),
            )
          ],
        ),
      ),
    );
  }
}
