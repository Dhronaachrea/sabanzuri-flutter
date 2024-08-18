import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sabanzuri/l10n/l10n.dart';
import 'package:sabanzuri/screens/login/bloc/login_bloc.dart';
import 'package:sabanzuri/screens/login/login_screen.dart';
import 'package:sabanzuri/utils/screens.dart';
import 'package:sabanzuri/utils/user_info.dart';
import 'package:sabanzuri/widgets/drawer/drawer_widgets/drawer_grid_tile.dart';
import 'drawer_title.dart';

class MyAccount extends StatelessWidget {
  const MyAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    final bool isLandscape = (orientation == Orientation.landscape);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DrawerTitle(title: context.l10n.myAccount.toUpperCase()),
        // DrawerTile(
        //   heading: context.l10n.myProfile,
        //   onTap: () {
        //     UserInfo.isLoggedIn()
        //         ? Navigator.pushNamed(context, Screen.profile_screen)
        //         : showDialog(
        //             context: context,
        //             builder: (context) => BlocProvider<LoginBloc>(
        //               create: (context) => LoginBloc(),
        //               child: const LoginScreen(),
        //             ),
        //           );
        //   },
        // ),
        // DrawerTile(
        //   heading: context.l10n.myTickets,
        //   onTap: () {
        //     UserInfo.isLoggedIn()
        //         ? Navigator.pushNamed(context, Screen.ticket_screen)
        //         : showDialog(
        //             context: context,
        //             builder: (context) => BlocProvider<LoginBloc>(
        //               create: (context) => LoginBloc(),
        //               child: const LoginScreen(),
        //             ),
        //           );
        //   },
        // ),
        // DrawerTile(
        //   heading: context.l10n.myWallet,
        //   onTap: () {
        //     UserInfo.isLoggedIn()
        //         ? Navigator.pushNamed(context, Screen.wallet_screen)
        //         : showDialog(
        //             context: context,
        //             builder: (context) => BlocProvider<LoginBloc>(
        //               create: (context) => LoginBloc(),
        //               child: const LoginScreen(),
        //             ),
        //           );
        //   },
        // ),
        // DrawerTile(
        //   heading: context.l10n.myTransactions,
        //   onTap: () {
        //     UserInfo.isLoggedIn()
        //         ? Navigator.pushNamed(context, Screen.transaction_screen)
        //         : showDialog(
        //             context: context,
        //             builder: (context) => BlocProvider<LoginBloc>(
        //               create: (context) => LoginBloc(),
        //               child: const LoginScreen(),
        //             ),
        //           );
        //   },
        // ),
        // DrawerTile(
        //   heading: context.l10n.inbox,
        //   onTap: () {
        //     UserInfo.isLoggedIn()
        //         ? Navigator.pushNamed(context, Screen.inbox_screen)
        //         : showDialog(
        //             context: context,
        //             builder: (context) => BlocProvider<LoginBloc>(
        //               create: (context) => LoginBloc(),
        //               child: const LoginScreen(),
        //             ),
        //           );
        //   },
        // ),
        // new design
        GridView(
          padding: const EdgeInsets.only(bottom: 0),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 1,
            crossAxisCount: isLandscape ? 4 : 3,
          ),
          children: [
            DrawerGridTile(
              icon: const AssetImage('assets/icons/user.png'),
              title: context.l10n.myProfile,
              onTap: () {
                UserInfo.isLoggedIn()
                    ? Navigator.pushNamed(context, Screen.profile_screen)
                    : showDialog(
                        context: context,
                        builder: (context) => BlocProvider<LoginBloc>(
                          create: (context) => LoginBloc(),
                          child: const LoginScreen(),
                        ),
                      );
              },
            ),
            DrawerGridTile(
              icon: const AssetImage('assets/icons/tickets.png'),
              title: context.l10n.myTickets,
              onTap: () {
                UserInfo.isLoggedIn()
                    ? Navigator.pushNamed(context, Screen.ticket_screen_infiniti_lotto)
                    : showDialog(
                        context: context,
                        builder: (context) => BlocProvider<LoginBloc>(
                          create: (context) => LoginBloc(),
                          child: const LoginScreen(),
                        ),
                      );
              },
            ),
            /*DrawerGridTile(
              icon: const AssetImage('assets/icons/wallet.png'),
              title: context.l10n.myWallet,
              onTap: () {
                *//*UserInfo.isLoggedIn()
                    ? Navigator.pushNamed(context, Screen.wallet_screen)
                    : showDialog(
                        context: context,
                        builder: (context) => BlocProvider<LoginBloc>(
                          create: (context) => LoginBloc(),
                          child: const LoginScreen(),
                        ),
                      );*//*
              },
            ),*/
            DrawerGridTile(
              icon: const AssetImage('assets/icons/transactions.png'),
              title: context.l10n.myTransactions,
              onTap: () {
                UserInfo.isLoggedIn()
                    ? Navigator.pushNamed(context, Screen.transaction_screen)
                    : showDialog(
                        context: context,
                        builder: (context) => BlocProvider<LoginBloc>(
                          create: (context) => LoginBloc(),
                          child: const LoginScreen(),
                        ),
                      );
              },
            ),
            DrawerGridTile(
              icon: const AssetImage('assets/icons/inbox.png'),
              title: context.l10n.inbox,
              onTap: () {
                UserInfo.isLoggedIn()
                    ? Navigator.pushNamed(context, Screen.inbox_screen)
                    : showDialog(
                        context: context,
                        builder: (context) => BlocProvider<LoginBloc>(
                          create: (context) => LoginBloc(),
                          child: const LoginScreen(),
                        ),
                      );
              },
            ),
            DrawerGridTile(
              icon: const AssetImage('assets/icons/high_five.png'),
              title: context.l10n.referAFriend,
              onTap: () {
                UserInfo.isLoggedIn()
                    ? Navigator.pushNamed(context, Screen.refer_a_friend_screen)
                    : showDialog(
                        context: context,
                        builder: (context) => BlocProvider<LoginBloc>(
                          create: (context) => LoginBloc(),
                          child: const LoginScreen(),
                        ),
                      );
              },
            ),
            DrawerGridTile(
              icon: const AssetImage('assets/icons/wallet.png'),
              title: context.l10n.myWallet,
              onTap: () {
                UserInfo.isLoggedIn()
                    ? Navigator.pushNamed(context, Screen.wallet_screen)
                    : showDialog(
                        context: context,
                        builder: (context) => BlocProvider<LoginBloc>(
                          create: (context) => LoginBloc(),
                          child: const LoginScreen(),
                        ),
                      );
              },
            ),
          ],
        ),
      ],
    );
  }
}
