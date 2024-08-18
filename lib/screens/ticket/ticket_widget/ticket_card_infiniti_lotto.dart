import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sabanzuri/l10n/l10n.dart';
import 'package:sabanzuri/model/response/ticket_detail_infiniti_lotto_response.dart';
import 'package:sabanzuri/screens/lobby/lobby_model/ige_game_response.dart' as igeNewResponse;
import 'package:sabanzuri/screens/lobby/lobby_model/ige_game_response.dart';
import 'package:sabanzuri/screens/theme/cubit/switch_cubit.dart';
import 'package:sabanzuri/utils/app_data.dart';
import 'package:sabanzuri/utils/date_format.dart';
import 'package:sabanzuri/utils/sabanzuri_colors.dart';
import 'package:sabanzuri/utils/user_info.dart';
import 'package:sabanzuri/utils/utils.dart';
import 'package:velocity_x/velocity_x.dart';

class TicketCardInfinitiLotto extends StatefulWidget {
  final TicketList ticketList;
  final bool isDarkThemeOn;

  const TicketCardInfinitiLotto({
    Key? key,
    required this.ticketList,
    required this.isDarkThemeOn
  }) : super(key: key);

  @override
  State<TicketCardInfinitiLotto> createState() => _TicketCardInfinitiLottoState();
}

class _TicketCardInfinitiLottoState extends State<TicketCardInfinitiLotto> {
  Map<String, String> ticketImageListMap = {};

  @override
  Widget build(BuildContext context) {

    var ticketImageList = {
      "Lucky 6"            : "assets/logo/lucky_6.jpg",
      "Lucky Number+ 5/90" : "assets/logo/5_90.jpg",
      "Super Keno"         : 'assets/logo/super_keno.jpg',
      "Twelve By TwentyFour" : 'assets/logo/game_12_by_24.png',
      'DailyLotto'         : 'assets/logo/daily_lotto.png',
      'Bonus Lotto'        : 'assets/logo/bonus_lotto6by42.png',
      'PowerBall'          : 'assets/logo/force-lotto.png',
      "SOCCER 4"           : "assets/logo/soccer_4.png",
      "SOCCER 12"          : "assets/logo/soccer_12.png",
      "CRICKET5"           : 'assets/logo/cricket5.png',
      "PICK4"              : 'assets/logo/logo-pick4.png',

      "Classic 75"          : "assets/logo/classic75.png",
      "Elegant 90"          : "assets/logo/elegant.png",
      "Fortune 90"          : 'assets/logo/fortune90.png',
      "Power Bingo 75"      : 'assets/logo/powerbingo75.png',
      "Power Bingo 90"      : 'assets/logo/powerbingo90.png',
      "Super 75"            : 'assets/logo/super75.png',

      "Five By Forty Nine Lotto Weekly" : 'assets/logo/5by49lottoWeekly_updated.png',
      "5/49 Lotto Weekly"               : 'assets/logo/5by49lottoWeekly_updated.png',
      'Thai Lottery'                    : 'assets/logo/logo-thaiLottery.png',
      '2D- MYANMAR'                     : 'assets/logo/logo-myanmar2d.png',
      'Zoo Lotto'                       : 'assets/logo/logo-zooLotto.png',//zoolotto

    };

    var getIgeGameListFromSharedPref = AppData.igeGamesData;
    Map<String, dynamic> jsonMap = jsonDecode(getIgeGameListFromSharedPref);
    igeNewResponse.IgeGameResponse gameResponse = IgeGameResponse.fromJson(jsonMap);

    List<Games?>? igeGameList = gameResponse.data?.ige?.engines?.nEW?.games;
    List<Games?>? igeGameListContainingImageList;
    if (gameResponse.data != null) {
      if (UserInfo.isLoggedIn()) {
        igeGameList = gameResponse.data?.ige?.engines?.nEW?.games?.where((
            element) =>
        (element.currencyCode ?? "EUR") == UserInfo.currencyDisplayCode)
            .toList();
      }
      if (igeGameList?.isNotEmpty == true) {
        igeGameListContainingImageList = igeGameList!.where((element) => (element?.gameName! == widget.ticketList.gameName!)).toList();
      }
    }

    bool isDarkThemeOn = context.watch<SwitchCubit>().state.isDarkThemeOn;
    String txnDate = formatDate(
      date: widget.ticketList.transactionDate ?? "",
      inputFormat: Format.apiDateFormat2,
      outputFormat: Format.apiDateFormat_with_time,
    );
    String amount = double.parse(widget.ticketList.amount ?? "0.0").toStringAsFixed(2);
    return Container(
      height: context.screenHeight / 6,
      decoration: BoxDecoration(
        color: isDarkThemeOn ? SabanzuriColors.cetaceanBlue : SabanzuriColors.white,
        boxShadow: const [
          BoxShadow(
            color: SabanzuriColors.grey_blue,
            offset: Offset(0.0, 0.1), //(x,y)
            blurRadius: 0.5,
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    widget.ticketList.gameType != "INSTANT WIN"
                        ? Expanded(child: Image.asset(ticketImageList[widget.ticketList.gameName.toString()] ?? "assets/images/instant_game_img.png",width: 85, height: 85,).pSymmetric(v:5, h:5))
                        : Expanded(child: Image.network(igeGameListContainingImageList!.isNotEmpty == true ? igeGameListContainingImageList[0]!.imagePath! : "assets/images/instant_game_img.png",width: 85, height: 85,).pSymmetric(v:5, h:5)),
                    /*Container(
                    width: 70,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        color: widget.ticketList.gameType == "INSTANT WIN" ? SabanzuriColors.light_violet : SabanzuriColors.pumpkin_orange,
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Text(
                        widget.ticketList.gameType == "INSTANT WIN" ? "Instant" : "Draw",
                        textAlign: TextAlign.center, style: const TextStyle(color: SabanzuriColors.white)),
                  )*/
                  ],
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        child: Text(
                          widget.ticketList.gameName ?? "",
                          style: TextStyle(
                            color: widget.isDarkThemeOn
                                ? SabanzuriColors.yellow_orange
                                : SabanzuriColors.cetaceanBlue,
                            fontWeight: FontWeight.w700,
                            fontFamily: "Roboto",
                            fontStyle: FontStyle.normal,
                            fontSize: 20.0,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        "${context.l10n.txnId} : ${widget.ticketList.transactionId ?? ""}",
                        style: const TextStyle(
                          color: SabanzuriColors.warm_grey_two,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Roboto",
                          fontStyle: FontStyle.italic,
                          fontSize: 15.0,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      FittedBox(
                        child: Text(
                          txnDate,
                          style: const TextStyle(
                            color: SabanzuriColors.warm_grey_two,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Roboto",
                            fontStyle: FontStyle.italic,
                            fontSize: 15.0,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      )
                    ],
                  ).pSymmetric(v: 16, h: 8),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      FittedBox(
                        child: Text(
                          "${UserInfo.getCurrencyCode} $amount",
                          // " ${widget.ticketDetails.amount}",
                          style: TextStyle(
                            color: widget.isDarkThemeOn
                                ? SabanzuriColors.sickly_yellow
                                : SabanzuriColors.ultramarine,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Roboto",
                            fontStyle: FontStyle.normal,
                            fontSize: 15.0,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ).pSymmetric(v: 16, h: 8),
                ),

              ],
            ).pOnly(top: 10, left: 8),
          ),
          Container(
              height: 1,
              width: double.infinity,
              color: isDarkThemeOn ? SabanzuriColors.cetaceanBlue : SabanzuriColors.white
          ).pOnly(top: 10)
        ],
      ),
    );
  }
}
