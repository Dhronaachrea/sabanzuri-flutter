part of 'forgot_password_bloc.dart';

@immutable
abstract class ForgotPasswordState {}

class ForgotPasswordInitial extends ForgotPasswordState {}

class SendingOtp extends ForgotPasswordState {}

class VerifyingOtp extends ForgotPasswordState {}

class SentOtp extends ForgotPasswordState {
  final ChangePasswordResponseModel passwordResponseModel;

  SentOtp({required this.passwordResponseModel});
}

class VerifiedOtp extends ForgotPasswordState {
  final ChangePasswordResponseModel passwordResponseModel;

  VerifiedOtp({required this.passwordResponseModel});
}

class SendOtpError extends ForgotPasswordState {
  final ChangePasswordResponseModel passwordResponseModel;

  SendOtpError({required this.passwordResponseModel});
}

class VerifyOtpError extends ForgotPasswordState {
  final ChangePasswordResponseModel passwordResponseModel;

  VerifyOtpError({required this.passwordResponseModel});
}
