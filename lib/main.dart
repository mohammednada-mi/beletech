//import 'package:belesah/flutter/screen_calc.dart';
import 'package:belesah/flutter/screen_calc_price.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../dart/screen/app_provider.dart';

void main() {}

class BelesahApp extends StatelessWidget {
  const BelesahApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: const ScreenCalcPrice());
  }
}
