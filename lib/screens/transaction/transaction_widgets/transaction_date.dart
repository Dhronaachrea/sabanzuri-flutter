part of 'transaction_widget.dart';

class TransactionDate extends StatefulWidget {
  final bool isDarkThemeOn;
  final String txnType;

  const TransactionDate(
      {Key? key, required this.isDarkThemeOn, required this.txnType})
      : super(key: key);

  @override
  State<TransactionDate> createState() => _TransactionDateState();
}

class _TransactionDateState extends State<TransactionDate> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.isDarkThemeOn
          ? SabanzuriColors.sky_blue.withOpacity(0.3)
          : SabanzuriColors.white,
      constraints: BoxConstraints(
        minHeight: context.screenHeight / 7,
      ),
      child: FittedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SelectDate(
              title: context.l10n.from,
              date: context.read<TransactionBloc>().fromDate,
              onTap: () {
                context.read<TransactionBloc>().add(
                      PickFromDate(context: context),
                    );
              },
            ).pOnly(right: 8),
            SelectDate(
              title: context.l10n.to,
              date: context.read<TransactionBloc>().toDate,
              onTap: () {
                context.read<TransactionBloc>().add(
                      PickToDate(context: context),
                    );
              },
            ).pOnly(right: 8),
            Forward(
              isDarkThemeOn: widget.isDarkThemeOn,
              onTap: () {
                context.read<TransactionBloc>().add(
                      GetTransaction(context: context, txnType: widget.txnType),
                    );
              },
            ),
          ],
        ).pSymmetric(v: 16, h: 10),
      ),
    );
  }
}
