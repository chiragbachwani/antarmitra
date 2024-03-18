import 'package:antarmitra/api/apiservices.dart';
import 'package:antarmitra/navBar.dart';
import 'package:antarmitra/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

String apiCode = '';
void main() {
  runApp(const MyApp());
  fetchApiCode();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    String apicode = apiCode;
    return GetMaterialApp(
        title: 'Anatrmitra',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColor.first),
          useMaterial3: true,
        ),
        home: const NavBar());
  }
}
