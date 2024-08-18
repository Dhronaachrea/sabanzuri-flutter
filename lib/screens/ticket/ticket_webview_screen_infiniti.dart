import 'package:flutter/material.dart';
import 'package:sabanzuri/utils/app_constants.dart';
import 'package:sabanzuri/utils/url.dart';
import 'package:sabanzuri/utils/user_info.dart';
import 'package:sabanzuri/widgets/drawer_web_view.dart';

class TicketWebViewScreen extends StatefulWidget {
  final Map<String, dynamic> ticketDetail;

  const TicketWebViewScreen({Key? key, required this.ticketDetail}) : super(key: key);

  @override
  State<TicketWebViewScreen> createState() => _TicketWebViewScreenState();
}

class _TicketWebViewScreenState extends State<TicketWebViewScreen> {
  String gameUrl = Url.GAME_BASE_URL;

  @override
  Widget build(BuildContext context) {
    String gameType       = widget.ticketDetail["gameType"];
    String gameName       = widget.ticketDetail["gameName"];
    String transactionId  = widget.ticketDetail["transactionId"];
    String ticketNo       = widget.ticketDetail["refTxnNo"];
    // String url = "$gameUrl/dge/results/${UserInfo.userId}/${UserInfo.userName}/${UserInfo.userToken}/${UserInfo.totalBalance}/${AppConstants.language}/${AppConstants.currencyCode}/${AppConstants.currencyDisplayCode}/${AppConstants.domainName}/${AppConstants.mobilePlatform}";
    String url;

    var bingoGameNameList = ["Classic 75", "Elegant 90", "Fortune 90", "Power Bingo 75", "Power Bingo 90", "Super 75"];

    //https://games-wls.infinitilotto.com/bingo/view-ticket/0/1882502/1806/757575352/8e4668115fdb00ed7c2cc6fc03a1ae74/15167/en/EUR/EUR/ice.igamew.com/1
    // https://dm-node1-wls.infinitilotto.com/sle/view-ticket/0/1882502/1806/757575352/8e4668115fdb00ed7c2cc6fc03a1ae74/15167/en/EUR/EUR/ice.igamew.com/1

    if (bingoGameNameList.contains(gameName)) {
      //https://games-wls.infinitilotto.com/bingo/view-ticket/0/1882502/1806/757575352/8e4668115fdb00ed7c2cc6fc03a1ae74/15167/en/EUR/EUR/ice.igamew.com/1
      url = "$gameUrl/bingo/view-ticket/0/$transactionId/${UserInfo.userId == '' ? '-' : UserInfo.userId}/${UserInfo.userName == '' ? '-' : UserInfo.userName}/${UserInfo.userToken == '' ? '-' : UserInfo.userToken}/${UserInfo.totalBalance}/${AppConstants.language}/${(UserInfo.currencyDisplayCode.isNotEmpty ? UserInfo.currencyDisplayCode : "EUR")}/${(UserInfo.currencyDisplayCode.isNotEmpty ? UserInfo.currencyDisplayCode : "EUR")}/${AppConstants.domainNameInfiniti}/1";


    } else {
      switch(gameType) {
        case "dge":
        //https://games-wls.infinitilotto.com/dge/results/1734/747474573/rynK2V0Aqr9h0Bm1hOSyb0iGpmeOULiHEoJvuTTrsPM/0.00/en/EUR/EUR/ice.igamew.com/1
          url = "$gameUrl/dge/view-ticket/0/$transactionId/${UserInfo.userId == '' ? '-' : UserInfo.userId}/${UserInfo.isLoggedIn() ? UserInfo.userName == '' ? UserInfo.mobNumber : UserInfo.userName : "-"}/${UserInfo.userToken == '' ? '-' : UserInfo.userToken}/${UserInfo.cashBalance.isNotEmpty ? UserInfo.cashBalance : "-"}/${AppConstants.language}/${(UserInfo.currencyDisplayCode.isNotEmpty ? UserInfo.currencyDisplayCode : "EUR")}/${(UserInfo.currencyDisplayCode.isNotEmpty ? UserInfo.currencyDisplayCode : "EUR")}/${AppConstants.domainNameInfiniti}/1";
          break;
        case "sle":
          // https://dm-node1-wls.infinitilotto.com/sle/view-ticket/16730072715332000187701/1882616/1582/789654321/4EErdAOZh2qqzZq6AAWHgtDE9h6L1UwDhsCvJlfLOCo/1301.49/en/BTC/BTC/ice.igamew.com/1
        //https://games-wls.infinitilotto.com/bingo/results/1734/747474573/rynK2V0Aqr9h0Bm1hOSyb0iGpmeOULiHEoJvuTTrsPM/0.00/en/EUR/EUR/ice.igamew.com/1
          gameUrl = Url.SPORT_LOTTY_WEB_BASE_URL;
          url = "$gameUrl/sle/view-ticket/$ticketNo/$transactionId/${UserInfo.userId == '' ? '-' : UserInfo.userId}/${UserInfo.isLoggedIn() ? UserInfo.userName == '' ? UserInfo.mobNumber : UserInfo.userName : "-"}/${UserInfo.userToken == '' ? '-' : UserInfo.userToken}/${UserInfo.cashBalance.isNotEmpty ? UserInfo.cashBalance : "-"}/${AppConstants.language}/${(UserInfo.currencyDisplayCode.isNotEmpty ? UserInfo.currencyDisplayCode : "EUR")}/${(UserInfo.currencyDisplayCode.isNotEmpty ? UserInfo.currencyDisplayCode : "EUR")}/${AppConstants.domainNameInfiniti}/1";
          break;
        default:
        //https://games-wls.infinitilotto.com/dge/results/1734/747474573/rynK2V0Aqr9h0Bm1hOSyb0iGpmeOULiHEoJvuTTrsPM/0.00/en/EUR/EUR/ice.igamew.com/1
          url = "$gameUrl/$gameType/view-ticket/0/$transactionId/${UserInfo.userId == '' ? '-' : UserInfo.userId}/${UserInfo.userName == '' ? '-' : UserInfo.userName}/${UserInfo.userToken == '' ? '-' : UserInfo.userToken}/${UserInfo.cashBalance.isNotEmpty ? UserInfo.cashBalance : "-"}/${AppConstants.language}/${(UserInfo.currencyDisplayCode.isNotEmpty ? UserInfo.currencyDisplayCode : "EUR")}/${(UserInfo.currencyDisplayCode.isNotEmpty ? UserInfo.currencyDisplayCode : "EUR")}/${AppConstants.domainNameInfiniti}/1";

      }
    }


    return DrawerWebView(
      url: url,
    );
  }
}
