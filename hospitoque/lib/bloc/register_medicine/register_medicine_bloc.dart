import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'register_medicine_event.dart';
part 'register_medicine_state.dart';

class RegisterMedicineBloc extends Bloc<RegisterMedicineEvent, RegisterMedicineState> {
  RegisterMedicineBloc() : super(RegisterMedicineState.initial()) {
    on<RegisterMedicineEvent>((event, emit) {
      
    });
  }
}
