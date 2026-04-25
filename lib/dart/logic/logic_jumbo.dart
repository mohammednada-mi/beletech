import '../contracts/contracts_belesah.dart';
import '../enum/enum_beleash.dart';

class LogicBelesahJumbo implements ContractsBelesah {
  @override
  double calcWidth(double width) {
    double belesahWidth = width - 0.032;
    return belesahWidth;
  }

  @override
  double calcHeight(double height) {
    double belesahHeight = height - 0.07;
    return belesahHeight;
  }

  @override
  double calcSash(double height) {
    double belesahSash = height - 0.095;
    return belesahSash;
  }

  @override
  double calcDoubleFace(double height) {
    double belesahDoubleFace = height - 0.035;
    return belesahDoubleFace;
  }

  @override
  double calcThread(double height, double width) {
    double belesahThread = ((height + width) * 2) + 0.35;
    return belesahThread;
  }

  @override
  double calcThreadSmall(double height, double width) {
    if (height > 1.3) {
      double belesahThreadSmall = ((height + width) * 2) + 0.35 - 1;
      return belesahThreadSmall;
    } else {
      return 0;
    }
  }

  @override
  double calcPunching(double height) {
    if (height <= 1.3) {
      return ((height - 0.14) / 3) * 100;
    } else {
      return ((height - 0.14) / 5) * 100;
    }
  }

  @override
  double calcWire(double width, Wiresize wire, TypeOfBelesah belesah) {
    switch (belesah) {
      case TypeOfBelesah.singleSashCurtain:
      case TypeOfBelesah.singleSashwire:
      case TypeOfBelesah.singleSashDoubleCurtain:
      case TypeOfBelesah.twoSashDoubleCurtainWithwire:
      case TypeOfBelesah.twoSashwireCurtain:
        switch (wire) {
          case Wiresize.wire15m:
            return (width + 0.28) / 0.03;
          case Wiresize.wire18m:
            double belesahWire = (width + 0.28) / 0.036;
            return belesahWire;
          case Wiresize.wire19m:
            return (width + 0.28) / 0.038;
          case Wiresize.wire20m:
            return (width + 0.28) / 0.04;
          case Wiresize.doublecurtain7m:
            return (width * 1.3) / 0.014;
        }
      case TypeOfBelesah.twoSashCurtain:
      case TypeOfBelesah.twoSashwire:
      case TypeOfBelesah.twoSashDoubleCurtain:
        switch (wire) {
          case Wiresize.wire15m:
            return ((width + 0.28) / 0.03) / 2;
          case Wiresize.wire18m:
            double belesahWire = ((width + 0.28) / 0.036) / 2;
            return belesahWire;
          case Wiresize.wire19m:
            return ((width + 0.28) / 0.038) / 2;
          case Wiresize.wire20m:
            return ((width + 0.28) / 0.04) / 2;
          case Wiresize.doublecurtain7m:
            return ((width * 1.3) / 0.014) / 2;
        }
    }
  }

  @override
  int calcNumThread(double height, TypeOfBelesah belesah) {
    switch (belesah) {
      case TypeOfBelesah.singleSashCurtain:
      case TypeOfBelesah.singleSashwire:
      case TypeOfBelesah.singleSashDoubleCurtain:
        return 2;
      case TypeOfBelesah.twoSashCurtain:
      case TypeOfBelesah.twoSashwire:
      case TypeOfBelesah.twoSashDoubleCurtain:
      case TypeOfBelesah.twoSashDoubleCurtainWithwire:
      case TypeOfBelesah.twoSashwireCurtain:
        return 4;
    }
  }

  @override
  int calcNumThreadSmall(double height, TypeOfBelesah belesah) {
    switch (belesah) {
      case TypeOfBelesah.singleSashCurtain:
      case TypeOfBelesah.singleSashwire:
      case TypeOfBelesah.singleSashDoubleCurtain:
        if (height > 1.3) {
          return 1;
        } else {
          return 0;
        }
      case TypeOfBelesah.twoSashCurtain:
      case TypeOfBelesah.twoSashwire:
      case TypeOfBelesah.twoSashDoubleCurtain:
      case TypeOfBelesah.twoSashDoubleCurtainWithwire:
      case TypeOfBelesah.twoSashwireCurtain:
        if (height > 1.3) {
          return 2;
        } else {
          return 0;
        }
    }
  }

  @override
  int numSash(TypeOfBelesah belesah) {
    switch (belesah) {
      case TypeOfBelesah.singleSashCurtain:
      case TypeOfBelesah.singleSashwire:
      case TypeOfBelesah.singleSashDoubleCurtain:
        return 1;
      case TypeOfBelesah.twoSashCurtain:
      case TypeOfBelesah.twoSashwire:
      case TypeOfBelesah.twoSashDoubleCurtain:
      case TypeOfBelesah.twoSashDoubleCurtainWithwire:
      case TypeOfBelesah.twoSashwireCurtain:
        return 2;
    }
  }

  @override
  int numDoubleFace(TypeOfBelesah belesah) {
    switch (belesah) {
      case TypeOfBelesah.singleSashCurtain:
      case TypeOfBelesah.singleSashwire:
      case TypeOfBelesah.singleSashDoubleCurtain:
        return 2;
      case TypeOfBelesah.twoSashCurtain:
      case TypeOfBelesah.twoSashwire:
      case TypeOfBelesah.twoSashDoubleCurtain:
      case TypeOfBelesah.twoSashDoubleCurtainWithwire:
      case TypeOfBelesah.twoSashwireCurtain:
        return 4;
    }
  }

  @override
  int numWire(TypeOfBelesah belesah) {
    switch (belesah) {
      case TypeOfBelesah.singleSashCurtain:
      case TypeOfBelesah.singleSashwire:
      case TypeOfBelesah.singleSashDoubleCurtain:
      case TypeOfBelesah.twoSashDoubleCurtainWithwire:
      case TypeOfBelesah.twoSashwireCurtain:
        return 1;
      case TypeOfBelesah.twoSashCurtain:
      case TypeOfBelesah.twoSashwire:
      case TypeOfBelesah.twoSashDoubleCurtain:
        return 2;
    }
  }
}
