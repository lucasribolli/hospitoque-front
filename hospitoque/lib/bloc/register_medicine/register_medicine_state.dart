part of 'register_medicine_bloc.dart';

class RegisterMedicineState {
  final String name;
  final String manufacturer;
  final List<RegisterMedicineField<String>> composition;
  final List<RegisterMedicineField<String>> variant;

  factory RegisterMedicineState.initial() {
    return RegisterMedicineState(
      name: '',
      manufacturer: '',
      composition: [
        RegisterMedicineField.initial(''),
      ],
      variant: [
        RegisterMedicineField.initial(''),
      ],
    );
  }

  RegisterMedicineState({
    required this.name,
    required this.manufacturer,
    required this.composition,
    required this.variant,
  });

  RegisterMedicineState copyWith({
    String? name,
    String? manufacturer,
    List<RegisterMedicineField<String>>? composition,
    List<RegisterMedicineField<String>>? variant,
  }) {
    return RegisterMedicineState(
      name: name ?? this.name,
      manufacturer: manufacturer ?? this.manufacturer,
      composition: composition ?? this.composition,
      variant: variant ?? this.variant,
    );
  }

  @override
  String toString() {
    return 'RegisterMedicineState(name: $name, manufacturer: $manufacturer, composition: $composition, variant: $variant)';
  }
}

class RegisterMedicineField<T> {
  final T value;
  final bool enabled;
  final String? id;

  RegisterMedicineField({
    required this.value,
    required this.enabled,
    this.id,
  });

  factory RegisterMedicineField.initial(
    T initialValue, {
    String? id,
  }) =>
      RegisterMedicineField(
        enabled: true,
        value: initialValue,
        id: id,
      );

  RegisterMedicineField<T> copyWith({
    T? value,
    bool? enabled,
    String? id,
  }) {
    return RegisterMedicineField<T>(
      value: value ?? this.value,
      enabled: enabled ?? this.enabled,
      id: id ?? this.id,
    );
  }

  @override
  String toString() =>
      'RegisterMedicineField(value: $value, enabled: $enabled, id: $id)';
}
