import 'package:belesah/dart/contracts/contracts_belesah.dart';
import 'package:flutter/material.dart';
import 'package:belesah/dart/screen/constants.dart';
import 'package:belesah/dart/logic/logic_mini.dart';
import 'package:belesah/dart/logic/logic_jumbo.dart';
import 'package:belesah/dart/logic/logic_mi.dart';

class ScreenCalc extends StatefulWidget {
  const ScreenCalc({super.key});

  @override
  State<ScreenCalc> createState() => _ScreenCalcState();
}

class _ScreenCalcState extends State<ScreenCalc> {
  String? selectedType;
  ContractsBelesah? logic;
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
              DropdownButton<String>(
                value: selectedType,
                hint: const Text('اختر نوع البليسيه'),
                items: pleatsTypes.map((String type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text(type),
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
              TextField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'العرض (متر)'),
                onChanged: (value) {
                  width = double.tryParse(value) ?? 0;
                },
              ),
              TextField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'الارتفاع (متر)'),
                onChanged: (value) {
                  height = double.tryParse(value) ?? 0;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
