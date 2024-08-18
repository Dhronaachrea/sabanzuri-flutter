part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class UserLogin extends AuthEvent {
  final RegistrationResponse registrationResponse;

  UserLogin({required this.registrationResponse});
}

class UserLogout extends AuthEvent {}

class AppStarted extends AuthEvent {}

class UpdateUserInfo extends AuthEvent {
  final User user;

  UpdateUserInfo({required this.user});
}
