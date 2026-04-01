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
  String get belName {
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
