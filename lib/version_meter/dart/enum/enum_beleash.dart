enum TypeOfBelesah {
  singleSashwire,
  singleSashCurtain,
  twoSashwire,
  twoSashwireCurtain,
  twoSashCurtain,
  singleSashDoubleCurtain,
  twoSashDoubleCurtain,
  twoSashDoubleCurtainWithwire,
}

enum Wiresize { wire15m, wire18m, wire19m, wire20m, doublecurtain7m }

extension TypeOfBelesahExtension on TypeOfBelesah {
  String get belesah {
    switch (this) {
      case TypeOfBelesah.singleSashwire:
        return 'ضلفة واحدة سلك';
      case TypeOfBelesah.singleSashCurtain:
        return 'ضلفة واحدة ستارة';
      case TypeOfBelesah.twoSashwire:
        return 'ضلفتين سلك';
      case TypeOfBelesah.twoSashwireCurtain:
        return 'سلك + ستارة';
      case TypeOfBelesah.twoSashCurtain:
        return 'ضلفتين ستارة';
      case TypeOfBelesah.singleSashDoubleCurtain:
        return 'ضلفة واحدة ستارة دبل';
      case TypeOfBelesah.twoSashDoubleCurtain:
        return 'ضلفتين ستارة دبل';
      case TypeOfBelesah.twoSashDoubleCurtainWithwire:
        return 'ستارة دبل + سلك';
    }
  }
}

extension WiresizeExtension on Wiresize {
  String get wire {
    switch (this) {
      case Wiresize.wire15m:
        return ' 15 ملي';
      case Wiresize.wire18m:
        return ' 18 ملي';
      case Wiresize.wire19m:
        return ' 19 ملي';
      case Wiresize.wire20m:
        return ' 20 ملي';
      case Wiresize.doublecurtain7m:
        return 'دبل 7 ملي';
    }
  }
}
