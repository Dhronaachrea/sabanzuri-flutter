part of 'change_password_bloc.dart';

@immutable
abstract class ChangePasswordEvent {}

class ChangePassword extends ChangePasswordEvent {
  final BuildContext context;
  final String oldPassword;
  final String newPassword;

  ChangePassword({
    required this.context,
    required this.oldPassword,
    required this.newPassword,
  });
}

class InitialChangePassword extends ChangePasswordEvent {
  final BuildContext context;
  final String newPassword;

  InitialChangePassword({
    required this.context,
    required this.newPassword,
  });
}
