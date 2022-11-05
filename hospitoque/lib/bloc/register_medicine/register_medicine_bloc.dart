import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

part 'register_medicine_event.dart';
part 'register_medicine_state.dart';

class RegisterMedicineBloc
    extends Bloc<RegisterMedicineEvent, RegisterMedicineState> {
  RegisterMedicineBloc() : super(_getInitialState()) {
    on<RegisterMedicineResetEvent>(onResetEvent);
    on<RegisterMedicineChangeNameEvent>(onChangeNameEvent);
    on<RegisterMedicineChangeManufacturerEvent>(onChangeManufacturerEvent);
    on<RegisterMedicineChangeLastCompositionEvent>(
        onChangeLastCompositionEvent);
    on<RegisterMedicineAddCompositionEvent>(onAddCompositionEvent);
    on<RegisterMedicineDeleteCompositionEvent>(onDeleteCompositionEvent);
    on<RegisterMedicineChangeLastVariantEvent>(
        onChangeLastCompositionEvent);
    on<RegisterMedicineAddVariantEvent>(onAddCompositionEvent);
    on<RegisterMedicineDeleteVariantEvent>(onDeleteCompositionEvent);
  }

  void onResetEvent(
      RegisterMedicineResetEvent event, Emitter<RegisterMedicineState> emit) {
    emit(_getInitialState());
  }

  void onChangeNameEvent(RegisterMedicineChangeNameEvent event, emit) {
    emit(state.copyWith(name: event.name));
  }

  void onChangeManufacturerEvent(
      RegisterMedicineChangeManufacturerEvent event, emit) {
    emit(state.copyWith(manufacturer: event.manufacturer));
  }

  void onChangeLastCompositionEvent(event, emit) {
    List<RegisterMedicineField<String>> list;
    if(event is RegisterMedicineChangeLastCompositionEvent) {
      list = state.composition;
    } else {
      list = state.variant;
    }
    RegisterMedicineField<String> updated = list.last.copyWith(value: event.value);
    list.removeLast();
    list.add(updated);
    emit(state.copyWith(composition: list));
  }

  void onAddCompositionEvent(event, emit) {
    List<RegisterMedicineField<String>> list;
    if(event is RegisterMedicineAddCompositionEvent) {
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
    RegisterMedicineField<String> freshComposition =
        RegisterMedicineField<String>.initial(
      '',
      id: DateTime.now().millisecondsSinceEpoch.toString(),
    );
    list.add(freshComposition);
    emit(state.copyWith(composition: list));
  }

  void onDeleteCompositionEvent(event, emit) {
    List<RegisterMedicineField<String>> list;
    if(event is RegisterMedicineDeleteCompositionEvent) {
      list = state.composition;
    } else {
      list = state.variant;
    }
    var composition = state.composition;
    list.remove(event.field);
    emit(state.copyWith(composition: composition));
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
