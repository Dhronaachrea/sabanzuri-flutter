import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sabanzuri/model/dge_game_model.dart';
import 'package:sabanzuri/screens/home/game_cubit/ige_game_state.dart';
import 'package:sabanzuri/screens/theme/cubit/switch_cubit.dart';
import 'package:sabanzuri/utils/sabanzuri_colors.dart';
import 'package:sabanzuri/widgets/sabanzuri_scaffold.dart';

import 'package:sabanzuri/widgets/game/dge_game/dge_game.dart';
import 'package:sabanzuri/model/ige_game_model.dart';
import 'package:sabanzuri/widgets/game/ige_game/ige_game.dart';
import 'package:sabanzuri/utils/loading_indicator.dart';
import 'game_cubit/dge_game_cubit.dart';
import 'game_cubit/ige_game_cubit.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DgeGameModel? dgeGameModel;
  IgeGameModel? igeGameModel;
  static const Channel = MethodChannel('com.example.sabanzuri/location');

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      BlocProvider.of<DgeGameCubit>(context).fetchDgeGameInfo();
      BlocProvider.of<IgeGameCubit>(context).fetchIgeGameInfo();
    });
    getLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SabanzuriScaffold(

      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: context.screenHeight / 2.5,
            color: SabanzuriColors.navy,
            child: BlocBuilder<DgeGameCubit, DgeGameState>(
                builder: (context, state) {
              if (state is DgeGameLoaded) {
                dgeGameModel = state.data;
                return DgeGame(dgeGameModel: dgeGameModel);
              } else {
                return const Center(child: LoadingIndicator());
              }
            }),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              color: SabanzuriColors.yellow_orange,
              child: BlocBuilder<IgeGameCubit, IgeGameState>(
                  builder: (context, state) {
                bool isDarkThemeOn =
                    context.watch<SwitchCubit>().state.isDarkThemeOn;
                if (state is IgeGameLoaded) {
                  igeGameModel = state.data;
                  return IgeGame(
                    igeGameModel: igeGameModel,
                    isDarkThemeOn: isDarkThemeOn,
                    clickIndex: -1,
                    gameTapCallback: (index) {},
                  );
                } else {
                  return const Center(child: LoadingIndicator());
                }
              }),
            ),
          ),
        ],
      ),
    );
  }

  getLocation() {
    String location = Channel.invokeMethod("getLocation") as String;

    print("location=============>>>$location");

  }
}
