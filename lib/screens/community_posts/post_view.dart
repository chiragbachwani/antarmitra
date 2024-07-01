import 'package:antarmitra/screens/community_posts/comment_view.dart';
import 'package:antarmitra/screens/community_posts/date_formatter.dart';
import 'package:antarmitra/widgets/like_button.dart';
import 'package:antarmitra/widgets/reply_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PostCard extends StatefulWidget {
  final String username;
  final String postId;
  final String name;
  final String postText;
  final String time;
  final List<String> likes;

  const PostCard({
    super.key,
    required this.likes,
    required this.name,
    required this.postId,
    required this.time,
    required this.username,
    required this.postText,
  });

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  final currentUser = FirebaseAuth.instance.currentUser;
  bool isLiked = false;

  TextEditingController replyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isLiked = widget.likes.contains(currentUser!.email);
  }

  // Future<String> getUserName() async {
  //   DocumentSnapshot userDoc = await FirebaseFirestore.instance
  //       .collection('Users')
  //       .doc(currentUser!.uid)
  //       .get();
  //   return userDoc['name'];
  // }

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });

    DocumentReference postRef =
        FirebaseFirestore.instance.collection('Posts').doc(widget.postId);

    if (isLiked) {
      postRef.update({
        "likes": FieldValue.arrayUnion([currentUser!.email])
      });
    } else {
      postRef.update({
        "likes": FieldValue.arrayRemove([currentUser!.email])
      });
    }
  }

  void addComment(String comment) async {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('Users')
        .doc(currentUser!.uid)
        .get();

    String name = userDoc['name'];
    await FirebaseFirestore.instance
        .collection('Posts')
        .doc(widget.postId)
        .collection("Comments")
        .add({
      "name": name,
      "commentText": comment,
      "commentUser": currentUser!.email!.split('@')[0],
      "time": Timestamp.now()
    });
  }

  void showCommentDialog() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Reply user"),
              content: TextField(
                controller: replyController,
                decoration: const InputDecoration(
                    hintText: "Reply with your expertise"),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      replyController.clear();
                    },
                    child: const Text("Cancel")),
                TextButton(
                    onPressed: () {
                      addComment(replyController.text);
                      Navigator.of(context).pop();
                      replyController.clear();
                    },
                    child: const Text("Reply")),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(12))),
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(widget.name, style: const TextStyle(fontSize: 16)),
                      const SizedBox(width: 6),
                      Text(
                        "@${widget.username}",
                        style: const TextStyle(
                            fontSize: 12, color: Colors.black38),
                      )
                    ],
                  ),
                  Text(
                    widget.time,
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
              Container(
                width: double.maxFinite,
                margin: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                    color: Colors.cyan[50],
                    borderRadius: const BorderRadius.all(Radius.circular(12))),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Text(widget.postText),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      LikeButton(isLiked: isLiked, onTap: toggleLike),
                      const SizedBox(width: 2),
                      Text((widget.likes.length).toString()),
                    ],
                  ),
                  ReplyButton(onTap: showCommentDialog)
                ],
              ),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("Posts")
                    .doc(widget.postId)
                    .collection("Comments")
                    .orderBy("time", descending: false)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: snapshot.data!.docs.map((doc) {
                      final replyData = doc.data() as Map<String, dynamic>;

                      return CommentCard(
                          name: replyData["name"],
                          username: replyData["commentUser"],
                          commentText: replyData["commentText"],
                          time: formatTime(replyData["time"]));
                    }).toList(),
                  );
                },
              )
            ],
          ),
        ),
        const Divider(
          color: Colors.black54,
        )
      ],
    );
  }
}
