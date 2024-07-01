import 'package:antarmitra/screens/community_posts/add_post.dart';
import 'package:antarmitra/screens/community_posts/date_formatter.dart';
import 'package:antarmitra/screens/community_posts/post_view.dart';
import 'package:antarmitra/widgets/appBar.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommunityPosts extends StatefulWidget {
  const CommunityPosts({super.key});

  @override
  State<CommunityPosts> createState() => _CommunityPostsState();
}

class _CommunityPostsState extends State<CommunityPosts> {
  final currUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      floatingActionButton: Container(
        width: 130,
        height: 130,
        padding: const EdgeInsets.all(32),
        child: FloatingActionButton(
          onPressed: () {
            Get.to(() => const AddPostScreen());
          },
          backgroundColor: Colors.cyan,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Icon(
            Icons.add,
            size: 30,
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Posts')
            .orderBy("datetime", descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                final data = snapshot.data!.docs[index];
                return PostCard(
                  username: data["userId"].split("@")[0],
                  postText: data["text"],
                  postId: data.id,
                  name: data["name"],
                  likes: List<String>.from(data["likes"] ?? []),
                  time: formatTime(data["datetime"]),
                );
              },
            );
          }
        },
      ),
    );
  }
}
