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

  String get yMd {
    return DateFormat('yyyy-MM-dd').format(this);
  }

  int get weeksInMonth {
    DateTime firstDayOfMonth = DateTime(year, month, 1);
    DateTime lastDayOfMonth = DateTime(year, month + 1, 0);

    // Calculate the number of days in the month
    int daysInMonth = lastDayOfMonth.day;

    // Calculate the weekday of the first day of the month (0 = Sunday, 6 = Saturday)
    int firstDayWeekday = firstDayOfMonth.weekday;

    // Calculate the number of days to complete the last week of the month
    int remainingDays = 7 - (firstDayWeekday - 1);

    // Calculate the number of full weeks in the month
    int fullWeeks = (daysInMonth - remainingDays) ~/ 7;

    // Calculate the total number of weeks in the month
    int totalWeeks = fullWeeks + 1; // Add one for the last week

    return totalWeeks;
  }

  int get week {
    final firstDayOfMonth = DateTime(year, month, 1);
    final daysOffset = (weekday - firstDayOfMonth.weekday + 1 + 7) % 7;
    return (day + daysOffset - 1) ~/ 7 + 1;
  }
}
