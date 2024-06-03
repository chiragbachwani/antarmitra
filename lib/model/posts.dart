import 'package:antarmitra/model/comments.dart';

class Post {
  final String postId;
  final String userId;
  final String text;
  final String imageUrl;
  final List<String> likes;
  final List<Comment> comments;
  final DateTime datetime;

  Post({
    required this.postId,
    required this.userId,
    required this.text,
    required this.imageUrl,
    required this.likes,
    required this.comments,
    required this.datetime,
  });
}
