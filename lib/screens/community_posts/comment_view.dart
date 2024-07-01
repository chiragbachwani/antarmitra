import 'package:flutter/material.dart';

class CommentCard extends StatelessWidget {
  final String username;
  final String name;
  final String commentText;
  final String time;

  const CommentCard({
    super.key,
    required this.username,
    required this.name,
    required this.commentText,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              margin: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Text(name),
                  const SizedBox(width: 6),
                  Text("@$username",
                      style:
                          const TextStyle(fontSize: 12, color: Colors.black38))
                ],
              )),
          Text(
            time,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
      subtitle: Container(
        width: double.maxFinite,
        margin: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
            color: Color.fromARGB(255, 241, 253, 255),
            borderRadius: BorderRadius.all(Radius.circular(12))),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Text(commentText),
      ),
    );
  }
}
