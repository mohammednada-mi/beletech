import 'package:belesah/dart/contracts/contracts_belesah.dart';
import 'package:flutter/material.dart';
import 'package:belesah/dart/screen/constants.dart';
import 'package:belesah/dart/logic/logic_mini.dart';
import 'package:belesah/dart/logic/logic_jumbo.dart';
import 'package:belesah/dart/logic/logic_mi.dart';
import 'package:belesah/dart/enum/enum_beleash.dart';
import 'package:belesah/dart/screen/app_data.dart';
import 'package:belesah/dart/screen/pdf_service.dart';

class ScreenCalc extends StatefulWidget {
  const ScreenCalc({super.key});

  @override
  State<ScreenCalc> createState() => _ScreenCalcState();
}

class _ScreenCalcState extends State<ScreenCalc> {
  String? selectedType = 'mi';
  ContractsBelesah? logic;
  TypeOfBelesah? selectedBelesah = TypeOfBelesah.singleSashwire;
  Wiresize? selectedWire = Wiresize.wire18m;
  Wiresize? selectedWire2 = Wiresize.wire18m;
  TypeOfSash? selectedSash = TypeOfSash.singleSash;
  double? resultWidth;
  double? resultHeight;
  double? resultSash;
  double? resultWire;
  double? resultDoubleFace;
  double? resultThread;
  double? resultThreadSmall;
  double? resultPunching;
  int? resultCalcNumTHread;
  int? resultCalcNumThreadSmall;
  int? resultCalcNumSash;
  int? resultCalcNumDoubleFace;
  int? resultCalcNumWire;
  int? numHeight = 2;
  int? numWidth = 2;
  double height = 0;
  double width = 0;
  int? numwindow = 1;
  String clientName = '';
  final TextEditingController _numWindowController = TextEditingController(
    text: '1',
  );
  @override
  void dispose() {
    _numWindowController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    logic = LogicBelesahMi();
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
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'اختر نوع القطاع',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: DropdownButton<String>(
                  value: selectedType,
                  hint: const Text('اختر نوع القطاع'),
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
                        AppData.height = height;
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
                        AppData.width = width;
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16.0),
              Row(
                children: [
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
                  const SizedBox(width: 16.0),
                  if (selectedBelesah ==
                      TypeOfBelesah.twoSashDoubleCurtainWithwire)
                    Expanded(
                      child: DropdownButton<Wiresize>(
                        value: selectedWire2,
                        hint: const Text('اختر مقاس السلك'),
                        items: Wiresize.values
                            .where((w) => w != Wiresize.doublecurtain7m)
                            .map((Wiresize type) {
                              return DropdownMenuItem<Wiresize>(
                                value: type,
                                child: Text(type.wire),
                              );
                            })
                            .toList(),
                        onChanged: (Wiresize? newValue) {
                          setState(() {
                            selectedWire2 = newValue;
                          });
                        },
                      ),
                    ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        labelText: 'اسم العميل',
                      ),
                      onChanged: (value) {
                        clientName = value;
                      },
                    ),
                  ),

                  const SizedBox(width: 16.0),
                  Expanded(
                    child: TextField(
                      controller: _numWindowController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'عدد النوافذ',
                      ),
                      onChanged: (value) {
                        setState(() {
                          numwindow = int.tryParse(value) ?? 1;
                        });
                      },
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropdownButton<TypeOfBelesah>(
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
                        if (newValue == TypeOfBelesah.singleSashDoubleCurtain ||
                            newValue == TypeOfBelesah.twoSashDoubleCurtain ||
                            newValue ==
                                TypeOfBelesah.twoSashDoubleCurtainWithwire) {
                          selectedWire = Wiresize.doublecurtain7m;
                        }
                        if (newValue == TypeOfBelesah.singleSashCurtain ||
                            newValue == TypeOfBelesah.twoSashwireCurtain ||
                            newValue == TypeOfBelesah.singleSashwire ||
                            newValue == TypeOfBelesah.twoSashCurtain ||
                            newValue == TypeOfBelesah.twoSashwire) {
                          selectedWire = Wiresize.wire18m;
                        }
                      });
                    },
                  ),
                ],
              ),

              const SizedBox(height: 16.0),
              //
              ElevatedButton(
                onPressed: () {
                  if (selectedWire == null ||
                      selectedSash == null ||
                      height <= 0 ||
                      width <= 0) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('الرجاء ملء جميع الحقول بشكل صحيح'),
                      ),
                    );
                  }
                  setState(() {
                    resultWidth = logic?.calcWidth(width);
                    resultHeight = logic?.calcHeight(height);
                    resultSash = logic?.calcSash(height);
                    resultWire = logic?.calcWire(
                      width,
                      selectedWire!,
                      selectedBelesah!,
                    );
                    resultDoubleFace = logic?.calcDoubleFace(height);
                    resultThread = logic?.calcThread(width, height);
                    resultThreadSmall = logic?.calcThreadSmall(height, width);
                    resultPunching = logic?.calcPunching(height);
                    resultCalcNumTHread = logic?.calcNumThread(
                      height,
                      selectedBelesah!,
                    );
                    resultCalcNumThreadSmall = logic?.calcNumThreadSmall(
                      height,
                      selectedBelesah!,
                    );
                    resultCalcNumSash = logic?.numSash(selectedBelesah!);
                    resultCalcNumDoubleFace = logic?.numDoubleFace(
                      selectedBelesah!,
                    );
                    resultCalcNumWire = logic?.numWire(selectedBelesah!);
                    numHeight = 2;
                    numWidth = 2;
                  });
                },
                child: const Text('احسب'),
              ),
              const SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      PdfService.addRow(
                        clientName: clientName,
                        width: width,
                        numWidth: numWidth!,
                        height: height,
                        numHeight: numHeight!,
                        typeOfBelesah: selectedBelesah?.belesah ?? '',
                        resultWidth: resultWidth ?? 0,
                        resultHeight: resultHeight ?? 0,
                        resultSash: resultSash ?? 0,
                        numSash: resultCalcNumSash ?? 0,
                        resultWire: resultWire ?? 0,
                        numWire: resultCalcNumWire ?? 0,
                        resultDoubleFace: resultDoubleFace ?? 0,
                        numDoubleFace: resultCalcNumDoubleFace ?? 0,
                        resultThread: resultThread ?? 0,
                        numThread: resultCalcNumTHread ?? 0,
                        resultWire2:
                            selectedBelesah ==
                                TypeOfBelesah.twoSashDoubleCurtainWithwire
                            ? logic!.calcWire(
                                width,
                                selectedWire2!,
                                selectedBelesah!,
                              )
                            : 0,
                      );
                    },
                    child: const Text('أضف للتقرير'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      PdfService.generatePdf();
                    },
                    child: const Text('حفظ التقرير'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      PdfService.clearRows();
                    },
                    child: const Text('مسح التقرير'),
                  ),
                ],
              ),

              // عرض النتائج
              const SizedBox(height: 16.0),
              if (resultWidth != null)
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'العرض: ${resultWidth!.toStringAsFixed(3)} متر ×${(numWidth! * numwindow!)} ',
                        ),
                        Text(
                          'الارتفاع: ${resultHeight!.toStringAsFixed(3)} متر ×${(numHeight! * numwindow!)} ',
                        ),

                        Text(
                          'الشيش: ${resultSash!.toStringAsFixed(3)} متر×${(resultCalcNumSash)! * numwindow!} ',
                        ),

                        Text(
                          'السلك: ${resultWire!.toStringAsFixed(0)} كسرة×${(resultCalcNumWire)! * numwindow!}',
                        ),
                        if (selectedBelesah ==
                            TypeOfBelesah.twoSashDoubleCurtainWithwire)
                          Text(
                            'السلك: ${logic!.calcWire(width, selectedWire2!, selectedBelesah!).toStringAsFixed(0)} كسرة×${(resultCalcNumWire)! * numwindow!}',
                          ),

                        Text(
                          'الدابل فيس: ${resultDoubleFace!.toStringAsFixed(3)} متر×${(resultCalcNumDoubleFace)! * numwindow!}',
                        ),
                        Text(
                          'الخيط: ${resultThread!.toStringAsFixed(2)} متر×${(resultCalcNumTHread)! * numwindow!}',
                        ),
                        Text(
                          'الخيط الصغير: ${resultThreadSmall!.toStringAsFixed(2)} متر×${(resultCalcNumThreadSmall)! * numwindow!}',
                        ),
                        Text(
                          'الثقوب: ${resultPunching!.toStringAsFixed(1)} سم',
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
