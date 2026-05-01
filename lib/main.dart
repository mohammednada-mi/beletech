import 'package:belesah/flutter/screen_calc.dart';
import 'package:belesah/flutter/screen_calc_price.dart';
import 'package:belesah/flutter/screen_calc_price_mini.dart';
import 'package:belesah/flutter/screen_calc_price_jumbo.dart';
import 'package:belesah/flutter/screen_activation.dart';
import 'package:belesah/flutter/screen_main.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final prefs = await SharedPreferences.getInstance();
  final isActivated = prefs.getBool('is_activated') ?? false;

  runApp(BelesahApp(isActivated: isActivated));
}

class BelesahApp extends StatelessWidget {
  final bool isActivated;
  const BelesahApp({super.key, required this.isActivated});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: isActivated ? const ScreenMain() : const ScreenActivation(),
    );
  }
}
