import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:sabanzuri/model/dge_game_model.dart';
import 'package:sabanzuri/screens/home/ForceUpdatePasswordDialog.dart';
import 'package:sabanzuri/screens/home/bloc/check_bonus/check_bonus_bloc.dart';
import 'package:sabanzuri/screens/home/bloc/check_bonus/check_bonus_event.dart';
import 'package:sabanzuri/screens/home/bloc/check_bonus/check_bonus_state.dart';
import 'package:sabanzuri/screens/login/bloc/login_bloc.dart';
import 'package:sabanzuri/screens/theme/cubit/switch_cubit.dart';
import 'package:sabanzuri/services/api_service.dart';
import 'package:sabanzuri/utils/sabanzuri_colors.dart';
import 'package:sabanzuri/utils/screens.dart';
import 'package:sabanzuri/utils/user_info.dart';
import 'package:sabanzuri/utils/utils.dart';
import 'package:sabanzuri/widgets/game/ige_game/ige_game_card.dart';
import 'package:sabanzuri/widgets/pull_to_referesh.dart';
import 'package:sabanzuri/widgets/sabanzuri_scaffold.dart';
import 'package:sabanzuri/model/ige_game_model.dart';
import 'package:velocity_x/velocity_x.dart';
import 'lobby _game_cubit/game_list_cubit.dart';
import 'lobby _game_cubit/game_list_state.dart';

class InfinityHomeScreen extends StatefulWidget {
  final bool? isFirstTimeLogin;

  const InfinityHomeScreen({Key? key, this.isFirstTimeLogin = false})
      : super(key: key);

  @override
  State<InfinityHomeScreen> createState() => _InfinityHomeScreenState();
}

class _InfinityHomeScreenState extends State<InfinityHomeScreen> {
  DgeGameModel? dgeGameModel;
  IgeGameModel? igeGameModel;
  var clickIndex = -1;
  var gameList = ["Lottery", "Instant", "Sportspool", "Bingo"];
  bool isGameTapped = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      isInternetConnect().then((value) {
        if (value) {
          //BlocProvider.of<DgeGameCubit>(context).fetchDgeGameInfo();
          //BlocProvider.of<IgeGameCubit>(context).fetchIgeGameInfo();

          if (UserInfo.isLoggedIn() && UserInfo.forceUpdatePassword.toLowerCase().contains("yes")) {
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return BlocProvider<LoginBloc>(
                    create: (context) => LoginBloc(),
                    child: WillPopScope(
                        onWillPop: () async{
                          return false;
                        },
                        child: const ForcePasswordChangeDialog()
                    ),
                  );
                }
            );
          }

          if (UserInfo.isLoggedIn()) {
            isInternetConnect().then((value) {
              if (value) {
                fetchHeaderInfo(context);
              } else {
                ApiService.showErrorSheet();
              }
            });
            if (widget.isFirstTimeLogin == true) {
              BlocProvider.of<CheckBonusBloc>(context)
                  .add(CheckBonusCallApiEvent());
            }
          }
        } else {
          ApiService.showErrorSheetHomeLobby();
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkThemeOn = context.watch<SwitchCubit>().state.isDarkThemeOn;
    final Orientation orientation = MediaQuery.of(context).orientation;
    final bool isLandscape = (orientation == Orientation.landscape);

    return PullToRefresh(
        onRefresh: () {
          return Future.delayed(
            const Duration(seconds: 1),
            () {
              if (UserInfo.isLoggedIn()) {
                isInternetConnect().then((value) {
                  if (value) {
                    fetchHeaderInfo(context);
                    /*BlocProvider.of<CheckBonusBloc>(context)
                          .add(CheckBonusCallApiEvent());*/
                  } else {
                    ApiService.showErrorSheet();
                  }
                });
              }
            },
          );
        },
        child: BlocListener<CheckBonusBloc, CheckBonusState>(
          listener: (blocContext, state) {
            if (state is CheckBonusSuccess) {
              var bonusDatas = state.responseData;
              double totalBonus = 0;
              bonusDatas?.forEach((bonusData) {
                totalBonus += bonusData.bonusAmt ?? 0;
              });

              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext ctx) {
                  return  WillPopScope(
                    onWillPop: () async{
                      return false;
                    },
                    child: Dialog(
                      insetPadding:
                      const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),
                      backgroundColor:
                      isDarkThemeOn ? SabanzuriColors.navy : SabanzuriColors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                  height: 90,
                                  width: 90,
                                  child: Image(
                                    image: AssetImage("assets/images/party_popper.png"),
                                    fit: BoxFit.cover,
                                  )
                              ),
                              const HeightBox(20),

                              Text(
                                  "Congratulations!",
                                  style: TextStyle(
                                      color: isDarkThemeOn ? SabanzuriColors.white : SabanzuriColors.navy,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20
                                  )
                              ),
                              const HeightBox(10),
                              Text(
                                "Your Registration is complete.",
                                style: TextStyle(
                                  color: isDarkThemeOn ? SabanzuriColors.white : SabanzuriColors.navy,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                "Enjoy with a welcome bonus of ${UserInfo.getCurrencyCode} $totalBonus",
                                style: TextStyle(
                                  color: isDarkThemeOn ? SabanzuriColors.white : SabanzuriColors.navy,
                                ),
                                textAlign: TextAlign.center,
                              ),

                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  const SizedBox(
                                      width: 180,
                                      height: 100,
                                      child: Image(
                                        image: AssetImage("assets/images/bonus_sprinkal_bg.png"),
                                      )
                                  ),
                                  Text(
                                      "${UserInfo.getCurrencyCode} $totalBonus",
                                      style: TextStyle(
                                          color: isDarkThemeOn ? SabanzuriColors.white : SabanzuriColors.navy,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold
                                      )
                                  ),
                                ],
                              ),

                              InkWell(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: isDarkThemeOn ? SabanzuriColors.white : SabanzuriColors.navy,
                                      borderRadius: BorderRadius.circular(22)
                                  ),
                                  child: Text("Continue", style: TextStyle(color: isDarkThemeOn ? SabanzuriColors.navy : SabanzuriColors.white, fontSize: 20, fontWeight: FontWeight.bold),).pOnly(left: 20, right: 20, top: 10, bottom: 10),
                                ),
                              )
                            ],
                          ).pSymmetric(v: 30, h: 30),
                        ],
                      ),
                    ),
                  );
                },
              );

              /*Alert.show(
                  title: "Bonus Received",
                  subtitle:
                      "Total Bonus : ${UserInfo.getCurrencyCode} $totalBonus",
                  buttonText: context.l10n.ok.toUpperCase(),
                  context: context,
                  isDarkThemeOn: isDarkThemeOn,
                  type: AlertType.success
              );*/
            }
          },
          child: SabanzuriScaffold(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: isDarkThemeOn ? SabanzuriColors.navy_blue : SabanzuriColors.white,
              child: Column(
                children: [
                  isLandscape
                      ? Image.asset(
                    'assets/images/banner_latest.png',
                    fit: BoxFit.fill,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.38,
                  )
                      : AspectRatio(
                          aspectRatio: 2,
                          child: Image.asset(
                            'assets/images/banner_latest.png',
                            fit: BoxFit.fill,
                          )
                        ),
                  Expanded(
                    child: ListView(
                      children: [
                        BlocListener<GameListCubit, GameListState>(
                          listener: (context, state) {
                            if (state is GameListLoaded) {
                              Future.delayed(const Duration(milliseconds: 100), () {
                                Navigator.pushNamed(context, Screen.lobby_screen,
                                    arguments: state.gameName);
                                if (mounted) {
                                  setState(() {
                                    isGameTapped = false;
                                    clickIndex = -1;
                                  });
                                }
                              });
                            }
                          },
                          child: SizedBox(
                            width: double.infinity,
                            // color: SabanzuriColors.navy_blue,
                            child: AbsorbPointer(
                              absorbing: isGameTapped,
                              child: AnimationLimiter(
                                child: GridView.builder(
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: isLandscape ? 3 : 1
                                    ),
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    // itemCount: igeGameCount,
                                    itemCount: 4,
                                    itemBuilder: (context, index) {
                                      return AnimationConfiguration.staggeredGrid(
                                        position: index,
                                        columnCount: 2,
                                        duration: const Duration(seconds: 1),
                                        child: FlipAnimation(
                                          flipAxis: FlipAxis.y,
                                          child: FadeInAnimation(
                                            child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  isGameTapped = true;
                                                  clickIndex = index;
                                                });
                                                isInternetConnect().then(
                                                      (value) {
                                                    if (value) {
                                                      BlocProvider.of<GameListCubit>(context)
                                                          .fetchGameList(gameList[index]);
                                                    } else {
                                                      ApiService.showErrorSheetHomeLobby();
                                                    }
                                                  },
                                                );
                                              },
                                              child: IgeGameCard(
                                                igeGame: null,
                                                index: index,
                                                isDarkThemeOn: isDarkThemeOn,
                                                clickIndex: clickIndex,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }).p(8),
                              )
                            )
                          ),
                        ),
                      ],
                    ),
                  )
                ] ,
              ),
            ).pOnly(left: (isLandscape ? 50 : 0), right: (isLandscape ? 50 : 0)),
          ),
        ));
  }
}
