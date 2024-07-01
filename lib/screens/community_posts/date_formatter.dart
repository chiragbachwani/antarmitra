import 'package:cloud_firestore/cloud_firestore.dart';

String formatDate(Timestamp timestamp) {
  DateTime dateTime = timestamp.toDate();

  String year = dateTime.year.toString();

  String month = dateTime.month.toString();
  String day = dateTime.day.toString();

  String formattedDate = "$day.$month.$year";
  return formattedDate;
}

String formatTime(Timestamp timestamp) {
  DateTime postDateTime = timestamp.toDate();
  DateTime currentDateTime = DateTime.now();

  Duration difference = currentDateTime.difference(postDateTime);

  if (difference.inSeconds < 60) {
    return "${difference.inSeconds} seconds ago";
  } else if (difference.inMinutes < 60) {
    return "${difference.inMinutes} minutes ago";
  } else if (difference.inHours < 24) {
    return "${difference.inHours} hours ago";
  } else {
    if (difference.inDays == 1) {
      return "${difference.inDays} day ago";
    } else {
      return "${difference.inDays} day ago";
    }
  }
}
