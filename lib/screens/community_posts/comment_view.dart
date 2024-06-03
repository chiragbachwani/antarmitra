import 'package:flutter/material.dart';

class CommentCard extends StatelessWidget {
  final String username;
  final String commentText;
  final String timeAgo;

  const CommentCard({
    super.key,
    required this.username,
    required this.commentText,
    required this.timeAgo,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(username),
      subtitle: Text(commentText),
      trailing: Text(timeAgo),
    );
  }
}
