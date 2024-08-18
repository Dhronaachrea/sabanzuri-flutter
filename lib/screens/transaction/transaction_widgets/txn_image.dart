part of 'transaction_widget.dart';

class TxnImage extends StatefulWidget {
  final TxnList txnDetails;

  const TxnImage({Key? key, required this.txnDetails}) : super(key: key);

  @override
  State<TxnImage> createState() => _TxnImageState();
}

class _TxnImageState extends State<TxnImage> {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imagePath(txnType: widget.txnDetails.txnType!),
      width: 50,
      height: 50,
    );
  }

  String imagePath({required String txnType}) {
    switch (txnType) {
      case "PLR_WINNING":
        return "assets/icons/winning.png";
      case "PLR_DEPOSIT":
        return "assets/icons/deposit.png";
      case "PLR_WITHDRAWAL":
        return "assets/icons/withdrawal.png";
      case "PLR_WAGER":
        return "assets/icons/wager.png";
      case "TRANSFER_IN":
        return "assets/icons/transfer_in.png";
      case "TRANSFER_OUT":
        return "assets/icons/transfer_out.png";
      case "TRANSFER_OUT_REFUND":
        return "assets/icons/refund.png";
      case "PLR_DEPOSIT_AGAINST_CANCEL":
        return "assets/icons/withdrawal_cancel.png";
      case "PLR_WAGER_REFUND":
        return "assets/icons/refund.png";
      default:
        return "assets/icons/winning.png";
    }
  }
}
