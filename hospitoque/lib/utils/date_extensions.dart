extension OnlyDaysExtension on DateTime {
  DateTime get ignoreDays => DateTime(year, month, day);
}