import 'package:antarmitra/screens/profile.dart';
import 'package:flutter/material.dart';

import '../controller/homecontroller.dart';
import 'package:get/get.dart';

class prayatnaCode extends StatelessWidget {
  const prayatnaCode({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<homeController>();
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(12)),
              child: Image.asset('assets/images/prayatna.webp').box.make()),
          50.heightBox,
          Container(child: Text('${controller.apiCode.value}')),
        ],
      )),
    );
  }
}
