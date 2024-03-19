import 'package:antarmitra/api/apiservices.dart';
import 'package:antarmitra/controller/user_provider.dart';
import 'package:antarmitra/controller/usercontroller.dart';
import 'package:antarmitra/firebase_options.dart';
import 'package:antarmitra/navBar.dart';
import 'package:antarmitra/screens/splash.dart';
import 'package:antarmitra/utils/app_color.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

String apiCode = '';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: const MyApp(),
    ),
  );

  fetchApiCode();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    String apicode = apiCode;
    return GetMaterialApp(
      title: 'Antarmitra',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Nunito',
        colorScheme: ColorScheme.fromSeed(seedColor: AppColor.first),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
      initialBinding: BindingsBuilder(() {
        Get.put(UserController());
      }),
    );
  }
}
