part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {}

class BalanceRefresh extends ProfileEvent {
  final BuildContext context;

  BalanceRefresh({required this.context});
}

class UpdateAvatar extends ProfileEvent {
  final BuildContext context;
  final XFile xFile;

  UpdateAvatar({required this.context, required this.xFile});
}
