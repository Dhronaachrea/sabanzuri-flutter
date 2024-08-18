part of 'sabanzuri_version_cubit.dart';

abstract class SabanzuriVersionState {
  String appVersion = "0.0.0";

  SabanzuriVersionState({required this.appVersion});
}

class SabanzuriVersionInitial extends SabanzuriVersionState {
  SabanzuriVersionInitial({required String appVersion})
      : super(appVersion: appVersion);
}

class SabanzuriVersionLoading extends SabanzuriVersionState {
  SabanzuriVersionLoading({required String appVersion})
      : super(appVersion: appVersion);
}

class SabanzuriVersionLoaded extends SabanzuriVersionState {
  @override
  final String appVersion;

  SabanzuriVersionLoaded({required this.appVersion})
      : super(appVersion: appVersion);
}
