part of 'forgot_password_bloc.dart';

@immutable
abstract class ForgotPasswordEvent {}

class SendOtp extends ForgotPasswordEvent {
  final BuildContext context;
  final String mobNumber;

  SendOtp({required this.context, required this.mobNumber});
}

class VerifyPassOtp extends ForgotPasswordEvent {
  final BuildContext context;
  final String otp;
  final String password;
  final String confPassword;
  final String mobNumber;

  VerifyPassOtp({
    required this.context,
    required this.otp,
    required this.password,
    required this.confPassword,
    required this.mobNumber,
  });
}

class CancelOtpVerification extends ForgotPasswordEvent {}
