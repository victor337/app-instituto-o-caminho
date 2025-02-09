import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  // 01/JAN/2022
  String ddMMMyyyy() =>
      DateFormat('dd/MMM/yyyy', 'pt_BR').format(this).toUpperCase();

  // 01 JAN
  String ddMMM() => DateFormat('dd MMM', 'pt_BR').format(this).toUpperCase();

  // 012022
  String monthYear() =>
      DateFormat('MMyyyy', 'pt_BR').format(this).toUpperCase();

  // 012022
  String monthYearSlash() =>
      DateFormat('MM/yyyy', 'pt_BR').format(this).toUpperCase();

  // 01/01/2022
  String ddMMyyyy() =>
      DateFormat('dd/MM/yyyy', 'pt_BR').format(this).toUpperCase();

  // 01/01/22
  String ddMMyy() => DateFormat('dd/MM/yy', 'pt_BR').format(this).toUpperCase();

  // JAN/22
  String mMMyy() => DateFormat('MMM/yy', 'pt_BR').format(this).toUpperCase();

  // JANEIRO
  String mMMM() {
    return DateFormat('MMMM', 'pt_BR').format(this);
  }

  // JAN/2022
  String mMMyyyy() =>
      DateFormat('MMM/yyyy', 'pt_BR').format(this).toUpperCase();

  // 01/22
  String mmyy() {
    return DateFormat('MM/yy', 'pt_BR').format(this);
  }

  // 2022-01-01
  String yyyyMMddSlash() =>
      DateFormat('yyyy-MM-dd', 'pt_BR').format(this).toUpperCase();

  // 2022/01/01
  String yyyyMMdd() =>
      DateFormat('yyyy/MM/dd', 'pt_BR').format(this).toUpperCase();

  // 01/01
  String ddMM() => DateFormat('dd/MM', 'pt_BR').format(this).toUpperCase();

  // 01 de JANEIRO
  String getdayAndMonth() {
    return '${DateFormat('dd').format(this)} de ${mMMM().toUpperCase()}';
  }

  // Janeiro de 2022
  String mMMMyyyy() {
    return '${mMMM()} de ${DateFormat('yyyy', 'pt_BR').format(this)}';
  }

  bool isSameDate(DateTime other) => difference(other).inDays == 0;

  int getWorkHoursTo(DateTime second) {
    int minutes = 0;

    DateTime first = DateTime(year, month, day, hour, minute);

    while (first.isBefore(second)) {
      if (first.hour >= 8 &&
          first.hour <= 17 &&
          ![6, 7].contains(first.weekday)) {
        minutes += 1;
      }
      first = first.add(const Duration(minutes: 1));
    }

    return minutes;
  }

  String getVerboseDateTimeRepresentation() {
    final DateTime now = DateTime.now();
    final DateTime justNow =
        DateTime.now().subtract(const Duration(minutes: 1));

    if (!difference(justNow).isNegative) {
      return 'Agora mesmo';
    }

    final String roughTimeString = DateFormat('HH:mm').format(this);

    if (day == now.day &&
        month == now.month &&
        year == now.year &&
        hour == now.hour) {
      final minutes = now.minute - minute;
      if (minutes <= 0) {
        return 'Agora mesmo';
      }

      return 'Há $minutes min';
    }

    if (day == now.day && month == now.month && year == now.year) {
      final hours = now.hour - hour;
      if (hours <= 0) {
        return 'Agora mesmo';
      }
      return 'Há ${hours}h';
    }

    final DateTime yesterday = now.subtract(const Duration(days: 1));
    if (day == yesterday.day &&
        month == yesterday.month &&
        year == yesterday.year) {
      return 'Ontem às $roughTimeString';
    }

    return '${DateFormat('dd').format(this)} ${DateFormat('MMM').format(this)} às $roughTimeString';
  }

  String getCurrentMonthAndYear() {
    switch (month) {
      case 1:
        return 'JANEIRO $year';
      case 2:
        return 'FEVEREIRO $year';
      case 3:
        return 'MARÇO $year';
      case 4:
        return 'ABRIL $year';
      case 5:
        return 'MAIO $year';
      case 6:
        return 'JUNHO $year';
      case 7:
        return 'JULHO $year';
      case 8:
        return 'AGOSTO $year';
      case 9:
        return 'SETEMBRO $year';
      case 10:
        return 'OUTUBRO $year';
      case 11:
        return 'NOVEMBRO $year';
      case 12:
        return 'DEZEMBRO $year';
      default:
        return '';
    }
  }

  DateTime? convertStringToDate(String? value) {
    if (value == null) return null;
    return DateTime.tryParse(value);
  }
}
