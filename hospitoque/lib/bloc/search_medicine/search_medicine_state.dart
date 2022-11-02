part of 'search_medicine_bloc.dart';

class SearchMedicineState {
  List<Medicine> medicines;

  SearchMedicineState({
    this.medicines = const [],
  });

  SearchMedicineState copyWith({
    List<Medicine>? medicines,
  }) {
    return SearchMedicineState(
      medicines: medicines ?? this.medicines,
    );
  }

  @override
  String toString() => 'SearchMedicineState(medicines: $medicines)';
}
