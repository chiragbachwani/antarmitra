import 'package:antarmitra/screens/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddPostScreen extends StatefulWidget {
  final VoidCallback? onPostAdded;
  const AddPostScreen({super.key, this.onPostAdded});

  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final TextEditingController _textController = TextEditingController();

  bool _isLoading = false;
  var currentUser = FirebaseAuth.instance.currentUser!;

  Future<void> _addPost() async {
    if (_textController.text.isEmpty) {
      VxToast.show(context, msg: "You can not post empty thoughts, buddy!");
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('Users')
          .doc(currentUser.uid)
          .get();

      String name = userDoc['name'];
      await FirebaseFirestore.instance.collection('Posts').add({
        'userId': currentUser.email,
        'name': name,
        'text': _textController.text,
        'likes': [],
        'comments': [],
        'datetime': Timestamp.now(),
      });

      if (widget.onPostAdded != null) {
        widget.onPostAdded!();
      }

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add post: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Post'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _isLoading ? null : _addPost,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: _textController,
                    maxLines: 4,
                    decoration: const InputDecoration(
                      hintText:
                          'Share your thoughts and feelings with community',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                ],
              ),
            ),
    );
  }
}
