part of 'registration_bloc.dart';

@immutable
abstract class RegistrationState {}

class RegistrationInitial extends RegistrationState {}

class Registering extends RegistrationState {}

class RegistrationError extends RegistrationState {
  final RegistrationResponse? registrationResponse;

  RegistrationError({required this.registrationResponse});
}

class Registered extends RegistrationState {
  final RegistrationResponse? registrationResponse;

  Registered({required this.registrationResponse});
}
