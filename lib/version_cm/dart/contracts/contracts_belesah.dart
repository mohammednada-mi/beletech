import '../enum/enum_beleash.dart';

abstract class ContractsBelesah {
  double calcWidth(double width);
  double calcHeight(double height);
  double calcSash(double height);
  double calcDoubleFace(double height);
  double calcWire(double width, Wiresize wire, TypeOfBelesah belesah);
  double calcThread(double height, double width);
  double calcThreadSmall(double height, double width);
  double calcPunching(double height);
  int calcNumThread(double height, TypeOfBelesah belesah);
  int calcNumThreadSmall(double height, TypeOfBelesah belesah);
  int numSash(TypeOfBelesah belesah);
  int numDoubleFace(TypeOfBelesah belesah);
  int numWire(TypeOfBelesah belesah);
}
