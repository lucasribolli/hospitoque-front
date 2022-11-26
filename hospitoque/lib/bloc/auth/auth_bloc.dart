import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart' show debugPrint, immutable, kDebugMode;
import 'package:hospitoque/repositories/repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitialState()) {
    on<AuthEventSignIn>(_onAuthEventSignIn);
    on<AuthEventVerifyLogin>(_onVerifyLogin);
    on<AuthEventSignOut>(_onSignOut);
    add(AuthEventVerifyLogin());
  }

  Future<void> _onAuthEventSignIn(AuthEventSignIn event, emit) async {
    try {
      String? email = await HospitoqueRepository.signIn();
      if(email != null) {
        bool isAuthorized = await HospitoqueRepository.auth(email);
        if(isAuthorized) {
          await HospitoqueRepository.saveEmail(email);
          emit(AuthSuccessState());
        } else {
          await HospitoqueRepository.logout();
          emit(AuthUnauthorizedState());
        }
      }
    } on Exception catch(e) {
      debugPrint('_onAuthEventSignIn error: $e');
      emit(AuthFailureState());
    }
  }

  Future<void> _onVerifyLogin(event, emit) async {
    try {
      String? email = await HospitoqueRepository.getEmail();
      if(email == null && !kDebugMode) {
        emit(AuthUnauthorizedState());
      } else {
        emit(AuthSuccessState());
      }
    } on Exception catch (e) {
      emit(AuthUnauthorizedState());
    }
  }

  FutureOr<void> _onSignOut(AuthEventSignOut event, Emitter<AuthState> emit) async {
    await HospitoqueRepository.logout();
    emit(AuthUnauthorizedState());
  }
}
