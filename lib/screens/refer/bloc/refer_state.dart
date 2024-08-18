part of 'refer_bloc.dart';

@immutable
abstract class ReferState {}

class ReferInitial extends ReferState {}

class Inviting extends ReferState {}

class Invited extends ReferState {
  final ChangePasswordResponseModel response;

  Invited({required this.response});
}

class InvitationError extends ReferState {
  final ChangePasswordResponseModel response;

  InvitationError({required this.response});
}

class TrackingStatus extends ReferState {}

class TrackedStatus extends ReferState {
  final TrackStatusResponseModel response;

  TrackedStatus({required this.response});
}

class TrackStatusError extends ReferState {
  final TrackStatusResponseModel response;

  TrackStatusError({required this.response});
}
