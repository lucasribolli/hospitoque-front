import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

part 'register_medicine_event.dart';
part 'register_medicine_state.dart';

class RegisterMedicineBloc
    extends Bloc<RegisterMedicineEvent, RegisterMedicineState> {
  RegisterMedicineBloc() : super(_getInitialState()) {
    on<ResetRegisterMedicineEvent>(onResetEvent);
    on<ChangeNameRegisterMedicineEvent>(onChangeNameEvent);
    on<ChangeManufacturerRegisterMedicineEvent>(onChangeManufacturerEvent);
    on<ChangeLastCompositionRegisterMedicineEvent>(
        onChangeLastItemEvent);
    on<AddCompositionRegisterMedicineEvent>(onAddEvent);
    on<DeleteCompositionRegisterMedicineEvent>(onDeleteEvent);
    on<ChangeLastVariantRegisterMedicineEvent>(
        onChangeLastItemEvent);
    on<AddVariantRegisterMedicineEvent>(onAddEvent);
    on<DeleteVariantRegisterMedicineEvent>(onDeleteEvent);
  }

  void onResetEvent(
      ResetRegisterMedicineEvent event, Emitter<RegisterMedicineState> emit) {
    emit(_getInitialState());
  }

  void onChangeNameEvent(ChangeNameRegisterMedicineEvent event, emit) {
    emit(state.copyWith(name: event.name));
  }

  void onChangeManufacturerEvent(
      ChangeManufacturerRegisterMedicineEvent event, emit) {
    emit(state.copyWith(manufacturer: event.manufacturer));
  }

  void onChangeLastItemEvent(event, emit) {
    List<RegisterMedicineField<String>> list;
    var isComposition = event is ChangeLastCompositionRegisterMedicineEvent;
    if(isComposition) {
      list = state.composition;
    } else {
      list = state.variant;
    }
    RegisterMedicineField<String> updated = list.last.copyWith(value: event.value);
    list.removeLast();
    list.add(updated);
    var newState = state.copyWith(
      composition: isComposition ? list : state.composition,
      variant: !isComposition ? list : state.variant,
    );
    emit(newState);
  }

  void onAddEvent(event, emit) {
    List<RegisterMedicineField<String>> list;
    var isComposition = event is AddCompositionRegisterMedicineEvent;
    if(isComposition) {
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

  void onDeleteEvent(event, emit) {
    List<RegisterMedicineField<String>> list;
    var isComposition = event is DeleteCompositionRegisterMedicineEvent;
    if(isComposition) {
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
