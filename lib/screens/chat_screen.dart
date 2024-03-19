import 'package:antarmitra/screens/profile.dart';
import 'package:antarmitra/widgets/appBar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(ChatScreen());
}

class ChatScreen extends StatefulWidget {
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _messageController = TextEditingController();

  final List<ChatMessage> messages = [
    ChatMessage(
      messageContent: 'Hello, how are you?',
      isMe: true,
    ),
    ChatMessage(
      messageContent: 'I\'m doing well, thank you!',
      isMe: false,
    ),
    ChatMessage(
      messageContent: 'That\'s great!',
      isMe: true,
    ),
    // Add more messages as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(text: "User name"),
        body: Column(children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return ChatBubble(message: messages[index]);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(children: [
              Expanded(
                child: TextField(
                  controller: _messageController,
                  decoration: InputDecoration(
                    hintText: 'Type your message...',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50)),
                  ),
                ),
              ),
              SizedBox(width: 8),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 168, 253, 251)),
                onPressed: () {
                  if (_messageController.text.isNotEmpty) {
                    setState(() {
                      messages.add(ChatMessage(
                          messageContent: _messageController.text, isMe: true));
                      _messageController.clear();
                    });
                  }
                },
                child: Text('Send'),
              ),
            ]),
          )
        ]));
  }
}

class ChatMessage {
  final String messageContent;
  final bool isMe;

  ChatMessage({required this.messageContent, required this.isMe});
}

class ChatBubble extends StatelessWidget {
  final ChatMessage message;

  ChatBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: message.isMe ? Color(0xFF07BEB8) : Color(0xff157B7A),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(message.isMe ? 20 : 0),
            bottomRight: Radius.circular(message.isMe ? 0 : 20),
          ),
        ),
        child: Text(
          message.messageContent,
          style: TextStyle(color: message.isMe ? Colors.white : Vx.gray200),
        ),
      ),
    );
  }
}
