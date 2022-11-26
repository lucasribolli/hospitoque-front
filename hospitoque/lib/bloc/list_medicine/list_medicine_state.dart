part of 'list_medicine_bloc.dart';

class ListMedicineState {
  List<Medicine> medicines;

  ListMedicineState._({
    required this.medicines,
  });

  factory ListMedicineState.initial() {
    return ListMedicineState._(
      medicines: []
    );
  }

  ListMedicineState copyWith({
    List<Medicine>? medicines,
  }) {
    return ListMedicineState._(
      medicines: medicines ?? this.medicines,
    );
  }

  @override
  String toString() => 'ListMedicineState(medicines: $medicines)';
}
