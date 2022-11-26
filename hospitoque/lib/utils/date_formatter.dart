import 'package:intl/intl.dart';

class DateFormatter {
  DateFormatter._();

  static String getDayFormatted(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }
}