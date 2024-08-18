import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sabanzuri/repo/repository.dart';
import 'package:sabanzuri/utils/app_constants.dart';
import 'package:sabanzuri/utils/sabanzuri_colors.dart';
import 'package:sabanzuri/widgets/blinking_animation.dart';
import 'package:sabanzuri/widgets/shake_animation.dart';

typedef GameResponseCallback = void Function(String date);

class MyTimer extends StatefulWidget {
  MyTimer(
      {Key? key,
        required this.callback,
        required this.currentDateTime,
        required this.drawDateTime,
        required this.gameType,  this.gameName})
      : super(key: key);

  final GameResponseCallback callback;
  String? gameType;
  DateTime? drawDateTime;
  DateTime? currentDateTime;
  String? gameName;

  @override
  State<MyTimer> createState() => _MyTimerState();
}

class _MyTimerState extends State<MyTimer> {
  static const duration = Duration(seconds: 1);
  DateTime drawDate = DateTime(0);
  Map<String, dynamic> drawRequest = {};
  Map<String, dynamic> sportRequest = {};
  Map<String, dynamic> bingoRequest = {};
  var timeDiff = 0.toSigned(64);
  bool isApiReadyToCall = true;
  late ShakeController hurryUpShakeController;

  Timer timer = Timer(duration, () {});
  Repository repository = Repository();
  var drawGameList = [
    "LuckySix",
    "FiveByNinety",
    "TwelveByTwentyFour",
    "SuperKeno",
    'DailyLotto',
    'SixByFortyTwoBonusBall',
    'powerball',
    'FiveByFortyNineLottoWeekly',
    'ThaiLottery'
  ];

  var bingoGameList = [
    "BingoSeventyFive",
    "BingoSeventyFive1",
    "BingoSeventyFive2",
    "BingoNinety",
    "BingoNinety1",
    "BingoNinety2"
  ];

  // Repository repository = Repository();

  @override
  void initState() {
    super.initState();
    hurryUpShakeController = ShakeController();
    initlizeTimer(widget.drawDateTime!, widget.currentDateTime!);
    // _callDge();
  }

  _callGameApi() async {
    drawRequest = {
      "domainCode": AppConstants.domainNameInfiniti,
      "gameCodes": drawGameList,
    };
    sportRequest = {"service": "B2C", "isMobile": true};

    bingoRequest = {
      "gameCodes": bingoGameList,
      "domainCode": AppConstants.domainNameInfiniti,
    };

    if (widget.gameType == 'drawGame') {
      repository.fetchDrawGames(drawRequest).then((result) {
        isApiReadyToCall = true;
        if (result != null) {
          try{
            result.responseData?.gameRespVOs?.forEach((element) {
              if(widget.gameName == element.gameName) {
                initlizeTimer(
                    DateFormat("yyyy-MM-dd hh:mm:ss").parse(element.timeToFetchUpdatedGameInfo ?? "2023-01-01 00:00:00"),
                    DateFormat("yyyy-MM-dd hh:mm:ss").parse(result.responseData?.currentDate ?? "2023-02-01 00:00:00")
                );
              }
            });

          } catch(e) {
            print("drawGame error on time -------------->$e");
          }

        }
      });
    }
    else if (widget.gameType == 'sportGame') {
      isApiReadyToCall = true;
      repository.fetchSportLotteryGames(sportRequest).then((result) {
        if (result != null) {
          try{
            result.responseData?.forEach((element) {
              if (widget.gameName == element.gameName) {
                initlizeTimer(
                    DateFormat("yyyy-MM-dd hh:mm:ss").parse(element.drawData![0].drawFreezeTime ?? "2023-01-01 00:00:00"),
                    // HttpDate.parse(result!.responseData![0].currentTime.toString()));
                    DateFormat("yyyy-MM-dd hh:mm:ss").parse(element.currentTime?? "2023-02-01 00:00:00")
                );
              }
            });

          } catch(e) {
            print("sportGame error on time -------------->$e");
          }
        }
      });
    }

    else if (widget.gameType == "bingo") {
      repository.fetchDrawGames(bingoRequest).then((result) {
        isApiReadyToCall = true;
        if (result != null) {
          try{
            result.responseData?.gameRespVOs?.forEach((element) {
              if(widget.gameName == element.gameName) {
                initlizeTimer(
                    DateFormat("yyyy-MM-dd hh:mm:ss").parse(element.timeToFetchUpdatedGameInfo ?? "2023-01-01 00:00:00"),
                    DateFormat("yyyy-MM-dd hh:mm:ss").parse(result.responseData?.currentDate ?? "2023-02-01 00:00:00")
                );
              }
            });
          } catch(e) {
            print("bingo error on time -------------->$e");
          }

        }
      });
    }
  }

  // _callDge() async {
  //   var request = {
  //     "field": [
  //       "DRAW_INFO",
  //       "CURRENCY",
  //       "BET_INFO",
  //       "DRAW_PRIZE_MULTIPLIER",
  //       "WINNING_RESULT",
  //       "NUMBER_CONFIG",
  //       "GAMES_SCHEMA"
  //     ],
  //     "gameCodes": ["DailyLotto"],
  //     // "domainCode": Common.domainName,
  //   };
  //
  //   await DGEService.fetchGameData(request).then((response) {
  //     gameModel = response ?? GameModel();
  //     widget.callback(gameModel);
  //     drawDateTime =
  //         gameModel.responseData?.gameRespVOs[0].drawRespVOs[0].drawDateTime;
  //     currentDate = gameModel.responseData?.currentDate;
  //
  //     try {
  //       // drawDate = drawDateTime!;
  //       // timeDiff = drawDate.difference(currentDate!).inSeconds;
  //     } catch (e) {
  //       log("Exception Draw Date time @ initState : $e");
  //     }
  //     timer.cancel();
  //     timer = Timer.periodic(duration, (Timer t) {
  //       _handleTick();
  //     });
  //   });
  // }

  _handleTick() {
    if (!mounted) return;
    setState(() {
      if (timeDiff > 0) {
        if (drawDate != widget.currentDateTime) {
          timeDiff = timeDiff - 1;
        }
      } else {
        // Timer(const Duration(milliseconds: 100), () {
        //   showDialog(
        //     barrierDismissible: false,
        //     context: context,
        //     builder: (context) {
        //       Future.delayed(const Duration(seconds: 1), () {
        //         Navigator.of(context).pop(true);
        //       });
        //       return const CupertinoActivityIndicator();
        //     },
        //   );
        // });
        // widget.callback("call");
        if (isApiReadyToCall) {
          print('Times up!');
          isApiReadyToCall = false;
          // widget.callback("");
          _callGameApi();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    int days = timeDiff ~/ (24 * 60 * 60);
    int hours = timeDiff ~/ (60 * 60) % 24;
    int minutes = (timeDiff ~/ 60) % 60;
    int seconds = timeDiff % 60;

    String strDays = (days == 0) ? '' : days.toString().padLeft(2, '0') + ' D : ';
    String strHours = (hours == 0) ? '' : hours.toString().padLeft(2, '0') + ' H : ';
    String strMinutes = minutes.toString().padLeft(2, '0') + ' M : ';
    String strSeconds = seconds.toString().padLeft(2, '0') + ' S';
    if (widget.drawDateTime != null && (days == 0 && hours == 0 && minutes < 1)) {
      try {
        hurryUpShakeController.shake();
      } catch(e) {}

    }
    return FittedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          (widget.drawDateTime != null &&
              (days == 0 && hours == 0 && minutes < 1))
              ? (days == 0 && hours == 0 && minutes == 0 && seconds == 0)
              ?  const SizedBox(width: 20, height: 20, child: CircularProgressIndicator( color: SabanzuriColors.sunflower_yellow,))
              : ShakeWidget(
                  controller: hurryUpShakeController,
                  child: const BlinkingAnimation(
                      text:'Hurry Up'
                  ),
                )
              : const FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              'Ends in', //'Starts In',
              style: TextStyle(
                color: SabanzuriColors.violet_blue,
              ),
              textAlign: TextAlign.end,
            ),
          ),
          Text(
            ((days == 0 && hours == 0 && minutes == 0 && seconds == 0)) ? "" :'$strDays$strHours$strMinutes$strSeconds',
            style: const TextStyle(
              color: SabanzuriColors.yellow_orange_two,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    timer.cancel();
    hurryUpShakeController.dispose();
    super.dispose();
  }

  void initlizeTimer(DateTime? drawDateTime, DateTime? currentDateTime) {
    // gameModel = GameModel();
    // widget.callback(gameModel);

    // drawDateTime =
    //     gameModel.responseData?.gameRespVOs[0].drawRespVOs[0].drawDateTime;
    // currentDate = gameModel.responseData?.currentDate;
    try {
      drawDate = drawDateTime!;
      timeDiff = drawDate.difference(currentDateTime!).inSeconds;
      print("gameName ===================>${widget.gameName}");
      print("drawdate ===================>$drawDate");
      print("currentDateTime ===================>$currentDateTime");
      print("diff ===================>${drawDate.difference(currentDateTime!).inDays}");
      print("-"*40);
    } catch (e) {
      log("Exception Draw Date time @ initState : $e");
    }
    timer.cancel();
    timer = Timer.periodic(duration, (Timer t) {
      _handleTick();
    });
  }
}
