import 'dart:io';

import 'package:antarmitra/controller/usercontroller.dart';
import 'package:antarmitra/firebase_const.dart';
import 'package:antarmitra/navBar.dart';
import 'package:antarmitra/screens/profile.dart';
import 'package:antarmitra/screens/sign_in.dart';
import 'package:antarmitra/screens/sign_up.dart';
import 'package:antarmitra/utils/app_color.dart';
import 'package:antarmitra/utils/app_constants.dart';
import 'package:antarmitra/widgets/reusableTextField.dart';
import 'package:antarmitra/widgets/reusable_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => SignUpScreenState();
}

storeUserData({name, password, email, type, certificate}) async {
  DocumentReference store = firestore.collection('Users').doc(currentuser!.uid);

  store.set({
    'name': name,
    'password': password,
    'email': email,
    'id': currentuser!.uid,
    'type': type,
    'image_url': '',
    'certificate': certificate,
    'points': 0
  });
}

// storeUserData(
//   email: _emailTextController.text,
//   password: _passwordTextController.text,
//   name: _userNameTextController.text,
//   type: _selectedValue == 1 ? 'Therapist' : 'User',
//   certificate: downloadlink != '' ? downloadlink : '',
// );
// Get.find<UserController>().setUserDetails(
//   name: _userNameTextController.text,
//   email: _emailTextController.text,
//   password: _passwordTextController.text,
//   type: _selectedValue == 1 ? 'Therapist' : 'User',
//   certificate: downloadlink != '' ? downloadlink : '',
// );

class SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _userNameTextController = TextEditingController();

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool certificate = false;

  var downloadlink = '';

  Future<String> uploadFile(String filename, File file) async {
    final ref = FirebaseStorage.instance.ref().child("certificate/$filename");
    final uploadTask = ref.putFile(file);
    await uploadTask.whenComplete(() {});
    final dOwnloadlink = await ref.getDownloadURL();
    return dOwnloadlink;
  }

  void selectFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
    );

    if (result != null) {
      String fileName = result.files[0].name;
      File file = File(result.files[0].path!);
      final downloadLink = await uploadFile(fileName, file);

      print(downloadLink);
      downloadlink = downloadLink;
      certificate = true;
      VxToast.show(context, msg: "Certificate uploaded Successfully");
    }
  }

  int? _selectedValue = 1;

  void _handleRadioValueChange(int? value) {
    setState(() {
      _selectedValue = value;
    });
  }

  // Future<UserCredential?> _handleSignIn() async {
  //   try {
  //     final GoogleSignInAccount? googleSignInAccount =
  //         await _googleSignIn.signIn();
  //     if (googleSignInAccount == null) return null;

  //     final GoogleSignInAuthentication googleSignInAuthentication =
  //         await googleSignInAccount.authentication;
  //     final AuthCredential credential = GoogleAuthProvider.credential(
  //       accessToken: googleSignInAuthentication.accessToken,
  //       idToken: googleSignInAuthentication.idToken,
  //     );

  //     return await _auth.signInWithCredential(credential);
  //   } catch (error) {
  //     print("Error signing in with Google: $error");
  //     return null;
  //   }
  // }

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
                        "Register",
                        style: TextStyle(color: Colors.white, fontSize: 40),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "as User/Therepist ",
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
                                  hintText: "Enter Your Full Name",
                                  isPassword: false,
                                  controller: _userNameTextController),
                              ReusableTextField(
                                  hintText: "Enter Email",
                                  isPassword: false,
                                  controller: _emailTextController),
                              ReusableTextField(
                                  hintText: "Enter your Password",
                                  isPassword: true,
                                  controller: _passwordTextController),
                              const SizedBox(height: 20),
                              Container(
                                color: AppColor.fifth.withOpacity(0.2),
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  children: [
                                    const Text(
                                      "You are a",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    RadioListTile(
                                      title: const Text('Therapist'),
                                      value: 1,
                                      groupValue: _selectedValue,
                                      onChanged: _handleRadioValueChange,
                                    ),
                                    RadioListTile(
                                      title: const Text('User'),
                                      value: 2,
                                      groupValue: _selectedValue,
                                      onChanged: _handleRadioValueChange,
                                    ),
                                    Visibility(
                                      visible:
                                          _selectedValue == 1 ? true : false,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          16)),
                                              padding: const EdgeInsets.all(12),
                                            ),
                                            onPressed: () {
                                              selectFile();
                                            },
                                            child: const Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Upload Therapist Certificate",
                                                  style:
                                                      TextStyle(fontSize: 16),
                                                )
                                              ],
                                            )),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        firebaseUIButton(context, "Sign Up", () {
                          (certificate && _selectedValue == 1)
                              ? FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                      email: _emailTextController.text,
                                      password: _passwordTextController.text)
                                  .then((value) {
                                  storeUserData(
                                    email: _emailTextController.text,
                                    password: _passwordTextController.text,
                                    name: _userNameTextController.text,
                                    type: _selectedValue == 1
                                        ? 'Therapist'
                                        : 'User',
                                    certificate:
                                        downloadlink != '' ? downloadlink : '',
                                  );

                                  print("Created New Account");
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text("Sign-up Successful"),
                                  ));
                                  // Navigator.of(context).pushNamed(RouteName.home);
                                  Get.to(() => const NavBar());
                                }).onError((error, stackTrace) {
                                  print("Error ${error.toString()}");
                                })
                              : _selectedValue == 2
                                  ? FirebaseAuth.instance
                                      .createUserWithEmailAndPassword(
                                          email: _emailTextController.text,
                                          password:
                                              _passwordTextController.text)
                                      .then((value) {
                                      storeUserData(
                                        email: _emailTextController.text,
                                        password: _passwordTextController.text,
                                        name: _userNameTextController.text,
                                        type: _selectedValue == 1
                                            ? 'Therapist'
                                            : 'User',
                                        certificate: downloadlink != ''
                                            ? downloadlink
                                            : '',
                                      );
                                      Get.find<UserController>().setUserDetails(
                                        name: _userNameTextController.text,
                                        email: _emailTextController.text,
                                        password: _passwordTextController.text,
                                        type: _selectedValue == 1
                                            ? 'Therapist'
                                            : 'User',
                                        certificate: downloadlink != ''
                                            ? downloadlink
                                            : '',
                                      );
                                      print("Created New Account");
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text("Sign-up Successful"),
                                      ));
                                      // Navigator.of(context).pushNamed(RouteName.home);
                                      Get.to(() => const NavBar());
                                    }).onError((error, stackTrace) {
                                      print("Error ${error.toString()}");
                                    })
                                  : VxToast.show(context,
                                      msg: "Certificate Not Uploaded!");
                        }),
                        signUpOption(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // Container(
            //   height: 110,
            //   decoration: const BoxDecoration(
            //       gradient: LinearGradient(colors: [
            //     Colors.white,
            //     AppColor.third,
            //   ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
            // )
          ],
        ),
      ),
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Already have an account?",
            style: TextStyle(color: Colors.black)),
        GestureDetector(
          onTap: () {
            // Navigator.of(context).pushNamed(RouteName.signIn);
            Get.to(() => const SignInScreen());
          },
          child: const Text(
            " Sign In",
            style:
                TextStyle(color: AppColor.sixth, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
