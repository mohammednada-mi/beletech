String? selectedType;

const List<String> pleatsTypes = ['mini', 'mi', 'jumbo'];

extension PleatsTypeExtension on String {
  String get typebel {
    switch (this) {
      case 'mini':
        return 'قطاع 1.7 ';
      case 'mi':
        return ' قطاع 2.7 ';
      case 'jumbo':
        return 'قطاع 3.7 ';
      default:
        return this;
    }
  }
}
