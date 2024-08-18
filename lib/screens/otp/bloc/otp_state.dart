part of 'otp_bloc.dart';

abstract class OtpState {}

class OtpInitial extends OtpState {}

class OtpRequesting extends OtpState {}

class OtpError extends OtpState {
  final OtpResponse otpResponse;

  OtpError({required this.otpResponse});
}

class OtpReceived extends OtpState {
  final OtpResponse otpResponse;

  OtpReceived({required this.otpResponse});
}

class GetCountryListLoading extends OtpState {}

class GetCountryListLoaded extends OtpState {
  final CountryListResponse countryListResponse;

  GetCountryListLoaded({required this.countryListResponse});
}

class GetCountryListError extends OtpState {
  final CountryListResponse countryListResponse;

  GetCountryListError({required this.countryListResponse});
}

class CheckMobileNoAvailabilityLoading extends OtpState {}

class CheckMobileNoAvailabilityError extends OtpState {
  String? errorMessage;

  CheckMobileNoAvailabilityError({required this.errorMessage});
}
