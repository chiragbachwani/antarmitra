import 'package:antarmitra/controller/homecontroller.dart';
import 'package:antarmitra/routes/route_name.dart';
import 'package:antarmitra/screens/community.dart';
import 'package:antarmitra/screens/prayatnascreen.dart';
import 'package:antarmitra/utils/app_color.dart';
import 'package:antarmitra/utils/app_constants.dart';
import 'package:antarmitra/widgets/appBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class Therapist {
  final String name;
  final String experience;
  final bool isOnline;

  Therapist({
    required this.name,
    required this.experience,
    required this.isOnline,
  });
}

class Home extends StatelessWidget {
  Home({super.key});

  final List<Therapist> therapists = [
    Therapist(
        name: "Mr. Rakesh Sharma", experience: "7+ Years", isOnline: true),
    Therapist(name: "Ms. Priya Singh", experience: "5+ Years", isOnline: false),
    Therapist(
        name: "Dr. Rajesh Verma", experience: "10+ Years", isOnline: true),
    // Add more therapists as needed
  ];

  @override
  Widget build(BuildContext context) {
    // var controller = Get.find<homeController>();
    return Scaffold(
        appBar: buildAppBar(text: 'Ishika\'s Space'),
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
                            borderRadius: BorderRadius.circular(25),
                            color: AppColor.fifth,
                          ),
                          // color: AppColor.fifth,
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text('Daily Meditation Streak',
                                    style: TextStyle(fontSize: 20)),
                              ),
                              const SizedBox(height: 30),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  buildDay("M"),
                                  buildDay("T"),
                                  buildDay("W"),
                                  buildDay("T"),
                                  buildDay("F"),
                                  buildDay("S"),
                                  buildDay("S"),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          )),
                      const SizedBox(height: 20),
                      Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: AppColor.second,
                          ),
                          // color: AppColor.fifth,
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text('Thearpists Available',
                                    style: TextStyle(fontSize: 20)),
                              ),
                              const SizedBox(height: 30),
                              Container(
                                height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: AppColor.fifth,
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
                                          const Icon(Icons.circle_outlined,
                                              size: 80),
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
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          )),
                      const SizedBox(
                        height: 30,
                      ),

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
                                        fontSize: 20, color: AppColor.fifth)),
                              ),
                              Text('14 Days ' '🔥',
                                  style: TextStyle(
                                      fontSize: 20,
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

  buildDay(String text) {
    return Column(
      children: [
        Text(
          text,
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 20),
        const Icon(
          Icons.circle_outlined,
          size: 35,
        )
      ],
    );
  }
}
