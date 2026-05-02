import 'package:belesah/dart/enum/enum_beleash.dart';
import 'package:belesah/dart/logic/logic_price.dart';
import 'package:flutter/material.dart';
import 'package:belesah/dart/logic/save_file.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:belesah/dart/screen/app_data.dart';

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
                      style: const TextStyle(fontSize: 20),
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
                      style: const TextStyle(fontSize: 20),
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
                      style: const TextStyle(fontSize: 20),
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
                      style: const TextStyle(fontSize: 20),
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
                      style: const TextStyle(fontSize: 20),
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
                      style: const TextStyle(fontSize: 20),
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
                      style: const TextStyle(fontSize: 20),
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
                      style: const TextStyle(fontSize: 20),
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
                      style: const TextStyle(fontSize: 20),
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
                      style: const TextStyle(fontSize: 20),
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
                      style: const TextStyle(fontSize: 20),
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
                      style: const TextStyle(fontSize: 20),
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
                      style: const TextStyle(fontSize: 20),
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
                      style: const TextStyle(fontSize: 20),
                      keyboardType: TextInputType.number,
                      controller: maksebController,
                      decoration: InputDecoration(labelText: 'المكسب '),
                      onChanged: (value) {
                        makseb = double.tryParse(value) ?? 0;
                        SaveFile.saveData('makseb', value);
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
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 15,
                  ),
                ),
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
