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
    return Scaffold(
      appBar: buildAppBar(text: 'Ishika\'s Space'),
      body: Center(
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Select time you want to Meditate?"),
              ElevatedButton(
                  onPressed: () {
                    Get.to(() => Meditation(
                          timerWidget: TimerWidget(
                            duration: const Duration(minutes: 1),
                            onFinish: showSessionCompleteDialog,
                          ),
                        ));
                  },
                  child: const Text("1 Minute")),
              ElevatedButton(
                  onPressed: () {
                    Get.to(() => Meditation(
                          timerWidget: TimerWidget(
                            duration: const Duration(minutes: 3),
                            onFinish: showSessionCompleteDialog,
                          ),
                        ));
                  },
                  child: const Text("3 Minute")),
              ElevatedButton(
                  onPressed: () {
                    Get.to(() => Meditation(
                          timerWidget: TimerWidget(
                            duration: const Duration(minutes: 5),
                            onFinish: showSessionCompleteDialog,
                          ),
                        ));
                  },
                  child: const Text("5 Minute")),
            ],
          ),
        ),
      ),
    );
  }
}
