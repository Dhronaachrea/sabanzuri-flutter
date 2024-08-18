import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sabanzuri/l10n/l10n.dart';
import 'package:sabanzuri/model/dge_game_model.dart';
import 'package:sabanzuri/screens/home/bloc/home_timer_bloc.dart';
import 'dge_game_card.dart';

class DgeGame extends StatefulWidget {
  final DgeGameModel? dgeGameModel;

  const DgeGame({Key? key, @required this.dgeGameModel}) : super(key: key);

  @override
  State<DgeGame> createState() => _DgeGameState();
}

class _DgeGameState extends State<DgeGame> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
            child: BlocProvider<HomeTimerBloc>(
          create: (context) => HomeTimerBloc(),
          child: DgeGameCard(
            dgeGame: widget.dgeGameModel!.data!.games!.powerball!,
            currentTime: widget.dgeGameModel!.data!.currentTime!,
            backImage: "assets/background/6_42_background.png",
            winText: context.l10n.jackpot.toUpperCase(),
            gameLogo: "assets/logo/game_6_by_42.png",
          ),
        )),
        // Expanded(
        //   child: BlocProvider<HomeTimerBloc>(
        //     create: (context) => HomeTimerBloc(),
        //     child: DgeGameCard(
        //       dgeGame: widget.dgeGameModel!.data!.games!.twelvebytwentyfour!,
        //       currentTime: widget.dgeGameModel!.data!.currentTime!,
        //       backImage: "assets/background/12_24_background.png",
        //       winText: context.l10n.jackpot.toUpperCase(),
        //       gameLogo: "assets/logo/game_12_by_24.png",
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
