// import 'package:female_health/utils/route_name.dart';
// import 'package:female_health/widgets/reusable_widget.dart';
import 'package:antarmitra/navBar.dart';
import 'package:antarmitra/screens/sign_up.dart';
import 'package:antarmitra/utils/app_color.dart';
import 'package:antarmitra/widgets/reusable_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
                gradient: LinearGradient(begin: Alignment.topCenter, colors: [
              AppColor.first,
              AppColor.second,
              AppColor.third,
            ])),
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                    20, MediaQuery.of(context).size.height * 0.1, 20, 0),
                child: Column(
                  children: <Widget>[
                    // logoWidget("assets/logos/coinLogo.png"),
                    const SizedBox(
                      height: 30,
                    ),
                    reusableTextField("Enter Email", Icons.person_outline,
                        false, _emailTextController),
                    const SizedBox(
                      height: 20,
                    ),
                    reusableTextField("Enter Password", Icons.lock_outline,
                        true, _passwordTextController),
                    const SizedBox(
                      height: 5,
                    ),
                    forgetPassword(context),
                    if (isLoading)
                      const CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 5,
                      ),
                    const SizedBox(height: 30),
                    firebaseUIButton(context, "Sign In", () {
                      setState(() {
                        isLoading = true;
                      });
                      FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: _emailTextController.text,
                              password: _passwordTextController.text)
                          .then((value) {
                        // Navigator.of(context).pushNamed(RouteName.home);
                        Get.to(() => const NavBar());
                      }).onError((error, stackTrace) {
                        print("Error ${error.toString()}");
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Sign-in failed: ${error.toString()}"),
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
                    signUpOption()
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(20), right: Radius.circular(20))),
            ),
          )
        ],
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
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  Widget forgetPassword(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 35,
      alignment: Alignment.bottomRight,
      child: TextButton(
          child: const Text(
            "Forgot Password?",
            style: TextStyle(color: Colors.white70),
            textAlign: TextAlign.right,
          ),
          onPressed: () {}),
    );
  }
}
