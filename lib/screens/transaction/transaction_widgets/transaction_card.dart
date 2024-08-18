part of 'transaction_widget.dart';

class TransactionCard extends StatefulWidget {
  final TxnList txnDetails;
  final bool isDarkThemeOn;
  final bool isCallFromWager;

  const TransactionCard({
    Key? key,
    required this.txnDetails,
    required this.isDarkThemeOn,
    this.isCallFromWager = false
  }) : super(key: key);

  @override
  State<TransactionCard> createState() => _TransactionCardState();
}

class _TransactionCardState extends State<TransactionCard> {
  late Map<int, String> transactionTypeListMap;
  late Map<int, String> transactionTypeListTagMap;
  late Map<String, String> transactionTypeIconsListTagMap;

  @override
  void initState() {
    super.initState();
    transactionTypeListMap          = {};
    transactionTypeListTagMap       = {};
    transactionTypeIconsListTagMap  = {};

  }

  @override
  Widget build(BuildContext context) {
    transactionTypeListMap[0]      = context.l10n.all;
    transactionTypeListMap[1]      = context.l10n.wager;
    transactionTypeListMap[2]      = context.l10n.deposit;
    transactionTypeListMap[3]      = context.l10n.withdrawal;
    transactionTypeListMap[4]      = context.l10n.winning;
    transactionTypeListMap[5]      = context.l10n.wagerRefund;
    transactionTypeListMap[6]      = context.l10n.withdrawalCancel;
    transactionTypeListMap[7]      = context.l10n.bonus;
    transactionTypeListMap[8]      = AppConstants.txnTransferOutRefund;
    transactionTypeListMap[9]      = AppConstants.txnWinningRefund;
    transactionTypeListMap[10]     = AppConstants.txnCommTxnRefund;
    transactionTypeListMap[11]     = AppConstants.txnDepositChargeTxn;
    transactionTypeListMap[12]     = AppConstants.txnDepositChargeRefund;
    transactionTypeListMap[13]     = AppConstants.txnDepositRefund;
    transactionTypeListMap[14]     = AppConstants.txnBonus2;
    transactionTypeListMap[15]     = AppConstants.txnBonusExpired;
    transactionTypeListMap[16]     = AppConstants.txnBonusCancel;
    transactionTypeListMap[17]     = AppConstants.txnBoCorrection;
    transactionTypeListMap[18]     = AppConstants.txnTdsDeducted;
    transactionTypeListMap[19]     = AppConstants.txnLoyalTyCash;
    transactionTypeListMap[20]     = AppConstants.txnCommTxn;
    transactionTypeListMap[21]     = AppConstants.txnTxCancel;
    transactionTypeListMap[22]     = AppConstants.txnDebitCustomer;
    transactionTypeListMap[23]     = AppConstants.txnCreditCustomer;
    transactionTypeListMap[24]     = AppConstants.tcnWithdrawalChargeTxn;
    transactionTypeListMap[25]     = AppConstants.tcnWithdrawalChargeRefund;
    transactionTypeListMap[26]     = AppConstants.tcnGovtVat;
    transactionTypeListMap[27]     = AppConstants.tcnGovtComm;
    transactionTypeListMap[28]     = AppConstants.txnTransferFromSubWalletCancel;
    transactionTypeListMap[29]     = AppConstants.txnTransferToSubWallet;
    transactionTypeListMap[30]     = AppConstants.txnTransferToSubWalletCancel;
    transactionTypeListMap[31]     = AppConstants.txnTransferFromSubWallet;
    transactionTypeListMap[32]     = AppConstants.txnCancel;

    transactionTypeListTagMap[0]      = AppConstants.txnAll;
    transactionTypeListTagMap[1]      = AppConstants.txnWager;
    transactionTypeListTagMap[2]      = AppConstants.txnDeposit;
    transactionTypeListTagMap[3]      = AppConstants.txnWithdrawal;
    transactionTypeListTagMap[4]      = AppConstants.txnWinning;
    transactionTypeListTagMap[5]      = AppConstants.txnWagerRefund;
    transactionTypeListTagMap[6]      = AppConstants.txnWithdrawalCancel;
    transactionTypeListTagMap[7]      = AppConstants.txnBonus;
    transactionTypeListTagMap[8]      = AppConstants.txnTransferOutRefund;
    transactionTypeListTagMap[9]      = AppConstants.txnWinningRefund;
    transactionTypeListTagMap[10]     = AppConstants.txnCommTxnRefund;
    transactionTypeListTagMap[11]     = AppConstants.txnDepositChargeTxn;
    transactionTypeListTagMap[12]     = AppConstants.txnDepositChargeRefund;
    transactionTypeListTagMap[13]     = AppConstants.txnDepositRefund;
    transactionTypeListTagMap[14]     = AppConstants.txnBonus2;
    transactionTypeListTagMap[15]     = AppConstants.txnBonusExpired;
    transactionTypeListTagMap[16]     = AppConstants.txnBonusCancel;
    transactionTypeListTagMap[17]     = AppConstants.txnBoCorrection;
    transactionTypeListTagMap[18]     = AppConstants.txnTdsDeducted;
    transactionTypeListTagMap[19]     = AppConstants.txnLoyalTyCash;
    transactionTypeListTagMap[20]     = AppConstants.txnCommTxn;
    transactionTypeListTagMap[21]     = AppConstants.txnTxCancel;
    transactionTypeListTagMap[22]     = AppConstants.txnDebitCustomer;
    transactionTypeListTagMap[23]     = AppConstants.txnCreditCustomer;
    transactionTypeListTagMap[24]     = AppConstants.tcnWithdrawalChargeTxn;
    transactionTypeListTagMap[25]     = AppConstants.tcnWithdrawalChargeRefund;
    transactionTypeListTagMap[26]     = AppConstants.tcnGovtVat;
    transactionTypeListTagMap[27]     = AppConstants.tcnGovtComm;
    transactionTypeListTagMap[28]     = AppConstants.txnTransferFromSubWalletCancel;
    transactionTypeListTagMap[29]     = AppConstants.txnTransferToSubWallet;
    transactionTypeListTagMap[30]     = AppConstants.txnTransferToSubWalletCancel;
    transactionTypeListTagMap[31]     = AppConstants.txnTransferFromSubWallet;
    transactionTypeListTagMap[32]     = AppConstants.txnCancel;

    transactionTypeIconsListTagMap[AppConstants.txnWager.toString()]                        = "assets/icons/svg/wager.svg";
    transactionTypeIconsListTagMap[AppConstants.txnDeposit.toString()]                      = "assets/icons/svg/deposit.svg";
    transactionTypeIconsListTagMap[AppConstants.txnWithdrawal.toString()]                   = "assets/icons/svg/withdrawal.svg";
    transactionTypeIconsListTagMap[AppConstants.txnWinning.toString()]                      = "assets/icons/svg/winner.svg";
    transactionTypeIconsListTagMap[AppConstants.txnWagerRefund.toString()]                  = "assets/icons/svg/refund.svg";
    transactionTypeIconsListTagMap[AppConstants.txnWithdrawalCancel.toString()]             = "assets/icons/svg/calendar.svg";
    transactionTypeIconsListTagMap[AppConstants.txnBonus.toString()]                        = "assets/icons/svg/calendar.svg";
    transactionTypeIconsListTagMap[AppConstants.txnTransferOutRefund.toString()]            = "assets/icons/svg/calendar.svg";
    transactionTypeIconsListTagMap[AppConstants.txnWinningRefund.toString()]                = "assets/icons/svg/calendar.svg";
    transactionTypeIconsListTagMap[AppConstants.txnCommTxnRefund.toString()]                = "assets/icons/svg/calendar.svg";
    transactionTypeIconsListTagMap[AppConstants.txnDepositChargeTxn.toString()]             = "assets/icons/svg/calendar.svg";
    transactionTypeIconsListTagMap[AppConstants.txnDepositChargeRefund.toString()]          = "assets/icons/svg/calendar.svg";
    transactionTypeIconsListTagMap[AppConstants.txnDepositRefund.toString()]                = "assets/icons/svg/calendar.svg";
    transactionTypeIconsListTagMap[AppConstants.txnBonus2.toString()]                       = "assets/icons/svg/calendar.svg";
    transactionTypeIconsListTagMap[AppConstants.txnBonusExpired.toString()]                 = "assets/icons/svg/calendar.svg";
    transactionTypeIconsListTagMap[AppConstants.txnBonusCancel.toString()]                  = "assets/icons/svg/calendar.svg";
    transactionTypeIconsListTagMap[AppConstants.txnBoCorrection.toString()]                 = "assets/icons/svg/calendar.svg";
    transactionTypeIconsListTagMap[AppConstants.txnTdsDeducted.toString()]                  = "assets/icons/svg/calendar.svg";
    transactionTypeIconsListTagMap[AppConstants.txnLoyalTyCash.toString()]                  = "assets/icons/svg/calendar.svg";
    transactionTypeIconsListTagMap[AppConstants.txnCommTxn.toString()]                      = "assets/icons/svg/calendar.svg";
    transactionTypeIconsListTagMap[AppConstants.txnTxCancel.toString()]                     = "assets/icons/svg/calendar.svg";
    transactionTypeIconsListTagMap[AppConstants.txnDebitCustomer.toString()]                = "assets/icons/svg/calendar.svg";
    transactionTypeIconsListTagMap[AppConstants.txnCreditCustomer.toString()]               = "assets/icons/svg/calendar.svg";
    transactionTypeIconsListTagMap[AppConstants.tcnWithdrawalChargeTxn.toString()]          = "assets/icons/svg/calendar.svg";
    transactionTypeIconsListTagMap[AppConstants.tcnWithdrawalChargeRefund.toString()]       = "assets/icons/svg/calendar.svg";
    transactionTypeIconsListTagMap[AppConstants.tcnGovtVat.toString()]                      = "assets/icons/svg/calendar.svg";
    transactionTypeIconsListTagMap[AppConstants.tcnGovtComm.toString()]                     = "assets/icons/svg/calendar.svg";
    transactionTypeIconsListTagMap[AppConstants.txnTransferFromSubWalletCancel.toString()]  = "assets/icons/svg/calendar.svg";
    transactionTypeIconsListTagMap[AppConstants.txnTransferToSubWallet.toString()]          = "assets/icons/svg/calendar.svg";
    transactionTypeIconsListTagMap[AppConstants.txnTransferToSubWalletCancel.toString()]    = "assets/icons/svg/calendar.svg";
    transactionTypeIconsListTagMap[AppConstants.txnTransferFromSubWallet.toString()]        = "assets/icons/svg/calendar.svg";
    transactionTypeIconsListTagMap[AppConstants.txnCancel.toString()]                       = "assets/icons/svg/calendar.svg";

    String txnDate = formatDate(
      date: widget.txnDetails.transactionDate.toString(),
      inputFormat: Format.apiDateFormat2,
      outputFormat: Format.apiDateFormat_with_time,
    );
    return Container(
      decoration: widget.isDarkThemeOn? const BoxDecoration(color: SabanzuriColors.cetaceanBlue) : const BoxDecoration(color: SabanzuriColors.white_two),

      child: IntrinsicHeight(
        child: Row(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                      color: SabanzuriColors.transaction_icon_bg,
                      borderRadius: BorderRadius.circular(40)
                  ),
                ),
                widget.txnDetails.txnType != null
                    ? SvgPicture.asset(transactionTypeIconsListTagMap[widget.txnDetails.txnType!] ?? "assets/icons/svg/winner.svg", width: 35, height: 35, color: SabanzuriColors.white)
                    : SvgPicture.asset("assets/icons/svg/winner.svg", width: 24, height: 24, color: Colors.lightGreen)
              ],
            ).pOnly(right: 12),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      widget.txnDetails.txnType != null
                          ? transactionTypeListTagMap.keys.firstWhere((k) => transactionTypeListTagMap[k] == widget.txnDetails.txnType).isNotNull == true
                          ? transactionTypeListMap[transactionTypeListTagMap.keys.firstWhere((k) => transactionTypeListTagMap[k] == widget.txnDetails.txnType)]!
                          : "NA"
                          : "NA",
                      style: TextStyle(color: widget.isDarkThemeOn ? SabanzuriColors.yellow_orange : SabanzuriColors.cetaceanBlue, fontWeight: FontWeight.w700, fontFamily: "SegoeUI", fontStyle: FontStyle.normal, fontSize: 18.0,), textAlign: TextAlign.left),
                  const HeightBox(10),
                  Text(widget.txnDetails.particular??"",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: widget.isDarkThemeOn ? SabanzuriColors.white_two : SabanzuriColors.navy,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.italic,
                    ),).pOnly(right: 10, bottom: 5),
                  Text("${context.l10n.txnId} : ${widget.txnDetails.transactionId}",
                      style: TextStyle(
                          color: widget.isDarkThemeOn
                              ? SabanzuriColors.warm_grey_four
                              : SabanzuriColors.warm_grey_three,
                          fontWeight: FontWeight.normal,
                          fontFamily: "SegoeUI",
                          fontStyle: FontStyle.italic,
                          fontSize: 14.0),
                      textAlign: TextAlign.right),
                  FittedBox(
                      child: Text(txnDate,
                          style: TextStyle(
                              color: widget.isDarkThemeOn
                                  ? SabanzuriColors.warm_grey_four
                                  : SabanzuriColors.warm_grey_three,
                              fontWeight: FontWeight.normal,
                              fontFamily: "SegoeUI",
                              fontStyle: FontStyle.italic,
                              fontSize: 14.0),
                          textAlign: TextAlign.right)
                  )
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                widget.txnDetails.debitAmount != null && widget.txnDetails.creditAmount == null
                    ? Text(
                    widget.txnDetails.debitAmount != null && widget.txnDetails.creditAmount == null
                        ? "${UserInfo.getCurrencyCode} ${widget.txnDetails.debitAmount}" : "NA",
                    style: const TextStyle(color:SabanzuriColors.lightish_red, fontWeight: FontWeight.bold,
                        fontFamily: "SegoeUI",
                        fontStyle: FontStyle.normal,
                        fontSize: 14.0)
                )
                    : Text(
                    widget.txnDetails.debitAmount == null && widget.txnDetails.creditAmount != null
                        ? "${UserInfo.getCurrencyCode} ${widget.txnDetails.creditAmount}" : "NA",
                    style: const TextStyle(color:SabanzuriColors.shamrock_green,fontWeight: FontWeight.bold,
                        fontFamily: "SegoeUI",
                        fontStyle: FontStyle.normal,
                        fontSize: 14.0)
                ),
                const HeightBox(10),
                const Text(
                    "Bal.Amt",
                    style: TextStyle(color:SabanzuriColors.warm_grey_four,fontWeight: FontWeight.w300,
                        fontFamily: "SegoeUI",
                        fontStyle: FontStyle.normal,
                        fontSize: 12.0)
                ),
                FittedBox(
                  child: Text(
                      "${UserInfo.currencyDisplayCode} ${widget.isCallFromWager ?  widget.txnDetails.txnAmount : widget.txnDetails.balance}",
                      style: TextStyle(color: widget.isDarkThemeOn ? SabanzuriColors.white : SabanzuriColors.cetaceanBlue, fontWeight: FontWeight.bold,
                          fontFamily: "SegoeUI",
                          fontSize: 12.0)
                  ),
                )
              ],
            ),
          ],
        ).p12(),
      ),
    );
  }
}
