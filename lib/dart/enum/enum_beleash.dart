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

enum TypeOfSash { singleSash, twoSash }

extension TypeOfBelesahExtension on TypeOfBelesah {
  String get belesah {
    switch (this) {
      case TypeOfBelesah.singleSashwire:
        return 'بليسيه بشريط سلك';
      case TypeOfBelesah.singleSashCurtain:
        return 'بليسيه بشريط قماش';
      case TypeOfBelesah.twoSashwire:
        return 'بليسيه بشريط سلك مزدوج';
      case TypeOfBelesah.twoSashwireCurtain:
        return 'بليسيه بشريط سلك مزدوج وقماش';
      case TypeOfBelesah.twoSashCurtain:
        return 'بليسيه بشريط قماش مزدوج';
      case TypeOfBelesah.singleSashDoubleCurtain:
        return 'بليسيه بشريط قماش ومزدوج';
      case TypeOfBelesah.twoSashDoubleCurtain:
        return 'بليسيه بشريط قماش مزدوج';
      case TypeOfBelesah.twoSashDoubleCurtainWithwire:
        return 'بليسيه بشريط قماش مزدوج وسلك';
    }
  }
}

extension WiresizeExtension on Wiresize {
  String get wire {
    switch (this) {
      case Wiresize.wire15m:
        return 'سلك 15 متر';
      case Wiresize.wire18m:
        return 'سلك 18 متر';
      case Wiresize.wire19m:
        return 'سلك 19 متر';
      case Wiresize.wire20m:
        return 'سلك 20 متر';
      case Wiresize.doublecurtain7m:
        return 'قماش مزدوج 7 متر';
    }
  }
}

extension TypeOfSashExtension on TypeOfSash {
  String get sash {
    switch (this) {
      case TypeOfSash.singleSash:
        return 'شيش مفرد';
      case TypeOfSash.twoSash:
        return 'شيش مزدوج';
    }
  }
}
