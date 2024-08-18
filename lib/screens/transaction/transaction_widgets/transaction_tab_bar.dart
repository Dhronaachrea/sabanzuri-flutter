part of 'transaction_widget.dart';

class TransactionTabBar extends StatefulWidget {
  final List<Tab> tabBarTitles;
  final List<Widget> tabBarViews;

  const TransactionTabBar({
    Key? key,
    required this.tabBarTitles,
    required this.tabBarViews,
  }) : super(key: key);

  @override
  State<TransactionTabBar> createState() => _TransactionTabBarState();
}

class _TransactionTabBarState extends State<TransactionTabBar>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      initialIndex: 0,
      length: 7,
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
            backgroundColor: SabanzuriColors.white,
            bottom: PreferredSize(
              preferredSize: const Size(
                double.infinity,
                kToolbarHeight,
              ),
              child: TabBar(
                isScrollable: true,
                controller: tabController,
                indicatorPadding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                labelPadding: const EdgeInsets.symmetric(horizontal: 16),
                // Space between tabs
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(300),
                  color: SabanzuriColors.navy,
                ),
                unselectedLabelColor: SabanzuriColors.navy.withOpacity(0.5),
                unselectedLabelStyle: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontFamily: "Roboto",
                  fontStyle: FontStyle.normal,
                  fontSize: 18,
                ),
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontFamily: "Roboto",
                  fontStyle: FontStyle.normal,
                  fontSize: 18.0,
                ),
                labelColor: SabanzuriColors.white,
                tabs: widget.tabBarTitles,
              ),
            ),
          ),
        ),
        Flexible(
          fit: FlexFit.tight,
          child: TabBarView(
            controller: tabController,
            children: widget.tabBarViews,
          ),
        ),
      ],
    );
  }
}
