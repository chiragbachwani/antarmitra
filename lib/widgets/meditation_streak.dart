import 'package:antarmitra/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MeditationStreakDisplay extends StatelessWidget {
  final String userId;

  MeditationStreakDisplay({required this.userId});

  Future<List<bool>> getLast7DaysStreak() async {
    final userDoc = await FirebaseFirestore.instance.collection('users').doc(userId).get();
    final data = userDoc.data();
    if (data == null) return List.filled(7, false);

    final lastOpenDate = data['lastOpenDate'] as Timestamp?;
    if (lastOpenDate == null) return List.filled(7, false);

    final now = DateTime.now();
    final streak = List.generate(7, (index) {
      final day = now.subtract(Duration(days: 6 - index));
      return day.difference(lastOpenDate.toDate()).inDays < (data['currentStreak'] as int? ?? 0);
    });

    return streak;
  }

  Widget buildDay(String day, bool isCompleted) {
    return Column(
      children: [
        Text(day, style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 5),
        Icon(
          isCompleted ? Icons.check_circle_outline : Icons.circle_outlined,
          color: isCompleted ? AppColor.first : Colors.grey,
          size: 30,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<bool>>(
      future: getLast7DaysStreak(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        final streak = snapshot.data ?? List.filled(7, false);

        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColor.fifth,
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Text(
                      'Daily Meditation Streak',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildDay("M", streak[0]),
                  buildDay("T", streak[1]),
                  buildDay("W", streak[2]),
                  buildDay("T", streak[3]),
                  buildDay("F", streak[4]),
                  buildDay("S", streak[5]),
                  buildDay("S", streak[6]),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}