import 'dart:async';
import 'package:flutter/material.dart';

import 'dart/contracts/contracts_belesah.dart';
import 'dart/contracts/contracts_price.dart';
import 'dart/enum/enum_beleash.dart';
import 'dart/logic/logic_jumbo.dart';
import 'dart/logic/logic_mi.dart';
import 'dart/logic/logic_mini.dart';
import 'dart/logic/logic_price.dart';
import 'dart/logic/save_file.dart';

void main() {
  runApp(const BelesahApp());
}

class BelesahApp extends StatelessWidget {
  const BelesahApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Belesah Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

enum BelesahSizeType { mini, mi, jumbo }

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  BelesahSizeType _selectedSizeType = BelesahSizeType.mi;
  TypeOfBelesah _selectedBelesahType = TypeOfBelesah.singleSashwire;
  Wiresize _selectedWireSize = Wiresize.wire18m;
  final List<String> _keys = const [
    'width',
    'height',
    'factory',
    'elhalk',
    'totalThread',
    'curtainPrice',
    'doubleCurtainPrice',
    'tapePrice',
    'assemblyKit',
    'forshPrice',
    'wightAlumColor',
    'frameWeight',
    'sashWeight',
    'magnetPrice',
    'wirePrice',
  ];
  final Map<String, String> _values = {};
  Timer? _saveDebounce;
  bool _isReady = false;

  String _dimensionsResult = '';
  String _priceResult = '';

  @override
  void initState() {
    super.initState();
    _loadSavedValues();
  }

  @override
  void dispose() {
    _saveDebounce?.cancel();
    super.dispose();
  }

  Future<void> _loadSavedValues() async {
    final Map<String, String> loaded = {};
    for (final String key in _keys) {
      loaded[key] = await SaveFile.loadData(key) ?? '';
    }
    if (!mounted) return;
    setState(() {
      _values.addAll(loaded);
      _isReady = true;
    });
  }

  void _setValue(String key, String value) {
    _values[key] = value;
    _saveDebounce?.cancel();
    _saveDebounce = Timer(const Duration(milliseconds: 350), () {
      SaveFile.saveData(key, value);
    });
  }

  double _num(String key) => double.tryParse(_values[key] ?? '') ?? 0;

  TypeOfSash _sashTypeFromBelesah(TypeOfBelesah type) {
    switch (type) {
      case TypeOfBelesah.singleSashwire:
      case TypeOfBelesah.singleSashCurtain:
      case TypeOfBelesah.singleSashDoubleCurtain:
        return TypeOfSash.singleSash;
      case TypeOfBelesah.twoSashwire:
      case TypeOfBelesah.twoSashwireCurtain:
      case TypeOfBelesah.twoSashCurtain:
      case TypeOfBelesah.twoSashDoubleCurtain:
      case TypeOfBelesah.twoSashDoubleCurtainWithwire:
        return TypeOfSash.twoSash;
    }
  }

  ContractsBelesah _getLogicForSizeType() {
    switch (_selectedSizeType) {
      case BelesahSizeType.mini:
        return LogicBelesahMini();
      case BelesahSizeType.mi:
        return LogicBelesahMi();
      case BelesahSizeType.jumbo:
        return LogicBelesahJumbo();
    }
  }

  void _calculateDimensions() {
    final double? width = double.tryParse(_values['width'] ?? '');
    final double? height = double.tryParse(_values['height'] ?? '');

    if (width == null || height == null) {
      setState(() {
        _dimensionsResult = 'من فضلك أدخل الطول والعرض بشكل صحيح.';
      });
      return;
    }

    final ContractsBelesah logic = _getLogicForSizeType();

    final double belesahWidth = logic.calcWidth(width);
    final double belesahHeight = logic.calcHeight(height);
    final double belesahSash = logic.calcSash(height);
    final double belesahDoubleFace = logic.calcDoubleFace(height);
    final double belesahThread = logic.calcThread(height, width);
    final double belesahThreadSmall = logic.calcThreadSmall(height, width);
    final double punching = logic.calcPunching(height);
    final double wire = logic.calcWire(
      width,
      _selectedWireSize,
      _sashTypeFromBelesah(_selectedBelesahType),
    );
    final int numThread = logic.calcNumThread(
      height,
      _sashTypeFromBelesah(_selectedBelesahType),
    );

    setState(() {
      _dimensionsResult =
          '''
النوع: ${_selectedSizeType.name}
عرض البليسة: ${belesahWidth.toStringAsFixed(3)} م
ارتفاع البليسة: ${belesahHeight.toStringAsFixed(3)} م
ضلفة الساش: ${belesahSash.toStringAsFixed(3)} م
الوجهين: ${belesahDoubleFace.toStringAsFixed(3)} م
طول الخيط الكبير: ${belesahThread.toStringAsFixed(3)} م
طول الخيط الصغير: ${belesahThreadSmall.toStringAsFixed(3)} م
عدد الخيوط: $numThread
عدد الثقوب (Punching): ${punching.toStringAsFixed(1)}
طول السلك المطلوب: ${wire.toStringAsFixed(0)} م
''';
    });
  }

  void _calculatePrice() {
    final double? width = double.tryParse(_values['width'] ?? '');
    final double? height = double.tryParse(_values['height'] ?? '');
    if (width == null || height == null) {
      setState(() {
        _priceResult = 'من فضلك أدخل الطول والعرض بشكل صحيح.';
      });
      return;
    }

    final double factory = _num('factory');
    final double elhalk = _num('elhalk');
    final double totalThread = _num('totalThread');
    final double curtainPrice = _num('curtainPrice');
    final double doubleCurtainPrice = _num('doubleCurtainPrice');
    final double tapePrice = _num('tapePrice');
    final double assemblyKit = _num('assemblyKit');
    final double forshPrice = _num('forshPrice');
    final double wightAlumColor = _num('wightAlumColor');
    final double frameWeight = _num('frameWeight');
    final double sashWeight = _num('sashWeight');
    final double magnetPrice = _num('magnetPrice');
    final double wirePrice = _num('wirePrice');

    final ContractsPrice logicPrice = LogicPrice();
    final TypeOfSash sashType = _sashTypeFromBelesah(_selectedBelesahType);

    final double price = logicPrice.calcPrice(
      width,
      height,
      factory,
      elhalk,
      totalThread,
      curtainPrice,
      doubleCurtainPrice,
      tapePrice,
      assemblyKit,
      forshPrice,
      wightAlumColor,
      frameWeight,
      sashWeight,
      magnetPrice,
      wirePrice,
      _selectedWireSize,
      sashType,
      _selectedBelesahType,
    );

    setState(() {
      _priceResult = 'السعر الكلي: ${price.toStringAsFixed(2)}';
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isReady) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('حساب البليسة'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'الأبعاد'),
              Tab(text: 'السعر'),
            ],
          ),
        ),
        body: TabBarView(children: [_buildDimensionsTab(), _buildPriceTab()]),
      ),
    );
  }

  Widget _buildDimensionsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'نوع البليسة',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          DropdownButton<BelesahSizeType>(
            value: _selectedSizeType,
            items: const [
              DropdownMenuItem(
                value: BelesahSizeType.mini,
                child: Text('Mini'),
              ),
              DropdownMenuItem(value: BelesahSizeType.mi, child: Text('Mi')),
              DropdownMenuItem(
                value: BelesahSizeType.jumbo,
                child: Text('Jumbo'),
              ),
            ],
            onChanged: (value) {
              if (value != null) {
                setState(() => _selectedSizeType = value);
              }
            },
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildNumberField('العرض (متر)', 'width'),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildNumberField('الارتفاع (متر)', 'height'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'نوع السلك والضلفة',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: DropdownButton<Wiresize>(
                  value: _selectedWireSize,
                  isExpanded: true,
                  items: Wiresize.values
                      .map(
                        (w) => DropdownMenuItem(value: w, child: Text(w.name)),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => _selectedWireSize = value);
                    }
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: DropdownButton<TypeOfSash>(
                  value: _sashTypeFromBelesah(_selectedBelesahType),
                  isExpanded: true,
                  items: TypeOfSash.values
                      .map(
                        (s) => DropdownMenuItem(value: s, child: Text(s.name)),
                      )
                      .toList(),
                  onChanged: null,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _calculateDimensions,
              child: const Text('احسب الأبعاد'),
            ),
          ),
          const SizedBox(height: 16),
          if (_dimensionsResult.isNotEmpty)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  _dimensionsResult,
                  textDirection: TextDirection.rtl,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPriceTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: _buildNumberField('العرض (متر)', 'width'),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildNumberField('الارتفاع (متر)', 'height'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _buildNumberField('سعر المصنع للمتر', 'factory'),
              _buildNumberField('الهالك', 'elhalk'),
              _buildNumberField('سعر الخيط للمتر', 'totalThread'),
              _buildNumberField('سعر الستارة للمتر', 'curtainPrice'),
              _buildNumberField(
                'سعر الستارة المزدوجة للمتر',
                'doubleCurtainPrice',
              ),
              _buildNumberField('سعر الشريط للمتر', 'tapePrice'),
              _buildNumberField('سعر طقم التجميع', 'assemblyKit'),
              _buildNumberField('سعر الفورش للمتر', 'forshPrice'),
              _buildNumberField(
                'سعر الألومنيوم الملون للكيلو',
                'wightAlumColor',
              ),
              _buildNumberField('وزن الإطار', 'frameWeight'),
              _buildNumberField('وزن الضلفة', 'sashWeight'),
              _buildNumberField('سعر المغناطيس للمتر', 'magnetPrice'),
              _buildNumberField('سعر السلك للمتر', 'wirePrice'),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'مقاس السلك',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          DropdownButton<Wiresize>(
            value: _selectedWireSize,
            isExpanded: true,
            items: Wiresize.values
                .map((w) => DropdownMenuItem(value: w, child: Text(w.name)))
                .toList(),
            onChanged: (value) {
              if (value != null) setState(() => _selectedWireSize = value);
            },
          ),
          const SizedBox(height: 16),
          const Text(
            'نوع الشباك (عدد الضلف + التغطية)',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          DropdownButton<TypeOfBelesah>(
            value: _selectedBelesahType,
            isExpanded: true,
            items: TypeOfBelesah.values
                .map((t) => DropdownMenuItem(value: t, child: Text(t.name)))
                .toList(),
            onChanged: (value) {
              if (value != null) {
                setState(() => _selectedBelesahType = value);
              }
            },
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _calculatePrice,
              child: const Text('احسب السعر'),
            ),
          ),
          const SizedBox(height: 16),
          if (_priceResult.isNotEmpty)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  _priceResult,
                  textDirection: TextDirection.rtl,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildNumberField(String label, String key) {
    return SizedBox(
      width: 220,
      child: TextFormField(
        initialValue: _values[key] ?? '',
        keyboardType: const TextInputType.numberWithOptions(
          decimal: true,
          signed: false,
        ),
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        onChanged: (value) => _setValue(key, value),
        textDirection: TextDirection.rtl,
      ),
    );
  }
}
