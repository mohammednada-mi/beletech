import '../enum/enum_beleash.dart';

abstract class ContractsBelesah {
  double calcWidth(double width);
  double calcHeight(double height);
  double calcSash(double height);
  double calcDoubleFace(double height);
  double calcWire(double width, Wiresize wire, TypeOfSash sash);
  double calcThread(double height, double width);
  double calcThreadSmall(double height, double width);
  double calcPunching(double height);
  int calcNumThread(double height, TypeOfSash sash);
  int calcNumThreadSmall(double height, TypeOfSash sash);
  int numSash(TypeOfSash sash);
  int numDoubleFace(TypeOfSash sash);
}
