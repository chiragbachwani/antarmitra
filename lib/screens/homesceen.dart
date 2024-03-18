import 'package:antarmitra/controller/homecontroller.dart';
import 'package:antarmitra/routes/route_name.dart';
import 'package:antarmitra/screens/prayatnascreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<homeController>();
    return Scaffold(
      body: Center(
        child: Container(
          child: ElevatedButton(
            child: Text("Prayatna"),
            onPressed: () {
              Get.to( ()=>prayatnaCode());
            },
          ),
        ),
      ),
    );
  }
}
