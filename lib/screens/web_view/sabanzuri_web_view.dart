import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sabanzuri/screens/lobby/lobby_model/NewDrawGamesResponse.dart' as DgeResponse;
import 'package:sabanzuri/screens/lobby/lobby_model/ige_game_response.dart';
import 'package:sabanzuri/screens/login/bloc/login_bloc.dart';
import 'package:sabanzuri/screens/login/login_screen.dart';
import 'package:sabanzuri/services/api_service.dart';
import 'package:sabanzuri/utils/app_constants.dart';
import 'package:sabanzuri/utils/auth/auth_bloc.dart';
import 'package:sabanzuri/utils/sabanzuri_colors.dart';
import 'package:sabanzuri/utils/screens.dart';
import 'package:sabanzuri/utils/url.dart';
import 'package:sabanzuri/utils/user_info.dart';
import 'package:sabanzuri/widgets/sabanzuri_scaffold.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:sabanzuri/utils/utils.dart';import 'package:sabanzuri/widgets/printing_dialog.dart';

import '../lobby/lobby_model/sport_lottery_response.dart';

class SabanzuriWebView extends StatefulWidget {
  // final Fivebyninety? dgeGame;
  // final GameRespVo? dgeGameInfiniti;
  final DgeResponse.GameRespVOs? dgeGameInfiniti;
  final DgeResponse.GameRespVOs? bingoGameInfiniti;
  final ResponseData? sportsLotty;
  final Games? igeGame;
  final String? gameUrl;
  final NEW? igeResponse;

  const SabanzuriWebView({Key? key,this.dgeGameInfiniti, this.igeGame, this.gameUrl, this.igeResponse, this.sportsLotty, this.bingoGameInfiniti})
      : super(key: key);

  @override
  _SabanzuriWebViewState createState() => _SabanzuriWebViewState();
}

class _SabanzuriWebViewState extends State<SabanzuriWebView> {
  late WebViewController _controller;
  double progress = 0;
  String finalUrlString = '';
  String url = '';
  String gameUrl = AppConstants.gameUrl;
  String gameType = AppConstants.dgeGameType;
  String gameCode = '';
  Map<String, dynamic> printingDataArgs = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getAllPrefs();
    });
  }

  _getAllPrefs() {
    String totalBalance = context.read<AuthBloc>().cashBalance ?? "0";
    /*var jsonMap = jsonDecode(AppData.versionResponse);
    VersionResponse versionResponse = VersionResponse.fromJson(jsonMap);*/
    if (widget.dgeGameInfiniti != null) {
      gameUrl = AppConstants.dgeGameBaseUrlInfiniti;
      gameType = AppConstants.dgeGameType;//dge
      gameCode = (widget.dgeGameInfiniti?.gameCode ?? "").toLowerCase();

      url = gameUrl +
          gameType +
          "/" +
          gameCode +
          "/" +
          (UserInfo.userId == '' ? '-' : UserInfo.userId) +
          "/" +
          (UserInfo.isLoggedIn() ? UserInfo.userName == '' ? UserInfo.mobNumber : UserInfo.userName : "-") +
          "/" +
          (UserInfo.userToken == '' ? '-' : UserInfo.userToken) +
          "/" +
          totalBalance //TotalBalance
          +
          "/" +
          AppConstants.language +
          "/" +
          (UserInfo.currencyDisplayCode.isNotEmpty ? UserInfo.currencyDisplayCode : "EUR") +
          "/" +
          (UserInfo.currencyDisplayCode.isNotEmpty ? UserInfo.currencyDisplayCode : "EUR") +
          "/" +
          AppConstants.domainNameInfiniti +
          "/" +
          "1";

    }
    else if (widget.sportsLotty != null) {
      // https://dm-node1-wls.infinitilotto.com/sle/soccer4/1302/clientdemo123/8d035341cf24288f80deccb84e902b90/8567.16/en/BTC/BTC/ice.igamew.com/0
      url = Url.SPORT_LOTTY_WEB_BASE_URL
          + "/sle/"
          + (widget.sportsLotty?.gameCode ?? "").replaceAll("_", "").toLowerCase()
          + "/" +
          (UserInfo.userId == '' ? '-' : UserInfo.userId) +
          "/" +
          (UserInfo.isLoggedIn() ? UserInfo.userName == '' ? UserInfo.mobNumber : UserInfo.userName : "-") +
          "/" +
          (UserInfo.userToken == '' ? '-' : UserInfo.userToken) +
          "/" +
          totalBalance //TotalBalance
          +
          "/" +
          AppConstants.language +
          "/" +
          (UserInfo.currencyDisplayCode.isNotEmpty ? UserInfo.currencyDisplayCode : "EUR") +
          "/" +
          (UserInfo.currencyDisplayCode.isNotEmpty ? UserInfo.currencyDisplayCode : "EUR") +
          "/" +
          AppConstants.domainNameInfiniti +
          "/" +
          "1";
    }
    else if (widget.bingoGameInfiniti != null) {
      // https://games-wls.infinitilotto.com/bingo/bingoseventyfive/1302/clientdemo123/8d035341cf24288f80deccb84e902b90/1297276.75/en/USD/USD/ice.igamew.com/0
      url = Url.GAME_BASE_URL
          + "/bingo/"
          + (widget.bingoGameInfiniti?.gameCode ?? "").toLowerCase()
          + "/" +
          (UserInfo.userId == '' ? '-' : UserInfo.userId) +
          "/" +
          (UserInfo.isLoggedIn() ? UserInfo.userName == '' ? UserInfo.mobNumber : UserInfo.userName : "-") +
          "/" +
          (UserInfo.userToken == '' ? '-' : UserInfo.userToken) +
          "/" +
          totalBalance //TotalBalance
          +
          "/" +
          AppConstants.language +
          "/" +
          (UserInfo.currencyDisplayCode.isNotEmpty ? UserInfo.currencyDisplayCode : "EUR") +
          "/" +
          (UserInfo.currencyDisplayCode.isNotEmpty ? UserInfo.currencyDisplayCode : "EUR") +
          "/" +
          AppConstants.domainNameInfiniti +
          "/" +
          "1";
    }
    else {
      // gameUrl = versionResponse.gameEngineInfo?.ige?.serverUrl ?? AppConstants.gameUrl;
      gameUrl = AppConstants.dgeGameBaseUrlInfiniti;
      gameType = AppConstants.igeGameTypeInfiniti;
      // gameCode = widget.igeGame?.gameNumber.toString() ?? "" ;
      gameCode = (widget.igeGame?.gameNumber ?? "").toString() + "/buy";

      url = '${widget.igeResponse?.params?.repo}?' +
          'root=${widget.igeResponse?.params?.root}' +
          '&gameNum=${widget.igeGame?.gameNumber}' +
          '&gameMode=buy' +
          '&domainName=${AppConstants.domainNameInfiniti}' +
          '&merchantKey=${widget.igeResponse?.params?.merchantKey}' +
          '&secureKey=${widget.igeResponse?.params?.secureKey}' +
          '&currencyCode=${UserInfo.currencyDisplayCode}' +
          '&lang=${widget.igeResponse?.params?.lang}' +
          '&gameType=scratch' +
          '&playerId=${UserInfo.userId}' +
          '&merchantSessionId=${UserInfo.userToken}' +
          '&balance=${UserInfo.totalBalance}' +
          '&commCharge=0' +
          '&userAgentIge=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.81 Safari/537.36' +
          '&deviceType=MOBILE_WEB' +
          '&appType=WEB' +
          '&clientType=FLASH' +
          '&ticketPrice=' +
          '&launchIc=${widget.igeGame?.imagePath}' +
          '&prizeSchemeIge=${json.encode(widget.igeGame?.prizeSchemes?.toJson())}' +
          '&loaderImage=${json.encode(widget.igeGame?.loaderImage?.toJson())}' +
          '&currencyDisplay=${UserInfo.currencyDisplayCode}' +
          '&merchantCode=${widget.igeResponse?.params?.merchantCode}' +
          '&name=${widget.igeResponse?.params?.domainName}' +
          '&deviceCheck=false' +
          '&priceSchemes=${json.encode(widget.igeGame?.prizeSchemes?.toJson())}' +
          '&prizeSchemeId={widget.igeGame?.prizeSchemes?.d441' +
          '&bonusMultiplier=${widget.igeGame?.bonusMultiplier}' +
          '&productInfo=${json.encode(widget.igeGame?.productInfo?.toJson())}' +
          // '&isNative=${Platform.isAndroid ? 'android' : 'ios'}';
          '&isNative=android';

    }
    //ige kenya ------> https://kenya-games.lottoweaver.com/ige/KENYA/1/buy/1302/clientdemo123/oUpyJ_Qzdgl5vZ4BB-9yOwVXFRqntZNOsgSfZe9XN_M/9218.53/en/KES/KES/www.sabanzuri.com/1
    //bingo infiniti -> https://games-wls.infinitilotto.com/bingo/bingoseventyfive/1302/clientdemo123/8d035341cf24288f80deccb84e902b90/1297276.75/en/USD/USD/ice.igamew.com/0
    //sportslotto --->  https://dm-node1-wls.infinitilotto.com/sle/soccer4/1302/clientdemo123/8d035341cf24288f80deccb84e902b90/8567.16/en/BTC/BTC/ice.igamew.com/0
    //dge infiniti ---> https://games-wls.infinitilotto.com/dge/luckysix/1302/clientdemo123/8d035341cf24288f80deccb84e902b90/1297276.75/en/USD/USD/ice.igamew.com/0
    //ige infiniti ---> https://www.infinitilotto.com/IWG_Single_Asset/index.php?root=http://172.31.64.13:8089/InstantGameEngineMS/&gameNum=1&gameMode=buy&domainName=ice.igamew.com&merchantKey=4&secureKey=12345678&currencyCode=EUR&lang=english&gameType=scratch&playerId=1412&merchantSessionId=v2iIgKw5K1WsVJ5U7FyP3YsjyDKKXDC5tXU-2Xfsvp8&balance=10038.52&commCharge=0&userAgentIge=Mozilla/5.0
    log("gameUrl: $gameUrl");
    log("gameURL: : $url");

    finalUrlString = url;
    isInternetConnect().then((value) {
      if(value) {
        setState(() {});
      } else {
        ApiService.showErrorSheet();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldBody = WillPopScope(
      onWillPop: () async {
        if (UserInfo.isLoggedIn()) {
          isInternetConnect().then((value) {
            if(value) {
              fetchHeaderInfo(navigatorKey.currentContext ?? context);
            } else {
              ApiService.showErrorSheet();
            }
          });
        }
        return true;
      },
      child: SafeArea(
        child: Stack(
          children: [
            finalUrlString != ''
                ? WebView(
              initialUrl: finalUrlString,
              zoomEnabled: false,
              navigationDelegate: (action) {
                return NavigationDecision.navigate;
              },
              javascriptMode: JavascriptMode.unrestricted,
              javascriptChannels: {
                JavascriptChannel(
                  name: 'goToHome',
                  onMessageReceived: (JavascriptMessage response) {
                    log("goToHome response : ${response.message}");
                    Navigator.pop(context);
                    if (UserInfo.isLoggedIn()) {
                      isInternetConnect().then((value) {
                        if(value) {
                          fetchHeaderInfo(navigatorKey.currentContext ?? context);
                        } else {
                          ApiService.showErrorSheet();
                        }
                      });
                    }
                  },
                ),
                JavascriptChannel(
                  name: 'loadInstantGameUrl',
                  onMessageReceived: (JavascriptMessage responseUrl) {
                    log("loadInstantGameUrl responseUrl : ${responseUrl.message}");
                    // finalUrlString = '${responseUrl.message}&isNative=android';
                    // _controller.loadUrl(finalUrlString);
                  },
                ),
                JavascriptChannel(
                  name: 'showLoginDialog',
                  onMessageReceived: (JavascriptMessage response) {
                    log("showLoginDialog response : ${response.message}");
                    // Navigator.pop(context);
                    // Navigator.popUntil(context, )
                    Navigator.pushNamedAndRemoveUntil (context, Screen.home_screen ,(route) => false);
                    onConfirmLogout(context);
                    showDialog(
                      context: context,
                      builder: (context) => BlocProvider<LoginBloc>(
                        create: (context) => LoginBloc(),
                        child: LoginScreen(
                          onLoginNavCallback: _onLoginCallBack,
                        ),
                      ),
                    );
                  },
                ),
                JavascriptChannel(
                  name: 'onBalanceUpdate',
                  onMessageReceived: (JavascriptMessage response) {
                    log("onBalanceUpdate response : ${response.message}");
                    if (UserInfo.isLoggedIn()) {
                      isInternetConnect().then((value) {
                        if(value) {
                          fetchHeaderInfo(navigatorKey.currentContext ?? context);
                        } else {
                          ApiService.showErrorSheet();
                        }
                      });
                    }
                  },
                ),
                JavascriptChannel(
                  name: 'loginWindow',
                  onMessageReceived: (JavascriptMessage response) {
                    log("loginWindow response : ${response.message}");
                  },
                ),
                JavascriptChannel(
                  name: 'backToLobby',
                  onMessageReceived: (JavascriptMessage response) {
                    log("backToLobby response : ${response.message}");
                  },
                ),
                JavascriptChannel(
                  name: 'reloadGame',
                  onMessageReceived: (JavascriptMessage response) {
                    log("reloadGame response : ${response.message}");
                  },
                ),
                JavascriptChannel(
                  name: 'updateBal',//working
                  onMessageReceived: (JavascriptMessage response) {
                    log("updateBal response ");
                    if (UserInfo.isLoggedIn()) {
                      isInternetConnect().then((value) {
                        if(value) {
                          fetchHeaderInfo(navigatorKey.currentContext ?? context);
                        } else {
                          ApiService.showErrorSheet();
                        }
                      });
                    }
                  },
                ),
                JavascriptChannel(
                  name: 'getWindowDimensions',
                  onMessageReceived: (JavascriptMessage response) {
                    log("getWindowDimensions response : ${response.message}");
                  },
                ),
                JavascriptChannel(
                  name: 'sendSaleData',
                  onMessageReceived: (JavascriptMessage response) {
                    log("sendSaleData response : ${response}");
                    log("sendSaleData response.msg : ${response.message}");// get response for print slip


                    printingDataArgs["saleResponse"] = jsonEncode(response.message);
                    PrintingDialog().show(
                        context: context,
                        title: "print",
                        isRetryButtonAllowed: false,
                        buttonText: "retry",
                        printingDataArgs: printingDataArgs,
                        onPrintingDone: () {
                          /*SharedPrefUtils.setSaleTicketResponse  = "";
                          SharedPrefUtils.setDgeLastSaleTicketNo = lastTicketNumber;
                          SharedPrefUtils.setDgeLastSaleGameCode = lastGameCode;
                          SharedPrefUtils.setLastReprintTicketNo = lastTicketNumber;*/
                          // widget.onComingToPreviousScreen("isBuyPerformed");
                          Navigator.of(context).pop(true);
                        },
                        onPrintingFailed: () {
                          // SharedPrefUtils.setSaleTicketResponse  = "";
                          // SharedPrefUtils.setDgeLastSaleGameCode = lastGameCode;
                          /*if (SharedPrefUtils.getDgeLastSaleTicketNo == "" ||
                      SharedPrefUtils.getDgeLastSaleTicketNo == "0") {
                    SharedPrefUtils.setDgeLastSaleTicketNo = "-1";
                    SharedPrefUtils.setDgeLastSaleGameCode = lastGameCode;
                  }*/

                          // cancelTicket(lastTicketNumber);

                        },
                        isPrintingForSale: true
                    );

                  },
                ),
              },
              onWebViewCreated: (WebViewController webViewController) {
                _controller = webViewController;
                //_controller.clearCache();
                isInternetConnect().then((value) {
                  if(value) {
                    _controller.loadUrl(Uri.parse(finalUrlString).toString());
                  } else {
                    ApiService.showErrorSheet();
                  }
                });
                // _controller.loadUrl(Uri.parse('https://kenya-games.lottoweaver.com/ige/KENYA/105/buy/466691/777777777/ioaQ3tTB6OhxCPPYt3nW4mjBSG4VG-W0wv4TuNEyq7E/0.00/en/KES/KES/www.sabanzuri.com/1').toString());
                log(finalUrlString);
              },
              onWebResourceError: (error) {
                print("WEB view error:----------->${error}");
                print("WEB view error fail url:----------->${error.failingUrl}");
                print("WEB view error discrip :----------->${error.description}");
                print("WEB view error domain:----------->${error.domain}");
                print("WEB view error type:----------->${error.errorType}");
              },
              onPageFinished: (url) {
                print("------------>$url");
              },
              debuggingEnabled: false,
              onProgress: (progress) {
                setState(() {
                  this.progress = progress / 100;
                });
              },
            )
                : Container(),
            progress < 1.0
                ? LinearProgressIndicator(
              value: progress,
              backgroundColor: SabanzuriColors.yellow_orange,
            )
                : Container(),
          ],
        ),
      ),
    );
    return widget.dgeGameInfiniti == null
        ? SabanzuriScaffold(
      title: widget.igeGame?.gameName,
      showDrawer: false,
      showAppBar: false,
      child: scaffoldBody,
    )
        : SabanzuriScaffold(
      showAppBar: false,
      child: scaffoldBody,
    );
  }

  _onLoginCallBack() {
    _getAllPrefs();

    _controller.loadUrl(finalUrlString);
  }
}
