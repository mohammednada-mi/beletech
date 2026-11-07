import '../contracts/contracts_belesah.dart';
import '../enum/enum_beleash.dart';

class LogicBelesahMi implements ContractsBelesah {
  @override
  double calcWidth(double width) {
    double belesahWidth = width - 2.7;
    return belesahWidth;
  }

  @override
  double calcHeight(double height) {
    double belesahHeight = height - 6.0;
    return belesahHeight;
  }

  @override
  double calcSash(double height) {
    double belesahSash = height - 8.0;
    return belesahSash;
  }

  @override
  double calcDoubleFace(double height) {
    double belesahDoubleFace = height - 3.0;
    return belesahDoubleFace;
  }

  @override
  double calcThread(double height, double width) {
    double belesahThread = ((height + width) * 2) + 30.0;
    return belesahThread;
  }

  @override
  double calcThreadSmall(double height, double width) {
    if (height > 130) {
      double belesahThreadSmall =
          (((height + width) * 2) + 30.0) - ((height - 3.0) * 0.56);
      return belesahThreadSmall;
    } else {
      return 0;
    }
  }

  @override
  double calcPunching(double height) {
    if (height <= 130) {
      return ((height - 12) / 3);
    } else {
      return ((height - 12) / 5);
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
            return (width + 0.25) / 3.0;
          case Wiresize.wire18m:
            double belesahWire = (width * 1.25) / 3.6;
            return belesahWire;
          case Wiresize.wire19m:
            return (width + 0.25) / 3.8;
          case Wiresize.wire20m:
            return (width + 0.25) / 4.0;
          case Wiresize.doublecurtain7m:
            double belesahWire = (width * 1.25) / 1.4;
            return belesahWire;
        }
      case TypeOfBelesah.twoSashCurtain:
      case TypeOfBelesah.twoSashwire:
      case TypeOfBelesah.twoSashDoubleCurtain:
        switch (wire) {
          case Wiresize.wire15m:
            return ((width + 0.25) / 3.0) / 2;
          case Wiresize.wire18m:
            double belesahWire = ((width * 1.25) / 3.6) / 2;
            return belesahWire;
          case Wiresize.wire19m:
            return ((width + 0.25) / 3.8) / 2;
          case Wiresize.wire20m:
            return ((width + 0.25) / 4.0) / 2;
          case Wiresize.doublecurtain7m:
            double belesahWire = ((width * 1.25) / 1.4) / 2;
            return belesahWire;
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
          int numThreadSmall = 1;
          return numThreadSmall;
        } else {
          return 0;
        }
      case TypeOfBelesah.twoSashCurtain:
      case TypeOfBelesah.twoSashwire:
      case TypeOfBelesah.twoSashDoubleCurtain:
      case TypeOfBelesah.twoSashDoubleCurtainWithwire:
      case TypeOfBelesah.twoSashwireCurtain:
        if (height > 1.3) {
          int numThreadSmall = 2;
          return numThreadSmall;
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
