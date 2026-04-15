import '../enum/enum_beleash.dart';
import '../contracts/contracts_price.dart';
import 'logic_mi.dart';

class LogicPrice implements ContractsPrice {
  final LogicBelesahMi logicBelesahMi = LogicBelesahMi();

  Map<String, double> calcPriceDetails(
    double width,
    double height,
    double factory,
    double elhalk,
    double totalThread,
    double curtainprice,
    double doubleCurtainPrice,
    double tapePrice,
    double assemblyKit,
    double forshPrice,
    double wightAlumColor,
    double frameWeight,
    double sashWeight,
    double magnetPrice,
    double wirePrice,
    TypeOfBelesah typeOfBelesah,
  ) {
    final TypeOfSash sashType = typeOfBelesah.name.startsWith('single')
        ? TypeOfSash.singleSash
        : TypeOfSash.twoSash;
    const Wiresize wireSize = Wiresize.wire18m;
    final double belesahWidth = logicBelesahMi.calcWidth(width);
    final double belesahHeight = logicBelesahMi.calcHeight(height);
    final double belesahSash = logicBelesahMi.calcSash(height);
    final double belesahDoubleFace = logicBelesahMi.calcDoubleFace(height);
    final double belesahThread = logicBelesahMi.calcThread(height, width);
    final double belesahThreadSmall = logicBelesahMi.calcThreadSmall(
      height,
      width,
    );
    final double belesahwire = logicBelesahMi.calcWire(
      width,
      wireSize,
      sashType,
    );
    final int numThread = logicBelesahMi.calcNumThread(height, sashType);
    final int numThreadSmall = logicBelesahMi.calcNumThreadSmall(
      height,
      sashType,
    );
    final int numSash = logicBelesahMi.numSash(sashType);
    final int numDoubleFace = logicBelesahMi.numDoubleFace(sashType);

    final double totalFrame = belesahWidth * 2 + belesahHeight * 2;
    final double totalSash = belesahSash * numSash;
    final double totalWight = (totalFrame * frameWeight) + (totalSash * sashWeight);
    final double totalPriceAlum = totalWight * wightAlumColor;
    final double totalPriceFactory = (width * height) * factory;
    final double totalPriceDoubleFace = belesahDoubleFace * tapePrice * numDoubleFace;
    final double totalPriceForsh = forshPrice * numSash * belesahSash;
    final double totalPriceMagnet = magnetPrice * numSash * belesahSash;
    final double totalPriceAssemblyKit = assemblyKit * numSash;
    final double totalPriceThread =
        (totalThread * belesahThread * numThread) +
        (totalThread * belesahThreadSmall * numThreadSmall);
    final double totalPriceWire =
        wirePrice * belesahwire * belesahDoubleFace * numSash * (3.8 / 100);
    final double totalPriceCurtain =
        curtainprice * belesahwire * belesahDoubleFace * numSash * (3.8 / 100);
    final double totalPriceDoubleCurtain =
        (doubleCurtainPrice * belesahwire * belesahDoubleFace * numSash * 1.4) /
        100;
    final double totalPriceElhalk = totalPriceFactory * (elhalk / 100);

    final double totalpricesingleSashwire =
        totalPriceAlum +
        totalPriceFactory +
        totalPriceWire +
        totalPriceThread +
        totalPriceDoubleFace +
        totalPriceForsh +
        totalPriceAssemblyKit;
    final double totalpricesingleSashCurtain =
        totalPriceAlum +
        totalPriceFactory +
        totalPriceCurtain +
        totalPriceThread +
        totalPriceDoubleFace +
        totalPriceForsh +
        totalPriceAssemblyKit;
    final double totalpricesingleSashDoubleCurtain =
        totalPriceAlum +
        totalPriceFactory +
        totalPriceDoubleCurtain +
        totalPriceThread +
        totalPriceDoubleFace +
        totalPriceForsh +
        totalPriceAssemblyKit;
    final double totalPriceTwoSashWire =
        totalPriceAlum +
        totalPriceFactory +
        totalPriceWire +
        totalPriceThread +
        totalPriceDoubleFace +
        totalPriceForsh +
        totalPriceAssemblyKit +
        totalPriceMagnet;
    final double totalPriceTwoSashCurtain =
        totalPriceAlum +
        totalPriceFactory +
        totalPriceCurtain +
        totalPriceThread +
        totalPriceDoubleFace +
        totalPriceForsh +
        totalPriceAssemblyKit +
        totalPriceMagnet;
    final double totalPriceTwoSashwireCurtain =
        totalPriceAlum +
        totalPriceFactory +
        totalPriceWire +
        totalPriceCurtain +
        totalPriceThread +
        totalPriceDoubleFace +
        totalPriceForsh +
        totalPriceAssemblyKit +
        totalPriceMagnet;
    final double totalPriceTwoSashDoubleCurtain =
        totalPriceAlum +
        totalPriceFactory +
        totalPriceDoubleCurtain +
        totalPriceThread +
        totalPriceDoubleFace +
        totalPriceForsh +
        totalPriceAssemblyKit +
        totalPriceMagnet;
    final double totalPriceTwoSashDoubleCurtainWithwire =
        totalPriceAlum +
        totalPriceFactory +
        totalPriceDoubleCurtain +
        totalPriceWire +
        totalPriceThread +
        totalPriceDoubleFace +
        totalPriceForsh +
        totalPriceAssemblyKit +
        totalPriceMagnet;

    return {
      'belesahWidth': belesahWidth,
      'belesahHeight': belesahHeight,
      'belesahSash': belesahSash,
      'belesahDoubleFace': belesahDoubleFace,
      'belesahThread': belesahThread,
      'belesahThreadSmall': belesahThreadSmall,
      'belesahwire': belesahwire,
      'numThread': numThread.toDouble(),
      'numThreadSmall': numThreadSmall.toDouble(),
      'numSash': numSash.toDouble(),
      'numDoubleFace': numDoubleFace.toDouble(),
      'totalFrame': totalFrame,
      'totalSash': totalSash,
      'totalWight': totalWight,
      'totalPriceAlum': totalPriceAlum,
      'totalPriceFactory': totalPriceFactory,
      'totalPriceElhalk': totalPriceElhalk,
      'totalPriceDoubleFace': totalPriceDoubleFace,
      'totalPriceForsh': totalPriceForsh,
      'totalPriceMagnet': totalPriceMagnet,
      'totalPriceAssemblyKit': totalPriceAssemblyKit,
      'totalPriceThread': totalPriceThread,
      'totalPriceWire': totalPriceWire,
      'totalPriceCurtain': totalPriceCurtain,
      'totalPriceDoubleCurtain': totalPriceDoubleCurtain,
      TypeOfBelesah.singleSashwire.name: totalpricesingleSashwire,
      TypeOfBelesah.singleSashCurtain.name: totalpricesingleSashCurtain,
      TypeOfBelesah.singleSashDoubleCurtain.name: totalpricesingleSashDoubleCurtain,
      TypeOfBelesah.twoSashwire.name: totalPriceTwoSashWire,
      TypeOfBelesah.twoSashCurtain.name: totalPriceTwoSashCurtain,
      TypeOfBelesah.twoSashwireCurtain.name: totalPriceTwoSashwireCurtain,
      TypeOfBelesah.twoSashDoubleCurtain.name: totalPriceTwoSashDoubleCurtain,
      TypeOfBelesah.twoSashDoubleCurtainWithwire.name:
          totalPriceTwoSashDoubleCurtainWithwire,
      'selectedTotal': _pickSelectedTotal(typeOfBelesah, {
        TypeOfBelesah.singleSashwire: totalpricesingleSashwire,
        TypeOfBelesah.singleSashCurtain: totalpricesingleSashCurtain,
        TypeOfBelesah.singleSashDoubleCurtain: totalpricesingleSashDoubleCurtain,
        TypeOfBelesah.twoSashwire: totalPriceTwoSashWire,
        TypeOfBelesah.twoSashCurtain: totalPriceTwoSashCurtain,
        TypeOfBelesah.twoSashwireCurtain: totalPriceTwoSashwireCurtain,
        TypeOfBelesah.twoSashDoubleCurtain: totalPriceTwoSashDoubleCurtain,
        TypeOfBelesah.twoSashDoubleCurtainWithwire:
            totalPriceTwoSashDoubleCurtainWithwire,
      }),
    };
  }

  double _pickSelectedTotal(
    TypeOfBelesah typeOfBelesah,
    Map<TypeOfBelesah, double> totals,
  ) {
    return totals[typeOfBelesah] ?? 0;
  }

  @override
  double calcPrice(
    double width, // الطول
    double height, // العرض
    double factory, // سعر المصنع
    double elhalk, // الهالك
    double totalThread, // اجمالي الخيط
    double curtainprice, // سعر الستارة
    double doubleCurtainPrice, // سعر الستارة المزدوجة
    double tapePrice, // سعر الشريط
    double assemblyKit, // سعر طقم التجميع
    double forshPrice, // سعر الفورش
    double wightAlumColor, // عرض الالمنيوم الملون
    double frameWeight, // وزن الاطار
    double sashWeight, // وزن الشباك
    double magnetPrice, // سعر المغناطيس
    double wirePrice, // سعر السلك // ضلفة واحدة أو اثنتين
    TypeOfBelesah typeOfBelesah,
  ) {
    final details = calcPriceDetails(
      width,
      height,
      factory,
      elhalk,
      totalThread,
      curtainprice,
      doubleCurtainPrice,
      tapePrice,
      assemblyKit,
      forshPrice,
      wightAlumColor,
      frameWeight,
      sashWeight,
      magnetPrice,
      wirePrice,
      typeOfBelesah,
    );
    return details['selectedTotal'] ?? 0;
  }
}
