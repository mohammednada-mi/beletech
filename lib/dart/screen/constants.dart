String? selectedType;

const List<String> pleatsTypes = ['mini', 'mi', 'jumbo'];

extension PleatsTypeExtension on String {
  String get typebel {
    switch (this) {
      case 'mini':
        return 'بليسيه ميني';
      case 'mi':
        return 'بليسيه مي';
      case 'jumbo':
        return 'بليسيه جامبو';
      default:
        return this;
    }
  }
}
