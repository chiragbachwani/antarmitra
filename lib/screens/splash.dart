// import 'package:femhealth/utils/route_name.dart';
import 'package:antarmitra/screens/onboarding.dart';
import 'package:antarmitra/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void changeScreen() {
    Future.delayed(const Duration(seconds: 3)).then((_) {
      Get.to(() => const OnBoarding());
    });
  }

  @override
  void initState() {
    changeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Center(
          child: Image.asset(
            ImagePath.appLogo,
            width: 150,
          ),
        ));
  }
}
