import 'dart:io';

import 'package:antarmitra/controller/user_provider.dart';
import 'package:antarmitra/firebase_const.dart';
import 'package:antarmitra/navBar.dart';
import 'package:antarmitra/screens/profile.dart';
import 'package:antarmitra/screens/sign_in.dart';
import 'package:antarmitra/widgets/reusable_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
export 'package:firebase_core/firebase_core.dart';
export 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
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
  });
}

class _SignUpScreenState extends State<SignUpScreen> {
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
                "Are you a :-".text.make(),
                RadioListTile(
                  title: Text('Therapist'),
                  value: 1,
                  groupValue: _selectedValue,
                  onChanged: _handleRadioValueChange,
                ),
                RadioListTile(
                  title: Text('User'),
                  value: 2,
                  groupValue: _selectedValue,
                  onChanged: _handleRadioValueChange,
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(height: 20),
                Visibility(
                  visible: _selectedValue == 1 ? true : false,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          padding: EdgeInsets.all(12),
                        ),
                        onPressed: () {
                          selectFile();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Upload Therapist Certificate",
                              style: TextStyle(fontSize: 16),
                            )
                          ],
                        )),
                  ),
                ),
                _buildGoogleSignInButton(),
                const SizedBox(
                  height: 50,
                ),
                firebaseUIButton(context, "Sign Up", () {
                  (certificate && _selectedValue == 1)
                      ? FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                              email: _emailTextController.text,
                              password: _passwordTextController.text)
                          .then((value) => storeUserData(
                              email: _emailTextController.text,
                              password: _passwordTextController.text,
                              name: _userNameTextController.text,
                              type: _selectedValue == 1 ? 'Therapist' : 'User',
                              certificate:
                                  downloadlink != '' ? downloadlink : ''))
                          .then((value) {
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
                                  password: _passwordTextController.text)
                              .then((value) => storeUserData(
                                  email: _emailTextController.text,
                                  password: _passwordTextController.text,
                                  name: _userNameTextController.text,
                                  type: _selectedValue == 1
                                      ? 'Therapist'
                                      : 'User',
                                  certificate:
                                      downloadlink != '' ? downloadlink : ''))
                              .then((value) {
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
          ))),
    );
  }

  Widget _buildGoogleSignInButton() {
    return ElevatedButton.icon(
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
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black, minimumSize: const Size(400, 60)),
      icon: Image.asset("assets/logos/coinLogo.png", height: 30),
      label: const Text(
        "Continue with Google",
        style: TextStyle(color: Colors.white),
      ),
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
