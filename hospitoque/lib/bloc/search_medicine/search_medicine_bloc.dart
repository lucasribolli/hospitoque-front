import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:hospitoque/model/medicine.dart';
import 'package:hospitoque/repositories/repository.dart';
import 'package:meta/meta.dart';

part 'search_medicine_event.dart';
part 'search_medicine_state.dart';

class SearchMedicineBloc extends Bloc<SearchMedicineEvent, SearchMedicineState> {
  SearchMedicineBloc() : super(SearchMedicineState()) {
    on<SearchMedicineEventKeyword>(_onSearchMedicineKeyword);
    on<SearchMedicineEventReset>(_onReset);
  }

  Future<void> _onSearchMedicineKeyword(SearchMedicineEventKeyword event, emit) async {
    try {
      String keyword = event.keyword;
      List<Medicine> medicines = await HospitoqueRepository.getMedicines();
      debugPrint('medicines with $keyword -> $medicines');
      emit(state.copyWith(medicines: medicines));
    } on Exception catch(e) {
      debugPrint('error on _onSearchMedicineKeyword: $e');
    }
  }

  void _onReset(event, emit) => emit(state.copyWith(medicines: []));
}
