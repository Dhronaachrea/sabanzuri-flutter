part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class Logging extends LoginState {}

class LoginError extends LoginState {
  final String errorMessage;

  LoginError({required this.errorMessage});
}

class LoggedIn extends LoginState {
  final RegistrationResponse? response;

  LoggedIn({required this.response});
}
