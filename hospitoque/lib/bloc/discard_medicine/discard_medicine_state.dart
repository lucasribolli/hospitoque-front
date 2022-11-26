part of 'discard_medicine_bloc.dart';

class DiscardMedicineState {
  List<ExpirationMedicine> medicines;

  DiscardMedicineState._({
    required this.medicines,
  });

  factory DiscardMedicineState.initial() {
    return DiscardMedicineState._(medicines: []);
  }

  DiscardMedicineState copyWith({
    List<ExpirationMedicine>? medicines,
  }) {
    return DiscardMedicineState._(
      medicines: medicines ?? this.medicines,
    );
  }
}

class ExpirationMedicine {
  final Medicine medicine;
  final TimeToExpiration timeToExpiration;

  ExpirationMedicine({
    required this.medicine,
    required this.timeToExpiration,
  });
}

enum TimeToExpiration {
  past,
  sameWeek,
  sameMonth,
  nextMonthOrMore,
}
