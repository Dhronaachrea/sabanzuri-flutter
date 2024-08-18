part of 'update_profile_bloc.dart';

@immutable
abstract class UpdateProfileEvent {}

class OnUpdateProfile extends UpdateProfileEvent {
  final User user;
  final BuildContext context;

  OnUpdateProfile({required this.user, required this.context});
}

class GetOtpApi extends UpdateProfileEvent {
  final String? mobileNo;
  final BuildContext context;
  final bool isResendOtp;

  GetOtpApi({required this.context, required this.mobileNo, this.isResendOtp = false });
}

class GetConfigValueCallApiEvent extends UpdateProfileEvent {}
