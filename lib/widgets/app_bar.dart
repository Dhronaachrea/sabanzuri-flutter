import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sabanzuri/l10n/l10n.dart';
import 'package:sabanzuri/screens/home/ForceUpdatePasswordDialog.dart';
import 'package:sabanzuri/utils/sabanzuri_colors.dart';
import 'package:sabanzuri/widgets/sabanzuri_button.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:sabanzuri/screens/login/bloc/login_bloc.dart';
import 'package:sabanzuri/screens/login/login_screen.dart';
import 'package:sabanzuri/utils/auth/auth_bloc.dart';
import 'package:sabanzuri/utils/user_info.dart';

import '../utils/screens.dart';

class SabanzuriAppBar extends StatefulWidget implements PreferredSizeWidget {
  final bool? showAppBar;
  final bool? showDrawer;
  final bool? showBell;
  final bool? showCart;
  final bool? showLogin;
  final bool? showBalance;
  final String? title;
  final bool? showStatusBar;
  final bool? isCartScreen;
  final bool? isInboxScreen;
  final bool? showElevation;

  const SabanzuriAppBar({
    Key? key,
    this.showAppBar,
    this.showDrawer,
    this.showBell,
    this.showCart,
    this.showLogin,
    this.title,
    this.showStatusBar,
    this.showBalance,
    this.isCartScreen,
    this.isInboxScreen,
    this.showElevation
  }) : super(key: key);

  @override
  _MyAppBarState createState() => _MyAppBarState();

  @override
  Size get preferredSize => showAppBar == true
      ? const Size(double.infinity, kToolbarHeight)
      : const Size(double.infinity, 0);
}

class _MyAppBarState extends State<SabanzuriAppBar> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      String? userName;
      String? cashBalance;
      var usrName = UserInfo.userName.isNotEmpty == true ? UserInfo.userName : UserInfo.mobNumber;
      userName    = context.watch<AuthBloc>().userName?.isNotEmpty == true ? context.watch<AuthBloc>().userName : usrName;
      cashBalance = UserInfo.cashBalance;// total balance

      return Container(
        color: widget.showStatusBar == true
            ? SabanzuriColors.navy
            : Colors.transparent,
        child: SafeArea(
          left: false,
          right: false,
          bottom: false,
          child: AppBar(
            elevation: widget.showElevation == false ? 0 : 4,
            centerTitle: false,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/appbar_image.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            backgroundColor: Colors.transparent,
            leading: widget.showDrawer == true
                ? MaterialButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              child: Image.asset('assets/icons/ham_menu.png'),
            )
                : MaterialButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Image.asset('assets/icons/back.png'),
            ),
            title: widget.title != null
                ? FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(widget.title!),
            )
                : SizedBox(
              height: kToolbarHeight * 0.8,
              child: Image.asset('assets/images/logo_white.png', width: 60, height: 60),
            ),
            actions: [
              // const WidthBox(20),
              widget.showLogin == true
                  ? UserInfo.isLoggedIn()
                  ? Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width:150,
                      child: Text(
                          "$userName",
                          textAlign: TextAlign.end,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: SabanzuriColors.white,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Roboto",
                            fontStyle: FontStyle.italic,
                            fontSize: 14.0,
                          )
                      ),
                    ),
                    Text(
                        "${UserInfo.getCurrencyCode} $cashBalance",
                        textAlign: TextAlign.end,
                        style: const TextStyle(
                          color: SabanzuriColors.white,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Roboto",
                          fontStyle: FontStyle.italic,
                          fontSize: 14.0,
                        )
                    )
                  ],
                ).pOnly(right: 8),
              )
                  : Row(
                children: [
                  widget.showDrawer == true
                      ? InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, Screen.scan_screen).then((value) {
                              setState(() {
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
                              });

                            });
                            /*AlertScanDialog.show(
                                type: AlertType.confirmation,
                                title: "Scan Qr",
                                subtitle: "Scan to play instantly.",
                                buttonText: context.l10n.ok.toUpperCase(),
                                context: context,
                                buttonClick: (Map<String, String> data) {


                                  BlocProvider.of<RegistrationBloc>(context).add(
                                    *//*RegistrationUsingScan(
                                                context: context,
                                                username: "5ec2f4a5-b1e8-4ce0-ad9f-c65619c5a7d1",
                                                currencyCode: "EUR",
                                                countryCode: "US"
                                              )*//*
                                      RegistrationUsingScan(
                                          context: context,
                                          username: "${data["couponCode"]}",
                                          currencyCode: "${data["currencyCode"]}",
                                          countryCode: "${data["countryCode"]}"
                                      )
                                  );
                                }

                            );*/
                          },
                          child: Row(
                            children: [
                              Image.asset("assets/icons/scaner_icon.png", width: 30, height: 30),
                              const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("SCAN", style: TextStyle(color: SabanzuriColors.white,fontSize: 9),),
                                  Text("QR", style: TextStyle(color: SabanzuriColors.white,fontSize: 13),),
                                ],
                              ).pOnly(left: 10)
                            ],
                          )

                          //const Icon(Icons.document_scanner_outlined, color: SabanzuriColors.yellow_orange, size: 30)
                      )
                      : Container(),
                  PrimaryButton(
                    borderColor: SabanzuriColors.white,
                    textColor: SabanzuriColors.white,
                    type: ButtonType.line_art,
                    onPressed: _loginOrSignUp,
                    text: context.l10n.loginOrSignup,
                    borderRadius: 67,
                  ).px(4)
                ],
              )
                  : const SizedBox(),
            ],
          ),
        ),
      );
    });
  }

  Future _loginOrSignUp() {
    return showDialog(
      context: context,
      builder: (context) => BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(),
        child: const LoginScreen(),
      ),
    );
  }
}
