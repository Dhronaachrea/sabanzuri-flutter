part of 'transaction_widget.dart';

class TxnType extends StatefulWidget {
  final TxnList txnDetails;
  final bool isDarkThemeOn;

  const TxnType(
      {Key? key, required this.txnDetails, required this.isDarkThemeOn})
      : super(key: key);

  @override
  State<TxnType> createState() => _TxnTypeState();
}

class _TxnTypeState extends State<TxnType> {
  @override
  Widget build(BuildContext context) {
    return Text(txnType(txnType: widget.txnDetails.txnType!),
        style: TextStyle(
            color: widget.isDarkThemeOn
                ? SabanzuriColors.yellow_orange_two
                : SabanzuriColors.warm_grey_three,
            fontWeight: FontWeight.w600,
            fontFamily: "SegoeUI",
            fontStyle: FontStyle.normal,
            fontSize: 11.0),
        textAlign: TextAlign.left);
  }

  String txnType({required String txnType}) {
    switch (txnType) {
      case "PLR_WINNING":
        return context.l10n.winning;
      case "PLR_DEPOSIT":
        return context.l10n.deposit;
      case "PLR_WITHDRAWAL":
        return context.l10n.withdrawal;
      case "PLR_WAGER":
        return context.l10n.wager;
      case "TRANSFER_IN":
        return context.l10n.cashIn;
      case "TRANSFER_OUT":
        return context.l10n.cashOut;
      case "TRANSFER_OUT_REFUND":
        return context.l10n.refund;
      case "PLR_DEPOSIT_AGAINST_CANCEL":
        return context.l10n.withdrawal + "\n" + context.l10n.cancel;
      case "PLR_WAGER_REFUND":
        return context.l10n.wager + "\n" + context.l10n.cancel;
      default:
        return context.l10n.na.toString().toUpperCase();
    }
  }
}
