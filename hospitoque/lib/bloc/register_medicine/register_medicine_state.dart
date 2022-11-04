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
      variant: [],
      composition: [],
    );
  }

  RegisterMedicineState({
    required this.name,
    required this.manufacturer,
    required this.composition,
    required this.variant,
  });
}

class RegisterMedicineField<T> {
  final T value;
  final bool enabled;

  RegisterMedicineField({
    required this.value,
    required this.enabled,
  });
}
