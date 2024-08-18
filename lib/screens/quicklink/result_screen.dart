import 'package:flutter/material.dart';
import 'package:sabanzuri/utils/app_constants.dart';
import 'package:sabanzuri/utils/url.dart';
import 'package:sabanzuri/utils/user_info.dart';
import 'package:sabanzuri/widgets/drawer_web_view.dart';

class ResultScreen extends StatefulWidget {
  final String resultType;

  const ResultScreen({Key? key, required this.resultType}) : super(key: key);

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  String gameUrl = Url.GAME_BASE_URL;

  @override
  Widget build(BuildContext context) {
    // String url = "$gameUrl/dge/results/${UserInfo.userId}/${UserInfo.userName}/${UserInfo.userToken}/${UserInfo.totalBalance}/${AppConstants.language}/${AppConstants.currencyCode}/${AppConstants.currencyDisplayCode}/${AppConstants.domainName}/${AppConstants.mobilePlatform}";
    String url;
    print("resultType===========================>${widget.resultType}");
    print("UserInfo.userName===========================>${UserInfo.userName}");

    switch(widget.resultType) {
      case "dgeResult":
        //https://games-wls.infinitilotto.com/dge/results/1734/747474573/rynK2V0Aqr9h0Bm1hOSyb0iGpmeOULiHEoJvuTTrsPM/0.00/en/EUR/EUR/ice.igamew.com/1
        url = "$gameUrl/dge/results/${UserInfo.userId == '' ? '-' : UserInfo.userId}/${UserInfo.isLoggedIn() ? UserInfo.userName == '' ? UserInfo.mobNumber : UserInfo.userName : "-"}/${UserInfo.userToken == '' ? '-' : UserInfo.userToken}/${UserInfo.cashBalance.isNotEmpty ? UserInfo.cashBalance : "-"}/${AppConstants.language}/${(UserInfo.currencyDisplayCode.isNotEmpty ? UserInfo.currencyDisplayCode : "EUR")}/${(UserInfo.currencyDisplayCode.isNotEmpty ? UserInfo.currencyDisplayCode : "EUR")}/${AppConstants.domainNameInfiniti}/1";
        break;
      case "bingoResult":
        //https://games-wls.infinitilotto.com/bingo/results/1734/747474573/rynK2V0Aqr9h0Bm1hOSyb0iGpmeOULiHEoJvuTTrsPM/0.00/en/EUR/EUR/ice.igamew.com/1
        url = "$gameUrl/bingo/results/${UserInfo.userId == '' ? '-' : UserInfo.userId}/${UserInfo.isLoggedIn() ? UserInfo.userName == '' ? UserInfo.mobNumber : UserInfo.userName : "-"}/${UserInfo.userToken == '' ? '-' : UserInfo.userToken}/${UserInfo.cashBalance.isNotEmpty ? UserInfo.cashBalance : "-"}/${AppConstants.language}/${(UserInfo.currencyDisplayCode.isNotEmpty ? UserInfo.currencyDisplayCode : "EUR")}/${(UserInfo.currencyDisplayCode.isNotEmpty ? UserInfo.currencyDisplayCode : "EUR")}/${AppConstants.domainNameInfiniti}/1";
        break;
      case "sportLotteryResult":
        //https://dm-node1-wls.infinitilotto.com/sle/result/1806/757575352/8e4668115fdb00ed7c2cc6fc03a1ae74/15167/en/EUR/EUR/ice.igamew.com/1
        gameUrl = "https://dm-node1-wls.infinitilotto.com";
        url = "$gameUrl/sle/result/${UserInfo.userId == '' ? '-' : UserInfo.userId}/${UserInfo.isLoggedIn() ? UserInfo.userName == '' ? UserInfo.mobNumber : UserInfo.userName : "-"}/${UserInfo.userToken == '' ? '-' : UserInfo.userToken}/${UserInfo.cashBalance.isNotEmpty ? UserInfo.cashBalance : "-"}/${AppConstants.language}/${(UserInfo.currencyDisplayCode.isNotEmpty ? UserInfo.currencyDisplayCode : "EUR")}/${(UserInfo.currencyDisplayCode.isNotEmpty ? UserInfo.currencyDisplayCode : "EUR")}/${AppConstants.domainNameInfiniti}/1";
        break;
      default:
        url = "$gameUrl/dge/results/${UserInfo.userId == '' ? '-' : UserInfo.userId}/${UserInfo.isLoggedIn() ? UserInfo.userName == '' ? UserInfo.mobNumber : UserInfo.userName : "-"}/${UserInfo.userToken == '' ? '-' : UserInfo.userToken}/${UserInfo.cashBalance.isNotEmpty ? UserInfo.cashBalance : "-"}/${AppConstants.language}/${(UserInfo.currencyDisplayCode.isNotEmpty ? UserInfo.currencyDisplayCode : "EUR")}/${(UserInfo.currencyDisplayCode.isNotEmpty ? UserInfo.currencyDisplayCode : "EUR")}/${AppConstants.domainNameInfiniti}/1";
    }
    
    
    return DrawerWebView(
      url: url,
    );
  }
}
