import 'package:antarmitra/routes/route_name.dart';
import 'package:antarmitra/screens/profile.dart';
import 'package:antarmitra/screens/sign_up.dart';
import 'package:antarmitra/utils/app_color.dart';
import 'package:antarmitra/utils/app_constants.dart';
import 'package:get/get.dart';
// import 'package:femhealth/utils/route_name.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
// import 'package:onboarding/onboarding.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnBoardingSlider(
        headerBackgroundColor: Colors.white,
        finishButtonText: 'Register',
        finishButtonStyle: const FinishButtonStyle(
          backgroundColor: AppColor.first,
        ),
        skipTextButton: const Text('Skip'),
        // trailing: const Text('Login'),
        // pageBackgroundColor: const Color.fromARGB(255, 227, 255, 252),
        background: [
          Image.asset('assets/images/onb3.jpg'),
          Image.asset('assets/images/onb2.jpg'),
          Image.asset('assets/images/onb1.jpg'),
        ],
        centerBackground: true,
        // hasFloatingButton: true,
        controllerColor: AppColor.sixth,
        indicatorAbove: true,
        indicatorPosition: 90,

        leading: Image.asset(ImagePath.coinLogo),
        onFinish: () {
          // Navigator.of(context).pushNamed(RouteName.signUp);
          Get.to(() => const SignUpScreen());
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
                  'Welcome to Your Well-being Journey',
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
                    'Effortlessly monitor your menstrual cycle and identify fertile days with our intuitive ovulation tracker. Understand your body\'s natural rhythm for better family planning or simply to stay in tune with your health'),
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
                    'Get personalized insights into your health journey. Track ovulation, fertility, and receive helpful tips tailored to your unique needs. Your well-being is our priority, empowering you to make informed decisions for a healthier lifestyle'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
