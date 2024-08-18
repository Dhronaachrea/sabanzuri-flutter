import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sabanzuri/l10n/l10n.dart';
import 'package:sabanzuri/model/dge_game_model.dart';
import 'package:sabanzuri/repo/repository.dart';
import 'package:sabanzuri/utils/app_data.dart';
import 'package:sabanzuri/utils/sabanzuri_colors.dart';
import 'package:sabanzuri/utils/screens.dart';
import 'package:sabanzuri/utils/shared_prefs.dart';
import 'package:sabanzuri/utils/utils.dart';
import 'package:velocity_x/velocity_x.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    _logPrefs();
    //var splashBloc = BlocProvider.of<SplashBloc>(context);
    //splashBloc.add(CheckVersion(context));
    //fetchDgeGames();
    fetchIgeGames();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final Orientation orientation = MediaQuery.of(context).orientation;
    final bool isLandscape = (orientation == Orientation.landscape);

    WidgetsBinding.instance.addPostFrameCallback(
      (_) => Timer(
        const Duration(seconds: 2),
        () {
          Navigator.pushReplacementNamed(
            context,
            Screen.home_screen,
          );
          /*Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => MultiBlocProvider(
            providers: [
              BlocProvider<CheckBonusBloc>(
                create: (BuildContext context) => CheckBonusBloc(),
              ),
              BlocProvider<GameListCubit>(
                create: (BuildContext context) => GameListCubit(),
              ),
            ],
            child: const InfinityHomeScreen(),
          ),
          transitionDuration: const Duration(milliseconds: 500),
          transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        ),
      );*/
        },
      ),
    );

    return Stack(
      children: [
        Image.asset(
          isLandscape ? "assets/images/infiniti_splash_landscape.png" : 'assets/images/infiniti_splash.png',
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Material(
            type: MaterialType.transparency,
            child: Text(
              isLandscape ? "" : context.l10n.splashText,
              style: const TextStyle(
                color: SabanzuriColors.white_two,
                fontWeight: FontWeight.w400,
                fontFamily: "Roboto",
                fontStyle: FontStyle.normal,
                fontSize: 18.0,
              ),
              textAlign: TextAlign.end,
            ).pOnly(
              left: 12,
              right: 12,
              bottom: 40,
            ),
          ),
        ),
      ],
    );
  }

  fetchDgeGames() async {
    DgeGameModel? gameResponse = await Repository.fetchDgeGame('SplashScreen');
    if (gameResponse != null && gameResponse.errorCode == 0) {
      //AppData.setDgeGameData(IgeGameResponse.fromJson(gameResponse));
    }
  }

  fetchIgeGames() async {
    var request = {
      "service": "B2C",
    };
    dynamic gameResponse = await Repository.fetchIgeGamesSplash(request);
    if (gameResponse != null) {
      AppData.setIgeGameData(jsonEncode(gameResponse));
    }
  }

  _logPrefs() async {
    final appPrefs = SharedPrefUtils.getAllAppPrefs();
    log("---------------APP_DATA---------------");
    prettyPrintJson(jsonEncode(appPrefs));

    final userPrefs = SharedPrefUtils.getAllUserPrefs();
    log("---------------USER_DATA---------------");
    prettyPrintJson(jsonEncode(userPrefs));
  }
}
