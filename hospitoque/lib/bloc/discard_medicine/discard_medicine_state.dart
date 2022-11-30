// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'discard_medicine_bloc.dart';

class DiscardMedicineState {
  final List<DiscartableMedicine> medicines;
  final DiscardMedicineStatus status;
  final String? reason;

  DiscardMedicineState._({
    required this.medicines,
    required this.status,
    this.reason,
  });

  factory DiscardMedicineState.initial() {
    return DiscardMedicineState._(
      medicines: [],
      status: DiscardMedicineStatus.select,
    );
  }

  DiscardMedicineState copyWith({
    List<DiscartableMedicine>? medicines,
    DiscardMedicineStatus? status,
    String? reason,
  }) {
    return DiscardMedicineState._(
      medicines: medicines ?? this.medicines,
      status: status ?? this.status,
      reason: reason ?? this.reason,
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
  String toString() =>
      'DiscartableMedicine(medicine: $medicine, timeToExpiration: $timeToExpiration, selected: $selected)';

  @override
  bool operator ==(covariant DiscartableMedicine other) {
    if (identical(this, other)) return true;

    return other.medicine == medicine &&
        other.timeToExpiration == timeToExpiration &&
        other.selected == selected;
  }

  @override
  int get hashCode =>
      medicine.hashCode ^ timeToExpiration.hashCode ^ selected.hashCode;
}

enum DiscardMedicineStatus {
  select,
  reason,
  deleted,
}

enum TimeToExpiration {
  past,
  sameMonth,
  future,
}

extension TimeComparation on TimeToExpiration {
  get isInPast => this == TimeToExpiration.past;
  get isSameMonth => this == TimeToExpiration.sameMonth;
  get isInFuture => this == TimeToExpiration.future;
}

extension StatusComparation on DiscardMedicineStatus {
  get isSelect => this == DiscardMedicineStatus.select;
  get isReason => this == DiscardMedicineStatus.reason;
  get isDeleted => this == DiscardMedicineStatus.deleted;
}
