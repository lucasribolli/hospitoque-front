import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart' show debugPrint, immutable;
import 'package:hospitoque/repositories/google_sign_in_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEventSignIn>(_onAuthEventSignIn);
  }

  Future<void> _onAuthEventSignIn(AuthEventSignIn event, emit) async {
    try {
      String? email = await GoogleSignInReposity.signIn();
      if(email != null) {
        
      }
    } on Exception catch(e) {
      debugPrint('_onAuthEventSignIn error: $e');
    }
  }
}
