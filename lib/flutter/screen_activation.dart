import 'package:flutter/material.dart';
import 'package:belesah/flutter/screen_main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class ScreenActivation extends StatefulWidget {
  const ScreenActivation({super.key});

  @override
  State<ScreenActivation> createState() => _ScreenActivationState();
}

class _ScreenActivationState extends State<ScreenActivation> {
  String activationCode = '';
  String clientName = '';
  String message = '';
  bool isLoading = false;

  Future<String> _getDeviceId() async {
    final prefs = await SharedPreferences.getInstance();
    if (Platform.isAndroid) {
      final info = await DeviceInfoPlugin().androidInfo;
      return info.id;
    } else if (Platform.isIOS) {
      final info = await DeviceInfoPlugin().iosInfo;
      return info.identifierForVendor ?? 'unknown';
    }
    String? savedId = prefs.getString('device_unique_id');
    if (savedId != null) return savedId;
    final newId = DateTime.now().millisecondsSinceEpoch.toString();
    await prefs.setString('device_unique_id', newId);
    return newId;
  }

  Future<void> _checkCode() async {
    if (clientName.trim().isEmpty) {
      setState(() => message = '⚠️ من فضلك أدخل اسمك');
      return;
    }
    if (activationCode.trim().isEmpty) {
      setState(() => message = '⚠️ من فضلك أدخل كود التفعيل');
      return;
    }

    setState(() {
      isLoading = true;
      message = '';
    });

    try {
      final deviceId = await _getDeviceId();
      final doc = await FirebaseFirestore.instance
          .collection('activation_codes')
          .doc(activationCode.trim())
          .get();

      if (!doc.exists) {
        setState(() => message = '❌ كود غير صحيح');
        return;
      }

      final data = doc.data()!;
      final bool used = data['used'] ?? false;
      final String linkedDevice = data['device_id'] ?? '';

      if (used && linkedDevice != deviceId) {
        setState(() => message = '⚠️ هذا الكود مستخدم على جهاز آخر');
        return;
      }

      if (!used) {
        await FirebaseFirestore.instance
            .collection('activation_codes')
            .doc(activationCode.trim())
            .update({
              'used': true,
              'device_id': deviceId,
              'owner_name': clientName.trim(), // ← حفظ الاسم في Firestore
            });
      }

      // حفظ محلياً
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('is_activated', true);
      await prefs.setString('owner_name', clientName.trim());

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ScreenMain()),
        );
      }
    } catch (e) {
      setState(() => message = '❌ خطأ في الاتصال بالإنترنت');
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('تفعيل برنامج البليسيه')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // خانة الاسم
            Center(
              child: SizedBox(
                width: 300,
                child: TextField(
                  textAlign: TextAlign.right,
                  decoration: const InputDecoration(labelText: 'اسم العميل'),
                  onChanged: (value) => clientName = value,
                ),
              ),
            ),
            const SizedBox(height: 16),
            // خانة الكود
            Center(
              child: SizedBox(
                width: 300,
                child: TextField(
                  textAlign: TextAlign.left,
                  decoration: const InputDecoration(labelText: 'كود التفعيل'),
                  onChanged: (value) => activationCode = value,
                ),
              ),
            ),
            const SizedBox(height: 16),
            isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _checkCode,
                    child: const Text('تفعيل'),
                  ),
            const SizedBox(height: 16),
            Text(
              message,
              style: TextStyle(
                color: message.startsWith('❌') || message.startsWith('⚠️')
                    ? Colors.red
                    : Colors.green,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
