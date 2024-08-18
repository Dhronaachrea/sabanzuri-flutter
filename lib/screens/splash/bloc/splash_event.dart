part of 'splash_bloc.dart';

@immutable
abstract class SplashEvent {}

class CheckVersion extends SplashEvent {
  final BuildContext context;

  CheckVersion(this.context);
}
