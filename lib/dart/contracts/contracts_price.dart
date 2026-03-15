import '../enum/enum_beleash.dart';

abstract class ContractsPrice {
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
    Wiresize wireSize, // مقاس السلك
    TypeOfSash sashType, // ضلفة واحدة أو اثنتين
    TypeOfBelesah typeOfBelesah,
  );
}
