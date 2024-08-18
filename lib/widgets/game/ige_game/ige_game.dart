import 'package:flutter/material.dart';
import 'package:sabanzuri/l10n/l10n.dart';
import 'package:sabanzuri/model/ige_game_model.dart';
import 'package:sabanzuri/utils/sabanzuri_colors.dart';
import 'package:velocity_x/velocity_x.dart';

import 'ige_game_list.dart';

class IgeGame extends StatefulWidget {
  final IgeGameModel? igeGameModel;
  final bool isDarkThemeOn;
  final int clickIndex;
  final Function(int) gameTapCallback;

  const IgeGame({
    Key? key,
    @required this.igeGameModel,
    required this.isDarkThemeOn,
    required this.clickIndex,
    required this.gameTapCallback,
  }) : super(key: key);

  @override
  State<IgeGame> createState() => _IgeGameState();
}

class _IgeGameState extends State<IgeGame> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const HeightBox(10),
        // instantHeading(),
        IgeGameList(
          igeGameModel: widget.igeGameModel,
          isDarkThemeOn: widget.isDarkThemeOn,
          clickIndex: widget.clickIndex,
          gameTapCallback: widget.gameTapCallback,
        ),
      ],
    );
  }

  instantHeading() {
    return Text(
      context.l10n.instantGames.toUpperCase(),
      style: const TextStyle(
        color: SabanzuriColors.rusty_red,
        fontWeight: FontWeight.w700,
        fontFamily: "Arial",
        fontStyle: FontStyle.normal,
        fontSize: 22.5,
      ),
      textAlign: TextAlign.center,
    );
  }
}
