import 'package:antarmitra/controller/usercontroller.dart';
import 'package:antarmitra/utils/app_color.dart';
import 'package:antarmitra/utils/app_constants.dart';
import 'package:antarmitra/widgets/appBar.dart';
import 'package:antarmitra/widgets/timer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Meditation extends StatefulWidget {
  final Widget timerWidget;
  const Meditation({super.key, required this.timerWidget});

  @override
  State<Meditation> createState() => _MeditationState();
}

class _MeditationState extends State<Meditation> {
  late bool _isTimerRunning;
  late Duration _selectedDuration;

  @override
  void initState() {
    super.initState();
    _isTimerRunning = false;
    _selectedDuration = const Duration(minutes: 1);
  }

  void _startTimer() {
    setState(() {
      _isTimerRunning = true;
    });
  }

  void _stopTimer() {
    setState(() {
      _isTimerRunning = false;
    });
  }

  // void _showDurationDialog() async {
  //   Duration? selectedDuration = await showDialog<Duration>(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return SimpleDialog(
  //         title: const Text('Select Timer Duration'),
  //         children: <Widget>[
  //           SimpleDialogOption(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //               TimerWidget(
  //                 duration: const Duration(minutes: 5),
  //                 onFinish: _showSessionCompleteDialog,
  //               );
  //             },
  //             child: const Text('1 minute'),
  //           ),
  //           SimpleDialogOption(
  //             onPressed: () {
  //               Navigator.pop(context, const Duration(minutes: 3));
  //             },
  //             child: const Text('3 minutes'),
  //           ),
  //           SimpleDialogOption(
  //             onPressed: () {
  //               Navigator.pop(context, const Duration(minutes: 5));
  //             },
  //             child: const Text('5 minutes'),
  //           ),
  //         ],
  //       );
  //     },
  //   );

  //   if (selectedDuration != null) {
  //     setState(() {
  //       _selectedDuration = selectedDuration;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    var userController = Get.find<UserController>();
    return Scaffold(
        appBar:
            buildAppBar(text: userController.userName.value.split(' ').first),
        body: Container(
          color: Colors.white,
          child: Column(
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Feedback Message'),
                  ),
                  Column(
                    children: [
                      _isTimerRunning ? widget.timerWidget : const SizedBox(),
                      ElevatedButton(
                        onPressed: !_isTimerRunning ? _startTimer : _stopTimer,
                        child: _isTimerRunning
                            ? const Icon(Icons.stop)
                            : const Icon(Icons.play_arrow),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
