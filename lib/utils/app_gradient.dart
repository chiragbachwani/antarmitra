import 'package:flutter/material.dart';

class AppGradient {
  static const LinearGradient buttonGradient = LinearGradient(
    colors: [Color(0xff685099), Color(0xff372559), Color(0xff372559)],
    stops: [0.0, 1.0, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const RadialGradient floatingBtnGradient = RadialGradient(
    colors: [Color(0xFFFFDEDE), Color(0xFFFF979A)],
  );
}
