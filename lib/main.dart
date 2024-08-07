import 'package:antarmitra/api/apiservices.dart';
// import 'package:antarmitra/controller/user_provider.dart';
import 'package:antarmitra/controller/usercontroller.dart';
import 'package:antarmitra/firebase_const.dart';
import 'package:antarmitra/firebase_options.dart';
import 'package:antarmitra/navBar.dart';
import 'package:antarmitra/screens/gemini_chat/themeNotifier.dart';
import 'package:antarmitra/screens/gemini_chat/themes.dart';
import 'package:antarmitra/screens/splash.dart';
import 'package:antarmitra/utils/app_color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

String apiCode = '';
@override
void main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ProviderScope(child: MyApp()));

  fetchApiCode();

  getSingleDocument();
}

Future<void> getSingleDocument() async {
  DocumentSnapshot documentSnapshot;
  try {
    documentSnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .doc(currentuser!.uid)
        .get();

    if (documentSnapshot.exists) {
      print(
          'Document data: ${documentSnapshot.data() as Map<String, dynamic>?}');
    } else {
      print('Document does not exist');
    }
  } catch (e) {
    print('Error fetching document: $e');
  }
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    String apicode = apiCode;
    return GetMaterialApp(
      title: 'Antarmitra',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Nunito',
        colorScheme: ColorScheme.fromSeed(seedColor: AppColor.first),
        useMaterial3: true,
      ),
      // theme: lightMode,
      darkTheme: darkMode,
      themeMode: themeMode,
      home: const SplashScreen(),
      initialBinding: BindingsBuilder(() {
        Get.put(UserController());
      }),
    );
  }
}
