import 'package:flutter/material.dart';
import 'package:sabanzuri/l10n/l10n.dart';
import 'package:sabanzuri/model/dge_game_model.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:sabanzuri/widgets/game/game_timer.dart';
import 'package:sabanzuri/utils/sabanzuri_colors.dart';
import 'package:sabanzuri/widgets/sabanzuri_button.dart';
import 'package:sabanzuri/screens/web_view/sabanzuri_web_view.dart';

import '../../../screens/lobby/lobby_screen.dart';

class DgeGameCard extends StatefulWidget {
  final Fivebyninety dgeGame;
  final String backImage;
  final String winText;
  final String gameLogo;
  final CurrentTime currentTime;

  const DgeGameCard({
    Key? key,
    required this.dgeGame,
    required this.backImage,
    required this.winText,
    required this.gameLogo,
    required this.currentTime,
  }) : super(key: key);

  @override
  State<DgeGameCard> createState() => _DgeGameCardState();
}

class _DgeGameCardState extends State<DgeGameCard> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              // image: AssetImage(widget.backImage),
              image: AssetImage('assets/images/banner_img.jpg'),
            ),
          ),
        ),
        // Row(
        //   children: [
        //     const WidthBox(20.0),
        //     Image.asset(
        //       widget.gameLogo,
        //       height: 125,
        //       width: context.screenWidth / 2.1,
        //     ),
        //     Expanded(
        //       child: Column(
        //         crossAxisAlignment: CrossAxisAlignment.center,
        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //         children: [
        //           const HeightBox(5),
        //           remainingTime(),
        //           GameTimer(
        //             dgeGame: widget.dgeGame,
        //             currentTime: widget.currentTime,
        //           ),
        //           winText(),
        //           winingAmount(),
        //           playNowButton(),
        //           const HeightBox(5),
        //         ],
        //       ).px(8),
        //     ),
        //   ],
        // )
      ],
    );
  }

  remainingTime() {
    return Text(context.l10n.remainingTime.toUpperCase(),
        style: const TextStyle(
            color: SabanzuriColors.white,
            fontWeight: FontWeight.w700,
            fontFamily: "Arial",
            fontStyle: FontStyle.normal,
            fontSize: 13.0),
        textAlign: TextAlign.end);
  }

  winText() {
    return Text(
      context.l10n.jackpot.toUpperCase(),
      style: const TextStyle(
          color: SabanzuriColors.lemon,
          fontWeight: FontWeight.w700,
          fontFamily: "Arial",
          fontStyle: FontStyle.normal,
          fontSize: 18.0),
      textAlign: TextAlign.end,
    );
  }

  winingAmount() {
    return Text(
      //context.l10n.kes.toUpperCase() + " " + "100000",
      widget.dgeGame.jackpotAmount!,
      style: const TextStyle(
          color: SabanzuriColors.white,
          fontWeight: FontWeight.w700,
          fontFamily: "Arial",
          fontStyle: FontStyle.normal,
          fontSize: 18),
      textAlign: TextAlign.end,
    );
  }

  playNowButton() {
    return PrimaryButton(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      height: 41,
      fillEnableColor: SabanzuriColors.reddish_pink,
      fillDisableColor: SabanzuriColors.reddish_pink,
      text: context.l10n.playNow.toUpperCase(),
      borderRadius: 5,
      onPressed: () {
        Future.delayed(const Duration(milliseconds: 100), () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => SabanzuriWebView(
                // dgeGame: widget.dgeGame,
              ),
            ),
          );

        });
      },
    );
  }
}
