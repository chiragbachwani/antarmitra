import 'package:antarmitra/utils/app_color.dart';
import 'package:antarmitra/utils/app_constants.dart';
import 'package:flutter/material.dart';

buildAppBar({List<Widget>? actions, required String text, Widget? leading}) {
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
      text,
      style: const TextStyle(
          fontSize: 20, color: AppColor.fifth, fontWeight: FontWeight.bold),
    ),
    actions: <Widget>[
      Row(
        children: [
          const Text(
            '32',
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
      ),
    ],
    leading: leading,
  );
}
