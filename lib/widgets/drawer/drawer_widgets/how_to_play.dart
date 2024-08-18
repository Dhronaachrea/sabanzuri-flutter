import "package:flutter/material.dart";
import 'package:sabanzuri/l10n/l10n.dart';
import 'package:sabanzuri/utils/screens.dart';
import 'package:sabanzuri/utils/url.dart';

import 'drawer_tile.dart';
import 'drawer_title.dart';

class HowToPlay extends StatelessWidget {
  const HowToPlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DrawerTitle(
          title: context.l10n.howToPlay.toUpperCase(),
        ),
        DrawerTile(
          heading: context.l10n.sabanzuriLotto,
          onTap: () => Navigator.pushNamed(
            context,
            Screen.common_web_view_screen,
            arguments: Url.HOW_PLAY_SABANZURI_URL,
          ),
        ),
        DrawerTile(
          heading: context.l10n.luckyTwelve,
          onTap: () => Navigator.pushNamed(
            context,
            Screen.common_web_view_screen,
            arguments: Url.HOW_PLAY_LUCKY_TWELVE_URL,
          ),
        ),
        DrawerTile(
          heading: context.l10n.treasureHunt,
          onTap: () => Navigator.pushNamed(
            context,
            Screen.common_web_view_screen,
            arguments: Url.HOW_PLAY_TREASURE_URL,
          ),
        ),
        DrawerTile(
          heading: context.l10n.ticTacToe,
          onTap: () => Navigator.pushNamed(
            context,
            Screen.common_web_view_screen,
            arguments: Url.HOW_PLAY_TIC_TAC_TOE_URL,
          ),
        ),
        DrawerTile(
          heading: context.l10n.moneyBee,
          onTap: () => Navigator.pushNamed(
            context,
            Screen.common_web_view_screen,
            arguments: Url.HOW_PLAY_MONEY_BEE_URL,
          ),
        ),
        DrawerTile(
          heading: context.l10n.bigFive,
          onTap: () => Navigator.pushNamed(
            context,
            Screen.common_web_view_screen,
            arguments: Url.HOW_PLAY_BIG_FIVE_URL,
          ),
        ),
        DrawerTile(
          heading: context.l10n.funTime,
          onTap: () => Navigator.pushNamed(
            context,
            Screen.common_web_view_screen,
            arguments: Url.HOW_PLAY_FUN_TIME_URL,
          ),
        ),
      ],
    );
  }
}
