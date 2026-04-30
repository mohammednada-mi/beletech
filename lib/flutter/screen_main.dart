import 'package:flutter/material.dart';
import 'package:belesah/flutter/screen_calc.dart';
import 'package:belesah/flutter/screen_calc_price.dart';
import 'package:belesah/flutter/screen_calc_price_mini.dart';
import 'package:belesah/flutter/screen_calc_price_jumbo.dart';

class ScreenMain extends StatefulWidget {
  const ScreenMain({super.key});

  @override
  State<ScreenMain> createState() => _ScreenMainState();
}

class _ScreenMainState extends State<ScreenMain> {
  Widget _currentScreen = const ScreenCalc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('بليسيه')),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text('التخصيمات'),
              onTap: () {
                setState(() {
                  _currentScreen = const ScreenCalc();
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('التسعير'),
              onTap: () {
                setState(() {
                  _currentScreen = const ScreenCalcPrice();
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('التسعير ميني'),
              onTap: () {
                setState(() {
                  _currentScreen = const ScreenCalcPriceMini();
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('التسعير جامبو'),
              onTap: () {
                setState(() {
                  _currentScreen = const ScreenCalcPriceJumbo();
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: _currentScreen,
    );
  }
}
