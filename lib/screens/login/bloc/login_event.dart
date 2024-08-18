part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class Login extends LoginEvent {
  final String mobNumber;
  final String password;
  final BuildContext context;

  Login({
    required this.mobNumber,
    required this.password,
    required this.context,
  });
}
