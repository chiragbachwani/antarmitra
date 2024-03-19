import 'package:antarmitra/widgets/appBar.dart';
import 'package:flutter/material.dart';

class Exercise extends StatelessWidget {
  const Exercise({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(text: 'Ishika\'s Space'),
      body: Container(
        color: Colors.pink,
      ),
    );
  }
}
