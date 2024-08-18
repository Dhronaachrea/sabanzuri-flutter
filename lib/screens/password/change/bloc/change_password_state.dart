part of 'change_password_bloc.dart';

@immutable
abstract class ChangePasswordState {}

class ChangePasswordInitial extends ChangePasswordState {}

class ChangingPassword extends ChangePasswordState {}

class ChangePasswordLoading extends ChangePasswordState {}

class ChangedPassword extends ChangePasswordState {
  final ChangePasswordResponseModel? changedPasswordResponse;

  ChangedPassword({required this.changedPasswordResponse});
}

class ChangePasswordError extends ChangePasswordState {
  final ChangePasswordResponseModel? changedPasswordResponse;

  ChangePasswordError({required this.changedPasswordResponse});
}
