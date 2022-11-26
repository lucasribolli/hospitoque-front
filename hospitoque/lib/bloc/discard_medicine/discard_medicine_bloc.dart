import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart' show debugPrint, immutable;
import 'package:hospitoque/model/medicine.dart';
import 'package:hospitoque/repositories/repository.dart';

part 'discard_medicine_event.dart';
part 'discard_medicine_state.dart';

class DiscardMedicineBloc
    extends Bloc<DiscardMedicineEvent, DiscardMedicineState> {
  static const _TAG = '[DiscardMedicineBloc] ';

  DiscardMedicineBloc() : super(DiscardMedicineState.initial()) {
    on<DiscardMedicineEvent>(_onListAll);
  }

  Future<void> _onListAll(event, emit) async {
    try {
      List<Medicine> medicines =
          await HospitoqueRepository.getMedicines(keyword: '');
      List<ExpirationMedicine> expirationMedicines = _orderMedicines(medicines);
      emit(state.copyWith(medicines: expirationMedicines));
    } catch (e) {
      debugPrint('$_TAG error on list all: $e');
    }
  }

  List<ExpirationMedicine> _orderMedicines(List<Medicine> medicines) {
    List<Medicine> orderedByExpiration = [...medicines];
    orderedByExpiration
        .sort((a, b) => a.expirationDate.compareTo(b.expirationDate));
    DateTime now = DateTime.now();
    return orderedByExpiration.map(
      (m) {
        return ExpirationMedicine(
          medicine: m,
          timeToExpiration: _getTimeToExpiration(now, m.expirationDate),
        );
      },
    ).toList();
  }

  TimeToExpiration _getTimeToExpiration(DateTime now, DateTime expirationDate) {
    if(expirationDate.isBefore(now)) {
      return TimeToExpiration.past;
    }
    return TimeToExpiration.nextMonthOrMore;
  }
}
