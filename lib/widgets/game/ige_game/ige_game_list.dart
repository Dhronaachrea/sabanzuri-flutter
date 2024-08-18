import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:sabanzuri/model/ige_game_model.dart';
import 'package:sabanzuri/screens/home/lobby%20_game_cubit/game_list_cubit.dart';
import 'package:sabanzuri/services/api_service.dart';
import 'package:sabanzuri/utils/utils.dart';
import 'package:velocity_x/velocity_x.dart';
import 'ige_game_card.dart';

class IgeGameList extends StatefulWidget {
  final IgeGameModel? igeGameModel;
  final bool isDarkThemeOn;
  final int clickIndex;
  final Function(int) gameTapCallback;

  const IgeGameList({
    Key? key,
    this.igeGameModel,
    required this.isDarkThemeOn,
    required this.clickIndex,
    required this.gameTapCallback,
  }) : super(key: key);

  @override
  State<IgeGameList> createState() => _IgeGameListState();
}

class _IgeGameListState extends State<IgeGameList> {
  IgeGameModel? _igeGameModel;
  List<Game>? _igeGames;
  int igeGameCount = 0;
  var gameList = ["Lottery", "Instant", "Sportspool", "Bingo"];

  @override
  void initState() {
    initializeVariables();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return igeGameCount > 0
        ? AnimationLimiter(
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1
                ),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                // itemCount: igeGameCount,
                itemCount: 4,
                itemBuilder: (context, index) {
                  return AnimationConfiguration.staggeredGrid(
                    position: index,
                    columnCount: 2,
                    duration: const Duration(milliseconds: 500),
                    child: FlipAnimation(
                      flipAxis: FlipAxis.y,
                      child: FadeInAnimation(
                        child: InkWell(
                          onTap: () {
                            widget.gameTapCallback(index);
                            // if (isRedundentClick()) return;
                            // setState(() {
                            //   widget.clickIndex = index;
                            // });
                            // isInternetConnect().then((value) {
                            //   if (value) {
                            //     BlocProvider.of<GameListCubit>(context)
                            //         .fetchGameList(gameList[index]);
                            //   } else {
                            //     ApiService.showErrorSheetHomeLobby();
                            //   }
                            // });

                            // Future.delayed(const Duration(milliseconds: 100), () {
                            //   // Navigator.of(context).push(
                            //   //   MaterialPageRoute(
                            //   //     builder: (context) => SabanzuriWebView(
                            //   //       igeGame: _igeGames![index],
                            //   //     ),
                            //   //   ),
                            //   // );
                            //
                            //   Navigator.of(context).push(
                            //     MaterialPageRoute(
                            //       builder: (context) => GameLobby(
                            //         // igeGame: _igeGames![index],
                            //       ),
                            //     ),
                            //   );
                            // });
                          },
                          child: IgeGameCard(
                            igeGame: _igeGames![index],
                            index: index,
                            isDarkThemeOn: widget.isDarkThemeOn,
                            clickIndex: widget.clickIndex,
                          ),
                        ),
                      ),
                    ),
                  );
                }).p(8),
          )
        : const SizedBox();
  }

  void initializeVariables() {
    _igeGameModel = widget.igeGameModel;
    _igeGames = _igeGameModel?.data?.ige?.engines?.kenya?.games ?? [];
    igeGameCount = _igeGames!.length;
  }
}
