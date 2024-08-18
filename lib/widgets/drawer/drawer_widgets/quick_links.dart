import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sabanzuri/l10n/l10n.dart';
import 'package:sabanzuri/model/response/registration_response.dart';
import 'package:sabanzuri/utils/screens.dart';
import 'package:sabanzuri/utils/user_info.dart';
import 'drawer_tile.dart';
import 'drawer_title.dart';

class QuickLinks extends StatefulWidget {
  const QuickLinks({Key? key}) : super(key: key);

  @override
  State<QuickLinks> createState() => _QuickLinksState();
}

class _QuickLinksState extends State<QuickLinks> {
  bool isFromScan = false;

  @override
  void initState() {
    super.initState();

    if (UserInfo.getRegistrationResponse().isNotEmpty) {
      print("UserInfo.getRegistrationResponse() -> ${UserInfo.getRegistrationResponse()}");
      var registrationResponse = UserInfo.getRegistrationResponse();
      print("registrationResponse: $registrationResponse");
      Map<String, dynamic> jsonMap = jsonDecode(registrationResponse);
      print("jsonMap: $jsonMap");
      RegistrationResponse regisResponse = RegistrationResponse.fromJson(jsonMap);
      isFromScan = regisResponse.ramPlayerInfo?.aliasName == "poc.igamew.com";
      print("isFromScan: $isFromScan");

    }
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DrawerTitle(title: context.l10n.quickLinks.toUpperCase()),
        /*DrawerTile(
          heading: "Withdrawal Initiate",
          onTap: () {
              if (UserInfo.isLoggedIn()) {
                Navigator.pushNamed(context, Screen.withdrawal_initiate_screen,arguments: "");
              }
            },
        ),*/
        DrawerTile(
          heading: "Lottery Result",
          onTap: () {
            Navigator.pushNamed(context, Screen.result_screen,arguments: "dgeResult");
          },
        ),
        DrawerTile(
          heading: "Bingo Result",
          onTap: () {
            Navigator.pushNamed(context, Screen.result_screen,arguments: "bingoResult");
          },
        ),
        DrawerTile(
          heading: "Sportspool Result",
          onTap: () {
            Navigator.pushNamed(context, Screen.result_screen,arguments: "sportLotteryResult");
          },
        ),
        /*DrawerTile(
          heading: context.l10n.myBonuses,
        ),*/
        // DrawerTile(
        //   heading: context.l10n.inbox,
        // ),
        // Not there in native android but in Zaplin
        // DrawerTile(
        //   heading: context.l10n.myDrawGameTickets,
        // ),
      ],
    );
  }
}
