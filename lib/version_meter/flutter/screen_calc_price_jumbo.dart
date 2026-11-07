import 'package:belesah/version_meter/dart/enum/enum_beleash.dart';
import 'package:belesah/version_meter/dart/logic/logic_price_jumbo.dart';
import 'package:flutter/material.dart';
import 'package:belesah/version_meter/dart/logic/save_file.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:belesah/version_meter/dart/screen/app_data.dart';

class ScreenCalcPriceJumbo extends StatefulWidget {
  const ScreenCalcPriceJumbo({super.key});

  @override
  State<ScreenCalcPriceJumbo> createState() => _ScreenCalcPriceJumboState();
}

class _ScreenCalcPriceJumboState extends State<ScreenCalcPriceJumbo> {
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
  TypeOfBelesah? selectedBelesah = TypeOfBelesah.singleSashwire;
  double? resultPrice;
  List<Map<String, dynamic>> addedCards = [];
  final TextEditingController factoryControllerJumbo = TextEditingController();
  final TextEditingController elhalkControllerJumbo = TextEditingController();
  final TextEditingController tapePriceControllerJumbo =
      TextEditingController();
  final TextEditingController assemblyKitControllerJumbo =
      TextEditingController();
  final TextEditingController forshPriceControllerJumbo =
      TextEditingController();
  final TextEditingController wightAlumColorControllerJumbo =
      TextEditingController();
  final TextEditingController frameWeightControllerJumbo =
      TextEditingController();
  final TextEditingController sashWeightControllerJumbo =
      TextEditingController();
  final TextEditingController magnetPriceControllerJumbo =
      TextEditingController();
  final TextEditingController wirePriceControllerJumbo =
      TextEditingController();
  final TextEditingController curtainPriceControllerJumbo =
      TextEditingController();
  final TextEditingController doubleCurtainPriceControllerJumbo =
      TextEditingController();
  final TextEditingController totalThreadControllerJumbo =
      TextEditingController();
  final TextEditingController maksebControllerJumbo = TextEditingController();
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      factoryControllerJumbo.text = prefs.getString('factoryJumbo') ?? '0';
      factory = double.tryParse(factoryControllerJumbo.text) ?? 0;
      elhalkControllerJumbo.text = prefs.getString('elhalkJumbo') ?? '0';
      elhalk = double.tryParse(elhalkControllerJumbo.text) ?? 0;
      tapePriceControllerJumbo.text = prefs.getString('tapePriceJumbo') ?? '0';
      tapePrice = double.tryParse(tapePriceControllerJumbo.text) ?? 0;
      assemblyKitControllerJumbo.text =
          prefs.getString('assemblyKitJumbo') ?? '0';
      assemblyKit = double.tryParse(assemblyKitControllerJumbo.text) ?? 0;
      forshPriceControllerJumbo.text =
          prefs.getString('forshPriceJumbo') ?? '0';
      forshPrice = double.tryParse(forshPriceControllerJumbo.text) ?? 0;
      wightAlumColorControllerJumbo.text =
          prefs.getString('wightAlumColorJumbo') ?? '0';
      wightAlumColor = double.tryParse(wightAlumColorControllerJumbo.text) ?? 0;
      frameWeightControllerJumbo.text =
          prefs.getString('frameWeightJumbo') ?? '0';
      frameWeight = double.tryParse(frameWeightControllerJumbo.text) ?? 0;
      sashWeightControllerJumbo.text =
          prefs.getString('sashWeightJumbo') ?? '0';
      sashWeight = double.tryParse(sashWeightControllerJumbo.text) ?? 0;
      magnetPriceControllerJumbo.text =
          prefs.getString('magnetPriceJumbo') ?? '0';
      magnetPrice = double.tryParse(magnetPriceControllerJumbo.text) ?? 0;
      wirePriceControllerJumbo.text = prefs.getString('wirePriceJumbo') ?? '0';
      wirePrice = double.tryParse(wirePriceControllerJumbo.text) ?? 0;

      curtainPriceControllerJumbo.text =
          prefs.getString('curtainpriceJumbo') ?? '0';
      curtainprice = double.tryParse(curtainPriceControllerJumbo.text) ?? 0;
      doubleCurtainPriceControllerJumbo.text =
          prefs.getString('doubleCurtainPriceJumbo') ?? '0';
      doubleCurtainPrice =
          double.tryParse(doubleCurtainPriceControllerJumbo.text) ?? 0;
      totalThreadControllerJumbo.text =
          prefs.getString('totalThreadJumbo') ?? '0';
      totalThread = double.tryParse(totalThreadControllerJumbo.text) ?? 0;
      maksebControllerJumbo.text = prefs.getString('maksebJumbo') ?? '0';
      makseb = double.tryParse(maksebControllerJumbo.text) ?? 0;
    });
  }

  @override
  void dispose() {
    factoryControllerJumbo.dispose();
    elhalkControllerJumbo.dispose();
    tapePriceControllerJumbo.dispose();
    assemblyKitControllerJumbo.dispose();
    forshPriceControllerJumbo.dispose();
    wightAlumColorControllerJumbo.dispose();
    frameWeightControllerJumbo.dispose();
    sashWeightControllerJumbo.dispose();
    magnetPriceControllerJumbo.dispose();
    wirePriceControllerJumbo.dispose();
    curtainPriceControllerJumbo.dispose();
    doubleCurtainPriceControllerJumbo.dispose();
    totalThreadControllerJumbo.dispose();
    maksebControllerJumbo.dispose();
    super.dispose();
  }

  Map<String, double>? details;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('تسعير قطاع 3.7')),
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
                      style: const TextStyle(fontSize: 20),
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
                      style: const TextStyle(fontSize: 20),
                      controller: factoryControllerJumbo,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'المصنعية'),
                      onChanged: (value) {
                        factory = double.tryParse(value) ?? 0;
                        SaveFile.saveData('factoryJumbo', value);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: TextField(
                      style: const TextStyle(fontSize: 20),
                      controller: elhalkControllerJumbo,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'نسبة الهالك'),
                      onChanged: (value) {
                        elhalk = double.tryParse(value) ?? 0;
                        SaveFile.saveData('elhalkJumbo', value);
                      },
                    ),
                  ),

                  SizedBox(
                    width: 100,
                    child: TextField(
                      style: const TextStyle(fontSize: 20),
                      controller: wirePriceControllerJumbo,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'سعر السلك'),
                      onChanged: (value) {
                        wirePrice = double.tryParse(value) ?? 0;
                        SaveFile.saveData('wirePriceJumbo', value);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: TextField(
                      style: const TextStyle(fontSize: 20),
                      controller: magnetPriceControllerJumbo,

                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'سعر المغناطيس'),
                      onChanged: (value) {
                        magnetPrice = double.tryParse(value) ?? 0;
                        SaveFile.saveData('magnetPriceJumbo', value);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: TextField(
                      style: const TextStyle(fontSize: 20),
                      controller: tapePriceControllerJumbo,

                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'سعر الشريط'),
                      onChanged: (value) {
                        tapePrice = double.tryParse(value) ?? 0;
                        SaveFile.saveData('tapePriceJumbo', value);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: TextField(
                      style: const TextStyle(fontSize: 20),
                      controller: assemblyKitControllerJumbo,

                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'سعر طقم التجميع'),
                      onChanged: (value) {
                        assemblyKit = double.tryParse(value) ?? 0;
                        SaveFile.saveData('assemblyKitJumbo', value);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: TextField(
                      style: const TextStyle(fontSize: 20),
                      controller: forshPriceControllerJumbo,

                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'سعر الفورش'),
                      onChanged: (value) {
                        forshPrice = double.tryParse(value) ?? 0;
                        SaveFile.saveData('forshPriceJumbo', value);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: TextField(
                      style: const TextStyle(fontSize: 20),
                      controller: wightAlumColorControllerJumbo,

                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'سعر كيلو الألومنيوم المدهون',
                      ),
                      onChanged: (value) {
                        wightAlumColor = double.tryParse(value) ?? 0;
                        SaveFile.saveData('wightAlumColorJumbo', value);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: TextField(
                      style: const TextStyle(fontSize: 20),
                      controller: frameWeightControllerJumbo,

                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'وزن الحلق'),
                      onChanged: (value) {
                        frameWeight = double.tryParse(value) ?? 0;
                        SaveFile.saveData('frameWeightJumbo', value);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: TextField(
                      style: const TextStyle(fontSize: 20),
                      controller: sashWeightControllerJumbo,

                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'وزن الضلفة'),
                      onChanged: (value) {
                        sashWeight = double.tryParse(value) ?? 0;
                        SaveFile.saveData('sashWeightJumbo', value);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: TextField(
                      style: const TextStyle(fontSize: 20),
                      controller: curtainPriceControllerJumbo,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'سعر الستارة'),
                      onChanged: (value) {
                        curtainprice = double.tryParse(value) ?? 0;
                        SaveFile.saveData('curtainpriceJumbo', value);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: TextField(
                      style: const TextStyle(fontSize: 20),
                      controller: doubleCurtainPriceControllerJumbo,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'سعر الستارة الدبل',
                      ),
                      onChanged: (value) {
                        doubleCurtainPrice = double.tryParse(value) ?? 0;
                        SaveFile.saveData('doubleCurtainPriceJumbo', value);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: TextField(
                      style: const TextStyle(fontSize: 20),
                      controller: totalThreadControllerJumbo,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'سعر الخيط'),
                      onChanged: (value) {
                        totalThread = double.tryParse(value) ?? 0;
                        SaveFile.saveData('totalThreadJumbo', value);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: TextField(
                      style: const TextStyle(fontSize: 20),
                      keyboardType: TextInputType.number,
                      controller: maksebControllerJumbo,
                      decoration: InputDecoration(labelText: 'نسبة المكسب'),
                      onChanged: (value) {
                        makseb = double.tryParse(value) ?? 0;
                        SaveFile.saveData('maksebJumbo', value);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'نوع الشباك',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  DropdownButton<TypeOfBelesah>(
                    style: const TextStyle(fontSize: 18, color: Colors.black),
                    value: selectedBelesah,
                    hint: const Text('اختر نوع الشباك'),
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
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 15,
                  ),
                ),
                onPressed: () {
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
                    final price = double.parse(
                      ((resultPrice! * (elhalk / 100) + resultPrice!) *
                                  (makseb / 100) +
                              (resultPrice! * (elhalk / 100) + resultPrice!))
                          .toStringAsFixed(2),
                    );
                    addedCards.add({
                      'width': AppData.width,
                      'height': AppData.height,
                      'price': price,
                    });
                  });
                },
                child: const Text('احسب', style: TextStyle(fontSize: 20)),
              ),
              if (addedCards.isNotEmpty)
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: addedCards.asMap().entries.map((entry) {
                      final i = entry.key;
                      final card = entry.value;
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                12,
                                30,
                                12,
                                12,
                              ), // ← 30 فوق عشان الإكس
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('شباك: ${i + 1}'),
                                  Text('العرض: ${card['width']} متر'),
                                  Text('الارتفاع: ${card['height']} متر'),
                                  Text(
                                    'السعر: ${card['price'].toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w900,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  setState(() {
                                    addedCards.removeAt(i);
                                    // تحديث الـ index بعد الحذف
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              if (resultPrice != null)
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'السعر الخامات فقط : ${resultPrice!.toStringAsFixed(2)}',
                          style: const TextStyle(fontSize: 20),
                        ),
                        Text(
                          'السعر شامل الهالك : ${(resultPrice! * (elhalk / 100) + resultPrice!).toStringAsFixed(2)}',
                          style: const TextStyle(fontSize: 20),
                        ),
                        Text(
                          'السعر شامل المكسب : ${((resultPrice! * (elhalk / 100) + resultPrice!) * (makseb / 100) + (resultPrice! * (elhalk / 100) + resultPrice!)).toStringAsFixed(2)}',
                          style: const TextStyle(fontSize: 20),
                        ),
                        if (selectedBelesah == TypeOfBelesah.twoSashwireCurtain)
                          Text(
                            'سعر بدون مغناطيس : ${((resultPrice!) - details!['totalPriceMagnet']!).toStringAsFixed(2)} ',
                            style: const TextStyle(fontSize: 20),
                          ),
                        Text(
                          'الاجمالي: ${addedCards.fold<double>(0, (sum, card) => sum + (card['price'] as double)).toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
