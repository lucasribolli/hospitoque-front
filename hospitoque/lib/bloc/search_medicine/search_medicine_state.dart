part of 'search_medicine_bloc.dart';

class SearchMedicineState {
  List<Medicine>? medicines = [];

  SearchMedicineState({
    this.medicines,
  });

  SearchMedicineState copyWith({
    List<Medicine>? medicines,
  }) {
    return SearchMedicineState(
      medicines: medicines ?? this.medicines,
    );
  }
}
