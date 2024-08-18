import 'package:flutter/material.dart';
import 'package:sabanzuri/l10n/l10n.dart';
import 'package:sabanzuri/screens/initiate_withdraw/withdrawal_initiate_screen.dart';
import 'package:sabanzuri/screens/wallet/wallet_widget/wallet_widget.dart';
import 'package:sabanzuri/utils/user_info.dart';
import 'package:sabanzuri/widgets/sabanzuri_scaffold.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    return SabanzuriScaffold(
      showDrawer: false,
      title: context.l10n.myWallet,
      child: WalletTabBar(
        tabBarTitles: [
          if(UserInfo.profileType != "ANONYMOUS")...[
            Tab(text: context.l10n.deposit),
          ],
          Tab(text: context.l10n.withdrawal),
        ],
        tabBarViews: [
          if(UserInfo.profileType != "ANONYMOUS")...[
            const DepositScreen(),
          ],
          // WithdrawalScreen(),
          const WithdrawalInitiateScreen(showAppBar: false,),
        ],
      ),
    );
  }
}
