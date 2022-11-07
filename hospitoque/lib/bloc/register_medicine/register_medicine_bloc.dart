import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart'
    show Navigator, BuildContext, debugPrint, immutable;
import 'package:hospitoque/model/medicine.dart';
import 'package:hospitoque/repositories/repository.dart';
import 'package:hospitoque/ui/routes.dart';

part 'register_medicine_event.dart';
part 'register_medicine_state.dart';

class RegisterMedicineBloc
    extends Bloc<RegisterMedicineEvent, RegisterMedicineState> {
  RegisterMedicineBloc() : super(_getInitialState()) {
    on<ResetRegisterMedicineEvent>(_onResetEvent);
    on<ChangeNameRegisterMedicineEvent>(_onChangeNameEvent);
    on<ChangeManufacturerRegisterMedicineEvent>(_onChangeManufacturerEvent);
    on<ChangeAvailableRegisterMedicineEvent>(_onChangeAvailableEvent);
    on<ChangeLastCompositionRegisterMedicineEvent>(_onChangeLastItemEvent);
    on<AddCompositionRegisterMedicineEvent>(_onAddEvent);
    on<DeleteCompositionRegisterMedicineEvent>(_onDeleteEvent);
    on<ChangeLastVariantRegisterMedicineEvent>(_onChangeLastItemEvent);
    on<AddVariantRegisterMedicineEvent>(_onAddEvent);
    on<DeleteVariantRegisterMedicineEvent>(_onDeleteEvent);
    on<NextClickRegisterMedicineEvent>(_onNextStatus);
  }

  void _onResetEvent(
      ResetRegisterMedicineEvent event, Emitter<RegisterMedicineState> emit) {
    emit(_getInitialState());
  }

  void _onChangeNameEvent(ChangeNameRegisterMedicineEvent event, emit) {
    emit(state.copyWith(name: event.name));
  }

  void _onChangeManufacturerEvent(
      ChangeManufacturerRegisterMedicineEvent event, emit) {
    emit(state.copyWith(manufacturer: event.manufacturer));
  }

  void _onChangeAvailableEvent(
    ChangeAvailableRegisterMedicineEvent event, emit
  ) {
    emit(state.copyWith(available: event.available));
  }

  void _onChangeLastItemEvent(event, emit) {
    List<RegisterMedicineField<String>> list;
    var isComposition = event is ChangeLastCompositionRegisterMedicineEvent;
    if (isComposition) {
      list = state.composition;
    } else {
      list = state.variant;
    }
    RegisterMedicineField<String> updated =
        list.last.copyWith(value: event.value);
    list.removeLast();
    list.add(updated);
    var newState = state.copyWith(
      composition: isComposition ? list : state.composition,
      variant: !isComposition ? list : state.variant,
    );
    emit(newState);
  }

  void _onAddEvent(event, emit) {
    List<RegisterMedicineField<String>> list;
    var isComposition = event is AddCompositionRegisterMedicineEvent;
    if (isComposition) {
      list = state.composition;
    } else {
      list = state.variant;
    }
    RegisterMedicineField<String> last = list.last;
    if (last.value.isEmpty) {
      return;
    }
    RegisterMedicineField<String> updated = last.copyWith(enabled: false);
    list.removeLast();
    list.add(updated);
    RegisterMedicineField<String> freshItem =
        RegisterMedicineField<String>.initial(
      '',
      id: DateTime.now().millisecondsSinceEpoch.toString(),
    );
    list.add(freshItem);
    var newState = state.copyWith(
      composition: isComposition ? list : state.composition,
      variant: !isComposition ? list : state.variant,
    );
    emit(newState);
  }

  void _onDeleteEvent(event, emit) {
    List<RegisterMedicineField<String>> list;
    var isComposition = event is DeleteCompositionRegisterMedicineEvent;
    if (isComposition) {
      list = state.composition;
    } else {
      list = state.variant;
    }
    list.remove(event.field);
    var newState = state.copyWith(
      composition: isComposition ? list : state.composition,
      variant: !isComposition ? list : state.variant,
    );
    emit(newState);
  }

  Future<void> _onNextStatus(event, emit) async {
    switch (state.status) {
      case RegisterMedicineCurrentStatus.initial:
        _onNextOfInitialStatus(emit);
        break;
      case RegisterMedicineCurrentStatus.confirmation:
        await _onNextOfConfirmationStatus(emit);
        break;
      case RegisterMedicineCurrentStatus.successful:
        _onNextOfSucessfulStatus(event, emit);
        break;
    }
  }

  void _onNextOfInitialStatus(Emitter<RegisterMedicineState> emit) {
    bool isValid = _verifyFields();
    debugPrint('isValid -> $isValid');
    // TODO add validation
    if (!isValid) {
      return;
    }
    Medicine medicine = Medicine(
      available: int.tryParse(state.available) ?? 0,
      composition: state.composition
          .where((field) => !field.enabled)
          .map((c) => c.value)
          .toList(),
      variant: state.composition
          .where((field) => !field.enabled)
          .map((v) => v.value)
          .toList(),
      name: state.name,
      manufacturer: state.manufacturer,
    );
    emit(state.copyWith(
      status: RegisterMedicineCurrentStatus.confirmation,
      medicine: medicine,
    ));
  }

  bool _verifyFields() {
    if (state.name.isEmpty ||
        state.manufacturer.isEmpty ||
        state.composition.isEmpty ||
        state.variant.isEmpty) {
      return false;
    }
    return true;
  }

  Future<void> _onNextOfConfirmationStatus(
      Emitter<RegisterMedicineState> emit) async {
    await HospitoqueRepository.addMedicine(state.medicine!);
    emit(state.copyWith(status: RegisterMedicineCurrentStatus.successful));
  }

  void _onNextOfSucessfulStatus(
    NextClickRegisterMedicineEvent event,
    Emitter<RegisterMedicineState> emit,
  ) {
    Navigator.of(event.context!).pushNamedAndRemoveUntil(
      HospitoqueRouter.HOME_ROUTE,
      (route) => false,
    );
  }
}

RegisterMedicineState _getInitialState() {
  final now = DateTime.now().millisecondsSinceEpoch;
  var initialState = RegisterMedicineState.initial();
  var initialComposition = [
    RegisterMedicineField.initial('', id: now.toString())
  ];
  var initialVariant = [
    RegisterMedicineField.initial('', id: (now + 1).toString())
  ];
  return initialState.copyWith(
    composition: initialComposition,
    variant: initialVariant,
  );
}
