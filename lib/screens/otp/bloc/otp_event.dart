part of 'otp_bloc.dart';

abstract class OtpEvent {}

class GetOtp extends OtpEvent {
  final String mobNumber;

  GetOtp({
    required this.mobNumber,
  });
}

class GetCountryList extends OtpEvent {}

class RegisterCheckMobileNoAvailabilityEvent extends OtpEvent {
  String mobileNo;
  BuildContext context;

  RegisterCheckMobileNoAvailabilityEvent({required this.context,required this.mobileNo});
}