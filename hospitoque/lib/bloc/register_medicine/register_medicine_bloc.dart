import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'register_medicine_event.dart';
part 'register_medicine_state.dart';

class RegisterMedicineBloc extends Bloc<RegisterMedicineEvent, RegisterMedicineState> {
  RegisterMedicineBloc() : super(RegisterMedicineInitial()) {
    on<RegisterMedicineEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
