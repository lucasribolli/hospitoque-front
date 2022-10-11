import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart' show debugPrint, immutable;
import 'package:hospitoque/repositories/auth_repository.dart';
import 'package:hospitoque/repositories/google_sign_in_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitialState()) {
    on<AuthEventSignIn>(_onAuthEventSignIn);
  }

  Future<void> _onAuthEventSignIn(AuthEventSignIn event, emit) async {
    try {
      String? email = await GoogleSignInRepository.signIn();
      if(email != null) {
        bool isAuthorized = await AuthRepository.auth(email);
        if(isAuthorized) {
          emit(AuthSuccessState());
        } else {
          await GoogleSignInRepository.logout();
          emit(AuthUnauthorizedState());
        }
      }
    } on Exception catch(e) {
      debugPrint('_onAuthEventSignIn error: $e');
      emit(AuthFailureState());
    }
  }
}
