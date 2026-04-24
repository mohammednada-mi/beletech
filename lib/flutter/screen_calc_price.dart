import 'package:belesah/dart/enum/enum_beleash.dart';
import 'package:belesah/dart/logic/logic_price.dart';
import 'package:flutter/material.dart';
import 'package:belesah/dart/logic/save_file.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:belesah/dart/screen/app_data.dart';

/// تسميات عربية لكل مفتاح يعيده [LogicPrice.calcPriceDetails] (لتتبع التسعير).
const Map<String, String> _kCalcPriceDetailLabels = {
  'wireSizeIsDoubleCurtain7m': 'حجم السلك المستخدم (1 = 7م دبل ستارة، 0 = 18م)',
  'belesahWidth': 'عرض البليسيه (محسوب)',
  'belesahHeight': 'ارتفاع البليسيه (محسوب)',
  'belesahSash': 'طول الضلفة (محسوب)',
  'belesahDoubleFace': 'الوجه المزدوج (محسوب)',
  'belesahThread': 'مقدار الخيط الرئيسي',
  'belesahThreadSmall': 'مقدار الخيط الصغير',
  'belesahwire': 'مقدار السلك (طول)',
  'numThread': 'عدد الخيوط الرئيسية',
  'numThreadSmall': 'عدد الخيوط الصغيرة',
  'numSash': 'عدد الضلف',
  'numDoubleFace': 'عدد الوجه المزدوج',
  'totalFrame': 'إجمالي محيط الحلق (م)',
  'totalSash': 'إجمالي طول الضلف (م)',
  'totalWight': 'إجمالي وزن الألومنيوم (كجم تقريباً)',
  'totalPriceAlum': 'سعر الألومنيوم',
  'totalPriceFactory': 'سعر المصنعية',
  'totalPriceDoubleFace': 'سعر الشريط (وجه مزدوج)',
  'totalPriceForsh': 'سعر الفورش',
  'totalPriceMagnet': 'سعر المغناطيس',
  'totalPriceAssemblyKit': 'سعر كيت التجميع',
  'totalPriceThread': 'سعر الخيط',
  'totalPriceWire': 'سعر السلك',
  'totalPriceCurtain': 'سعر الستارة',
  'totalPriceDoubleCurtain': 'سعر الستارة المزدوجة',
  'totalpricesingleSashwire': 'إجمالي نوع: ضلفة واحدة سلك',
  'totalpricesingleSashCurtain': 'إجمالي نوع: ضلفة واحدة ستارة',
  'totalpricesingleSashDoubleCurtain': 'إجمالي نوع: ضلفة واحدة ستارة دبل',
  'totalPriceTwoSashWire': 'إجمالي نوع: ضلفتين سلك',
  'totalPriceTwoSashCurtain': 'إجمالي نوع: ضلفتين ستارة',
  'totalPriceTwoSashwireCurtain': 'إجمالي نوع: ضلفتين سلك وستارة',
  'totalPriceTwoSashDoubleCurtain': 'إجمالي نوع: ضلفتين ستارة دبل',
  'totalPriceTwoSashDoubleCurtainWithwire': 'إجمالي نوع: ضلفتين ستارة دبل وسلك',
  'selectedTotal': 'المجموع المختار لهذا النوع (خامات فقط)',
};

const List<String> _kCalcPriceDetailKeyOrder = [
  'wireSizeIsDoubleCurtain7m',
  'belesahWidth',
  'belesahHeight',
  'belesahSash',
  'belesahDoubleFace',
  'belesahThread',
  'belesahThreadSmall',
  'belesahwire',
  'numThread',
  'numThreadSmall',
  'numSash',
  'numDoubleFace',
  'totalFrame',
  'totalSash',
  'totalWight',
  'totalPriceAlum',
  'totalPriceFactory',
  'totalPriceDoubleFace',
  'totalPriceForsh',
  'totalPriceMagnet',
  'totalPriceAssemblyKit',
  'totalPriceThread',
  'totalPriceWire',
  'totalPriceCurtain',
  'totalPriceDoubleCurtain',
  'totalpricesingleSashwire',
  'totalpricesingleSashCurtain',
  'totalpricesingleSashDoubleCurtain',
  'totalPriceTwoSashWire',
  'totalPriceTwoSashCurtain',
  'totalPriceTwoSashwireCurtain',
  'totalPriceTwoSashDoubleCurtain',
  'totalPriceTwoSashDoubleCurtainWithwire',
  'selectedTotal',
];

List<Widget> _debugDetailRows(Map<String, double> d) {
  final seen = <String>{};
  final rows = <Widget>[];
  for (final key in _kCalcPriceDetailKeyOrder) {
    if (!d.containsKey(key)) continue;
    seen.add(key);
    rows.add(
      SelectableText(
        '${_kCalcPriceDetailLabels[key] ?? key}: ${d[key]!.toStringAsFixed(4)}',
      ),
    );
    rows.add(const SizedBox(height: 4));
  }
  for (final e in d.entries) {
    if (seen.contains(e.key)) continue;
    rows.add(
      SelectableText(
        '${_kCalcPriceDetailLabels[e.key] ?? e.key}: ${e.value.toStringAsFixed(4)}',
      ),
    );
    rows.add(const SizedBox(height: 4));
  }
  return rows;
}

class ScreenCalcPrice extends StatefulWidget {
  const ScreenCalcPrice({super.key});

  @override
  State<ScreenCalcPrice> createState() => _ScreenCalcPriceState();
}

class _ScreenCalcPriceState extends State<ScreenCalcPrice> {
  double factory = 0;
  double elhalk = 0;
  double totalThread = 0;
  double curtainprice = 0;
  double doubleCurtainPrice = 0;
  double tapePrice = 0;
  double assemblyKit = 0;
  double forshPrice = 0;
  double wightAlumColor = 0;
  double frameWeight = 0;
  double sashWeight = 0;
  double magnetPrice = 0;
  double wirePrice = 0;
  double makseb = 0;
  TypeOfBelesah? selectedBelesah;
  double? resultPrice;
  final TextEditingController factoryController = TextEditingController();
  final TextEditingController elhalkController = TextEditingController();
  final TextEditingController tapePriceController = TextEditingController();
  final TextEditingController assemblyKitController = TextEditingController();
  final TextEditingController forshPriceController = TextEditingController();
  final TextEditingController wightAlumColorController =
      TextEditingController();
  final TextEditingController frameWeightController = TextEditingController();
  final TextEditingController sashWeightController = TextEditingController();
  final TextEditingController magnetPriceController = TextEditingController();
  final TextEditingController wirePriceController = TextEditingController();
  final TextEditingController curtainPriceController = TextEditingController();
  final TextEditingController doubleCurtainPriceController =
      TextEditingController();
  final TextEditingController totalThreadController = TextEditingController();
  final TextEditingController maksebController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      factoryController.text = prefs.getString('factory') ?? '0';
      factory = double.tryParse(factoryController.text) ?? 0;
      elhalkController.text = prefs.getString('elhalk') ?? '0';
      elhalk = double.tryParse(elhalkController.text) ?? 0;
      tapePriceController.text = prefs.getString('tapePrice') ?? '0';
      tapePrice = double.tryParse(tapePriceController.text) ?? 0;
      assemblyKitController.text = prefs.getString('assemblyKit') ?? '0';
      assemblyKit = double.tryParse(assemblyKitController.text) ?? 0;
      forshPriceController.text = prefs.getString('forshPrice') ?? '0';
      forshPrice = double.tryParse(forshPriceController.text) ?? 0;
      wightAlumColorController.text = prefs.getString('wightAlumColor') ?? '0';
      wightAlumColor = double.tryParse(wightAlumColorController.text) ?? 0;
      frameWeightController.text = prefs.getString('frameWeight') ?? '0';
      frameWeight = double.tryParse(frameWeightController.text) ?? 0;
      sashWeightController.text = prefs.getString('sashWeight') ?? '0';
      sashWeight = double.tryParse(sashWeightController.text) ?? 0;
      magnetPriceController.text = prefs.getString('magnetPrice') ?? '0';
      magnetPrice = double.tryParse(magnetPriceController.text) ?? 0;
      wirePriceController.text = prefs.getString('wirePrice') ?? '0';
      wirePrice = double.tryParse(wirePriceController.text) ?? 0;

      curtainPriceController.text = prefs.getString('curtainprice') ?? '0';
      curtainprice = double.tryParse(curtainPriceController.text) ?? 0;
      doubleCurtainPriceController.text =
          prefs.getString('doubleCurtainPrice') ?? '0';
      doubleCurtainPrice =
          double.tryParse(doubleCurtainPriceController.text) ?? 0;
      totalThreadController.text = prefs.getString('totalThread') ?? '0';
      totalThread = double.tryParse(totalThreadController.text) ?? 0;
      maksebController.text = prefs.getString('makseb') ?? '0';
      makseb = double.tryParse(maksebController.text) ?? 0;
    });
  }

  @override
  void dispose() {
    factoryController.dispose();
    elhalkController.dispose();
    tapePriceController.dispose();
    assemblyKitController.dispose();
    forshPriceController.dispose();
    wightAlumColorController.dispose();
    frameWeightController.dispose();
    sashWeightController.dispose();
    magnetPriceController.dispose();
    wirePriceController.dispose();
    curtainPriceController.dispose();
    doubleCurtainPriceController.dispose();
    totalThreadController.dispose();
    maksebController.dispose();
    super.dispose();
  }

  Map<String, double>? details;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('بليسيه')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'الارتفاع (متر)',
                      ),
                      onChanged: (value) {
                        AppData.height = double.tryParse(value) ?? 0;
                      },
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'العرض (متر)',
                      ),
                      onChanged: (value) {
                        AppData.width = double.tryParse(value) ?? 0;
                      },
                    ),
                  ),
                ],
              ),

              Wrap(
                spacing: 5.0,
                runSpacing: 5.0,
                children: [
                  SizedBox(
                    width: 100,
                    child: TextField(
                      controller: factoryController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'سعر المصنع'),
                      onChanged: (value) {
                        factory = double.tryParse(value) ?? 0;
                        SaveFile.saveData('factory', value);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: TextField(
                      controller: elhalkController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'الهالك'),
                      onChanged: (value) {
                        elhalk = double.tryParse(value) ?? 0;
                        SaveFile.saveData('elhalk', value);
                      },
                    ),
                  ),

                  SizedBox(
                    width: 100,
                    child: TextField(
                      controller: wirePriceController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'سعر السلك'),
                      onChanged: (value) {
                        wirePrice = double.tryParse(value) ?? 0;
                        SaveFile.saveData('wirePrice', value);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: TextField(
                      controller: magnetPriceController,

                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'سعر المغناطيس'),
                      onChanged: (value) {
                        magnetPrice = double.tryParse(value) ?? 0;
                        SaveFile.saveData('magnetPrice', value);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: TextField(
                      controller: tapePriceController,

                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'سعر الشريط'),
                      onChanged: (value) {
                        tapePrice = double.tryParse(value) ?? 0;
                        SaveFile.saveData('tapePrice', value);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: TextField(
                      controller: assemblyKitController,

                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'سعر كيت التجميع'),
                      onChanged: (value) {
                        assemblyKit = double.tryParse(value) ?? 0;
                        SaveFile.saveData('assemblyKit', value);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: TextField(
                      controller: forshPriceController,

                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'سعر الفورش'),
                      onChanged: (value) {
                        forshPrice = double.tryParse(value) ?? 0;
                        SaveFile.saveData('forshPrice', value);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: TextField(
                      controller: wightAlumColorController,

                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'وزن الالومنيوم'),
                      onChanged: (value) {
                        wightAlumColor = double.tryParse(value) ?? 0;
                        SaveFile.saveData('wightAlumColor', value);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: TextField(
                      controller: frameWeightController,

                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'وزن الإطار'),
                      onChanged: (value) {
                        frameWeight = double.tryParse(value) ?? 0;
                        SaveFile.saveData('frameWeight', value);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: TextField(
                      controller: sashWeightController,

                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'وزن الشيش'),
                      onChanged: (value) {
                        sashWeight = double.tryParse(value) ?? 0;
                        SaveFile.saveData('sashWeight', value);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: TextField(
                      controller: curtainPriceController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'سعر الستارة'),
                      onChanged: (value) {
                        curtainprice = double.tryParse(value) ?? 0;
                        SaveFile.saveData('curtainprice', value);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: TextField(
                      controller: doubleCurtainPriceController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'سعر الستارة المزدوجة',
                      ),
                      onChanged: (value) {
                        doubleCurtainPrice = double.tryParse(value) ?? 0;
                        SaveFile.saveData('doubleCurtainPrice', value);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: TextField(
                      controller: totalThreadController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'سعر الخيط'),
                      onChanged: (value) {
                        totalThread = double.tryParse(value) ?? 0;
                        SaveFile.saveData('totalThread', value);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: maksebController,
                      decoration: InputDecoration(labelText: 'المكسب '),
                      onChanged: (value) {
                        setState(() {
                          makseb = double.tryParse(value) ?? 0;
                          SaveFile.saveData('makseb', value);
                        });
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  DropdownButton<TypeOfBelesah>(
                    value: selectedBelesah,
                    hint: const Text('اختر نوع البليسيه'),
                    items: TypeOfBelesah.values.map((TypeOfBelesah type) {
                      return DropdownMenuItem<TypeOfBelesah>(
                        value: type,
                        child: Text(type.belesah),
                      );
                    }).toList(),
                    onChanged: (TypeOfBelesah? newValue) {
                      setState(() {
                        selectedBelesah = newValue;
                      });
                    },
                  ),
                ],
              ),
              //Test
              ElevatedButton(
                onPressed: () {
                  if (selectedBelesah == null ||
                      AppData.width <= 0 ||
                      AppData.height <= 0 ||
                      factory <= 0 ||
                      elhalk <= 0 ||
                      tapePrice <= 0 ||
                      assemblyKit <= 0 ||
                      forshPrice <= 0 ||
                      wightAlumColor <= 0 ||
                      frameWeight <= 0 ||
                      sashWeight <= 0 ||
                      magnetPrice <= 0 ||
                      wirePrice <= 0 ||
                      curtainprice <= 0 ||
                      doubleCurtainPrice <= 0 ||
                      totalThread <= 0 ||
                      makseb <= 0) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('الرجاء ملء جميع الحقول بشكل صحيح'),
                      ),
                    );
                    return;
                  }

                  setState(() {
                    details = LogicPrice().calcPriceDetails(
                      AppData.width,
                      AppData.height,
                      factory,
                      elhalk,
                      totalThread,
                      curtainprice,
                      doubleCurtainPrice,
                      tapePrice,
                      assemblyKit,
                      forshPrice,
                      wightAlumColor,
                      frameWeight,
                      sashWeight,
                      magnetPrice,
                      wirePrice,
                      makseb,
                      selectedBelesah!,
                    );
                    resultPrice = details!['selectedTotal']!;
                  });
                },
                child: const Text('احسب'),
              ),
              if (resultPrice != null && details != null) ...[
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'مدخلات الأبعاد: العرض ${AppData.width} م — الارتفاع ${AppData.height} م',
                        ),
                        if (selectedBelesah != null)
                          Text('النوع: ${selectedBelesah!.belesah}'),
                        Text('الهالك %: $elhalk — المكسب %: $makseb'),
                        const Divider(height: 24),
                        Text(
                          'السعر الخامات فقط : ${resultPrice!.toStringAsFixed(2)}',
                        ),
                        Text(
                          'السعر شامل الهالك : ${(resultPrice! * (elhalk / 100) + resultPrice!).toStringAsFixed(2)}',
                        ),
                        Text(
                          'السعر شامل المكسب : ${((resultPrice! * (elhalk / 100) + resultPrice!) * (makseb / 100) + (resultPrice! * (elhalk / 100) + resultPrice!)).toStringAsFixed(2)}',
                        ),
                        if (selectedBelesah == TypeOfBelesah.twoSashwireCurtain)
                          Text(
                            'سعر بدون مغناطيس : ${((resultPrice!) - details!['totalPriceMagnet']!).toStringAsFixed(2)} ',
                          ),
                      ],
                    ),
                  ),
                ),
                Card(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'تفاصيل الحساب (كل النتائج)',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        ..._debugDetailRows(details!),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
