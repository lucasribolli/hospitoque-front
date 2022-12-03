import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart' show immutable, debugPrint;
import 'package:hospitoque/model/medicine.dart';
import 'package:hospitoque/repositories/repository.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(NoNotificationsState()) {
    on<NotifyAboutExpiredMedicines>(_alertAboutExpiredMedicines);
    add(NotifyAboutExpiredMedicines());
  }

  Future<void> _alertAboutExpiredMedicines(NotifyAboutExpiredMedicines event,
      Emitter<NotificationState> emit) async {
    try {
      List<Medicine> medicines = await HospitoqueRepository.getMedicines();
      DateTime now = DateTime.now();
      bool isThereExpiredMedicines = medicines
          .where((m) => m.expirationDate.isBefore(now))
          .toList()
          .isNotEmpty;
      if (isThereExpiredMedicines) {
        emit(ThereIsExpiredMedicines());
      }
    } catch (e) {
      debugPrint('Error on _alertAboutExpiredMedicines: $e');
    }
  }
}
