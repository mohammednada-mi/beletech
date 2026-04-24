import 'package:belesah/dart/enum/enum_beleash.dart';
import 'package:belesah/dart/logic/logic_price_mini.dart';
import 'package:flutter/material.dart';
import 'package:belesah/dart/logic/save_file.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:belesah/dart/screen/app_data.dart';

class ScreenCalcPriceMini extends StatefulWidget {
  const ScreenCalcPriceMini({super.key});

  @override
  State<ScreenCalcPriceMini> createState() => _ScreenCalcPriceMiniState();
}

class _ScreenCalcPriceMiniState extends State<ScreenCalcPriceMini> {
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
  final TextEditingController factoryControllerMini = TextEditingController();
  final TextEditingController elhalkControllerMini = TextEditingController();
  final TextEditingController tapePriceControllerMini = TextEditingController();
  final TextEditingController assemblyKitControllerMini =
      TextEditingController();
  final TextEditingController forshPriceControllerMini =
      TextEditingController();
  final TextEditingController wightAlumColorControllerMini =
      TextEditingController();
  final TextEditingController frameWeightControllerMini =
      TextEditingController();
  final TextEditingController sashWeightControllerMini =
      TextEditingController();
  final TextEditingController magnetPriceControllerMini =
      TextEditingController();
  final TextEditingController wirePriceControllerMini = TextEditingController();
  final TextEditingController curtainPriceControllerMini =
      TextEditingController();
  final TextEditingController doubleCurtainPriceControllerMini =
      TextEditingController();
  final TextEditingController totalThreadControllerMini =
      TextEditingController();
  final TextEditingController maksebControllerMini = TextEditingController();
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      factoryControllerMini.text = prefs.getString('factoryMini') ?? '0';
      factory = double.tryParse(factoryControllerMini.text) ?? 0;
      elhalkControllerMini.text = prefs.getString('elhalkMini') ?? '0';
      elhalk = double.tryParse(elhalkControllerMini.text) ?? 0;
      tapePriceControllerMini.text = prefs.getString('tapePriceMini') ?? '0';
      tapePrice = double.tryParse(tapePriceControllerMini.text) ?? 0;
      assemblyKitControllerMini.text =
          prefs.getString('assemblyKitMini') ?? '0';
      assemblyKit = double.tryParse(assemblyKitControllerMini.text) ?? 0;
      forshPriceControllerMini.text = prefs.getString('forshPriceMini') ?? '0';
      forshPrice = double.tryParse(forshPriceControllerMini.text) ?? 0;
      wightAlumColorControllerMini.text =
          prefs.getString('wightAlumColorMini') ?? '0';
      wightAlumColor = double.tryParse(wightAlumColorControllerMini.text) ?? 0;
      frameWeightControllerMini.text =
          prefs.getString('frameWeightMini') ?? '0';
      frameWeight = double.tryParse(frameWeightControllerMini.text) ?? 0;
      sashWeightControllerMini.text = prefs.getString('sashWeightMini') ?? '0';
      sashWeight = double.tryParse(sashWeightControllerMini.text) ?? 0;
      magnetPriceControllerMini.text =
          prefs.getString('magnetPriceMini') ?? '0';
      magnetPrice = double.tryParse(magnetPriceControllerMini.text) ?? 0;
      wirePriceControllerMini.text = prefs.getString('wirePriceMini') ?? '0';
      wirePrice = double.tryParse(wirePriceControllerMini.text) ?? 0;

      curtainPriceControllerMini.text =
          prefs.getString('curtainpriceMini') ?? '0';
      curtainprice = double.tryParse(curtainPriceControllerMini.text) ?? 0;
      doubleCurtainPriceControllerMini.text =
          prefs.getString('doubleCurtainPriceMini') ?? '0';
      doubleCurtainPrice =
          double.tryParse(doubleCurtainPriceControllerMini.text) ?? 0;
      totalThreadControllerMini.text =
          prefs.getString('totalThreadMini') ?? '0';
      totalThread = double.tryParse(totalThreadControllerMini.text) ?? 0;
      maksebControllerMini.text = prefs.getString('maksebMini') ?? '0';
      makseb = double.tryParse(maksebControllerMini.text) ?? 0;
    });
  }

  @override
  void dispose() {
    factoryControllerMini.dispose();
    elhalkControllerMini.dispose();
    tapePriceControllerMini.dispose();
    assemblyKitControllerMini.dispose();
    forshPriceControllerMini.dispose();
    wightAlumColorControllerMini.dispose();
    frameWeightControllerMini.dispose();
    sashWeightControllerMini.dispose();
    magnetPriceControllerMini.dispose();
    wirePriceControllerMini.dispose();
    curtainPriceControllerMini.dispose();
    doubleCurtainPriceControllerMini.dispose();
    totalThreadControllerMini.dispose();
    maksebControllerMini.dispose();
    super.dispose();
  }

  Map<String, double>? details;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('بليسيه ميني')),
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
                      controller: factoryControllerMini,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'سعر المصنع'),
                      onChanged: (value) {
                        factory = double.tryParse(value) ?? 0;
                        SaveFile.saveData('factoryMini', value);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: TextField(
                      controller: elhalkControllerMini,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'الهالك'),
                      onChanged: (value) {
                        elhalk = double.tryParse(value) ?? 0;
                        SaveFile.saveData('elhalkMini', value);
                      },
                    ),
                  ),

                  SizedBox(
                    width: 100,
                    child: TextField(
                      controller: wirePriceControllerMini,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'سعر السلك'),
                      onChanged: (value) {
                        wirePrice = double.tryParse(value) ?? 0;
                        SaveFile.saveData('wirePriceMini', value);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: TextField(
                      controller: magnetPriceControllerMini,

                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'سعر المغناطيس'),
                      onChanged: (value) {
                        magnetPrice = double.tryParse(value) ?? 0;
                        SaveFile.saveData('magnetPriceMini', value);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: TextField(
                      controller: tapePriceControllerMini,

                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'سعر الشريط'),
                      onChanged: (value) {
                        tapePrice = double.tryParse(value) ?? 0;
                        SaveFile.saveData('tapePriceMini', value);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: TextField(
                      controller: assemblyKitControllerMini,

                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'سعر كيت التجميع'),
                      onChanged: (value) {
                        assemblyKit = double.tryParse(value) ?? 0;
                        SaveFile.saveData('assemblyKitMini', value);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: TextField(
                      controller: forshPriceControllerMini,

                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'سعر الفورش'),
                      onChanged: (value) {
                        forshPrice = double.tryParse(value) ?? 0;
                        SaveFile.saveData('forshPriceMini', value);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: TextField(
                      controller: wightAlumColorControllerMini,

                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'وزن الالومنيوم'),
                      onChanged: (value) {
                        wightAlumColor = double.tryParse(value) ?? 0;
                        SaveFile.saveData('wightAlumColorMini', value);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: TextField(
                      controller: frameWeightControllerMini,

                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'وزن الإطار'),
                      onChanged: (value) {
                        frameWeight = double.tryParse(value) ?? 0;
                        SaveFile.saveData('frameWeightMini', value);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: TextField(
                      controller: sashWeightControllerMini,

                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'وزن الشيش'),
                      onChanged: (value) {
                        sashWeight = double.tryParse(value) ?? 0;
                        SaveFile.saveData('sashWeightMini', value);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: TextField(
                      controller: curtainPriceControllerMini,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'سعر الستارة'),
                      onChanged: (value) {
                        curtainprice = double.tryParse(value) ?? 0;
                        SaveFile.saveData('curtainpriceMini', value);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: TextField(
                      controller: doubleCurtainPriceControllerMini,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'سعر الستارة المزدوجة',
                      ),
                      onChanged: (value) {
                        doubleCurtainPrice = double.tryParse(value) ?? 0;
                        SaveFile.saveData('doubleCurtainPriceMini', value);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: TextField(
                      controller: totalThreadControllerMini,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'سعر الخيط'),
                      onChanged: (value) {
                        totalThread = double.tryParse(value) ?? 0;
                        SaveFile.saveData('totalThreadMini', value);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: maksebControllerMini,
                      decoration: InputDecoration(labelText: 'المكسب '),
                      onChanged: (value) {
                        setState(() {
                          makseb = double.tryParse(value) ?? 0;
                          SaveFile.saveData('maksebMini', value);
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
              if (resultPrice != null)
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
            ],
          ),
        ),
      ),
    );
  }
}
