import 'package:antarmitra/controller/homecontroller.dart';
import 'package:antarmitra/controller/usercontroller.dart';
import 'package:antarmitra/firebase_const.dart';
// import 'package:antarmitra/routes/route_name.dart';
import 'package:antarmitra/screens/community.dart';
import 'package:antarmitra/screens/prayatnascreen.dart';
import 'package:antarmitra/utils/app_color.dart';
// import 'package:antarmitra/utils/app_constants.dart';
import 'package:antarmitra/widgets/appBar.dart';
import 'package:antarmitra/widgets/dailyStreaks.dart';
import 'package:antarmitra/widgets/meditation_streak.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late DailyStreakManager _streakManager;
  int _currentStreak = 0;

   @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _streakManager = DailyStreakManager(user.uid);
      _initializeStreak();
    }
  } 


  Future<void> _initializeStreak() async {
    await _streakManager.checkAndUpdateStreak();
    _updateStreakDisplay();
    
    // Start a timer to check session duration every minute
    Future.delayed(Duration(minutes: 1), _checkSessionDuration);
  }

  Future<void> _checkSessionDuration() async {
    await _streakManager.checkSessionDuration();
    _updateStreakDisplay();
    
    // Schedule the next check
    Future.delayed(Duration(minutes: 1), _checkSessionDuration);
  }

  Future<void> _updateStreakDisplay() async {
    final streak = await _streakManager.getCurrentStreak();
    setState(() {
      _currentStreak = streak;
    });
  }

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

  @override
  Widget build(BuildContext context) {
    // var userController = Get.find<UserController>();
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
                      MeditationStreakDisplay(userId: currentuser!.uid),
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
                          child:  Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text('Current Streak Days - ',
                                    style: TextStyle(
                                        fontSize: 16, color: AppColor.fifth)),
                              ),
                              Text('$_currentStreak' ' 🔥',
                                  style: TextStyle(
                                      fontSize: 26,
                                      color: AppColor.fifth,
                                      fontWeight: FontWeight.bold)),
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
