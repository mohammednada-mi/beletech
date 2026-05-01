import 'package:flutter/material.dart';
import 'package:belesah/flutter/screen_main.dart';

class ScreenActivation extends StatefulWidget {
  const ScreenActivation({super.key});

  @override
  State<ScreenActivation> createState() => _ScreenActivationState();
}

class _ScreenActivationState extends State<ScreenActivation> {
  String activationCode = '';
  String message = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('تفعيل برنامج البليسيه')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: SizedBox(
                width: 300,
                child: TextField(
                  
                  textAlign: TextAlign.left,
                  decoration: const InputDecoration(labelText: 'كود التفعيل'),
                  onChanged: (value) {
                    activationCode = value;
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (activationCode == '1234') {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const ScreenMain()),
                  );
                } else {
                  setState(() {
                    message = 'كود غير صحيح';
                  });
                }
              },
              child: const Text('تفعيل'),
            ),
            const SizedBox(height: 16),
            Text(message),
          ],
        ),
      ),
    );
  }
}
