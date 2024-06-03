import 'package:antarmitra/model/comments.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> addPost(String text, String imageUrl) async {
  String postId = FirebaseFirestore.instance.collection('Posts').doc().id;
  await FirebaseFirestore.instance.collection('Posts').doc(postId).set({
    'postId': postId,
    'userId': 'anonymous', // or use an actual userId if available
    'text': text,
    'imageUrl': imageUrl,
    'likes': [],
    'comments': [],
    'datetime': FieldValue.serverTimestamp(),
  });
}

Future<void> likePost(String postId, String userId) async {
  DocumentReference postRef =
      FirebaseFirestore.instance.collection('Posts').doc(postId);
  DocumentSnapshot postSnapshot = await postRef.get();
  List<String> likes = List<String>.from(postSnapshot['likes']);
  if (likes.contains(userId)) {
    likes.remove(userId);
  } else {
    likes.add(userId);
  }
  await postRef.update({'likes': likes});
}

Future<void> addComment(String postId, String userId, String text) async {
  String commentId = FirebaseFirestore.instance
      .collection('Posts')
      .doc(postId)
      .collection('comments')
      .doc()
      .id;
  Comment newComment = Comment(
    commentId: commentId,
    userId: userId,
    text: text,
    datetime: DateTime.now(),
  );
  await FirebaseFirestore.instance.collection('Posts').doc(postId).update({
    'comments': FieldValue.arrayUnion([newComment.toMap()]),
  });
}

extension on Comment {
  Map<String, dynamic> toMap() {
    return {
      'commentId': commentId,
      'userId': userId,
      'text': text,
      'datetime': datetime,
    };
  }
}
