import 'package:intl/intl.dart';

extension DateTimeFormatter on DateTime {
  String get toText {
    if (day == DateTime.now().day) {
      return 'Hoje';
    }
    if (day == DateTime.now().subtract(const Duration(days: 1)).day) {
      return 'Ontem';
    }
    if (day == DateTime.now().add(const Duration(days: 1)).day) {
      return 'Amanhã';
    }
    return DateFormat("d 'de' MMMM 'de' yyyy", 'pt_BR').format(this);
  }
}
