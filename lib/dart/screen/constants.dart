String? selectedType;

const List<String> pleatsTypes = ['mini', 'mi', 'jumbo'];

extension PleatsTypeExtension on String {
  String get typebel {
    switch (this) {
      case 'mini':
        return 'قطاع صغير';
      case 'mi':
        return ' قطاع 3.7 سم';
      case 'jumbo':
        return 'قطاع جامبو';
      default:
        return this;
    }
  }
}
