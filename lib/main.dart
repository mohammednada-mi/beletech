// pubspec.yaml dependencies:
import 'package:belesah/screen_activation.dart';
import 'package:belesah/version_cm/flutter/screen_main_cm.dart';
import 'package:belesah/version_meter/flutter/screen_main_meter.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

// لازم تبقى خارج أي class
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // إعداد FCM
  final messaging = FirebaseMessaging.instance;
  await messaging.requestPermission();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  final prefs = await SharedPreferences.getInstance();
  final isActivated = prefs.getBool('is_activated') ?? false;
  final isMeter = prefs.getBool('is_meter') ?? true;
  runApp(BelesahApp(isActivated: isActivated, isMeter: isMeter));
}

class BelesahApp extends StatelessWidget {
  final bool isActivated;
  final bool isMeter;
  const BelesahApp({
    super.key,
    required this.isActivated,
    required this.isMeter,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: isActivated
          ? isMeter
                ? const ScreenMainMeter()
                : const ScreenMainCM()
          : const ScreenActivation(),
    );
  }
}
