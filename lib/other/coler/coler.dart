import 'dart:math';

import 'package:flutter/material.dart';

class AppColors {
  static const Color background = Color(0xFFEBEDE5);
  static const Color tabselColor = Colors.black;
  static const Color tabnorColor = Color(0xFFD4D4D4);
  static const Color centerColor = Color(0xFFAAD301);
  static const Color blacktextColor = Color(0xFF333333);
}

Color getRandomColorWithAlpha() {
  Random random = Random();
  return Color.fromARGB(
    random.nextInt(256), // A
    random.nextInt(256), // R
    random.nextInt(256), // G
    random.nextInt(256), // B
  );
}

const String h5Host = 'http://8.212.151.134:10393';
