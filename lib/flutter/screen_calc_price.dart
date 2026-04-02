import 'package:flutter/material.dart';

class ScreenCalcPrice extends StatefulWidget {
  const ScreenCalcPrice({super.key});

  @override
  State<ScreenCalcPrice> createState() => _ScreenCalcPriceState();
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('بليسيه')),
    body: SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(children: []),
      ),
    ),
  );
}
