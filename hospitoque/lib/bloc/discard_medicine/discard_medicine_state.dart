// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'discard_medicine_bloc.dart';

class DiscardMedicineState {
  List<DiscartableMedicine> medicines;

  DiscardMedicineState._({
    required this.medicines,
  });

  factory DiscardMedicineState.initial() {
    return DiscardMedicineState._(medicines: []);
  }

  DiscardMedicineState copyWith({
    List<DiscartableMedicine>? medicines,
  }) {
    return DiscardMedicineState._(
      medicines: medicines ?? this.medicines,
    );
  }
}

class DiscartableMedicine {
  final Medicine medicine;
  final TimeToExpiration timeToExpiration;
  final bool selected;

  DiscartableMedicine({
    required this.medicine,
    required this.timeToExpiration,
    this.selected = false,
  });

  DiscartableMedicine copyWith({
    bool? selected,
  }) {
    return DiscartableMedicine(
      medicine: medicine,
      timeToExpiration: timeToExpiration,
      selected: selected ?? this.selected,
    );
  }

  @override
  String toString() => 'DiscartableMedicine(medicine: $medicine, timeToExpiration: $timeToExpiration, selected: $selected)';

  @override
  bool operator ==(covariant DiscartableMedicine other) {
    if (identical(this, other)) return true;
  
    return 
      other.medicine == medicine &&
      other.timeToExpiration == timeToExpiration &&
      other.selected == selected;
  }

  @override
  int get hashCode => medicine.hashCode ^ timeToExpiration.hashCode ^ selected.hashCode;
}

enum TimeToExpiration {
  past,
  sameMonth,
  future,
}

extension Comparation on TimeToExpiration {
  get isInPast => this == TimeToExpiration.past;
  get isSameMonth => this == TimeToExpiration.sameMonth;
  get isInFuture => this == TimeToExpiration.future;
}