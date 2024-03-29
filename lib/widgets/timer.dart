import 'dart:async';
import 'dart:math';

import 'package:antarmitra/utils/app_color.dart';
import 'package:flutter/material.dart';

class TimerWidget extends StatefulWidget {
  final Duration duration;
  final VoidCallback onFinish;

  const TimerWidget(
      {super.key, required this.duration, required this.onFinish});

  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  late Timer _timer;
  late int _secondsRemaining;
  late int _totalSeconds;

  @override
  void initState() {
    super.initState();
    _totalSeconds = widget.duration.inSeconds;
    _secondsRemaining = _totalSeconds;
    _timer = Timer.periodic(const Duration(seconds: 1), _updateTimer);
  }

  void _updateTimer(Timer timer) {
    setState(() {
      if (_secondsRemaining > 0) {
        _secondsRemaining--;
      } else {
        timer.cancel();
        widget.onFinish();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double progress = _secondsRemaining / _totalSeconds;
    return SizedBox(
      width: 100,
      height: 100,
      child: CustomPaint(
        painter: TimerPainter(progress: progress),
        child: Center(
          child: Text(
            '${(_secondsRemaining / 60).floor()}:${(_secondsRemaining % 60).toString().padLeft(2, '0')}',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class TimerPainter extends CustomPainter {
  final double progress;

  TimerPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = AppColor.sixth
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = size.width / 2 - 10;

    canvas.drawCircle(center, radius, paint);

    Paint progressPaint = Paint()
      ..color = AppColor.fifth
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    double arcAngle = 2 * pi * (1 - progress);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2,
        -arcAngle, false, progressPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
