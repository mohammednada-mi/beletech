import '../enum/enum_beleash.dart';
import '../contracts/contracts_price.dart';
import 'logic_mi.dart';

class LogicPrice implements ContractsPrice {
  final LogicBelesahMi logicBelesahMi = LogicBelesahMi();

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
    double wirePrice, // سعر السلك

    TypeOfSash sashType, // ضلفة واحدة أو اثنتين
    TypeOfBelesah typeOfBelesah,
  ) {
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

    switch (typeOfBelesah) {
      case TypeOfBelesah.singleSashwire:
        return totalpricesingleSashwire;
      case TypeOfBelesah.singleSashCurtain:
        return totalpricesingleSashCurtain;
      case TypeOfBelesah.singleSashDoubleCurtain:
        return totalpricesingleSashDoubleCurtain;
      case TypeOfBelesah.twoSashwireCurtain:
        return totalPriceTwoSashwireCurtain;
      case TypeOfBelesah.twoSashwire:
        return totalPriceTwoSashWire;
      case TypeOfBelesah.twoSashCurtain:
        return totalPriceTwoSashCurtain;
      case TypeOfBelesah.twoSashDoubleCurtain:
        return totalPriceTwoSashDoubleCurtain;
      case TypeOfBelesah.twoSashDoubleCurtainWithwire:
        return totalPriceTwoSashDoubleCurtainWithwire;
    }
  }
}
