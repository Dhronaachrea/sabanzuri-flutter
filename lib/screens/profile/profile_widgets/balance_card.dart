part of 'profile_widget.dart';

class BalanceCard extends StatefulWidget {
  final bool isDarkThemeOn;
  final String cashBalance;

  const BalanceCard(
      {Key? key, required this.isDarkThemeOn, required this.cashBalance})
      : super(key: key);

  @override
  State<BalanceCard> createState() => _BalanceCardState();
}

class _BalanceCardState extends State<BalanceCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.account_balance_wallet,
              color: widget.isDarkThemeOn
                  ? SabanzuriColors.white
                  : SabanzuriColors.russianViolet,
            ),
            const WidthBox(10.0),
            Text(context.l10n.balance,
                style: TextStyle(
                  color: widget.isDarkThemeOn
                      ? SabanzuriColors.white
                      : SabanzuriColors.Manatee,
                  fontSize: 20.0,
                )),
          ],
        ),
        const HeightBox(10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              UserInfo.currencyDisplayCode + " ${widget.cashBalance}",
              style: TextStyle(
                color: widget.isDarkThemeOn
                    ? SabanzuriColors.inchWorm
                    : SabanzuriColors.russianViolet,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            const WidthBox(30.0),
            Icon(
              Icons.loop,
              color: widget.isDarkThemeOn
                  ? SabanzuriColors.white
                  : SabanzuriColors.reddish_pink,
            ),
          ],
        ),
      ],
    );
  }
}
