import 'package:antarmitra/utils/app_color.dart';
import 'package:flutter/material.dart';

buildAppBar({List<Widget>? actions, required String text, Widget? leading}) {
  return AppBar(
    elevation: 3,
    shadowColor: AppColor.fifth.withOpacity(0.2),
    backgroundColor: AppColor.first,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(20.0),
      ),
    ),
    iconTheme: const IconThemeData(color: AppColor.sixth),
    toolbarHeight: 80,
    title: Text(
      text,
      style: const TextStyle(
          fontSize: 20, color: AppColor.sixth, fontWeight: FontWeight.bold),
    ),
    actions: actions,
    leading: leading,
  );
}