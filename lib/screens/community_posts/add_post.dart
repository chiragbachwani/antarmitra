import 'package:antarmitra/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddPostScreen extends StatefulWidget {
  final VoidCallback? onPostAdded;
  const AddPostScreen({super.key, this.onPostAdded});

  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final TextEditingController _textController = TextEditingController();
  // File? _image;
  // final ImagePicker _picker = ImagePicker();
  bool _isLoading = false;

  // Future<void> _pickImage() async {
  //   final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
  //   setState(() {
  //     if (pickedFile != null) {
  //       _image = File(pickedFile.path);
  //     }
  //   });
  // }

  Future<void> _addPost() async {
    if (_textController.text.isEmpty) {
      VxToast.show(context, msg: "Certificate Not Uploaded!");
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // String imageUrl = '';
      // if (_image != null) {
      //   // Upload image to Firestore or any storage service and get the URL
      //   // Here we assume you have a method to upload the image and get its URL
      //   imageUrl = await _uploadImageToStorage(_image!);
      // }

      await FirebaseFirestore.instance.collection('Posts').add({
        'userId': '1', // or use actual user ID if available
        'text': _textController.text,

        'likes': [],
        'comments': [],
        'datetime': FieldValue.serverTimestamp(),
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
                    maxLines: 3,
                    decoration: const InputDecoration(
                      hintText: 'What\'s on your mind?',
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
