import 'package:belesah/dart/contracts/contracts_belesah.dart';
import 'package:flutter/material.dart';
import 'package:belesah/dart/screen/constants.dart';
import 'package:belesah/dart/logic/logic_mini.dart';
import 'package:belesah/dart/logic/logic_jumbo.dart';
import 'package:belesah/dart/logic/logic_mi.dart';
import 'package:belesah/dart/enum/enum_beleash.dart';

class ScreenCalc extends StatefulWidget {
  const ScreenCalc({super.key});

  @override
  State<ScreenCalc> createState() => _ScreenCalcState();
}

class _ScreenCalcState extends State<ScreenCalc> {
  String? selectedType;
  ContractsBelesah? logic;
  TypeOfBelesah? selectedBelesah;
  Wiresize? selectedWire;
  TypeOfSash? selectedSash;
  double? resultWidth;
  double? resultHeight;
  double? resultSash;
  double? resultWire;
  double? resultDoubleFace;
  double? resultThread;
  double? resultThreadSmall;
  double? resultPunching;
  double height = 0;
  double width = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('بليسيه')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'اختر نوع البليسيه:',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: DropdownButton<String>(
                  value: selectedType,
                  hint: const Text('اختر نوع البليسيه'),
                  items: pleatsTypes.map((String type) {
                    return DropdownMenuItem<String>(
                      value: type,
                      child: Text(type.typebel),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedType = newValue;
                      if (selectedType == 'mini') {
                        logic = LogicBelesahMini();
                      } else if (selectedType == 'mi') {
                        logic = LogicBelesahMi();
                      } else if (selectedType == 'jumbo') {
                        logic = LogicBelesahJumbo();
                      }
                    });
                  },
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'الارتفاع (متر)',
                      ),
                      onChanged: (value) {
                        height = double.tryParse(value) ?? 0;
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
                        width = double.tryParse(value) ?? 0;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(
                    child: DropdownButton<TypeOfSash>(
                      value: selectedSash,
                      hint: const Text('اختر نوع الشيش'),
                      items: TypeOfSash.values.map((TypeOfSash type) {
                        return DropdownMenuItem<TypeOfSash>(
                          value: type,
                          child: Text(type.sash),
                        );
                      }).toList(),
                      onChanged: (TypeOfSash? newValue) {
                        setState(() {
                          selectedSash = newValue;
                        });
                      },
                    ),
                  ),

                  Expanded(
                    child: DropdownButton<Wiresize>(
                      value: selectedWire,
                      hint: const Text('اختر نوع السلك'),
                      items: Wiresize.values.map((Wiresize type) {
                        return DropdownMenuItem<Wiresize>(
                          value: type,
                          child: Text(type.wire),
                        );
                      }).toList(),
                      onChanged: (Wiresize? newValue) {
                        setState(() {
                          selectedWire = newValue;
                        });
                      },
                    ),
                  ),
                ],
              ),

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

              ElevatedButton(
                onPressed: () {
                  setState(() {
                    resultWidth = logic?.calcWidth(width);
                    resultHeight = logic?.calcHeight(height);
                    resultSash = logic?.calcSash(height);
                    resultWire = logic?.calcWire(
                      width,
                      selectedWire!,
                      selectedSash!,
                    );
                    resultDoubleFace = logic?.calcDoubleFace(height);
                    resultThread = logic?.calcThread(width, height);
                    resultThreadSmall = logic?.calcThreadSmall(width, height);
                    resultPunching = logic?.calcPunching(height);
                  });
                },
                child: const Text('احسب'),
              ),
              const SizedBox(height: 16.0),
              if (resultWidth != null)
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('العرض: ${resultWidth!.toStringAsFixed(2)} متر'),
                        Text(
                          'الارتفاع: ${resultHeight!.toStringAsFixed(2)} متر',
                        ),
                        Text('الشيش: ${resultSash!.toStringAsFixed(2)} متر'),
                        Text('السلك: ${resultWire!.toStringAsFixed(0)} كسرة'),
                        Text(
                          'الدابل فيس: ${resultDoubleFace!.toStringAsFixed(2)} متر',
                        ),
                        Text('الخيط: ${resultThread!.toStringAsFixed(2)} متر'),
                        Text(
                          'الخيط الصغير: ${resultThreadSmall!.toStringAsFixed(2)} متر',
                        ),
                        Text(
                          'الثقوب: ${resultPunching!.toStringAsFixed(2)} سم',
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
