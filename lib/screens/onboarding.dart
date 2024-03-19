import 'package:antarmitra/routes/route_name.dart';
import 'package:antarmitra/screens/profile.dart';
import 'package:antarmitra/screens/sign_in.dart';
import 'package:antarmitra/screens/sign_up.dart';
import 'package:antarmitra/utils/app_color.dart';
import 'package:antarmitra/utils/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
// import 'package:femhealth/utils/route_name.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:onboarding/onboarding.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnBoardingSlider(
        headerBackgroundColor: Colors.white,
        finishButtonText: 'Login',
        finishButtonStyle: const FinishButtonStyle(
            highlightElevation: 20,
            elevation: 5,
            backgroundColor: AppColor.first,
            splashColor: AppColor.fifth),
        skipTextButton: const Text('Skip'),
        // trailing: const Text('Login'),
        // pageBackgroundColor: const Color.fromARGB(255, 227, 255, 252),
        background: [
          Column(
            children: [
              const SizedBox(
                height: 60,
              ),
              Container(
                alignment: Alignment.bottomCenter,
                height: 250,
                child: Image.asset(
                  ImagePath.appLogo,
                ),
              ),
            ],
          ),
          Column(
            children: [
              const SizedBox(
                height: 60,
              ),
              Container(
                alignment: Alignment.bottomCenter,
                height: 250,
                child: Image.asset('assets/images/onb2.jpg'),
              ),
            ],
          ),
          // Image.asset('assets/images/onb2.jpg'),
          Image.asset('assets/images/onb1.jpg'),
        ],
        centerBackground: true,

        controllerColor: AppColor.sixth,
        indicatorAbove: true,
        indicatorPosition: 90,

        leading: Image.asset(ImagePath.appLogo),
        onFinish: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool('onboardingCompleted', true);
          // Navigator.of(context).pushNamed(RouteName.signUp);
          Get.to(() => const SignInScreen());
        },

        totalPage: 3,
        speed: 3,
        pageBodies: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: const Column(
              children: <Widget>[
                SizedBox(
                  height: 400,
                ),
                Text(
                  'Welcome to AntarMitra, Your Foe in attaining Inner Peace & Harmony',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: const Column(
              children: <Widget>[
                SizedBox(
                  height: 400,
                ),
                Text(
                  'Train your mind like a muscle: - The more you exercise it , the stronger and more resilient it becomes.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: const Column(
              children: <Widget>[
                SizedBox(
                  height: 400,
                ),
                Text(
                  'Say Goodbye to Anxiety and Bad Thoughts, Integrate AntarMitra in Your life',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
