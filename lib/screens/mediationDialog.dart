import 'package:antarmitra/controller/usercontroller.dart';
import 'package:antarmitra/screens/face_detection.dart';
import 'package:antarmitra/screens/meditation.dart';
import 'package:antarmitra/utils/app_color.dart';
import 'package:antarmitra/utils/app_constants.dart';
import 'package:antarmitra/widgets/appBar.dart';
import 'package:antarmitra/widgets/timer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogMeditation extends StatefulWidget {
  const DialogMeditation({super.key});

  @override
  State<DialogMeditation> createState() => _DialogMeditationState();
}

class _DialogMeditationState extends State<DialogMeditation> {
  void showSessionCompleteDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Session Completed"),
          content: const Text("Your meditation session has been completed."),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var userController = Get.find<UserController>();
    return Scaffold(
      appBar: buildAppBar(text: userController.userName.value.split(' ').first),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 100),
              const Text(
                textAlign: TextAlign.center,
                "Which mode of Meditation you would like to go with?",
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(fixedSize: const Size(200, 40)),
                  onPressed: () {
                    //   Get.to(() => Meditation(
                    //         timerWidget: TimerWidget(
                    //           duration: const Duration(minutes: 2),
                    //           onFinish: showSessionCompleteDialog,
                    //         ),
                    //       ));
                    // },
                    Get.to(
                      () => CameraScreen(),
                    );
                  },
                  child: const Text("Quick Calm Mode")),
              ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(fixedSize: const Size(200, 40)),
                  onPressed: () {
                    Get.to(() => Meditation(
                          timerWidget: TimerWidget(
                            duration: const Duration(minutes: 5),
                            onFinish: showSessionCompleteDialog,
                          ),
                        ));
                  },
                  child: const Text("Blissful Five Mode")),
              ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(fixedSize: const Size(200, 40)),
                  onPressed: () {
                    Get.to(() => Meditation(
                          timerWidget: TimerWidget(
                            duration: const Duration(minutes: 10),
                            onFinish: showSessionCompleteDialog,
                          ),
                        ));
                  },
                  child: const Text("Serenity Stretch")),
            ],
          ),
        ),
      ),
    );
  }
}
