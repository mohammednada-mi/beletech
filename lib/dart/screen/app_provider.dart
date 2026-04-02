import 'package:belesah/dart/enum/enum_beleash.dart';
import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  double height = 0;
  double width = 0;
  String? selectedType;
  Wiresize? selectedWire;
  TypeOfSash? selectedSash;
  TypeOfBelesah? selectedBelesah;

  void setHeight(double value) {
    height = value;
    notifyListeners();
  }

  void setWidth(double value) {
    width = value;
    notifyListeners();
  }

  void setSelectedType(String? value) {
    selectedType = value;
    notifyListeners();
  }

  void setSelectedWire(Wiresize? value) {
    selectedWire = value;
    notifyListeners();
  }

  void setSelectedSash(TypeOfSash? value) {
    selectedSash = value;
    notifyListeners();
  }

  void setSelectedBelesah(TypeOfBelesah? value) {
    selectedBelesah = value;
    notifyListeners();
  }
}

///ChangeNotifier ده زي اللي بيقول لكل الشاشات "في حاجة اتغيرت".
///المتغيرات زي height و width دي المتغيرات المشتركة بين الشاشتين.
///الـ functions زي setHeight و setWidth دي اللي بتغير المتغيرات، وبعد ما تغيرهم بتقول notifyListeners() اللي معناها "قول لكل الشاشات إن في حاجة اتغيرت اتحدثوا".

///يعني باختصار، أي شاشة بتغير في المتغير، كل الشاشات التانية بتعرف وبتتحدث أوتوماتيك.
