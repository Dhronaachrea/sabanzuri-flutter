import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:intl/intl.dart';
import 'package:sabanzuri/screens/lobby/ige_game_card_custom_paint.dart';
import 'package:sabanzuri/screens/lobby/lobby_cubit/init_game_state.dart';
import 'package:sabanzuri/screens/lobby/lobby_cubit/lobby_draw_game_state.dart';
import 'package:sabanzuri/screens/lobby/lobby_cubit/lobby_ige_game_cubit.dart';
import 'package:sabanzuri/screens/lobby/lobby_cubit/lobby_ige_game_state.dart';
import 'package:sabanzuri/screens/lobby/lobby_cubit/lobby_sports_lottery_cubit.dart';
import 'package:sabanzuri/screens/lobby/lobby_cubit/lobby_sports_lottery_state.dart';
import 'package:sabanzuri/screens/lobby/lobby_model/NewDrawGamesResponse.dart';
import 'package:sabanzuri/screens/lobby/lobby_model/ige_game_response.dart';
import 'package:sabanzuri/screens/lobby/lobby_model/init_game_response.dart';
import 'package:sabanzuri/screens/lobby/lobby_model/sport_lottery_response.dart';
import 'package:sabanzuri/screens/login/bloc/login_bloc.dart';
import 'package:sabanzuri/screens/login/login_screen.dart';
import 'package:sabanzuri/screens/timer/my_timer.dart';
import 'package:sabanzuri/utils/app_constants.dart';
import 'package:sabanzuri/utils/user_info.dart';
import 'package:sabanzuri/widgets/sabanzuri_scaffold.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../model/response/game_list_model.dart';
import '../../widgets/shadow_card.dart';
import '../web_view/sabanzuri_web_view.dart';
import 'lobby_cubit/lobby_draw_game_cubit.dart';
import 'lobby_cubit/init_game_cubit.dart';

class GameLobby extends StatefulWidget {
  String? gameName;

  GameLobby({Key? key, this.gameName}) : super(key: key);

  @override
  _GameLobbyState createState() => _GameLobbyState();
}

class _GameLobbyState extends State<GameLobby> {
  GameListModel? gameList;
  InitGameResponse? initGameResponse;
  // DrawGameResponse? drawGameResponse;
  NewDrawGamesResponse? drawGameResponse;
  NewDrawGamesResponse? bingoGameResponse;
  IgeGameResponse? igeGameResponse;
  SportLotteryResponse? sportLotteryResponse;
  Map<String, dynamic> request = {};
  List<String> comingSoonGameList = [
    'TwoDMYANMAAR',
    'PICK_4',
    'BichoRapido'
  ];

  var drawGameList = [
    "LuckySix",
    "FiveByNinety",
    "TwelveByTwentyFour",
    "SuperKeno",
    'DailyLotto',
    'SixByFortyTwoBonusBall',
    'powerball',
    'FiveByFortyNineLottoWeekly',
    'ThaiLottery',
    'TwoDMYANMAAR',
    "BichoRapido"// zoolotto
  ];

  var bingoGameList = [
    "BingoSeventyFive",
    "BingoSeventyFive1",
    "BingoSeventyFive2",
    "BingoNinety",
    "BingoNinety1",
    "BingoNinety2"
  ];

  var drawAssetsImage = {
    "LuckySix": "assets/logo/lucky_6.jpg",
    "FiveByNinety": "assets/logo/5_90.jpg",
    "SuperKeno": 'assets/logo/super_keno.jpg',
    "TwelveByTwentyFour": 'assets/logo/game_12_by_24.png',
    'DailyLotto': 'assets/logo/daily_lotto.png',
    'SixByFortyTwoBonusBall': 'assets/logo/bonus_lotto6by42.png',//SixByFortyTwoBonusBall
    'powerball': 'assets/logo/force-lotto.png',
    'FiveByFortyNineLottoWeekly':'assets/logo/5by49lottoWeekly_updated.png',
    'ThaiLottery':'assets/logo/logo-thaiLottery.png',
    'TwoDMYANMAAR':'assets/logo/logo-myanmar2d.png',
    'BichoRapido':'assets/logo/logo-zooLotto.png',//zoolotto
  };

  var sportLotteryAssetsImage = {
    "SOCCER 4": "assets/logo/soccer_4.png",
    "SOCCER 12": "assets/logo/soccer_12.png",
    "CRICKET5": 'assets/logo/cricket5.png',
    "PICK4": 'assets/logo/logo-pick4.png'
  };

  var bingoLotteryAssetsImage = {
    "BingoSeventyFive": "assets/logo/classic75.png",
    "BingoNinety": "assets/logo/elegant.png",
    "BingoNinety1": 'assets/logo/fortune90.png',
    "BingoSeventyFive2": 'assets/logo/powerbingo75.png',
    "BingoNinety2": 'assets/logo/powerbingo90.png',
    "BingoSeventyFive1": 'assets/logo/super75.png'
  };

  bool isLoading = true;
  double progress = 0;

  @override
  void initState() {
    super.initState();
    if (widget.gameName == 'Lottery') {
      _callInitApi();
    } else if (widget.gameName == 'Instant') {
      _callFetchIgeGameApi();
    } else if (widget.gameName == 'Sportspool') {
      _callFetchSportLotteryGameApi();
    } else if (widget.gameName == "Bingo") {
      _callBingoGameListApi();
    }
    // String gameListPrefs = SharedPrefUtils.getAppStringValue("gamesList");
    // if (gameListPrefs != '') {
    //   gameList = GameListModel.fromJson(json.decode(gameListPrefs));
    //   BlocProvider.of<GameListCubit>(context).fetchGameList(gameList);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return SabanzuriScaffold(
        showDrawer: false,
        title: '${widget.gameName}',
        child: MultiBlocListener(
            listeners: [
              BlocListener<InitGameCubit, InitGameState>(
                listener: (context, state) {
                  if (state is InitGameLoading) {
                    print("-------------------InitGameLoading---------------------");
                    setState(() {
                      isLoading = true;
                    });
                  } else if (state is InitGameError) {
                    setState(() {
                      isLoading = false;
                    });
                  } else if (state is InitGameLoaded) {
                    initGameResponse = state.initGameResponse;
                    if (initGameResponse!.success == true) {
                      _callFetchDrawGameApi();
                    }
                  }
                },
              ),
              BlocListener<LobbyDrawGameCubit, LobbyDrawGameState>(
                listener: (context, state) {
                  if (state is LobbyDrawGameLoading) {
                    print("-------------------LobbyDrawGameLoading---------------------");
                    setState(() {
                      isLoading = true;
                    });
                  } else if (state is LobbyDrawGameError) {
                    setState(() {
                      isLoading = false;
                    });
                  } else if (state is LobbyDrawGameLoaded) {
                    setState(() {
                      isLoading = false;
                      drawGameResponse = state.drawGameResponse;
                      bingoGameResponse = state.drawGameResponse;
                    });
                  }
                },
              ),
              BlocListener<LobbyIgeGameCubit, LobbyIgeGameState>(
                listener: (context, state) {
                  if (state is LobbyIgeGameLoading) {
                    setState(() {
                      isLoading = true;
                    });
                  } else if (state is LobbyIgeGameError) {
                    setState(() {
                      isLoading = false;
                    });
                  } else if (state is LobbyIgeGameLoaded) {
                    setState(() {
                      isLoading = false;
                      igeGameResponse = state.igeGameResponse;
                    });
                  }
                },
              ),
              BlocListener<LobbySportLotteryCubit, LobbySportLotteryState>(
                listener: (context, state) {
                  if (state is LobbySportLotteryLoading) {
                    setState(() {
                      isLoading = true;
                    });
                  } else if (state is LobbySportLotteryError) {
                    setState(() {
                      isLoading = false;
                    });
                  } else if (state is LobbySportLotteryLoaded) {
                    setState(() {
                      isLoading = false;
                      sportLotteryResponse = state.sportLotteryResponse;
                    });
                  }
                },
              ),
            ],
            child: Container(
                alignment: Alignment.topCenter,
                child:
                    Column(
                      children: [
                        isLoading
                            ?
                              GradientProgressIndicator(
                                gradient: Gradients.rainbowBlue,
                              )
                            :
                              Container(),
                        Expanded(
                            child: lobbyGameList().pSymmetric(h: 20, v: 10)
                        )
                      ],
                    )
            )));
  }

  void _callInitApi() {
    request = {
      "userId": "-",
      "username": "-",
      "authToken": "-",
      "lang": "en",
      "currencyCode": "EUR",
      "aliasName": "ice.igamew.com",
      "balance": "0",
      "isMobileApp": "0",
      "currencyCodeDisplay": "�",
    };

    BlocProvider.of<InitGameCubit>(context).initGames(request);
  }

  void _callFetchDrawGameApi() {
    request = {
      "gameCodes": drawGameList,
      "domainCode": AppConstants.domainNameInfiniti,
    };
    BlocProvider.of<LobbyDrawGameCubit>(context).fetchDrawGames(request);
  }

  void _callBingoGameListApi() {
    request = {
      "gameCodes": bingoGameList,
      "domainCode": AppConstants.domainNameInfiniti,
      "timerType": "",
      "service": "B2C",
      "isMobile": false
    };

    BlocProvider.of<LobbyDrawGameCubit>(context).fetchDrawGames(request);
  }

  void _callFetchIgeGameApi() {
    request = {
      "service": "B2C",
    };
    BlocProvider.of<LobbyIgeGameCubit>(context).fetchIgeGames(request);
  }

  void _callFetchSportLotteryGameApi() {
    request = {"service": "B2C", "isMobile": true};
    BlocProvider.of<LobbySportLotteryCubit>(context)
        .fetchSportLotteryGames(request);
  }

  Widget lobbyGameList() {
    switch (widget.gameName) {
      case 'Lottery':
        List<GameRespVOs>? drawList = drawGameResponse?.responseData != null
            ? drawGameResponse?.responseData?.gameRespVOs
            : [];
        //drawList = drawList?.where((element) => element.drawRespVOs != null && element.drawRespVOs?.isNotEmpty == true).toList();

        return drawList?.isNotEmpty == true
                ?
                  MediaQuery.of(context).orientation == Orientation.portrait
                    ? GridView.builder(
                      padding: EdgeInsets.zero,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8,
                        childAspectRatio: 0.55
                      ),
                      shrinkWrap: true,
                      itemCount: drawList?.length ?? 0,
                      itemBuilder: (_, index) => AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 700),
                        child: SlideAnimation(
                          verticalOffset: 50,
                          child: FadeInAnimation(
                            child: ShadowCard(
                              onTap: () {
                                if ((drawList?[index].drawRespVOs != null && drawList?[index].drawRespVOs?.isNotEmpty ==  true)) {
                                  Future.delayed(const Duration(milliseconds: 100), () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => SabanzuriWebView(
                                          dgeGameInfiniti: drawList![index],
                                        ),
                                      ),
                                    );
                                  });
                                }
                              },
                              child: Stack(
                                children: [
                                  Column(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          margin:
                                          const EdgeInsets.only(left: 8, right: 8, top: 5),
                                          height: context.screenHeight * 0.2,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            borderRadius: const BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                            image: DecorationImage(
                                              image: AssetImage(drawAssetsImage[
                                              drawList![index].gameCode.toString()]
                                                  .toString()),
                                              // fit: BoxFit.fill,
                                              alignment: Alignment.center,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(8),
                                        child: Column(
                                          children: [
                                            FittedBox(
                                              child: Text(
                                                (drawList[index].gameName == "PowerBall")
                                                    ? "Force Lotto"
                                                    : (drawList[index].gameName ?? ""),
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.blueAccent,
                                                ),
                                              ),
                                            ).pOnly(bottom: 8),
                                            (drawList[index].drawRespVOs == null || drawList[index].drawRespVOs?.isEmpty ==  true)
                                                ?  const Text("Draw Not Available" , style: TextStyle(color: Colors.black, fontSize: 15),)
                                                :   MyTimer(
                                              drawDateTime: DateFormat("yyyy-MM-dd hh:mm:ss").parse(drawGameResponse!.responseData!.gameRespVOs![index].timeToFetchUpdatedGameInfo ?? "2000-01-01 00:00:00"),
                                              currentDateTime: DateFormat("yyyy-MM-dd hh:mm:ss").parse(drawGameResponse!.responseData!.currentDate ?? "2000-01-01 00:00:00"),
                                              gameType: 'drawGame',
                                              gameName: drawGameResponse?.responseData?.gameRespVOs![index].gameName,
                                              callback: (newGameData) {
                                                print("datas $newGameData");
                                              },
                                            ).pOnly(left: 6, top: 8)
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  (comingSoonGameList.contains(drawList[index].gameCode))
                                      ? Positioned(
                                    top: -1,
                                    left: -1,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 11),
                                      decoration: const BoxDecoration(
                                          color: Colors.purpleAccent,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(8),
                                            bottomRight: Radius.circular(8),
                                          ) // green shaped
                                      ),
                                      child: const Text("Coming Soon", style: TextStyle(color: Colors.white),),
                                    ),
                                  )
                                      : Container()
                                ]
                              )
                            ),
                          ),
                        ),
                      ),
                    )
                    : AnimationLimiter(
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 0.85,
                crossAxisCount: 5,
              ),
              itemCount: drawList?.length ?? 0,
              itemBuilder: (_, index) => AnimationConfiguration.staggeredGrid(
                position: index,
                duration: const Duration(milliseconds: 700),
                columnCount: 3,
                child: SlideAnimation(
                  verticalOffset: 50,
                  child: FadeInAnimation(
                    child: ShadowCard(
                      onTap: () {
                        if (drawList?[index].drawRespVOs != null || drawList?[index].drawRespVOs?.isNotEmpty ==  true) {
                          Future.delayed(const Duration(milliseconds: 100), () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => SabanzuriWebView(
                                  dgeGameInfiniti: drawList![index],
                                ),
                              ),
                            );
                          });
                        }
                      },
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Expanded(
                                child: Container(
                                  margin:
                                  const EdgeInsets.only(left: 20, right: 20, top: 5),
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    image: DecorationImage(
                                      image: AssetImage(drawAssetsImage[
                                      drawList![index].gameCode.toString()]
                                          .toString()),
                                      // fit: BoxFit.fill,
                                      alignment: Alignment.center,
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    (drawList[index].gameName == "PowerBall")
                                        ? "Force Lotto"
                                        : drawList[index].gameName.toString(),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.blueAccent,
                                    ),
                                  ),
                                  (drawList[index].drawRespVOs == null || drawList[index].drawRespVOs?.isEmpty ==  true)
                                      ?  const Text("Draw not \n available" , textAlign: TextAlign.center, style: TextStyle(color: Colors.red, fontSize: 12),)
                                      :  Flexible(
                                    child: MyTimer(
                                      drawDateTime: DateFormat("yyyy-MM-dd hh:mm:ss").parse(drawGameResponse!.responseData!.gameRespVOs![index].timeToFetchUpdatedGameInfo ?? "2000-01-01 00:00:00"),
                                      currentDateTime: DateFormat("yyyy-MM-dd hh:mm:ss").parse(drawGameResponse!.responseData!.currentDate ?? "2000-01-01 00:00:00"),
                                      gameType: 'drawGame',
                                      gameName: drawGameResponse?.responseData?.gameRespVOs![index].gameName,
                                      callback: (newGameData) {
                                        print("datas $newGameData");
                                      },
                                    )
                                  )
                                ],
                              ).p(8),
                            ],
                          ),
                          // Align(
                          //   alignment: Alignment.topRight,
                          //   child: Container(
                          //     clipBehavior: Clip.antiAlias,
                          //     width: 50,
                          //     height: 50,
                          //     padding: const EdgeInsets.all(2.0),
                          //     decoration: BoxDecoration(
                          //       border: Border.all(color: Colors.grey, width: 1),
                          //       color: Colors.black,
                          //       borderRadius: const BorderRadius.only(
                          //         bottomLeft: Radius.circular(20),
                          //       ),
                          //     ),
                          //     child: gameList?.data?.ige?.engines?.dUBAI
                          //                 ?.games?[index].productInfo?.donation !=
                          //             null
                          //         ? Image.network(
                          //             gameList!
                          //                 .data!
                          //                 .ige!
                          //                 .engines!
                          //                 .dUBAI!
                          //                 .games![index]
                          //                 .productInfo!
                          //                 .donation![0]
                          //                 .image!,
                          //             errorBuilder: (context, url, error) {
                          //               return Image.asset(
                          //                   "assets/images/mask.png");
                          //             },
                          //           )
                          //         : Image.asset("assets/images/mask.png"),
                          //   ),
                          // )
                        ],
                      ),
                    ).p(4),
                  ),
                ),
              )),
        )
                : isLoading ? Container() : const SizedBox(
                          child: Center(
                              child: Text(
                                "Games Not Available",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 28),
                              )
                          ),
                        );

      case 'Instant':
        List<Games?>? igeGameList = igeGameResponse?.data?.ige?.engines?.nEW?.games;
        if (igeGameList != null) {
          if (UserInfo.isLoggedIn()) {
            igeGameList = igeGameList
                .where((element) =>
                    (element?.currencyCode ?? "EUR") ==
                    UserInfo.currencyDisplayCode)
                .toList();
          } else {
            igeGameList = igeGameList
                .where((element) => (element?.currencyCode ?? "EUR") == "EUR")
                .toList();
          }
          print("igeGameList:: ---> $igeGameList");
        }
        return igeGameList?.isNotEmpty == true
                ?
                  MediaQuery.of(context).orientation == Orientation.portrait
                    ? SingleChildScrollView(
                        child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: (igeGameList != null)
                              ? (igeGameList.length > 5
                                  ? igeGameList.length
                                  : igeGameList.length)
                              : 0,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.9,
                          ),
                          itemBuilder: (_, index) => AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 700),
                            child: FlipAnimation(
                              flipAxis: FlipAxis.x,
                              child: FadeInAnimation(
                                child:
                                igeGameList?[index]?.status?.toLowerCase() == "new"
                                    ? Container(
                                  margin: const EdgeInsets.only(top:30, left: 16),
                                  child: Stack(
                                    children: [
                                      CustomPaint(
                                          painter: Background()
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(top:5),
                                        decoration: BoxDecoration(
                                            color: const Color(0xff8c5ab7),
                                            borderRadius: BorderRadius.circular(30),
                                            boxShadow: const [BoxShadow(
                                                color: Colors.black,
                                                blurRadius: 5.0
                                            )
                                            ]
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(left:5, right: 5),
                                          child: ShadowCard(
                                            onTap: () {
                                              UserInfo.isLoggedIn()
                                                  ? Future.delayed(const Duration(milliseconds: 300),
                                                      () {
                                                    Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                        builder: (context) => SabanzuriWebView(
                                                            igeGame: igeGameList?[index],
                                                            igeResponse: igeGameResponse
                                                                ?.data?.ige?.engines?.nEW),
                                                      ),
                                                    );
                                                  })
                                                  : showDialog(
                                                context: context,
                                                builder: (context) => BlocProvider<LoginBloc>(
                                                  create: (context) => LoginBloc(),
                                                  child: const LoginScreen(),
                                                ),
                                              );
                                            },
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  margin: const EdgeInsets.all(5),
                                                  height: context.screenHeight * 0.11,
                                                  width: context.screenWidth,
                                                  child: Image.network(igeGameList?[index]?.imagePath.toString() ?? "",
                                                    fit: BoxFit.fill,
                                                    loadingBuilder: (BuildContext context, Widget child,
                                                        ImageChunkEvent? loadingProgress) {
                                                      if (loadingProgress == null) return child;
                                                      return Stack(
                                                          alignment: Alignment.center,
                                                          children: [
                                                            CircularProgressIndicator(
                                                                value: loadingProgress.expectedTotalBytes != null
                                                                    ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                                                    : null,
                                                                color: Colors.green),
                                                            Text( loadingProgress.expectedTotalBytes != null ? "${(double.parse((loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!).toStringAsFixed(2)) * 100).toInt()} %" : "", textAlign: TextAlign.center)
                                                          ]
                                                      );
                                                    },
                                                  ),
                                                ),
                                                Container(
                                                  padding: const EdgeInsets.all(4),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        igeGameList?[index]?.gameName?.toString() ?? "",
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w500,
                                                          color: Colors.blueAccent,
                                                        ),
                                                      ),
                                                    ],
                                                  ).p4(),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                          width: 200,
                                          height: 200,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          child: CustomPaint(
                                              painter: StickerTriangle()
                                          )
                                      ),
                                      CustomPaint(
                                          painter: CustomTextPainter()
                                      )
                                    ] ,
                                  ),
                                )

                                //without new tag
                                    : Container(
                                  margin: const EdgeInsets.only(top:20, left: 8, right:8),
                                  decoration: BoxDecoration(
                                      color: const Color(0xff8c5ab7),
                                      borderRadius: BorderRadius.circular(30),
                                      boxShadow: const [BoxShadow(
                                          color: Colors.black,
                                          blurRadius: 5.0
                                      )
                                      ]
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left:5, right: 5),
                                    child: ShadowCard(
                                      onTap: () {
                                        UserInfo.isLoggedIn()
                                            ? Future.delayed(const Duration(milliseconds: 300),
                                                () {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) => SabanzuriWebView(
                                                      igeGame: igeGameList?[index],
                                                      igeResponse: igeGameResponse
                                                          ?.data?.ige?.engines?.nEW),
                                                ),
                                              );
                                            })
                                            : showDialog(
                                          context: context,
                                          builder: (context) => BlocProvider<LoginBloc>(
                                            create: (context) => LoginBloc(),
                                            child: const LoginScreen(),
                                          ),
                                        );
                                      },
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Container(
                                              margin: const EdgeInsets.all(5),
                                              width: context.screenWidth,
                                              child: Image.network(igeGameList?[index]?.imagePath.toString() ?? "",
                                                fit: BoxFit.fill,
                                                loadingBuilder: (BuildContext context, Widget child,
                                                    ImageChunkEvent? loadingProgress) {
                                                  if (loadingProgress == null) return child;
                                                  return Stack(
                                                      alignment: Alignment.center,
                                                      children: [
                                                        CircularProgressIndicator(
                                                            value: loadingProgress.expectedTotalBytes != null
                                                                ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                                                : null,
                                                            color: Colors.green),
                                                        Text( loadingProgress.expectedTotalBytes != null ? "${(double.parse((loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!).toStringAsFixed(2)) * 100).toInt()} %" : "", textAlign: TextAlign.center)
                                                      ]
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(4),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  igeGameList?[index]?.gameName?.toString() ?? "",
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.blueAccent,
                                                  ),
                                                ),
                                              ],
                                            ).p4(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ),
                            ),
                          ),
                        ),
                      )
                    : AnimationLimiter(
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 1,
                    crossAxisCount: 3,
                  ),
                  itemCount: (igeGameList != null)
                      ? (igeGameList.length > 5
                          ? igeGameList.length
                          : igeGameList.length)
                      : 0,
                  itemBuilder: (_, index) => AnimationConfiguration.staggeredGrid(
                    position: index,
                    duration: const Duration(milliseconds: 700),
                    columnCount: 3,
                    child: FlipAnimation(
                      flipAxis: FlipAxis.y,
                      child: FadeInAnimation(
                        child: ShadowCard(
                            onTap: () {
                              UserInfo.isLoggedIn()
                                  ? Future.delayed(const Duration(milliseconds: 100),
                                      () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => SabanzuriWebView(
                                              igeGame: igeGameList?[index],
                                              igeResponse: igeGameResponse
                                                  ?.data?.ige?.engines?.nEW),
                                        ),
                                      );
                                    })
                                  : showDialog(
                                      context: context,
                                      builder: (context) => BlocProvider<LoginBloc>(
                                        create: (context) => LoginBloc(),
                                        child: const LoginScreen(),
                                      ),
                                    );
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
                                  height: context.screenHeight * 0.395,
                                  width: context.screenWidth,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(igeGameList![index]!
                                              .imagePath
                                              .toString()),
                                          fit: BoxFit.fill)),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        igeGameList[index]!.gameName.toString(),
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.blueAccent,
                                        ),
                                      ),
                                    ],
                                  ).p4(),
                                ),
                              ],
                            )).p(4),
                      ),
                    ),
                  )),
            )
                :
                  Container();

      case 'Sportspool':
        var sportLotteryGameList = sportLotteryResponse?.responseData ?? [];

        /*sportLotteryGameList = sportLotteryGameList
            .where((elements) => (elements != null &&
                elements.drawData?.isNotEmpty == true))
            .toList();*/

        return sportLotteryGameList.isNotEmpty == true
                ?
                  MediaQuery.of(context).orientation == Orientation.portrait
                    ? GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8,
                        childAspectRatio: 0.69,
                      ),
                      shrinkWrap: true,
                      itemCount: sportLotteryGameList.length,
                      itemBuilder: (_, index) => AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 700),
                        child: FlipAnimation(
                          flipAxis: FlipAxis.x,
                          child: FadeInAnimation(
                            child: ShadowCard(
                              onTap: () {
                                if(sportLotteryGameList[index].drawData != null && sportLotteryGameList[index].drawData?.isNotEmpty ==  true) {
                                  Future.delayed(const Duration(milliseconds: 100), () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => SabanzuriWebView(
                                          sportsLotty: sportLotteryGameList[index],
                                        ),
                                      ),
                                    );
                                  });
                                }

                              },
                              child: Stack(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
                                        height: context.screenHeight * 0.15,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                          image: DecorationImage(
                                            image: AssetImage(sportLotteryAssetsImage[
                                                    sportLotteryGameList[index]
                                                        .gameName
                                                        .toString()]
                                                .toString()),
                                            fit: BoxFit.fill,
                                            alignment: Alignment.center,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          padding: const EdgeInsets.all(8),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                sportLotteryGameList[index]
                                                    .gameName
                                                    .toString(),
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.blueAccent,
                                                ),
                                              ).pOnly(bottom: 8),
                                              (sportLotteryGameList[index].drawData == null || sportLotteryGameList[index].drawData?.isEmpty ==  true)
                                                  ?  const Text("Draw Not Available" , style: TextStyle(color: Colors.red, fontSize: 15),).pOnly(top: 20)
                                              :  MyTimer(
                                                  drawDateTime: DateFormat("yyyy-MM-dd hh:mm:ss").parse((sportLotteryResponse?.responseData?[index].drawData!.isNotEmpty == true) ? (sportLotteryResponse?.responseData?[index].drawData?[0].drawFreezeTime ?? "2000-01-01 00:00:00") : "2000-01-01 00:00:00"),
                                                  currentDateTime: DateFormat("yyyy-MM-dd hh:mm:ss").parse(sportLotteryResponse?.responseData?[index].currentTime ?? "2000-01-01 00:00:00"),//sportLotteryResponse!.responseData![index].currentTime
                                                  gameType: 'sportGame',
                                                  callback: (newGameData) {},
                                                  gameName: sportLotteryGameList[index].gameName
                                              )
                                            ],
                                          )
                                        ),
                                      ),
                                    ],
                                  ),
                                  (comingSoonGameList.contains(sportLotteryGameList[index].gameCode))
                                      ? Positioned(
                                    top: -1,
                                    left: -1,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 11),
                                      decoration: const BoxDecoration(
                                          color: Colors.purpleAccent,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(8),
                                            bottomRight: Radius.circular(8),
                                          ) // green shaped
                                      ),
                                      child: const Text("Coming Soon", style: TextStyle(color: Colors.white),),
                                    ),
                                  )
                                      : Container()
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                    : AnimationLimiter(
              child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 1,
              crossAxisCount: 3,
              ),
              itemCount: sportLotteryGameList.length,
              itemBuilder: (_, index) =>  AnimationConfiguration.staggeredGrid(
                duration: const Duration(milliseconds: 700),
                columnCount: 2,
                position: index,
                child: FlipAnimation(
                  flipAxis: FlipAxis.y,
                  child: FadeInAnimation(
                    child: ShadowCard(
                      onTap: () {
                        if ((sportLotteryGameList[index].drawData != null && sportLotteryGameList[index].drawData?.isNotEmpty ==  true)) {
                            Future.delayed(const Duration(milliseconds: 100), () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => SabanzuriWebView(
                                    sportsLotty: sportLotteryGameList[index],
                                  ),
                                ),
                              );
                            });
                        }
                      },
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
                                height: context.screenHeight * 0.15,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  image: DecorationImage(
                                    image: AssetImage(sportLotteryAssetsImage[
                                    sportLotteryGameList[index]
                                        .gameName
                                        .toString()]
                                        .toString()),
                                    fit: BoxFit.fill,
                                    alignment: Alignment.center,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                    padding: const EdgeInsets.all(8),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          sportLotteryGameList[index]
                                              .gameName
                                              .toString(),
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.blueAccent,
                                          ),
                                        ).pOnly(bottom: 8),
                                        (sportLotteryGameList[index].drawData == null || sportLotteryGameList[index].drawData?.isEmpty ==  true)
                                            ?  const Text("Draw Not Available" , style: TextStyle(color: Colors.red, fontSize: 15),).pOnly(top: 20)
                                            :  MyTimer(
                                            drawDateTime: DateFormat("yyyy-MM-dd hh:mm:ss").parse((sportLotteryResponse?.responseData?[index].drawData!.isNotEmpty == true) ? (sportLotteryResponse?.responseData?[index].drawData?[0].drawFreezeTime ?? "2000-01-01 00:00:00") : "2000-01-01 00:00:00"),
                                            currentDateTime: DateFormat("yyyy-MM-dd hh:mm:ss").parse(sportLotteryResponse?.responseData?[index].currentTime ?? "2000-01-01 00:00:00"),//sportLotteryResponse!.responseData![index].currentTime
                                            gameType: 'sportGame',
                                            callback: (newGameData) {},
                                            gameName: sportLotteryGameList[index].gameName
                                        )
                                      ],
                                    )
                                ),
                              ),
                            ],
                          ),
                          (comingSoonGameList.contains(sportLotteryGameList[index].gameCode))
                              ? Positioned(
                            top: -1,
                            left: -1,
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 11),
                              decoration: const BoxDecoration(
                                  color: Colors.purpleAccent,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    bottomRight: Radius.circular(8),
                                  ) // green shaped
                              ),
                              child: const Text("Coming Soon", style: TextStyle(color: Colors.white),),
                            ),
                          )
                              : Container()
                        ],
                      ),
                    ).p(4),
                  ),
                ),
              )),
            )
                : isLoading ? Container() :  const SizedBox(
                    child: Center(
                        child: Text(
                          "Games Not Available",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 28),
                        )
                    ),
                  );

      case "Bingo":
        var bingoLotteryGameList = bingoGameResponse?.responseData?.gameRespVOs;
        bingoLotteryGameList = bingoLotteryGameList?.where((element) => element.familyCode == "Bingo").toList();
        //bingoLotteryGameList = bingoLotteryGameList?.where((element) => (element.drawRespVOs != null && element.drawRespVOs?.isNotEmpty == true)).toList();
        return bingoLotteryGameList?.isNotEmpty == true
                ?
                  MediaQuery.of(context).orientation == Orientation.portrait
                      ? GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8,
                          childAspectRatio: 0.64,
                        ),
                        shrinkWrap: true,
                        itemCount: bingoLotteryGameList?.length,
                        itemBuilder: (_, index) => AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 700),
                          child: SlideAnimation(
                            verticalOffset: 50,
                            child: FadeInAnimation(
                              child: ShadowCard(
                                onTap: () {
                                  // bool isUserLoggedIn = Auth.of(context).user.playerToken != null ? true : false;
                                  // isUserLoggedIn == true ?
                                  if ((bingoLotteryGameList?[index].drawRespVOs != null || bingoLotteryGameList?[index].drawRespVOs?.isNotEmpty ==  true)) {
                                    Future.delayed(const Duration(milliseconds: 100), () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => SabanzuriWebView(
                                            bingoGameInfiniti: bingoLotteryGameList?[index],
                                          ),
                                        ),
                                      );
                                    });
                                  }

                                },
                                child: Stack(
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Container(
                                            margin:const EdgeInsets.only(left: 10, right: 10, top: 10),
                                            height: context.screenHeight * 0.2,
                                            width: context.screenHeight * 0.2,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              borderRadius: const BorderRadius.all(
                                                Radius.circular(10),
                                              ),
                                              image: DecorationImage(
                                                image: AssetImage(bingoLotteryAssetsImage[
                                                        bingoLotteryGameList?[index]
                                                            .gameCode
                                                            .toString()]
                                                    .toString()),
                                                fit: BoxFit.fill,
                                                alignment: Alignment.center,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(8),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                bingoLotteryGameList?[index].gameName ?? "--",
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.blueAccent,
                                                ),
                                              ),
                                              bingoGameResponse?.responseData != null
                                                  ? FittedBox(
                                                    child: Align(
                                                      alignment: Alignment.centerLeft,
                                                      child: (bingoLotteryGameList?[index].drawRespVOs == null || bingoLotteryGameList?[index].drawRespVOs?.isEmpty ==  true)
                                                          ?  const Text("Draw Not Available" , style: TextStyle(color: Colors.black, fontSize: 20),)
                                                          :  MyTimer(
                                                                drawDateTime: DateFormat("yyyy-MM-dd hh:mm:ss").parse(bingoLotteryGameList![index].timeToFetchUpdatedGameInfo ?? "2000-01-01 00:00:00"),
                                                                currentDateTime: DateFormat("yyyy-MM-dd hh:mm:ss").parse(bingoGameResponse!.responseData!.currentDate ?? "2000-01-01 00:00:00"),
                                                                gameType: 'bingo',
                                                                gameName: bingoLotteryGameList[index].gameName,
                                                                callback: (newGameData) {
                                                                      print("datas $newGameData");
                                                                },
                                                              ),
                                                    ).pOnly(left: 6, top: 8),
                                                  )
                                                  : Container()
                                            ],
                                          ),
                                        ),
                                        /*CachedNetworkImage(
                                          // imageBuilder: (context, imageProvider) => Container(
                                          //   // height: context.screenHeight * 0.2,
                                          //   alignment: Alignment.center,
                                          //   decoration: BoxDecoration(
                                          //     borderRadius: const BorderRadius.all(
                                          //       Radius.circular(10),
                                          //     ),
                                          //     image: DecorationImage(
                                          //       image: imageProvider,
                                          //       fit: BoxFit.fill,
                                          //       alignment: Alignment.center,
                                          //     ),
                                          //   ),
                                          // ),

                                          imageBuilder: (context, imageProvider) => Container(
                                            height: context.screenHeight * 0.2,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              borderRadius: const BorderRadius.all(
                                                Radius.circular(10),
                                              ),
                                              image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.fill,
                                                alignment: Alignment.center,
                                              ),
                                            ),
                                          ),
                                          imageUrl: 'https://picsum.photos/200',
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(8),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                bingoLotteryGameList?[index].gameName ?? "",
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.blueAccent,
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        'WinUpTo',
                                                        style: const TextStyle(
                                                          color: Colors.orangeAccent,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                      Text(
                                                        '\$1000.00',
                                                        style: const TextStyle(
                                                          color: Colors.orangeAccent,
                                                          fontWeight: FontWeight.w600,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        '\$ ',
                                                        style: const TextStyle(
                                                            fontSize: 15, color: Colors.blue),
                                                      ),
                                                      Text(
                                                        '10.0',
                                                        style: const TextStyle(
                                                            fontSize: 15,
                                                            color: Colors.blue,
                                                            fontWeight: FontWeight.w700),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )
                                            ],
                                          ).p4(),
                                        ),*/
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                      : AnimationLimiter(
                child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 1,
                crossAxisCount: 3,
            ),
            itemCount: bingoLotteryGameList?.length,
            itemBuilder: (_, index) => AnimationConfiguration.staggeredGrid(
              position: index,
              duration: const Duration(milliseconds: 700),
              columnCount: 3,
              child: SlideAnimation(
                verticalOffset: 50,
                child: FadeInAnimation(
                  child: ShadowCard(
                      onTap: () {
                        // bool isUserLoggedIn = Auth.of(context).user.playerToken != null ? true : false;
                        // isUserLoggedIn == true ?
                        if ((bingoLotteryGameList?[index].drawRespVOs != null && bingoLotteryGameList?[index].drawRespVOs?.isNotEmpty ==  true)) {
                            Future.delayed(const Duration(milliseconds: 100), () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => SabanzuriWebView(
                                  bingoGameInfiniti: bingoLotteryGameList?[index],
                                ),
                              ),
                            );
                          });
                        }
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin:
                            const EdgeInsets.only(left: 10, right: 10, top: 10),
                            height: context.screenHeight * 0.365,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                              image: DecorationImage(
                                image: AssetImage(bingoLotteryAssetsImage[
                                bingoLotteryGameList?[index]
                                    .gameCode
                                    .toString()]
                                    .toString()),
                                // fit: BoxFit.fill,
                                alignment: Alignment.center,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  FittedBox(
                                    child: Text(
                                      bingoLotteryGameList?[index].gameName ?? "--",
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.blueAccent,
                                      ),
                                    ),
                                  ),
                                  bingoGameResponse!.responseData != null
                                      ? Flexible(
                                    child: (bingoLotteryGameList?[index].drawRespVOs == null && bingoLotteryGameList?[index].drawRespVOs?.isEmpty ==  true)
                                        ?  const Text("Draw Not Available" , style: TextStyle(color: Colors.black, fontSize: 20),)
                                        :  MyTimer(
                                      drawDateTime: DateFormat("yyyy-MM-dd hh:mm:ss").parse(bingoLotteryGameList![index].timeToFetchUpdatedGameInfo ?? "2000-01-01 00:00:00"),
                                      currentDateTime: DateFormat("yyyy-MM-dd hh:mm:ss").parse(bingoGameResponse!.responseData!.currentDate ?? "2000-01-01 00:00:00"),
                                      gameType: 'bingo',
                                      gameName: bingoLotteryGameList[index].gameName,
                                      callback: (newGameData) {
                                        print("datas $newGameData");
                                      },
                                    )
                                  )
                                      : Container()
                                ],
                              ),
                            ),
                          ),
                          /*CachedNetworkImage(
                                // imageBuilder: (context, imageProvider) => Container(
                                //   // height: context.screenHeight * 0.2,
                                //   alignment: Alignment.center,
                                //   decoration: BoxDecoration(
                                //     borderRadius: const BorderRadius.all(
                                //       Radius.circular(10),
                                //     ),
                                //     image: DecorationImage(
                                //       image: imageProvider,
                                //       fit: BoxFit.fill,
                                //       alignment: Alignment.center,
                                //     ),
                                //   ),
                                // ),

                                imageBuilder: (context, imageProvider) => Container(
                                  height: context.screenHeight * 0.2,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.fill,
                                      alignment: Alignment.center,
                                    ),
                                  ),
                                ),
                                imageUrl: 'https://picsum.photos/200',
                              ),
                              Container(
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      bingoLotteryGameList?[index].gameName ?? "",
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.blueAccent,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'WinUpTo',
                                              style: const TextStyle(
                                                color: Colors.orangeAccent,
                                                fontSize: 14,
                                              ),
                                            ),
                                            Text(
                                              '\$1000.00',
                                              style: const TextStyle(
                                                color: Colors.orangeAccent,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              '\$ ',
                                              style: const TextStyle(
                                                  fontSize: 15, color: Colors.blue),
                                            ),
                                            Text(
                                              '10.0',
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ).p4(),
                              ),*/
                        ],
                      ),
                  ).p(4),
                ),
              ),
            )),
              )
                : isLoading ? Container() : const SizedBox(
          child: Center(
              child: Text(
                "Games Not Available",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 28),
              )
          ),
        );

      default:
        return SingleChildScrollView(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: 10,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (_, index) => ShadowCard(
              onTap: () {
                // bool isUserLoggedIn = Auth.of(context).user.playerToken != null ? true : false;
                // isUserLoggedIn == true ?
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
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CachedNetworkImage(
                        // imageBuilder: (context, imageProvider) => Container(
                        //   // height: context.screenHeight * 0.2,
                        //   alignment: Alignment.center,
                        //   decoration: BoxDecoration(
                        //     borderRadius: const BorderRadius.all(
                        //       Radius.circular(10),
                        //     ),
                        //     image: DecorationImage(
                        //       image: imageProvider,
                        //       fit: BoxFit.fill,
                        //       alignment: Alignment.center,
                        //     ),
                        //   ),
                        // ),

                        imageBuilder: (context, imageProvider) => Container(
                          height: context.screenHeight * 0.2,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.fill,
                              alignment: Alignment.center,
                            ),
                          ),
                        ),
                        imageUrl: 'https://picsum.photos/200',
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'gameName',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.blueAccent,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'WinUpTo',
                                      style: const TextStyle(
                                        color: Colors.orangeAccent,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      '\$1000.00',
                                      style: const TextStyle(
                                        color: Colors.orangeAccent,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '\$ ',
                                      style: const TextStyle(
                                          fontSize: 15, color: Colors.blue),
                                    ),
                                    Text(
                                      '10.0',
                                      style: const TextStyle(
                                          fontSize: 15,
                                          color: Colors.blue,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ).p4(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
    }
  }

  getLotteryCurrentTime(String? currentTime) {
    return HttpDate.parse(currentTime!);
  }
}
