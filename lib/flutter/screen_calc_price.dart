import 'package:belesah/dart/enum/enum_beleash.dart';

import 'package:provider/provider.dart';
import 'package:belesah/dart/screen/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:belesah/dart/logic/save_file.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  TypeOfBelesah? selectedBelesah;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      factory = double.tryParse(prefs.getString('factory') ?? '0') ?? 0;
      elhalk = double.tryParse(prefs.getString('elhalk') ?? '0') ?? 0;
      tapePrice = double.tryParse(prefs.getString('tapePrice') ?? '0') ?? 0;
      assemblyKit = double.tryParse(prefs.getString('assemblyKit') ?? '0') ?? 0;
      forshPrice = double.tryParse(prefs.getString('forshPrice') ?? '0') ?? 0;
      wightAlumColor =
          double.tryParse(prefs.getString('wightAlumColor') ?? '0') ?? 0;
      frameWeight = double.tryParse(prefs.getString('frameWeight') ?? '0') ?? 0;
      sashWeight = double.tryParse(prefs.getString('sashWeight') ?? '0') ?? 0;
      magnetPrice = double.tryParse(prefs.getString('magnetPrice') ?? '0') ?? 0;
      wirePrice = double.tryParse(prefs.getString('wirePrice') ?? '0') ?? 0;
      curtainprice =
          double.tryParse(prefs.getString('curtainprice') ?? '0') ?? 0;
      doubleCurtainPrice =
          double.tryParse(prefs.getString('doubleCurtainPrice') ?? '0') ?? 0;
      totalThread = double.tryParse(prefs.getString('totalThread') ?? '0') ?? 0;
    });
  }

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
                        double.tryParse(value) ?? 0;
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
                        double.tryParse(value) ?? 0;
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
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'سعر الخيط'),
                      onChanged: (value) {
                        totalThread = double.tryParse(value) ?? 0;
                        SaveFile.saveData('totalThread', value);
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
            ],
          ),
        ),
      ),
    );
  }
}
