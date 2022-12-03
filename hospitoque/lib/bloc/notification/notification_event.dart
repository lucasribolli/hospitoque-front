part of 'notification_bloc.dart';

@immutable
abstract class NotificationEvent {}

class NotifyAboutExpiredMedicines extends NotificationEvent {}
