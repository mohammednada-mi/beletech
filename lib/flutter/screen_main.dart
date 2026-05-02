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
  int _currentIndex = 0;
  late final List<Widget?> _cachedScreens;

  @override
  void initState() {
    super.initState();
    _cachedScreens = List<Widget?>.filled(4, null);
    _cachedScreens[0] = const ScreenCalc();
  }

  Widget _createScreen(int index) {
    switch (index) {
      case 1:
        return const ScreenCalcPrice();
      case 2:
        return const ScreenCalcPriceMini();
      case 3:
        return const ScreenCalcPriceJumbo();
      case 0:
      default:
        return const ScreenCalc();
    }
  }

  void _selectTab(int index) {
    setState(() {
      _currentIndex = index;
      _cachedScreens[index] ??= _createScreen(index);
    });
  }

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
                _selectTab(0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('التسعير'),
              onTap: () {
                _selectTab(1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('التسعير ميني'),
              onTap: () {
                _selectTab(2);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('التسعير جامبو'),
              onTap: () {
                _selectTab(3);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: List<Widget>.generate(
          _cachedScreens.length,
          (index) => _cachedScreens[index] ?? const SizedBox.shrink(),
        ),
      ),
    );
  }
}
