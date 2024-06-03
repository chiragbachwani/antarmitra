import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  final int likes;
  final bool isliked;
  final String username;
  final String timeAgo;
  final String postText;
  final String imageUrl;
  final VoidCallback onLike;
  final Function(String) onComment;
  final List<CommentCard> comments;

  const PostCard({
    super.key,
    required this.likes,
    required this.isliked,
    required this.username,
    required this.timeAgo,
    required this.postText,
    required this.imageUrl,
    required this.onLike,
    required this.onComment,
    required this.comments,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(16))),
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          ListTile(
            // tileColor: Colors.white,
            leading: Image.asset(imageUrl),
            title: Text(username),
            subtitle: Text(timeAgo),
            trailing: IconButton(
              icon: Icon(isliked ? Icons.favorite : Icons.favorite_border),
              onPressed: onLike,
            ),
          ),
          // if (imageUrl.isNotEmpty) Image.network(imageUrl),
          Container(
            // color: Colors.white,
            padding: const EdgeInsets.all(16.0),
            child: Text(postText),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onSubmitted: onComment,
              decoration: const InputDecoration(
                labelText: 'Add a comment...',
              ),
            ),
          ),
          ...comments,
        ],
      ),
    );
  }
}

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
