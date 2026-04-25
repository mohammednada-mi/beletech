import '../enum/enum_beleash.dart';
import '../contracts/contracts_price.dart';
import 'logic_jumbo.dart';

class LogicPrice implements ContractsPrice {
  final LogicBelesahJumbo logicBelesahJumbo = LogicBelesahJumbo();

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
    double makseb, // المكسب
    TypeOfBelesah typeOfBelesah,
  ) {
    return calcPriceDetails(
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
      makseb,
      typeOfBelesah,
    )['selectedTotal']!;
  }

  @override
  Map<String, double> calcPriceDetails(
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
    double makseb, // المكسب
    TypeOfBelesah typeOfBelesah,
  ) {
    final Wiresize wireSize =
        (typeOfBelesah == TypeOfBelesah.singleSashDoubleCurtain ||
            typeOfBelesah == TypeOfBelesah.twoSashDoubleCurtain ||
            typeOfBelesah == TypeOfBelesah.twoSashDoubleCurtainWithwire)
        ? Wiresize.doublecurtain7m
        : Wiresize.wire18m;
    final double belesahwire2 =
        (typeOfBelesah == TypeOfBelesah.twoSashDoubleCurtainWithwire)
        ? logicBelesahJumbo.calcWire(width, Wiresize.wire18m, typeOfBelesah)
        : 0;

    final double belesahWidth = logicBelesahJumbo.calcWidth(width);
    final double belesahHeight = logicBelesahJumbo.calcHeight(height);
    final double belesahSash = logicBelesahJumbo.calcSash(height);
    final double belesahDoubleFace = logicBelesahJumbo.calcDoubleFace(height);
    final double belesahThread = logicBelesahJumbo.calcThread(height, width);
    final double belesahThreadSmall = logicBelesahJumbo.calcThreadSmall(
      height,
      width,
    );

    final double belesahwire = logicBelesahJumbo.calcWire(
      width,
      wireSize,
      typeOfBelesah,
    );
    final int numThread = logicBelesahJumbo.calcNumThread(
      height,
      typeOfBelesah,
    );
    final int numThreadSmall = logicBelesahJumbo.calcNumThreadSmall(
      height,
      typeOfBelesah,
    );
    final int numWire = logicBelesahJumbo.numWire(typeOfBelesah);

    final int numSash = logicBelesahJumbo.numSash(typeOfBelesah);
    final int numDoubleFace = logicBelesahJumbo.numDoubleFace(typeOfBelesah);

    final double totalPriceWire2 =
        wirePrice * belesahwire2 * belesahDoubleFace * numWire * (3.8 / 100);

    final double totalFrame =
        belesahWidth * 2 + belesahHeight * 2; // اجمالي اطوال الحلق
    final double totalSash = belesahSash * numSash; // اجمالي الضلفة
    final double totalWight =
        (totalFrame * frameWeight) +
        (totalSash * sashWeight); // اجمالي وزن الالمنيوم
    final double totalPriceAlum =
        totalWight * wightAlumColor; // اجمالي سعر الالمنيوم
    final double totalPriceFactory =
        (width * height) * factory; // اجمالي سعر المصنعية
    final double totalPriceDoubleFace =
        belesahDoubleFace * tapePrice * numDoubleFace; // اجمالي سعر الشريط
    final double totalPriceForsh =
        forshPrice * numSash * belesahSash; // اجمالي سعر الفورش
    final double totalPriceMagnet =
        magnetPrice * numSash * belesahSash; // اجمالي سعر المغناطيس
    final double totalPriceAssemblyKit =
        assemblyKit * numSash; // اجمالي سعر طقم التجميع
    final double totalPriceThread =
        (totalThread * belesahThread * numThread) +
        (totalThread * belesahThreadSmall * numThreadSmall); // اجمالي سعر الخيط
    final double totalPriceWire =
        wirePrice *
        belesahwire *
        belesahDoubleFace *
        numSash *
        (3.8 / 100); // اجمالي سعر السلك
    final double totalPriceCurtain =
        curtainprice * belesahwire * belesahDoubleFace * numSash * (3.8 / 100);
    final double totalPriceDoubleCurtain =
        (doubleCurtainPrice * belesahwire * belesahDoubleFace * numSash * 1.4) /
        100;

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

    double selectedTotal = 0;
    switch (typeOfBelesah) {
      case TypeOfBelesah.singleSashwire:
        selectedTotal = totalpricesingleSashwire;
        break;
      case TypeOfBelesah.singleSashCurtain:
        selectedTotal = totalpricesingleSashCurtain;
        break;
      case TypeOfBelesah.singleSashDoubleCurtain:
        selectedTotal = totalpricesingleSashDoubleCurtain;
        break;
      case TypeOfBelesah.twoSashwireCurtain:
        selectedTotal = totalPriceTwoSashwireCurtain;
        break;
      case TypeOfBelesah.twoSashwire:
        selectedTotal = totalPriceTwoSashWire;
        break;
      case TypeOfBelesah.twoSashCurtain:
        selectedTotal = totalPriceTwoSashCurtain;
        break;
      case TypeOfBelesah.twoSashDoubleCurtain:
        selectedTotal = totalPriceTwoSashDoubleCurtain;
        break;
      case TypeOfBelesah.twoSashDoubleCurtainWithwire:
        selectedTotal = totalPriceTwoSashDoubleCurtainWithwire;
        break;
    }

    return {
      'selectedTotal': selectedTotal,
      'totalPriceForsh': totalPriceForsh,
      'totalPriceAlum': totalPriceAlum,
      'totalPriceFactory': totalPriceFactory,
      'totalPriceDoubleFace': totalPriceDoubleFace,
      'totalPriceMagnet': totalPriceMagnet,
      'totalPriceAssemblyKit': totalPriceAssemblyKit,
      'totalPriceThread': totalPriceThread,
      'totalPriceWire': totalPriceWire,
      'totalPriceCurtain': totalPriceCurtain,
      'totalPriceDoubleCurtain': totalPriceDoubleCurtain,
    };
  }
}
