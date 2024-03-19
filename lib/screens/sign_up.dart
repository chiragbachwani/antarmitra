import 'package:antarmitra/controller/user_provider.dart';
import 'package:antarmitra/navBar.dart';
import 'package:antarmitra/screens/sign_in.dart';
import 'package:antarmitra/utils/app_color.dart';
import 'package:antarmitra/widgets/reusable_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _userNameTextController = TextEditingController();

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential?> _handleSignIn() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      if (googleSignInAccount == null) return null;

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      return await _auth.signInWithCredential(credential);
    } catch (error) {
      print("Error signing in with Google: $error");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: const Color.fromARGB(255, 255, 255, 255),
          child: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 80, 20, 0),
            child: Column(
              children: <Widget>[
                logoWidget('assets/logos/coinLogo.png'),
                reusableTextField("Enter Your Name", Icons.person_outline,
                    false, _userNameTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Email Id", Icons.person_outline, false,
                    _emailTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Password", Icons.lock_outlined, true,
                    _passwordTextController),
                const SizedBox(
                  height: 30,
                ),
                _buildGoogleSignInButton(),
                const SizedBox(
                  height: 50,
                ),
                firebaseUIButton(context, "Sign Up", () {
                  Provider.of<UserProvider>(context, listen: false)
                      .setUsername(_userNameTextController.text);
                  FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                          email: _emailTextController.text,
                          password: _passwordTextController.text)
                      .then((value) {
                    print("Created New Account");
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Sign-up Successful"),
                    ));
                    // Navigator.of(context).pushNamed(RouteName.home);
                    Get.to(() => const NavBar());
                  }).onError((error, stackTrace) {
                    print("Error ${error.toString()}");
                  });
                }),
                signUpOption(),
              ],
            ),
          ))),
    );
  }

  Widget _buildGoogleSignInButton() {
    return IconButton(
      onPressed: () async {
        UserCredential? userCredential = await _handleSignIn();
        if (userCredential != null) {
          print("Google Sign-In Successful");
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Google Sign-In Successful"),
          ));
          // Navigator.of(context).pushNamed(RouteName.home);
          Get.to(() => const NavBar());
        } else {
          print("Google Sign-In Failed");
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Google Sign-In Failed"),
          ));
        }
      },
      style: ElevatedButton.styleFrom(backgroundColor: AppColor.fifth),
      icon: Image.asset("assets/logos/google_logo.png", height: 30),
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Already have an account?",
            style: TextStyle(color: Color.fromARGB(179, 222, 0, 133))),
        GestureDetector(
          onTap: () {
            // Navigator.of(context).pushNamed(RouteName.signIn);
            Get.to(() => const SignInScreen());
          },
          child: const Text(
            " Sign In",
            style: TextStyle(
                color: Color.fromARGB(255, 70, 11, 11),
                fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
