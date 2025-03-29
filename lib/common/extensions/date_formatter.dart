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

  String get formatISOTime {
    var duration = timeZoneOffset;
    if (duration.isNegative) {
      return ("${toIso8601String().replaceAll('Z', '-')}${duration.inHours.toString().padLeft(2, '0')}:${(duration.inMinutes - (duration.inHours * 60)).toString().padLeft(2, '0')}");
    } else {
      return ("${toIso8601String().replaceAll('Z', '+')}${duration.inHours.toString().padLeft(2, '0')}:${(duration.inMinutes - (duration.inHours * 60)).toString().padLeft(2, '0')}");
    }
  }
}
