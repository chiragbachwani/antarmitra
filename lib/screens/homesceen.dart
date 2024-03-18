import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key,  required this.apiCode});
  final String apiCode;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.orange,
      ),
    );
  }
}
