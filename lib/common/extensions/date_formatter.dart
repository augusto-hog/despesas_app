import 'package:intl/intl.dart';

extension DateTimeFormatter on DateTime {
  String get toText {
    if (isAfter(DateTime.now().subtract(const Duration(days: 1)))) {
      return 'Hoje';
    }
    if (isAfter(DateTime.now().subtract(const Duration(days: 2))) && isBefore(DateTime.now().subtract(const Duration(days: 1)))) {
      return 'Ontem';
    }
    if (isAtSameMomentAs(DateTime.now().add(const Duration(days: 1)).copyWith(hour: 0, minute: 0, second: 0, millisecond: 0, microsecond: 0))) {
      return 'Amanhã';
    }
    return DateFormat("d 'de' MMMM 'de' yyyy", 'pt_BR').format(this);
  }
}
