import 'package:antarmitra/controller/homecontroller.dart';
import 'package:antarmitra/controller/usercontroller.dart';
import 'package:antarmitra/firebase_const.dart';
import 'package:antarmitra/routes/route_name.dart';
import 'package:antarmitra/screens/community.dart';
import 'package:antarmitra/screens/prayatnascreen.dart';
import 'package:antarmitra/utils/app_color.dart';
import 'package:antarmitra/utils/app_constants.dart';
import 'package:antarmitra/widgets/appBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class Therapist {
  final String name;
  final String experience;
  final bool isOnline;
  final String image;

  Therapist(
      {required this.name,
      required this.experience,
      required this.isOnline,
      required this.image});
}

class Home extends StatelessWidget {
  Home({super.key});

  final List<Therapist> therapists = [
    Therapist(
        name: "Mr. Rakesh Sharma",
        experience: "7+ Years",
        isOnline: true,
        image: 'assets/logos/male2.jpeg'),
    Therapist(
        name: "Ms. Priya Singh",
        experience: "5+ Years",
        isOnline: false,
        image: 'assets/logos/female.jpeg'),
    Therapist(
        name: "Dr. Rajesh Verma",
        experience: "10+ Years",
        isOnline: true,
        image: 'assets/logos/male1.jpeg'),
    // Add more therapists as needed
  ];

  // Future<void> getUserDetails() async {
  //   DocumentSnapshot documentSnapshot;
  //   try {
  //     documentSnapshot = await FirebaseFirestore.instance
  //         .collection('Users')
  //         .doc(currentuser!.uid)
  //         .get();

  //     if (documentSnapshot.exists) {
  //       print(documentSnapshot.data());
  //       var data = documentSnapshot.data();
  //     } else {
  //       print('Document does not exist');
  //     }
  //   } catch (e) {
  //     print('Error fetching document: $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    var userController = Get.find<UserController>();
    return Scaffold(
        appBar: buildAppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // const SizedBox(height: 20),
                      // ignore: avoid_unnecessary_containers
                      Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColor.fifth,
                          ),
                          // color: AppColor.fifth,
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text('Daily Meditation Streak',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                              ),
                              const SizedBox(height: 30),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  buildDay("M", Icons.circle_outlined),
                                  buildDay(
                                      "T", Icons.check_circle_outline_outlined),
                                  buildDay(
                                      "W", Icons.check_circle_outline_outlined),
                                  buildDay("T", Icons.circle_outlined),
                                  buildDay("F", Icons.circle_outlined),
                                  buildDay("S", Icons.circle_outlined),
                                  buildDay("S", Icons.circle_outlined),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          )),
                      const SizedBox(height: 10),
                      const Divider(thickness: 1),
                      const SizedBox(height: 10),
                      Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColor.first,
                          ),
                          // color: AppColor.fifth,
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text('Therapists Available',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                              ),
                              const SizedBox(height: 30),
                              Container(
                                height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColor.fifth.withOpacity(0.3),
                                ),
                                // width: 200,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: therapists.length,
                                  itemBuilder: (context, index) {
                                    final therapist = therapists[index];
                                    return Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30),
                                      child: Row(
                                        children: [
                                          // const SizedBox(width: 5),
                                          // const SizedBox(width: 10),
                                          const Icon(
                                            Icons.person,
                                            size: 80,
                                            color: AppColor.fifth,
                                          ),
                                          // CircleAvatar(
                                          //   radius: 40,
                                          //   backgroundImage:
                                          //       AssetImage(therapist.image),
                                          // ),
                                          const SizedBox(
                                              width: 20), // Adjust as needed
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(therapist.name,
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              Text(therapist.experience),
                                              Text(therapist.isOnline
                                                  ? "Online Now"
                                                  : "Offline"),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    Get.to(() => const Community());
                                  },
                                  child: const Text('View More')),
                            ],
                          )),
                      const SizedBox(height: 10),
                      const Divider(thickness: 1),
                      const SizedBox(height: 10),

                      Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: AppColor.sixth,
                          ),
                          // color: AppColor.fifth,
                          padding: const EdgeInsets.all(20),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text('Current Streak Days - ',
                                    style: TextStyle(
                                        fontSize: 16, color: AppColor.fifth)),
                              ),
                              Text('14 Days ' '🔥',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: AppColor.fifth,
                                      fontWeight: FontWeight.bold)),
                              // SizedBox(height: 30),
                              // SizedBox(
                              //   height: 20,
                              // ),
                            ],
                          )),
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                child: const Text("Prayatna"),
                onPressed: () {
                  Get.to(() => const prayatnaCode());
                },
              ),
            ],
          ),
        ));
  }

  buildDay(String text, IconData didIcon) {
    return Column(
      children: [
        Text(
          text,
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 20),
        Icon(
          didIcon,
          size: 35,
        )
      ],
    );
  }
}
