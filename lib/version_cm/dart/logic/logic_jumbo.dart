import '../contracts/contracts_belesah.dart';
import '../enum/enum_beleash.dart';

class LogicBelesahJumbo implements ContractsBelesah {
  @override
  double calcWidth(double width) {
    double belesahWidth = width - 3.2;
    return belesahWidth;
  }

  @override
  double calcHeight(double height) {
    double belesahHeight = height - 7.0;
    return belesahHeight;
  }

  @override
  double calcSash(double height) {
    double belesahSash = height - 9.5;
    return belesahSash;
  }

  @override
  double calcDoubleFace(double height) {
    double belesahDoubleFace = height - 3.5;
    return belesahDoubleFace;
  }

  @override
  double calcThread(double height, double width) {
    double belesahThread = ((height + width) * 2) + 35.0;
    return belesahThread;
  }

  @override
  double calcThreadSmall(double height, double width) {
    if (height > 130) {
      double belesahThreadSmall =
          ((((height + width) * 2) + 30.0) - ((height - 3.0) * 0.56)) * 100;
      return belesahThreadSmall;
    } else {
      return 0;
    }
  }

  @override
  double calcPunching(double height) {
    if (height <= 130) {
      return ((height - 14.0) / 3);
    } else {
      return ((height - 14.0) / 5);
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
            return (width + 0.28) / 3.0;
          case Wiresize.wire18m:
            double belesahWire = (width + 0.28) / 3.6;
            return belesahWire;
          case Wiresize.wire19m:
            return (width + 0.28) / 3.8;
          case Wiresize.wire20m:
            return (width + 0.28) / 4.0;
          case Wiresize.doublecurtain7m:
            return (width * 1.3) / 1.4;
        }
      case TypeOfBelesah.twoSashCurtain:
      case TypeOfBelesah.twoSashwire:
      case TypeOfBelesah.twoSashDoubleCurtain:
        switch (wire) {
          case Wiresize.wire15m:
            return ((width + 0.28) / 3.0) / 2;
          case Wiresize.wire18m:
            double belesahWire = ((width + 0.28) / 3.6) / 2;
            return belesahWire;
          case Wiresize.wire19m:
            return ((width + 0.28) / 3.8) / 2;
          case Wiresize.wire20m:
            return ((width + 0.28) / 4.0) / 2;
          case Wiresize.doublecurtain7m:
            return ((width * 1.3) / 1.4) / 2;
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
        if (height > 130) {
          return 1;
        } else {
          return 0;
        }
      case TypeOfBelesah.twoSashCurtain:
      case TypeOfBelesah.twoSashwire:
      case TypeOfBelesah.twoSashDoubleCurtain:
      case TypeOfBelesah.twoSashDoubleCurtainWithwire:
      case TypeOfBelesah.twoSashwireCurtain:
        if (height > 130) {
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
