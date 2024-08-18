import 'package:bloc/bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';

part 'sabanzuri_version_state.dart';

class SabanzuriVersionCubit extends Cubit<SabanzuriVersionState> {
  String appVersion = "0.0.0";

  SabanzuriVersionCubit() : super(SabanzuriVersionInitial(appVersion: "0.0.0"));

  getVersion() async {
    emit(SabanzuriVersionLoading(appVersion: appVersion));
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;
    appVersion = '$version+$buildNumber';
    emit(SabanzuriVersionLoaded(appVersion: appVersion));
  }
}
