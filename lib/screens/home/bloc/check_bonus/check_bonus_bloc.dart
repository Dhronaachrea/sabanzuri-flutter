import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:sabanzuri/model/response/CheckBonusStatusResponse.dart';
import 'package:sabanzuri/repo/repository.dart';
import 'package:sabanzuri/screens/home/bloc/check_bonus/check_bonus_event.dart';
import 'package:sabanzuri/screens/home/bloc/check_bonus/check_bonus_state.dart';
import 'package:sabanzuri/screens/home/bloc/ticker.dart';
import 'package:sabanzuri/utils/app_constants.dart';
import 'package:sabanzuri/utils/user_info.dart';


class CheckBonusBloc extends Bloc<CheckBonusEvent, CheckBonusState> {

  CheckBonusBloc() : super(CheckBonusInitial()) {
    on<CheckBonusCallApiEvent>(callCheckBonusApi);

  }

  callCheckBonusApi(CheckBonusCallApiEvent event, Emitter<CheckBonusState> emit) async{

    Map<String, dynamic> request = {
      "aliasName": AppConstants.domainNameInfiniti,
      "playerToken": UserInfo.userToken,
      "userId": UserInfo.userId
    };

    CheckBonusStatusResponse? response = await Repository.checkBonusStatus(request);

    if(response != null) {
      if(response.errorCode == 0){
        emit(CheckBonusSuccess(response.data));
      }
    } else {
      print("checkBonus ----------------> $response}");
    }

  }

}
