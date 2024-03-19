import 'package:antarmitra/navBar.dart';
import 'package:antarmitra/screens/sign_up.dart';
import 'package:antarmitra/screens/sign_up.dart';
import 'package:antarmitra/utils/app_color.dart';
import 'package:antarmitra/utils/app_constants.dart';
import 'package:antarmitra/widgets/reusableTextField.dart';
import 'package:antarmitra/widgets/reusable_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _psTextController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          AppColor.sixth,
          AppColor.second,
          AppColor.third,
        ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 80,
            ),
            const Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Login",
                        style: TextStyle(color: Colors.white, fontSize: 40),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Welcome Back ",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  ),
                  CircleAvatar(
                    backgroundImage:
                        AssetImage('assets/logos/appLogoWhite.png'),
                    radius: 50,
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(60),
                          topRight: Radius.circular(60))),
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 60,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                    color: Color.fromRGBO(27, 212, 225, 0.298),
                                    blurRadius: 20,
                                    offset: Offset(0, 10))
                              ]),
                          child: Column(
                            children: <Widget>[
                              ReusableTextField(
                                  hintText: "Enter Email",
                                  isPassword: false,
                                  controller: _emailTextController),
                              ReusableTextField(
                                  hintText: "Enter your Password",
                                  isPassword: true,
                                  controller: _psTextController),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        InkWell(
                          onTap: () {},
                          child: const Text(
                            "Forgot Password?",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        firebaseUIButton(context, "Sign In", () {
                          setState(() {
                            isLoading = true;
                          });
                          FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: _emailTextController.text,
                                  password: _psTextController.text)
                              .then((value) {
                            // Navigator.of(context).pushNamed(RouteName.home);
                            Get.to(() => const NavBar());
                          }).onError((error, stackTrace) {
                            print("Error ${error.toString()}");
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content:
                                  Text("Sign-in failed: ${error.toString()}"),
                            ));
                          }).whenComplete(() {
                            setState(() {
                              isLoading = false;
                            });
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("Sign-in successful"),
                            ));
                          });
                        }),
                        signUpOption(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: 110,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                Colors.white,
                AppColor.third,
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
            )
          ],
        ),
      ),
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have account?",
            style: TextStyle(color: Color.fromARGB(179, 0, 0, 0))),
        GestureDetector(
          onTap: () {
            // Navigator.of(context).pushNamed(RouteName.signUp);
            Get.to(() => const SignUpScreen());
          },
          child: const Text(
            " Sign Up",
            style:
                TextStyle(color: AppColor.sixth, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
