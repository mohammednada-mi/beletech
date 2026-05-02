
import 'package:belesah/flutter/screen_activation.dart';
import 'package:belesah/flutter/screen_main.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final isActivated = prefs.getBool('is_activated') ?? false;
  if (!isActivated) {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  }

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
