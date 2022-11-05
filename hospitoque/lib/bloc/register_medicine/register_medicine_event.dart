part of 'register_medicine_bloc.dart';

@immutable
abstract class RegisterMedicineEvent {}

class RegisterMedicineResetEvent implements RegisterMedicineEvent {}

class RegisterMedicineChangeNameEvent implements RegisterMedicineEvent {
  final String name;

  RegisterMedicineChangeNameEvent(this.name);
}

class RegisterMedicineChangeManufacturerEvent implements RegisterMedicineEvent {
  final String manufacturer;

  RegisterMedicineChangeManufacturerEvent(this.manufacturer);
}

// Composition events
class RegisterMedicineChangeLastCompositionEvent implements RegisterMedicineEvent {
  final String value;

  RegisterMedicineChangeLastCompositionEvent(this.value);
}

class RegisterMedicineAddCompositionEvent implements RegisterMedicineEvent {}

class RegisterMedicineDeleteCompositionEvent implements RegisterMedicineEvent {
  final RegisterMedicineField field;

  RegisterMedicineDeleteCompositionEvent(this.field);
}

// Variant events
class RegisterMedicineChangeLastVariantEvent implements RegisterMedicineEvent {
  final String value;

  RegisterMedicineChangeLastVariantEvent(this.value);
}

class RegisterMedicineAddVariantEvent implements RegisterMedicineEvent {}

class RegisterMedicineDeleteVariantEvent implements RegisterMedicineEvent {
  final RegisterMedicineField field;

  RegisterMedicineDeleteVariantEvent(this.field);
}