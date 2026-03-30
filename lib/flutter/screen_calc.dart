import 'package:flutter/material.dart';

class ScreenCalc extends StatelessWidget {
  const ScreenCalc({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('بليسيه')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(children: [
          

        ],),
        ),
      ),
    );
  }
}
