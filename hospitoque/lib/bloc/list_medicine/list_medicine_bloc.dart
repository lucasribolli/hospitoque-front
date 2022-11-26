import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart' show debugPrint, immutable;
import 'package:hospitoque/model/medicine.dart';
import 'package:hospitoque/repositories/repository.dart';

part 'list_medicine_event.dart';
part 'list_medicine_state.dart';

class ListMedicineBloc extends Bloc<ListMedicineEvent, ListMedicineState> {
  static const _TAG = '[ListMedicineBloc]';

  ListMedicineBloc() : super(ListMedicineState.initial()) {
    on<ListAllMedicinesEvent>(_onListAll);
    add(ListAllMedicinesEvent());
  }

  Future<void> _onListAll(ListAllMedicinesEvent event, emit) async {
    try {
      List<Medicine> medicines =
          await HospitoqueRepository.getMedicines(keyword: '');
      emit(state.copyWith(medicines: medicines));
    } catch (e) {
      debugPrint('$_TAG error on list all: $e');
    }
  }
}
