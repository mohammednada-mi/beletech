import 'package:belesah/version_meter/dart/contracts/contracts_belesah.dart';
import 'package:flutter/material.dart';
import 'package:belesah/version_meter/dart/screen/constants.dart';
import 'package:belesah/version_meter/dart/logic/logic_mini.dart';
import 'package:belesah/version_meter/dart/logic/logic_jumbo.dart';
import 'package:belesah/version_meter/dart/logic/logic_mi.dart';
import 'package:belesah/version_meter/dart/enum/enum_beleash.dart';
import 'package:belesah/version_meter/dart/screen/app_data.dart';
import 'package:belesah/version_meter/dart/screen/pdf_service.dart';

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
  List<Map<String, dynamic>> addedCards = [];
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
  String color = '';
  Set<int> selectedRows = {};
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
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'اختر نوع القطاع',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: DropdownButton<String>(
                  style: const TextStyle(fontSize: 20, color: Colors.black),
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
                      style: const TextStyle(fontSize: 20),
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'الارتفاع (متر)',
                        labelStyle: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
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
                      style: const TextStyle(fontSize: 20),
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'العرض (متر)',
                        labelStyle: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
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
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'اختر مقاس الكسرة',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),

              const SizedBox(height: 7.0),
              Row(
                children: [
                  Expanded(
                    child: DropdownButton<Wiresize>(
                      isExpanded: true,
                      style: const TextStyle(fontSize: 20, color: Colors.black),
                      value: selectedWire,
                      hint: const Text('اختر مقاس السلك/الستارة'),
                      items: Wiresize.values.map((Wiresize type) {
                        return DropdownMenuItem<Wiresize>(
                          value: type,
                          child: Text(type.wire),
                        );
                      }).toList(),
                      onChanged: (Wiresize? newValue) {
                        setState(() {
                          selectedWire = newValue;
                          if (selectedWire == Wiresize.doublecurtain7m) {
                            selectedBelesah =
                                TypeOfBelesah.singleSashDoubleCurtain;
                          }
                          if (selectedWire == Wiresize.wire15m ||
                              selectedWire == Wiresize.wire18m ||
                              selectedWire == Wiresize.wire19m ||
                              selectedWire == Wiresize.wire20m &&
                                  selectedBelesah ==
                                      TypeOfBelesah.singleSashDoubleCurtain ||
                              selectedBelesah ==
                                  TypeOfBelesah.twoSashDoubleCurtain ||
                              selectedBelesah ==
                                  TypeOfBelesah.twoSashDoubleCurtainWithwire) {
                            selectedBelesah = TypeOfBelesah.singleSashwire;
                          }
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  if (selectedBelesah ==
                      TypeOfBelesah.twoSashDoubleCurtainWithwire)
                    Expanded(
                      child: DropdownButton<Wiresize>(
                        isExpanded: true,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
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
                      style: const TextStyle(fontSize: 20),
                      decoration: const InputDecoration(
                        labelText: 'اسم العميل',
                        labelStyle: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onChanged: (value) {
                        clientName = value;
                      },
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: TextField(
                      style: const TextStyle(fontSize: 20),
                      decoration: const InputDecoration(
                        labelText: 'لون الشباك',
                        labelStyle: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onChanged: (value) {
                        color = value;
                      },
                    ),
                  ),

                  const SizedBox(width: 16.0),
                  Expanded(
                    child: TextField(
                      style: const TextStyle(fontSize: 20),
                      controller: _numWindowController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'عدد الشبابيك',
                        labelStyle: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
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
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  
                ],
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropdownButton<TypeOfBelesah>(
                    style: const TextStyle(fontSize: 20, color: Colors.black),
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
                        if (newValue == null) return;

                        // أنواع الشبابيك اللي بتستخدم Double Curtain 7m
                        final doubleCurtainTypes = [
                          TypeOfBelesah.singleSashDoubleCurtain,
                          TypeOfBelesah.twoSashDoubleCurtain,
                          TypeOfBelesah.twoSashDoubleCurtainWithwire,
                        ];

                        // أنواع الشبابيك اللي بتستخدم Wire 18m
                        final wire18mTypes = [
                          TypeOfBelesah.singleSashCurtain,
                          TypeOfBelesah.twoSashwireCurtain,
                          TypeOfBelesah.singleSashwire,
                          TypeOfBelesah.twoSashCurtain,
                          TypeOfBelesah.twoSashwire,
                        ];

                        // لو النوع الجديد من نوع Double Curtain
                        if (doubleCurtainTypes.contains(newValue)) {
                          // بس لو المقاس الحالي مش مناسب، غيّره
                          if (selectedWire != Wiresize.doublecurtain7m) {
                            selectedWire = Wiresize.doublecurtain7m;
                          }
                        }
                        // لو النوع الجديد من نوع Wire 18m
                        else if (wire18mTypes.contains(newValue)) {
                          // بس لو المقاس الحالي مش مناسب، غيّره
                          if (selectedWire != Wiresize.wire18m &&
                              selectedWire !=
                                  Wiresize
                                      .wire20m // لو عندك مقاسات تانية
                                      ) {
                            selectedWire = Wiresize.wire18m;
                          }
                        }
                      });
                    },
                  ),
                ],
              ),
              Row(),

              const SizedBox(height: 16.0),
              //
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 15,
                  ),
                ),
                onPressed: () {
                  if (selectedWire == null || height <= 0 || width <= 0) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('الرجاء ملء جميع الحقول بشكل صحيح'),
                      ),
                    );
                    return;
                  }
                  final rWidth = logic?.calcWidth(width);
                  final rHeight = logic?.calcHeight(height);
                  final rSash = logic?.calcSash(height);
                  final rDoubleFace = logic?.calcDoubleFace(height);
                  final rThread = logic?.calcThread(width, height);
                  final rThreadSmall = logic?.calcThreadSmall(height, width);
                  final rPunching = logic?.calcPunching(height);
                  final rNumThread = logic?.calcNumThread(
                    height,
                    selectedBelesah!,
                  );
                  final rNumThreadSmall = logic?.calcNumThreadSmall(
                    height,
                    selectedBelesah!,
                  );
                  final rNumSash = logic?.numSash(selectedBelesah!);
                  final rNumDoubleFace = logic?.numDoubleFace(selectedBelesah!);
                  final rNumWire = logic?.numWire(selectedBelesah!);
                  setState(() {
                    resultWidth = rWidth;
                    resultHeight = rHeight;
                    resultSash = rSash;
                    resultDoubleFace = rDoubleFace;
                    resultThread = rThread;
                    resultThreadSmall = rThreadSmall;
                    resultPunching = rPunching;
                    resultCalcNumTHread = rNumThread;
                    resultCalcNumThreadSmall = rNumThreadSmall;
                    resultCalcNumSash = rNumSash;
                    resultCalcNumDoubleFace = rNumDoubleFace;
                    resultCalcNumWire = rNumWire;
                    numHeight = 2;
                    numWidth = 2;
                  });
                  PdfService.addRow(
                    clientName: clientName,
                    color: color,
                    selectedWire: selectedWire?.wire ?? '',
                    selectedWire2: selectedWire2?.wire ?? '',
                    selectType: selectedType?.typebel ?? '',
                    resultPunching: resultPunching ?? 0,
                    width: width,
                    numWidth: numWidth!,
                    height: height,
                    numHeight: numHeight!,
                    typeOfBelesah: selectedBelesah?.belesah ?? '',
                    resultWidth: resultWidth ?? 0,
                    resultHeight: resultHeight ?? 0,
                    resultSash: resultSash ?? 0,
                    numSash: resultCalcNumSash ?? 0,
                    resultWire:
                        selectedBelesah ==
                            TypeOfBelesah.twoSashDoubleCurtainWithwire
                        ? logic!.calcWire(
                            width,
                            selectedWire!,
                            selectedBelesah!,
                          )
                        : selectedBelesah == TypeOfBelesah.twoSashwireCurtain
                        ? logic!.calcWire(
                            width,
                            selectedWire!,
                            selectedBelesah!,
                          )
                        : selectedBelesah == TypeOfBelesah.twoSashCurtain
                        ? logic!.calcWire(
                            width,
                            selectedWire!,
                            selectedBelesah!,
                          )
                        : selectedBelesah == TypeOfBelesah.twoSashDoubleCurtain
                        ? logic!.calcWire(
                            width,
                            selectedWire!,
                            selectedBelesah!,
                          )
                        : selectedBelesah ==
                              TypeOfBelesah.singleSashDoubleCurtain
                        ? logic!.calcWire(
                            width,
                            selectedWire!,
                            selectedBelesah!,
                          )
                        : selectedBelesah == TypeOfBelesah.singleSashCurtain
                        ? logic!.calcWire(
                            width,
                            selectedWire!,
                            selectedBelesah!,
                          )
                        : selectedBelesah == TypeOfBelesah.singleSashwire
                        ? 0
                        : selectedBelesah == TypeOfBelesah.twoSashwire
                        ? 0
                        : 0,

                    numWire: resultCalcNumWire ?? 0,
                    resultDoubleFace: resultDoubleFace ?? 0,
                    numDoubleFace: resultCalcNumDoubleFace ?? 0,
                    resultThread: resultThread ?? 0,
                    numThread: resultCalcNumTHread ?? 0,
                    resultThread2: resultThreadSmall ?? 0,
                    numThread2: resultCalcNumThreadSmall ?? 0,
                    numWindow: numwindow!,
                    resultWire2:
                        selectedBelesah ==
                            TypeOfBelesah.twoSashDoubleCurtainWithwire
                        ? logic!.calcWire(
                            width,
                            selectedWire2!,
                            selectedBelesah!,
                          )
                        : selectedBelesah == TypeOfBelesah.twoSashwireCurtain
                        ? logic!.calcWire(
                            width,
                            selectedWire!,
                            selectedBelesah!,
                          )
                        : selectedBelesah == TypeOfBelesah.twoSashCurtain
                        ? 0
                        : selectedBelesah == TypeOfBelesah.twoSashDoubleCurtain
                        ? 0
                        : selectedBelesah ==
                              TypeOfBelesah.singleSashDoubleCurtain
                        ? 0
                        : selectedBelesah == TypeOfBelesah.singleSashCurtain
                        ? 0
                        : selectedBelesah == TypeOfBelesah.singleSashwire
                        ? logic!.calcWire(
                            width,
                            selectedWire!,
                            selectedBelesah!,
                          )
                        : selectedBelesah == TypeOfBelesah.twoSashwire
                        ? logic!.calcWire(
                            width,
                            selectedWire!,
                            selectedBelesah!,
                          )
                        : 0,
                  );
                  addedCards.add({
                    'clientName': clientName,
                    'width': width,
                    'height': height,
                    'index': PdfService.rows.length - 1,
                  });
                },
                child: const Text('احسب'),
              ),
              const SizedBox(height: 16.0),
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
                                  Text('العرض: ${card['width']} متر'),
                                  Text('الارتفاع: ${card['height']} متر'),
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
                                    PdfService.removeRow(i);
                                    addedCards.removeAt(i);
                                    // تحديث الـ index بعد الحذف
                                    for (
                                      int j = i;
                                      j < addedCards.length;
                                      j++
                                    ) {
                                      addedCards[j]['index'] = j;
                                    }
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
              const SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 200,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 25,
                          vertical: 25,
                        ),
                      ),
                      onPressed: () async {
                        await PdfService.generatePdf();
                      },
                      icon: const Icon(
                        Icons.picture_as_pdf,
                        color: Colors.redAccent,
                      ),
                      label: const Text('حفظ التقرير'),
                    ),
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
                        if (selectedBelesah ==
                            TypeOfBelesah.twoSashDoubleCurtainWithwire)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'العرض: ${resultWidth!.toStringAsFixed(3)} متر ×${(numWidth! * numwindow!)} ',
                              ),
                              Text(
                                'الارتفاع: ${resultHeight!.toStringAsFixed(3)} متر ×${(numHeight! * numwindow!)} ',
                              ),

                              Text(
                                'الضلفة: ${resultSash!.toStringAsFixed(3)} متر×${(resultCalcNumSash)! * numwindow!} ',
                              ),
                              Text(
                                'السلك: ${logic!.calcWire(width, selectedWire2!, selectedBelesah!).toStringAsFixed(0)} كسرة×${(resultCalcNumWire)! * numwindow!}',
                              ),

                              Text(
                                'الستارة ${logic!.calcWire(width, selectedWire!, selectedBelesah!).toStringAsFixed(0)} كسرة×${(resultCalcNumWire)! * numwindow!}',
                              ),
                              Text(
                                'الشريط: ${resultDoubleFace!.toStringAsFixed(3)} متر×${(resultCalcNumDoubleFace)! * numwindow!}',
                              ),
                              Text(
                                'الشريط الصغير: ${resultSash!.toStringAsFixed(3)} متر×${(resultCalcNumDoubleFace)! * numwindow!}',
                              ),
                              Text(
                                'الخيط: ${resultThread!.toStringAsFixed(2)} متر×${(resultCalcNumTHread)! * numwindow!}',
                              ),
                              Text(
                                'الخيط الاوسط: ${resultThreadSmall!.toStringAsFixed(2)} متر×${(resultCalcNumThreadSmall)! * numwindow!}',
                              ),
                              Text(
                                'التخريم: ${resultPunching!.toStringAsFixed(1)} سم',
                              ),
                            ],
                          ),
                        if (selectedBelesah ==
                                TypeOfBelesah.singleSashCurtain ||
                            selectedBelesah == TypeOfBelesah.twoSashCurtain ||
                            selectedBelesah ==
                                TypeOfBelesah.singleSashDoubleCurtain ||
                            selectedBelesah ==
                                TypeOfBelesah.twoSashDoubleCurtain)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'العرض: ${resultWidth!.toStringAsFixed(3)} متر ×${(numWidth! * numwindow!)} ',
                              ),
                              Text(
                                'الارتفاع: ${resultHeight!.toStringAsFixed(3)} متر ×${(numHeight! * numwindow!)} ',
                              ),

                              Text(
                                'الضلفة: ${resultSash!.toStringAsFixed(3)} متر×${(resultCalcNumSash)! * numwindow!} ',
                              ),
                              Text(
                                'الستارة ${logic!.calcWire(width, selectedWire!, selectedBelesah!).toStringAsFixed(0)} كسرة×${(resultCalcNumWire)! * numwindow!}',
                              ),
                              Text(
                                'الشريط: ${resultDoubleFace!.toStringAsFixed(3)} متر×${(resultCalcNumDoubleFace)! * numwindow!}',
                              ),
                              Text(
                                'الشريط الصغير: ${resultSash!.toStringAsFixed(3)} متر×${(resultCalcNumDoubleFace)! * numwindow!}',
                              ),
                              Text(
                                'الخيط: ${resultThread!.toStringAsFixed(2)} متر×${(resultCalcNumTHread)! * numwindow!}',
                              ),
                              Text(
                                'الخيط الاوسط: ${resultThreadSmall!.toStringAsFixed(2)} متر×${(resultCalcNumThreadSmall)! * numwindow!}',
                              ),
                              Text(
                                'التخريم: ${resultPunching!.toStringAsFixed(1)} سم',
                              ),
                            ],
                          ),

                        if (selectedBelesah == TypeOfBelesah.twoSashwireCurtain)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'العرض: ${resultWidth!.toStringAsFixed(3)} متر ×${(numWidth! * numwindow!)} ',
                              ),
                              Text(
                                'الارتفاع: ${resultHeight!.toStringAsFixed(3)} متر ×${(numHeight! * numwindow!)} ',
                              ),

                              Text(
                                'الضلفة: ${resultSash!.toStringAsFixed(3)} متر×${(resultCalcNumSash)! * numwindow!} ',
                              ),
                              Text(
                                'السلك: ${logic!.calcWire(width, selectedWire!, selectedBelesah!).toStringAsFixed(0)} كسرة×${(resultCalcNumWire)! * numwindow!}',
                              ),

                              Text(
                                'الستارة ${logic!.calcWire(width, selectedWire!, selectedBelesah!).toStringAsFixed(0)} كسرة×${(resultCalcNumWire)! * numwindow!}',
                              ),
                              Text(
                                'الشريط: ${resultDoubleFace!.toStringAsFixed(3)} متر×${(resultCalcNumDoubleFace)! * numwindow!}',
                              ),
                              Text(
                                'الشريط الصغير: ${resultSash!.toStringAsFixed(3)} متر×${(resultCalcNumDoubleFace)! * numwindow!}',
                              ),
                              Text(
                                'الخيط: ${resultThread!.toStringAsFixed(2)} متر×${(resultCalcNumTHread)! * numwindow!}',
                              ),
                              Text(
                                'الخيط الاوسط: ${resultThreadSmall!.toStringAsFixed(2)} متر×${(resultCalcNumThreadSmall)! * numwindow!}',
                              ),
                              Text(
                                'التخريم: ${resultPunching!.toStringAsFixed(1)} سم',
                              ),
                            ],
                          ),
                        if (selectedBelesah == TypeOfBelesah.singleSashwire ||
                            selectedBelesah == TypeOfBelesah.twoSashwire)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'العرض: ${resultWidth!.toStringAsFixed(3)} متر ×${(numWidth! * numwindow!)} ',
                              ),
                              Text(
                                'الارتفاع: ${resultHeight!.toStringAsFixed(3)} متر ×${(numHeight! * numwindow!)} ',
                              ),

                              Text(
                                'الضلفة: ${resultSash!.toStringAsFixed(3)} متر×${(resultCalcNumSash)! * numwindow!} ',
                              ),
                              Text(
                                'السلك: ${logic!.calcWire(width, selectedWire!, selectedBelesah!).toStringAsFixed(0)} كسرة×${(resultCalcNumWire)! * numwindow!}',
                              ),

                              Text(
                                'الشريط: ${resultDoubleFace!.toStringAsFixed(3)} متر×${(resultCalcNumDoubleFace)! * numwindow!}',
                              ),
                              Text(
                                'الشريط الصغير: ${resultSash!.toStringAsFixed(3)} متر×${(resultCalcNumDoubleFace)! * numwindow!}',
                              ),
                              Text(
                                'الخيط: ${resultThread!.toStringAsFixed(2)} متر×${(resultCalcNumTHread)! * numwindow!}',
                              ),
                              Text(
                                'الخيط الاوسط: ${resultThreadSmall!.toStringAsFixed(2)} متر×${(resultCalcNumThreadSmall)! * numwindow!}',
                              ),
                              Text(
                                'التخريم: ${resultPunching!.toStringAsFixed(1)} سم',
                              ),
                            ],
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
