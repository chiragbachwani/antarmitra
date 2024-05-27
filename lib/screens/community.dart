import 'dart:ui';

import 'package:antarmitra/controller/usercontroller.dart';
import 'package:antarmitra/screens/chat_screen.dart';
import 'package:antarmitra/screens/profile.dart';
import 'package:antarmitra/widgets/appBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Community extends StatelessWidget {
  const Community({super.key});

  @override
  Widget build(BuildContext context) {
    var userController = Get.find<UserController>();
    return Scaffold(
      appBar: buildAppBar(),
      body: MessagesList(),
    );
  }
}

class MessagesList extends StatelessWidget {
  final List<Message> messages = [
    Message(
      senderName: 'John Doe',
      content: 'Hey there! How are you?',
      timestamp: '10:30 AM',
    ),
    Message(
      senderName: 'Jane Smith',
      content: 'Hello im doing well thanks',
      timestamp: '11:00 AM',
    ),
    // Add more messages as needed
  ];

  MessagesList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: messages.length,
      itemBuilder: (context, index) {
        return MessageTile(message: messages[index]);
      },
    );
  }
}

class Message {
  final String senderName;
  final String content;
  final String timestamp;

  Message(
      {required this.senderName,
      required this.content,
      required this.timestamp});
}

class MessageTile extends StatelessWidget {
  final Message message;

  const MessageTile({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        // You can add sender's profile image here
        child: Text(
            message.senderName[0]), // Display first letter of sender's name
      ),
      title: Text(
        message.senderName,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(message.content),
          const SizedBox(height: 4),
          Text(
            message.timestamp,
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
      onTap: () {
        // Add onTap functionality as needed
        Get.to(() => ChatScreen());
      },
    );
  }
}
