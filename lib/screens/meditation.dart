import 'package:antarmitra/utils/app_color.dart';
import 'package:antarmitra/utils/app_constants.dart';
import 'package:antarmitra/widgets/appBar.dart';
import 'package:flutter/material.dart';

class Meditation extends StatelessWidget {
  const Meditation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(text: 'Ishsika\'s Space', actions: <Widget>[
        Row(
          children: [
            const Text(
              '32',
              style: TextStyle(
                color: AppColor.fifth,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 10),
            Image.asset(
              ImagePath.coinLogo,
              height: 40,
              width: 40,
            ),
            const SizedBox(width: 10),
          ],
        ),
      ]),
      body: Container(
        color: Colors.white,
      ),
    );
  }
}
