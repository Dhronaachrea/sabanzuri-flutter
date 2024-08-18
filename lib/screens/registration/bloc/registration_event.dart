part of 'registration_bloc.dart';

@immutable
abstract class RegistrationEvent {}

class Registration extends RegistrationEvent {
  final String mobNumber;
  final String password;
  final String otp;
  final String currencyCode;
  final String countryCode;
  final String referCode;
  final BuildContext context;

  Registration({
    required this.mobNumber,
    required this.password,
    required this.otp,
    required this.context,
    required this.currencyCode,
    required this.countryCode,
    required this.referCode,
  });
}

class RegistrationUsingScan extends RegistrationEvent {
  final String? username;
  final String? currencyCode;
  final String? countryCode;
  final String? data;
  final BuildContext context;

  RegistrationUsingScan({
    this.username,
    required this.context,
    this.currencyCode,
    this.countryCode,
    required this.data,
  });
}
