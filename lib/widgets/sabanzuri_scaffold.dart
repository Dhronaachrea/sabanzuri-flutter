import 'package:flutter/material.dart';
import 'package:sabanzuri/widgets/app_bar.dart';
import 'package:sabanzuri/widgets/drawer/drawer.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class SabanzuriScaffold extends StatefulWidget {
  final Widget child;
  final bool? showAppBar;
  final bool? showDrawer;
  final bool? showBell;
  final bool? showCart;
  final bool? showLogin;
  final String? title;
  final bool? showStatusBar;
  final bool? showBalance;
  final bool? isCartScreen;
  final bool? isInboxScreen;
  final bool? showElevation;
  final BottomNavigationBar? bottomNavigationBar;
  final bool? mResizeToAvoidBottomInset;
  final VoidCallback? updateHome;

  const SabanzuriScaffold({
    Key? key,
    required this.child,
    this.showAppBar = true,
    this.showDrawer = true,
    this.showBell = true,
    this.showCart = false,
    this.showLogin = true,
    this.title,
    this.showStatusBar = true,
    this.showBalance = true,
    this.isCartScreen = false,
    this.isInboxScreen = false,
    this.showElevation,
    this.bottomNavigationBar,
    this.mResizeToAvoidBottomInset = true,
    this.updateHome
  }) : super(key: key);

  @override
  _MyScaffoldState createState() => _MyScaffoldState();
}

class _MyScaffoldState extends State<SabanzuriScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      endDrawerEnableOpenDragGesture: false,
      resizeToAvoidBottomInset: widget.mResizeToAvoidBottomInset ?? true,
      appBar: SabanzuriAppBar(
        showAppBar: widget.showAppBar,
        showDrawer: widget.showDrawer,
        showBell: widget.showBell,
        showCart: widget.showCart,
        showLogin: widget.showLogin,
        title: widget.title,
        showStatusBar: widget.showStatusBar,
        showBalance: widget.showBalance,
        isCartScreen: widget.isCartScreen,
        isInboxScreen: widget.isInboxScreen,
        showElevation: widget.showElevation
      ),
      body: widget.child,
      drawer: const SabanzuriDrawer(),
      bottomNavigationBar: widget.bottomNavigationBar,
    );
  }
}
