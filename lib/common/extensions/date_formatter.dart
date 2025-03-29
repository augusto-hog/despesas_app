import 'package:intl/intl.dart';

extension DateTimeFormatter on DateTime {
  String get toText {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final tomorrow = today.add(const Duration(days: 1));
    final selectedDate = DateTime(year, month, day); // Remove a hora da comparação

    if (selectedDate.isAtSameMomentAs(today)) {
      return 'Hoje';
    }
    if (selectedDate.isAtSameMomentAs(yesterday)) {
      return 'Ontem';
    }
    if (selectedDate.isAtSameMomentAs(tomorrow)) {
      return 'Amanhã';
    }

    return DateFormat("d 'de' MMMM 'de' yyyy", 'pt_BR').format(this);
  }
}
