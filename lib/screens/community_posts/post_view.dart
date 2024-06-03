import 'package:antarmitra/screens/community_posts/comment_view.dart';
import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  // final int likes;
  // final bool isliked;
  final String username;
  final String timeAgo;
  final String postText;
  final String imageUrl;
  // final VoidCallback onLike;
  final Function(String) onComment;
  final List<CommentCard> comments;

  const PostCard({
    super.key,
    // required this.likes,
    // required this.isliked,
    required this.username,
    required this.timeAgo,
    required this.postText,
    required this.imageUrl,
    // required this.onLike,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text(username),
            subtitle: Text(timeAgo),
            trailing: Image.asset(imageUrl),
            // trailing: Row(
            //   mainAxisSize: MainAxisSize.min,
            //   children: [
            //     IconButton(
            //       icon: isliked
            //           ? const Icon(
            //               Icons.favorite,
            //               color: Colors.red,
            //             )
            //           : const Icon(Icons.favorite_border),
            //       onPressed: onLike,
            //     ),
            //     Text(likes.toString())
            //   ],
            // ),
          ),
          Container(
            // color: Colors.blue,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Text(postText),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: const Icon(Icons.comment),
          )
          // Padding(
          //   padding: const EdgeInsets.all(16.0),
          //   child: TextField(
          //     onSubmitted: onComment,
          //     decoration: const InputDecoration(
          //       labelText: 'Add a comment...',
          //     ),
          //   ),
          // ),
          // ...comments,
        ],
      ),
    );
  }
}
