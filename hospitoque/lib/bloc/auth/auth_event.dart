part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class AuthEventSignIn extends AuthEvent {}

class AuthEventVerifyLogin extends AuthEvent {}

class AuthEventSignOut extends AuthEvent {}