import 'package:flutter/material.dart';

class CustomRoute {
  static Route<dynamic> allRoutes(RouteSettings settings) {
    return MaterialPageRoute(builder: (context) {
      switch (settings.name) {
        // case RouteName.splash:
        //   return const SplashScreen();
        // case RouteName.onboarding:
        //   return const OnBoarding();
        // case RouteName.signUp:
        //   return const SignUpScreen();
        // case RouteName.signIn:
        //   return const SignInScreen();
        // case RouteName.home:
        //   return const HomeScreen();

        default:
          return const Scaffold(body: Center(child: Text('Route not found')));
      }
    });
  }
}
