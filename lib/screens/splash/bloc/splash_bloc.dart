import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:sabanzuri/model/response/version_response.dart';
import 'package:sabanzuri/repo/repository.dart';
import 'package:sabanzuri/utils/app_constants.dart';
import 'package:sabanzuri/utils/screens.dart';
import 'package:sabanzuri/utils/utils.dart';
import 'package:sabanzuri/widgets/popup/version/version_alert.dart';
import 'package:sabanzuri/utils/user_info.dart';
import 'package:sabanzuri/utils/app_data.dart';

part 'splash_event.dart';

part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<CheckVersion>(_checkVersion);
  }

  _checkVersion(CheckVersion event, Emitter<SplashState> emit) async {
    BuildContext context = event.context;
    // BlocProvider.of<SabanzuriVersionCubit>(context).getVersion();
    // var appVersion =context.read<SabanzuriVersionCubit>().state.appVersion;
    var appVersion = await getVersion();
    Map<String, dynamic> request = {
      "appType": AppConstants.appType,
      "currAppVer": appVersion,
      "domainName": AppConstants.domainName,
      "os": AppConstants.os,
      "playerToken": UserInfo.userToken,
    };
    VersionResponse? response = await Repository.version(request);
    if (response != null) {
      if (response.errorCode == 0) {
        AppData.setVersionResponse(jsonEncode(response));
        if (response.appDetails!.isUpdateAvailable!) {
          String message = response.appDetails!.message ?? '';
          if (response.appDetails!.mandatory == true) {
            VersionAlert.show(
              context: context,
              type: VersionAlertType.mandatory,
              message: message,
              onUpdate: () {
                downloadNewVersion(response.appDetails!.url!, context);
              },
            );
          } else {
            VersionAlert.show(
              context: context,
              type: VersionAlertType.optional,
              message: message,
              onUpdate: () {
                downloadNewVersion(response.appDetails!.url!, context);
              },
              onCancel: () {
                Navigator.pushReplacementNamed(context, Screen.home_screen);
              },
            );
          }
        } else {
          Timer(const Duration(seconds: 2), () {
            Navigator.pushReplacementNamed(context, Screen.home_screen);
          });
        }
      }
    }
  }

  downloadNewVersion(String url, context) async {
    await FlutterDownloader.enqueue(
      url: url,
      savedDir: '/storage/emulated/0/Download/',
      showNotification: true,
      openFileFromNotification: true,
      saveInPublicStorage: true,
    );
  }
}
