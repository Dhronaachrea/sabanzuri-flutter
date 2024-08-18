part of 'update_profile_bloc.dart';

@immutable
abstract class UpdateProfileState {}

class UpdateProfileInitial extends UpdateProfileState {}

class UpdatingProfile extends UpdateProfileState {}

class UpdatedProfile extends UpdateProfileState {
  final String successMsg;

  UpdatedProfile({required this.successMsg});
}

class UpdateProfileError extends UpdateProfileState {
  final String errorMsg;

  UpdateProfileError({required this.errorMsg});
}

class GetOtpSuccess extends UpdateProfileState {
  final String msg;
  final bool isResendOtp;
  GetOtpSuccess({required this.msg, required this.isResendOtp});
}

class GetResendOtpError extends UpdateProfileState {}


class GetConfigValueSuccess extends UpdateProfileState {
  final List<String> requiredFieldList;
  GetConfigValueSuccess(this.requiredFieldList);
}

class GetConfigValueError extends UpdateProfileState {
  final String? errorMessage;
  GetConfigValueError(this.errorMessage);
}
