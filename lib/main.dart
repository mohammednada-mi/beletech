import 'package:belesah/flutter/screen_calc.dart';
import 'package:belesah/flutter/screen_calc_price.dart';
import 'package:belesah/flutter/screen_calc_price_mini.dart';
import 'package:belesah/flutter/screen_calc_price_jumbo.dart';
import 'package:belesah/flutter/screen_activation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async{
    WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const BelesahApp());
}

class BelesahApp extends StatelessWidget {
  const BelesahApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: const ScreenActivation());
  }
}
