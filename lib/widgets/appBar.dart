import 'package:antarmitra/controller/usercontroller.dart';
import 'package:antarmitra/utils/app_color.dart';
import 'package:antarmitra/utils/app_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

var userController = Get.find<UserController>();

buildAppBar({
  List<Widget>? actions,
}) {
  return AppBar(
    elevation: 3,
    shadowColor: AppColor.fifth.withOpacity(0.2),
    backgroundColor: AppColor.second,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(20.0),
      ),
    ),
    iconTheme: const IconThemeData(color: AppColor.fifth),
    toolbarHeight: 80,
    title: Text(
      '${userController.userName.value.split(' ').first}\'s space',
      style: const TextStyle(
          fontSize: 20, color: AppColor.fifth, fontWeight: FontWeight.bold),
    ),

    actions: <Widget>[
      StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: userController.getUserDetailsStream(),
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            } else {
              var data = snapshot.data;
              var name = data['name'];
              var email = data['email'];
              var userType = data['type'];

              int points = data['points'] == null ? 0 : data['points'];
              userController.points.value = points;
              userController.userName.value = name;
              userController.userEmail.value = email;
              userController.userType.value = userType;

              return Row(
                children: [
                  Text(
                    '${userController.points.value}',
                    style: TextStyle(
                      color: AppColor.fifth,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Image.asset(
                    ImagePath.coinLogo,
                    height: 40,
                    width: 40,
                  ),
                  const SizedBox(width: 10),
                ],
              );
            }
          }),
    ],
    // leading: leading,
  );
}
