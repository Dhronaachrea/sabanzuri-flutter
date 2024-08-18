part of 'wallet_widget.dart';

class WalletTabBar extends StatefulWidget {
  final List<Tab> tabBarTitles;
  final List<Widget> tabBarViews;

  const WalletTabBar({
    Key? key,
    required this.tabBarTitles,
    required this.tabBarViews,
  }) : super(key: key);

  @override
  State<WalletTabBar> createState() => _WalletTabBarState();
}

class _WalletTabBarState extends State<WalletTabBar>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );

    tabController.addListener(
          () {
        if (tabController.indexIsChanging ||
            tabController.index != tabController.previousIndex) {
          FocusScope.of(context).unfocus();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          color: SabanzuriColors.white,
          height: kToolbarHeight,
          child: AppBar(
            backgroundColor: SabanzuriColors.pinkish_grey.withOpacity(0.1),
            bottom: PreferredSize(
              preferredSize: const Size(
                double.infinity,
                kToolbarHeight,
              ),
              child: TabBar(
                controller: tabController,
                indicator: const UnderlineTabIndicator(
                  borderSide: BorderSide(
                    width: 6,
                    color: SabanzuriColors.violet_blue,
                  ),
                ),
                unselectedLabelColor: SabanzuriColors.navy.withOpacity(0.5),
                unselectedLabelStyle: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontFamily: "Roboto",
                  fontStyle: FontStyle.normal,
                  fontSize: 20,
                ),
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontFamily: "Roboto",
                  fontStyle: FontStyle.normal,
                  fontSize: 20.0,
                ),
                labelColor: SabanzuriColors.violet_blue,
                tabs: widget.tabBarTitles,
              ),
            ),
          ),
        ),
        Flexible(
          fit: FlexFit.loose,
          child: TabBarView(
            controller: tabController,
            children: widget.tabBarViews,
          ),
        ),
      ],
    );
  }
}
