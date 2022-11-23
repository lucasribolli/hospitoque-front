part of 'register_medicine_bloc.dart';

@immutable
abstract class RegisterMedicineEvent {}

class ResetRegisterMedicineEvent implements RegisterMedicineEvent {}

class ChangeNameRegisterMedicineEvent implements RegisterMedicineEvent {
  final String name;

  ChangeNameRegisterMedicineEvent(this.name);
}

class ChangeManufacturerRegisterMedicineEvent implements RegisterMedicineEvent {
  final String manufacturer;

  ChangeManufacturerRegisterMedicineEvent(this.manufacturer);
}

class ChangeAvailableRegisterMedicineEvent implements RegisterMedicineEvent {
  final String available;

  ChangeAvailableRegisterMedicineEvent(this.available);
}

// Composition events
class ChangeLastCompositionRegisterMedicineEvent implements RegisterMedicineEvent {
  final String value;

  ChangeLastCompositionRegisterMedicineEvent(this.value);
}

class ChangeExpirationDateRegisterMedicineEvent implements RegisterMedicineEvent {
  final DateTime value;

  ChangeExpirationDateRegisterMedicineEvent(this.value);
}

class AddCompositionRegisterMedicineEvent implements RegisterMedicineEvent {}

class DeleteCompositionRegisterMedicineEvent implements RegisterMedicineEvent {
  final RegisterMedicineField field;

  DeleteCompositionRegisterMedicineEvent(this.field);
}

// Variant events
class ChangeLastVariantRegisterMedicineEvent implements RegisterMedicineEvent {
  final String value;

  ChangeLastVariantRegisterMedicineEvent(this.value);
}

class AddVariantRegisterMedicineEvent implements RegisterMedicineEvent {}

class DeleteVariantRegisterMedicineEvent implements RegisterMedicineEvent {
  final RegisterMedicineField field;

  DeleteVariantRegisterMedicineEvent(this.field);
}

class NextClickRegisterMedicineEvent implements RegisterMedicineEvent {
  final BuildContext? context;

  NextClickRegisterMedicineEvent({this.context});
}