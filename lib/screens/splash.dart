// import 'package:femhealth/utils/route_name.dart';
import 'package:antarmitra/firebase_const.dart';
import 'package:antarmitra/navBar.dart';
import 'package:antarmitra/screens/homescreen.dart';
import 'package:antarmitra/screens/onboarding.dart';
import 'package:antarmitra/utils/app_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  gotoNextScreen() {
    Future.delayed(const Duration(seconds: 3), () {
      // Get.to(() => const LoginScren());

      auth.authStateChanges().listen((User? user) {
        if (user == null && mounted) {
          Get.to(const OnBoarding());
        } else {
          Get.to(() => NavBar());
        }
      });
    });
  }

  @override
  void initState() {
    gotoNextScreen();
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
