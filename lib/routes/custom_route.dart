import 'package:antarmitra/routes/route_name.dart';
import 'package:antarmitra/screens/prayatnascreen.dart';
import 'package:flutter/material.dart';

class CustomRoute {
  static Route<dynamic> allRoutes(RouteSettings settings) {
    return MaterialPageRoute(builder: (context) {
      switch (settings.name) {
        case RouteName.prayatna:
          return const prayatnaCode();
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
