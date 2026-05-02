import 'package:flutter/material.dart';
import 'package:belesah/flutter/screen_calc.dart';
import 'package:belesah/flutter/screen_calc_price.dart';
import 'package:belesah/flutter/screen_calc_price_mini.dart';
import 'package:belesah/flutter/screen_calc_price_jumbo.dart';
import 'package:url_launcher/url_launcher.dart';

class ScreenMain extends StatefulWidget {
  const ScreenMain({super.key});

  @override
  State<ScreenMain> createState() => _ScreenMainState();
}

class _ScreenMainState extends State<ScreenMain> {
  int _currentIndex = 0;
  late final List<Widget?> _cachedScreens;
  bool _showStartupSplash = true;

  @override
  void initState() {
    super.initState();
    _cachedScreens = List<Widget?>.filled(4, null);
    _cachedScreens[0] = const ScreenCalc();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _prepareStartup();
    });
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

  void _preloadRemainingScreens() {
    if (!mounted) return;
    for (var index = 1; index < _cachedScreens.length; index++) {
      _cachedScreens[index] ??= _createScreen(index);
    }
  }

  Future<void> _prepareStartup() async {
    final splashStart = DateTime.now();
    _preloadRemainingScreens();

    const minimumSplashDuration = Duration(milliseconds: 450);
    final elapsed = DateTime.now().difference(splashStart);
    final remaining = minimumSplashDuration - elapsed;
    if (remaining > Duration.zero) {
      await Future<void>.delayed(remaining);
    }

    if (!mounted) return;
    setState(() {
      _showStartupSplash = false;
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
            ListTile(
              leading: const Icon(Icons.chat, color: Colors.green),
              title: const Text('للتواصل عبر واتساب'),
              onTap: () async {
                final phone = '01012025465'; // ← رقمك هنا بالكود الدولي بدون +
                final url = Uri.parse('whatsapp://send?phone=$phone');
                if (await canLaunchUrl(url)) {
                  await launchUrl(url, mode: LaunchMode.externalApplication);
                }
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          IndexedStack(
            index: _currentIndex,
            children: List<Widget>.generate(
              _cachedScreens.length,
              (index) => _cachedScreens[index] ?? const SizedBox.shrink(),
            ),
          ),
          if (_showStartupSplash)
            ColoredBox(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'بليسيه',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 12),
                    CircularProgressIndicator(strokeWidth: 2.5),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
