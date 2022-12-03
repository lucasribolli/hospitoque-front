part of 'notification_bloc.dart';

@immutable
abstract class NotificationState {}

class NoNotificationsState extends NotificationState {}

class ThereIsExpiredMedicines extends NotificationState {}
