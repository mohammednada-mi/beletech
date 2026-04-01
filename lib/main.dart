import 'package:belesah/flutter/screen_calc.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const BelesahApp());
}

class BelesahApp extends StatelessWidget {
  const BelesahApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: const ScreenCalc());
  }
}
