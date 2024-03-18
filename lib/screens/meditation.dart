import 'package:antarmitra/utils/app_color.dart';
import 'package:antarmitra/utils/app_constants.dart';
import 'package:antarmitra/widgets/appBar.dart';
import 'package:antarmitra/widgets/timer.dart';
import 'package:flutter/material.dart';

class Meditation extends StatefulWidget {
  const Meditation({super.key});

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

  void _showSessionCompleteDialog() {
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

  void _showDurationDialog() async {
    Duration? selectedDuration = await showDialog<Duration>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Select Timer Duration'),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () {
                Navigator.of(context).pop();
                TimerWidget(
                  duration: const Duration(minutes: 5),
                  onFinish: _showSessionCompleteDialog,
                );
              },
              child: const Text('1 minute'),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, const Duration(minutes: 3));
              },
              child: const Text('3 minutes'),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, const Duration(minutes: 5));
              },
              child: const Text('5 minutes'),
            ),
          ],
        );
      },
    );

    if (selectedDuration != null) {
      setState(() {
        _selectedDuration = selectedDuration;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(text: 'Ishsika\'s Space', actions: <Widget>[
          Row(
            children: [
              const Text(
                '32',
                style: TextStyle(
                  color: AppColor.fifth,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 10),
              Image.asset(
                ImagePath.coinLogo,
                height: 40,
                width: 40,
              ),
              const SizedBox(width: 10),
            ],
          ),
        ]),
        body: Container(
          color: Colors.white,
          child: Column(
            children: [
              ElevatedButton(
                onPressed: !_isTimerRunning ? _showDurationDialog : null,
                child: const Text('Select Timer Duration'),
              ),
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
                      _isTimerRunning
                          ? TimerWidget(
                              duration: const Duration(minutes: 1),
                              onFinish: _showSessionCompleteDialog,
                            )
                          : const SizedBox(),
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
