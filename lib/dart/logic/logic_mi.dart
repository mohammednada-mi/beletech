import '../contracts/contracts_belesah.dart';
import '../enum/enum_beleash.dart';

class LogicBelesahMi implements ContractsBelesah {
  @override
  double calcWidth(double width) {
    double belesahWidth = width - 0.027;
    return belesahWidth;
  }

  @override
  double calcHeight(double height) {
    double belesahHeight = height - 0.06;
    return belesahHeight;
  }

  @override
  double calcSash(double height) {
    double belesahSash = height - 0.082;
    return belesahSash;
  }

  @override
  double calcDoubleFace(double height) {
    double belesahDoubleFace = height - 0.03;
    return belesahDoubleFace;
  }

  @override
  double calcThread(double height, double width) {
    double belesahThread = ((height + width) * 2) + 0.3;
    return belesahThread;
  }

  @override
  double calcThreadSmall(double height, double width) {
    if (height > 1.3) {
      double belesahThreadSmall =
          (((height + width) * 2) + 0.3) - ((height - 0.03) * 0.56);
      return belesahThreadSmall;
    } else {
      return 0;
    }
  }

  @override
  double calcPunching(double height) {
    if (height <= 1.3) {
      return ((height - 0.12) / 3) * 100;
    } else {
      return ((height - 0.12) / 5) * 100;
    }
  }

  @override
  double calcWire(double width, Wiresize wire, TypeOfSash sash) {
    switch (sash) {
      case TypeOfSash.singleSash:
        switch (wire) {
          case Wiresize.wire15m:
            return (width + 0.25) / 0.03;
          case Wiresize.wire18m:
            double belesahWire = (width * 1.25) / 0.036;
            return belesahWire;
          case Wiresize.wire19m:
            return (width + 0.25) / 0.038;
          case Wiresize.wire20m:
            return (width + 0.25) / 0.04;
          case Wiresize.doublecurtain7m:
            double belesahWire = (width * 1.25) / 0.014;
            return belesahWire;
        }
      case TypeOfSash.twoSash:
        switch (wire) {
          case Wiresize.wire15m:
            return ((width + 0.25) / 0.03) / 2;
          case Wiresize.wire18m:
            double belesahWire = ((width * 1.25) / 0.036) / 2;
            return belesahWire;
          case Wiresize.wire19m:
            return ((width + 0.25) / 0.038) / 2;
          case Wiresize.wire20m:
            return ((width + 0.25) / 0.04) / 2;
          case Wiresize.doublecurtain7m:
            double belesahWire = ((width * 1.25) / 0.014) / 2;
            return belesahWire;
        }
    }
  }

  @override
  int calcNumThread(double height, TypeOfSash sash) {
    switch (sash) {
      case TypeOfSash.singleSash:
        return 2;
      case TypeOfSash.twoSash:
        return 4;
    }
  }

  @override
  int calcNumThreadSmall(double height, TypeOfSash sash) {
    switch (sash) {
      case TypeOfSash.singleSash:
        if (height > 1.3) {
          int numThreadSmall = 1;
          return numThreadSmall;
        } else {
          return 0;
        }
      case TypeOfSash.twoSash:
        if (height > 1.3) {
          int numThreadSmall = 2;
          return numThreadSmall;
        } else {
          return 0;
        }
    }
  }

  @override
  int numSash(TypeOfSash sash) {
    switch (sash) {
      case TypeOfSash.singleSash:
        return 1;
      case TypeOfSash.twoSash:
        return 2;
    }
  }

  @override
  int numDoubleFace(TypeOfSash sash) {
    switch (sash) {
      case TypeOfSash.singleSash:
        return 2;
      case TypeOfSash.twoSash:
        return 4;
    }
  }
}
