import 'package:antarmitra/screens/onboarding.dart';
import 'package:antarmitra/screens/profile.dart';
import 'package:antarmitra/screens/sign_in.dart';
import 'package:antarmitra/utils/app_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
export 'package:velocity_x/velocity_x.dart';
import 'package:get/get.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: widget.isShowed,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Vx.gray700,
          ),
          onPressed: () {
            //Get.offAll(() => Home());
          },
        ),
        backgroundColor: Colors.white,
        title: const Text(
          'Account',
          style: TextStyle(color: Vx.gray600),
        ),
        actions: [
          TextButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                // _googleSignIn.signOut();
                VxToast.show(
                  context,
                  msg: "Logged out successfully",
                );
                // Navigator.of(context)
                //     .pushReplacement(MaterialPageRoute(builder: (context) {
                //   return SignInScreen();

                // }));
              },
              child: "Logout".text.size(16).bold.make())
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                10.heightBox,
                // data['image_url'] == '' &&
                //         controller.profileImgPath.isEmpty
                //     ?
                const CircleAvatar(
                  radius: 60,
                  // backgroundImage: AssetImage("assets/image/profile.gif"),
                )
                // : data['image_url'] != '' &&
                //         controller.profileImgPath.isEmpty
                //     ? CircleAvatar(
                //         radius: 60,
                //         backgroundImage:
                //             NetworkImage(data['image_url']))
                //     : CircleAvatar(
                //         radius: 60,
                //         backgroundImage: FileImage(
                //             File(controller.profileImgPath.value)),
                //       ),
                ,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () async {
                          // await controller
                          //     .selectImagefromGallery(context);
                          // if (controller
                          //     .profileImgPath.value.isNotEmpty) {
                          //   await controller.uplaodProfileImage();
                          // } else {
                          //   controller.profileImagelink =
                          //       data['image_url'];
                          // }
                          // controller.storeimage();
                          // setState(() {
                          //   VxToast.show(context, msg: "Profile Updated");
                          // });
                        },
                        icon: const Icon(
                          Icons.photo_size_select_actual_rounded,
                          color: Vx.gray600,
                        )),
                    5.widthBox,
                    IconButton(
                        onPressed: () async {
                          // await controller.selectImagefromCamera(context);
                          // if (controller
                          //     .profileImgPath.value.isNotEmpty) {
                          //   await controller.uplaodProfileImage();
                          // } else {
                          //   controller.profileImagelink =
                          //       data['image_url'];
                          // }
                          // controller.storeimage();
                          // setState(() {
                          //   VxToast.show(context, msg: "Profile Updated");
                          // });
                        },
                        icon: const Icon(
                          Icons.camera,
                          color: Vx.gray600,
                        ))
                  ],
                ),
                // data['Username'] == null
                // ?
                " Username Not Set".text.semiBold.gray800.size(18).make()
                // : "${data['Username']}"
                //     .text
                //     .semiBold
                //     .gray800
                //     .size(18)
                //     .make(),
                ,
                10.heightBox,
                // data['Email'] == null
                //     ? " Email Not set".text.gray800.size(16).make()
                //     : "${data['Email']}".text.gray800.size(16).make(),
                " Email@gmail.com".text.gray800.size(16).make(),
                10.heightBox,
                const Divider(
                  thickness: 6,
                ),
                Visibility(
                  // visible: point == -1 ? false : true,
                  child: ListTile(
                    splashColor: Colors.green,
                    onTap: () async {},
                    // trailing: Icon(Icons.arrow_forward_ios_outlined),
                    leading: Image.asset(
                      ImagePath.coinLogo,
                      height: 30,
                      width: 30,
                    ),
                    title: const Text(
                      ' 32 Points',
                      style: TextStyle(
                          color: Vx.gray600,
                          fontSize: 17,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                const Divider(
                  thickness: 1,
                ),
                ListTile(
                  splashColor: Colors.green,
                  onTap: () async {
                    // controller.linkWithGoogle(context).then((value) {
                    //   controller.storeGoogleData(
                    //       context: context, email: googleEmail);
                    // });
                  },
                  trailing: const Icon(Icons.arrow_forward_ios_outlined),
                  title: const Text(
                    'Link your Google Account',
                    style: TextStyle(
                        color: Vx.gray600,
                        fontSize: 17,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                const Divider(
                  thickness: 1,
                ),
                ListTile(
                  splashColor: Colors.green,
                  onTap: () {
                    // Get.to(() => LinkMobileScreen(),
                    //     transition: Transition.rightToLeft);
                  },
                  trailing: const Icon(Icons.arrow_forward_ios_outlined),
                  title: const Text(
                    'Link your Phone Number',
                    style: TextStyle(
                        color: Vx.gray600,
                        fontSize: 17,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                const Divider(
                  thickness: 1,
                ),
                ListTile(
                  splashColor: Colors.green,
                  onTap: () {
                    // Get.to(() => LinkEmailScreen(),
                    //     transition: Transition.rightToLeft);
                  },
                  trailing: const Icon(Icons.arrow_forward_ios_outlined),
                  title: const Text(
                    'Link your Username and password',
                    style: TextStyle(
                        color: Vx.gray600,
                        fontSize: 17,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                const Divider(
                  thickness: 1,
                ),
                // Column(
                //   children: [
                //     "Visit us at".text.gray500.size(18).semiBold.make(),
                //     5.heightBox,
                //     Image.asset(
                //       "assets/image/imgbg.png",
                //       width: 80,
                //     ).onTap(() async {
                //       // link = Uri.parse("https://www.reway.tech/");
                //       // if (await canLaunchUrl(link)) {
                //       //   launchUrl(link);
                //       // }
                //     }),
                //     20.heightBox,
                //     "OR".text.gray500.size(16).semiBold.make(),
                //     20.heightBox
                //   ],
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     "Contact Us:-"
                //         .text
                //         .semiBold
                //         .size(16)
                //         .color(Vx.gray500)
                //         .make(),
                //     IconButton(
                //         onPressed: () async {
                //           // link = Uri.parse(
                //           //     "https://twitter.com/Reway_ewaste?t=lg9Owp-C46D9ZPzJsg0Qqw&s=09");
                //           // if (await canLaunchUrl(link)) {
                //           //   launchUrl(link);
                //           // }
                //         },
                //         icon: Image.asset(
                //           "assets/image/twitter.png",
                //           width: context.screenWidth * 0.060,
                //         )),
                //     IconButton(
                //         onPressed: () async {
                //           // link = Uri.parse(
                //           //     "https://www.linkedin.com/company/reway-technologies/");
                //           // if (await canLaunchUrl(link)) {
                //           //   launchUrl(link);
                //           // }
                //         },
                //         icon: Image.asset(
                //           "assets/image/link.png",
                //           width: context.screenWidth * 0.060,
                //           color: Vx.blue600,
                //         )),
                //     IconButton(
                //         onPressed: () async {
                //           // link = Uri.parse("tel:+917290908877");
                //           // if (await canLaunchUrl(link)) {
                //           //   launchUrl(link);
                //           // }
                //         },
                //         icon: Image.asset(
                //           "assets/image/tele.png",
                //           width: context.screenWidth * 0.060,
                //           color: Colors.green,
                //         )),
                //     IconButton(
                //         onPressed: () async {
                //           // link = Uri.parse("mailto: reway.ewm@gmail.com");
                //           // if (await canLaunchUrl(link)) {
                //           //   launchUrl(link);
                //           // }
                //         },
                //         icon: Icon(
                //           Icons.mail,
                //           color: Vx.gray600,
                //         )),
                //   ],
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
