import 'package:flutter/material.dart';

import '../controller/homecontroller.dart';
import 'package:get/get.dart';

class prayatnaCode extends StatelessWidget {
  const prayatnaCode({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<homeController>();
    return Scaffold(
      body:
          Center(child: Container(child: Text('${controller.apiCode.value}'))),
    );
  }
}
