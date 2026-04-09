import 'package:belesah/dart/enum/enum_beleash.dart';
import 'package:provider/provider.dart';
import 'package:belesah/dart/screen/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:belesah/dart/logic/save_file.dart';

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

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AppProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text('بليسيه')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
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
                      },
                    ),
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
