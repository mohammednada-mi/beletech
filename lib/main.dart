import 'package:flutter/material.dart';

import 'contracts/contracts_belesah.dart';
import 'contracts/contracts_price.dart';
import 'enum/enum_beleash.dart';
import 'logic/logic_jumbo.dart';
import 'logic/logic_mi.dart';
import 'logic/logic_mini.dart';
import 'logic/logic_price.dart';

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
  TypeOfSash _selectedSashType = TypeOfSash.singleSash;

  final TextEditingController _widthController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();

  // Price controllers
  final TextEditingController _factoryController = TextEditingController();
  final TextEditingController _elhalkController = TextEditingController();
  final TextEditingController _totalThreadController = TextEditingController();
  final TextEditingController _curtainPriceController = TextEditingController();
  final TextEditingController _doubleCurtainPriceController =
      TextEditingController();
  final TextEditingController _tapePriceController = TextEditingController();
  final TextEditingController _assemblyKitController = TextEditingController();
  final TextEditingController _forshPriceController = TextEditingController();
  final TextEditingController _wightAlumColorController =
      TextEditingController();
  final TextEditingController _frameWeightController = TextEditingController();
  final TextEditingController _sashWeightController = TextEditingController();
  final TextEditingController _magnetPriceController = TextEditingController();
  final TextEditingController _wirePriceController = TextEditingController();

  String _dimensionsResult = '';
  String _priceResult = '';

  @override
  void dispose() {
    _widthController.dispose();
    _heightController.dispose();
    _factoryController.dispose();
    _elhalkController.dispose();
    _totalThreadController.dispose();
    _curtainPriceController.dispose();
    _doubleCurtainPriceController.dispose();
    _tapePriceController.dispose();
    _assemblyKitController.dispose();
    _forshPriceController.dispose();
    _wightAlumColorController.dispose();
    _frameWeightController.dispose();
    _sashWeightController.dispose();
    _magnetPriceController.dispose();
    _wirePriceController.dispose();
    super.dispose();
  }

  /// عدد الضلفة يتبع نوع الشباك (ضلفة واحدة أو اثنتين)
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
    final double? width = double.tryParse(_widthController.text);
    final double? height = double.tryParse(_heightController.text);

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
      _selectedSashType,
    );
    final int numThread = logic.calcNumThread(height, _selectedSashType);

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
طول السلك المطلوب: ${wire.toStringAsFixed(3)} م
''';
    });
  }

  void _calculatePrice() {
    final double? width = double.tryParse(_widthController.text);
    final double? height = double.tryParse(_heightController.text);
    if (width == null || height == null) {
      setState(() {
        _priceResult = 'من فضلك أدخل الطول والعرض بشكل صحيح.';
      });
      return;
    }

    double _parseOrZero(TextEditingController c) =>
        double.tryParse(c.text) ?? 0;

    final double factory = _parseOrZero(_factoryController);
    final double elhalk = _parseOrZero(_elhalkController);
    final double totalThread = _parseOrZero(_totalThreadController);
    final double curtainPrice = _parseOrZero(_curtainPriceController);
    final double doubleCurtainPrice = _parseOrZero(
      _doubleCurtainPriceController,
    );
    final double tapePrice = _parseOrZero(_tapePriceController);
    final double assemblyKit = _parseOrZero(_assemblyKitController);
    final double forshPrice = _parseOrZero(_forshPriceController);
    final double wightAlumColor = _parseOrZero(_wightAlumColorController);
    final double frameWeight = _parseOrZero(_frameWeightController);
    final double sashWeight = _parseOrZero(_sashWeightController);
    final double magnetPrice = _parseOrZero(_magnetPriceController);
    final double wirePrice = _parseOrZero(_wirePriceController);

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
                child: _buildNumberField('العرض (متر)', _widthController),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildNumberField('الارتفاع (متر)', _heightController),
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
                  value: _selectedSashType,
                  isExpanded: true,
                  items: TypeOfSash.values
                      .map(
                        (s) => DropdownMenuItem(value: s, child: Text(s.name)),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => _selectedSashType = value);
                    }
                  },
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
                child: _buildNumberField('العرض (متر)', _widthController),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildNumberField('الارتفاع (متر)', _heightController),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _buildNumberField('سعر المصنع للمتر', _factoryController),
              _buildNumberField('الهالك', _elhalkController),
              _buildNumberField('سعر الخيط للمتر', _totalThreadController),
              _buildNumberField('سعر الستارة للمتر', _curtainPriceController),
              _buildNumberField(
                'سعر الستارة المزدوجة للمتر',
                _doubleCurtainPriceController,
              ),
              _buildNumberField('سعر الشريط للمتر', _tapePriceController),
              _buildNumberField('سعر طقم التجميع', _assemblyKitController),
              _buildNumberField('سعر الفورش للمتر', _forshPriceController),
              _buildNumberField(
                'سعر الألومنيوم الملون للكيلو',
                _wightAlumColorController,
              ),
              _buildNumberField('وزن الإطار', _frameWeightController),
              _buildNumberField('وزن الضلفة', _sashWeightController),
              _buildNumberField('سعر المغناطيس للمتر', _magnetPriceController),
              _buildNumberField('سعر السلك للمتر', _wirePriceController),
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

  Widget _buildNumberField(String label, TextEditingController controller) {
    return SizedBox(
      width: 220,
      child: TextField(
        controller: controller,
        keyboardType: const TextInputType.numberWithOptions(
          decimal: true,
          signed: false,
        ),
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        textDirection: TextDirection.rtl,
      ),
    );
  }
}
