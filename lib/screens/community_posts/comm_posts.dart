import 'package:antarmitra/model/comments.dart';
import 'package:antarmitra/model/posts.dart';
import 'package:antarmitra/screens/community_posts/add_post.dart';
import 'package:antarmitra/screens/community_posts/community_functions.dart';
import 'package:antarmitra/screens/community_posts/post_comment_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommunityPosts extends StatefulWidget {
  const CommunityPosts({super.key});

  @override
  State<CommunityPosts> createState() => _CommunityPostsState();
}

class _CommunityPostsState extends State<CommunityPosts> {
  String currentUserId = '';
  @override
  Widget build(BuildContext context) {
    Future<void> getCurrentUser() async {
      // Retrieve the current user from FirebaseAuth
      User? user = FirebaseAuth.instance.currentUser;

      // Check if user is not null and set the currentUserId
      if (user != null) {
        setState(() {
          currentUserId = user.uid;
        });
      }
    }

    Future<List<Post>> fetchPosts() async {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance.collection('Posts').get();

      List<Post> posts = [];

      for (var doc in querySnapshot.docs) {
        var postData = doc.data();
        List<Comment> comments = [];
        if (postData['comments'] != null) {
          for (var comment in postData['comments']) {
            comments.add(Comment(
              commentId: comment['commentId'] ?? '',
              userId: comment['userId'] ?? '',
              text: comment['text'] ?? '',
              datetime: (comment['datetime'] as Timestamp).toDate(),
            ));
          }
        }

        posts.add(Post(
          postId: postData['postId'] ?? '',
          userId: postData['userId'] ?? '',
          text: postData['text'] ?? '',
          imageUrl: postData['imageUrl'] ?? 'assets/images/profile.gif',
          likes: List<String>.from(postData['likes'] ?? []),
          comments: comments,
          datetime:
              (postData['datetime'] as Timestamp?)?.toDate() ?? DateTime.now(),
        ));
      }

      return posts;
    }

    // var controller = Get.find<Homecontroller>();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => AddPostScreen(
                onPostAdded: () {
                  setState(() {
                    fetchPosts();
                  });
                },
              ));
        },
        backgroundColor: Colors.cyan,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.cyan[100],
      body: FutureBuilder(
        future: fetchPosts(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<Post> posts = snapshot.data ?? [];
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (BuildContext context, int index) {
                var data = posts[index];
                return PostCard(
                  likes: data.likes.length,
                  isliked: data.likes.contains(
                      currentUserId), // replace with actual user ID check
                  username: 'Anonymous',
                  timeAgo: data.datetime.toString(),
                  postText: data.text,
                  imageUrl: data.imageUrl,
                  onLike: () {
                    likePost(data.postId,
                        currentUserId); // replace with actual user ID
                  },
                  onComment: (text) {
                    addComment(data.postId, currentUserId,
                        text); // replace with actual user ID
                  },
                  comments: data.comments
                      .map((c) => CommentCard(
                            username: 'Anonymous', // Or fetch actual user name
                            commentText: c.text,
                            timeAgo: c.datetime.toString(),
                          ))
                      .toList(),
                );
              },
            );
          }
        },
      ),
    );
  }
}
