import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:sabanzuri/screens/login/bloc/login_bloc.dart';
import 'package:sabanzuri/screens/login/login_screen.dart';
import 'package:sabanzuri/services/api_service.dart';
import 'package:sabanzuri/utils/sabanzuri_colors.dart';
import 'package:sabanzuri/utils/user_info.dart';
import 'package:sabanzuri/widgets/sabanzuri_scaffold.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:sabanzuri/utils/utils.dart';

class DrawerWebView extends StatefulWidget {
  final String url;
  final bool showAppBar;

  const DrawerWebView({
    Key? key,
    required this.url,
    this.showAppBar = false,
  }) : super(key: key);

  @override
  _DrawerWebViewState createState() => _DrawerWebViewState();
}

class _DrawerWebViewState extends State<DrawerWebView> {
  late WebViewController _controller;
  double progress = 0;

  @override
  Widget build(BuildContext context) {
    final scaffoldBody = SafeArea(
      child: Stack(
        children: [
          widget.url != ''
              ? Container(
            width: double.infinity,
            height: double.infinity,
            color: SabanzuriColors.white,
            child: WebView(
              navigationDelegate: (action) {
                return NavigationDecision.navigate;
              },
              javascriptMode: JavascriptMode.unrestricted,
              zoomEnabled: false,
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
                  name: 'showLoginDialog',
                  onMessageReceived: (JavascriptMessage response) {
                    log("showLoginDialog response : ${response.message}");
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
                    isInternetConnect().then((value) {
                      if(value) {
                        fetchHeaderInfo(context);
                      } else {
                        ApiService.showErrorSheet();
                      }
                    });
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
                    log("reloadGame response1 : ${response.message}");
                  },
                ),
                JavascriptChannel(
                  name: 'getWindowDimensions',
                  onMessageReceived: (JavascriptMessage response) {
                    log("getWindowDimensions response : ${response.message}");
                  },
                ),
              },
              onWebViewCreated: (WebViewController webViewController) {
                _controller = webViewController;
                isInternetConnect().then((value) {
                  if(value) {
                    _controller.loadUrl(Uri.parse(widget.url).toString());
                  } else {
                    ApiService.showErrorSheet();
                  }
                });
              },
              onPageFinished: (url) {
                print("===============>$url");
              },
              debuggingEnabled: false,
              onProgress: (progress) {

                setState(() {
                  this.progress = progress / 100;
                });
              },
            ).p(13),
          )
              : Container(
            color: Colors.white,
          ),
          progress < 1.0
              ? Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            child: Center(
              child: SizedBox(
                  width: 60,
                  height: 60,
                  child: Lottie.asset('assets/lottie/gradient_loading.json')),
            ),
          )
              : Container(),
        ],
      ),
    );
    return widget.showAppBar
        ? SabanzuriScaffold(
      showDrawer: false,
      child: scaffoldBody,
    )
        : Container(
      child: scaffoldBody,
    );
  }

  _onLoginCallBack() {
    _controller.loadUrl(widget.url);
  }
}
