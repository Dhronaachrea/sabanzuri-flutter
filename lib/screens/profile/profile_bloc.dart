import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:sabanzuri/l10n/l10n.dart';
import 'package:sabanzuri/model/response/get_balance_response.dart';
import 'package:sabanzuri/model/user/user.dart';
import 'package:sabanzuri/repo/repository.dart';
import 'package:sabanzuri/utils/app_constants.dart';
import 'package:sabanzuri/utils/auth/auth_bloc.dart';
import 'package:sabanzuri/utils/user_info.dart';
import 'package:sabanzuri/widgets/show_toast.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<BalanceRefresh>(_onBalanceRefresh);
    on<UpdateAvatar>(_onUpdateAvatar);
  }

  String? profileImage;

  FutureOr<void> _onBalanceRefresh(
      BalanceRefresh event, Emitter<ProfileState> emit) async {
    emit(BalanceRefreshing());
    BuildContext context = event.context;
    Map<String, dynamic> request = {
      "domainName": AppConstants.domainNameInfiniti,
      "playerId": UserInfo.userId,
      "playerToken": UserInfo.userToken,
    };
    GetBalanceResponse? response = await Repository.refreshBalance(request);
    if (response != null) {
      if (response.errorCode == 0) {
        emit(BalanceRefreshed());
        context.read<AuthBloc>().add(
              UpdateUserInfo(
                user: User(

                  totalBalance:
                      response.wallet?.totalBalance?.toStringAsFixed(2),
                  cashBalance: response.wallet?.withdrawableBal != 0.0 ? response.wallet?.withdrawableBal?.toStringAsFixed(2) : response.wallet?.cashBalance?.toStringAsFixed(2)//response.wallet?.cashBalance?.toStringAsFixed(2),
                ),
              ),
            );
        /*ShowToast.showToast(context.l10n.balanceUpdatedSuccessfully, context,
            type: ToastType.SUCCESS);*/
      } else {
        emit(BalanceRefreshError(response: response));
      }
    }
  }

  FutureOr<void> _onUpdateAvatar(
      UpdateAvatar event, Emitter<ProfileState> emit) async {
    BuildContext context = event.context;
    XFile xFile = event.xFile;
    Map<String, String> request = {
      "domainName": AppConstants.domainName,
      "playerId": UserInfo.userId,
      "playerToken": UserInfo.userToken,
      "isDefaultAvatar": "N",
    };
    var file = await http.MultipartFile.fromPath(
      "file",
      xFile.path,
      filename: xFile.name,
    );
    var response = await Repository.uploadAvatar(request, file);
    if (response != null) {
      if (response["errorCode"] == 0) {
        context.read<AuthBloc>().add(
              UpdateUserInfo(user: User(profileImage: response["avatarPath"])),
            );
        ShowToast.showToast(context.l10n.avatarUpdatedSuccessfully, context,
            type: ToastType.SUCCESS);
      } else {
        ShowToast.showToast(context.l10n.avatarUpdatingError, context,
            type: ToastType.ERROR);
      }
    }
  }
}
