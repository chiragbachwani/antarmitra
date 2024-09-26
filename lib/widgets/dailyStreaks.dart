import 'package:cloud_firestore/cloud_firestore.dart';

class DailyStreakManager {
  final String userId;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  DailyStreakManager(this.userId);

  Future<void> checkAndUpdateStreak() async {
    final userDoc = _firestore.collection('Users').doc(userId);
    
    return _firestore.runTransaction((transaction) async {
      final snapshot = await transaction.get(userDoc);
      
      if (!snapshot.exists) {
        transaction.set(userDoc, {
          'lastOpenDate': FieldValue.serverTimestamp(),
          'currentStreak': 1,
          'sessionStartTime': FieldValue.serverTimestamp(),
        });
        return;
      }

      final data = snapshot.data()!;
      final lastOpenDate = data['lastOpenDate'] as Timestamp?;
      final now = DateTime.now().toUtc();

      if (lastOpenDate == null) {
        // Handle case where lastOpenDate is missing
        transaction.update(userDoc, {
          'lastOpenDate': FieldValue.serverTimestamp(),
          'currentStreak': 1,
          'sessionStartTime': FieldValue.serverTimestamp(),
        });
        return;
      }

      final difference = now.difference(lastOpenDate.toDate());

      if (difference.inHours >= 24 && difference.inHours < 48) {
        // User opened the app within 24-48 hours, increment streak
        transaction.update(userDoc, {
          'lastOpenDate': FieldValue.serverTimestamp(),
          'currentStreak': (data['currentStreak'] as int? ?? 0) + 1,
          'sessionStartTime': FieldValue.serverTimestamp(),
        });
      } else if (difference.inHours >= 48) {
        // User missed a day, reset streak
        transaction.update(userDoc, {
          'lastOpenDate': FieldValue.serverTimestamp(),
          'currentStreak': 1,
          'sessionStartTime': FieldValue.serverTimestamp(),
        });
      } else {
        // User opened the app within 24 hours, update last open date
        transaction.update(userDoc, {
          'lastOpenDate': FieldValue.serverTimestamp(),
          'sessionStartTime': FieldValue.serverTimestamp(),
        });
      }
    });
  }

  Future<void> checkSessionDuration() async {
    final userDoc = _firestore.collection('Users').doc(userId);
    final snapshot = await userDoc.get();
    
    if (snapshot.exists) {
      final data = snapshot.data()!;
      final sessionStartTime = data['sessionStartTime'] as Timestamp?;
      if (sessionStartTime != null) {
        final now = DateTime.now().toUtc();
        final sessionDuration = now.difference(sessionStartTime.toDate());

        if (sessionDuration.inMinutes >= 3) {
          // User has been in the app for at least 3 minutes
          await userDoc.update({
            'lastValidSession': FieldValue.serverTimestamp(),
          });
        }
      }
    }
  }

  Future<int> getCurrentStreak() async {
    final userDoc = await _firestore.collection('Users').doc(userId).get();
    return userDoc.data()?['currentStreak'] as int? ?? 0;
  }
}