part of 'wallet_widget.dart';

class CurrencyAmount extends StatefulWidget {
  final TextEditingController amountController;

  const CurrencyAmount({Key? key, required this.amountController})
      : super(key: key);

  @override
  State<CurrencyAmount> createState() => _CurrencyAmountState();
}

class _CurrencyAmountState extends State<CurrencyAmount> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              border: Border.all(
                color: SabanzuriColors.warm_grey_two,
                width: 1,
              ),
              color: SabanzuriColors.white_two,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.l10n.currency.toUpperCase(),
                  style: const TextStyle(
                      color: SabanzuriColors.warm_grey_two,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Arial",
                      fontStyle: FontStyle.normal,
                      fontSize: 15.5),
                  textAlign: TextAlign.left,
                ),
                const HeightBox(10),
                Text(
                  context.l10n.kes.toUpperCase(),
                  style: const TextStyle(
                    color: SabanzuriColors.brownish_grey,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Arial",
                    fontStyle: FontStyle.normal,
                    fontSize: 18.5,
                  ),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
        ),
        const WidthBox(10),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              border: Border.all(
                color: SabanzuriColors.warm_grey_two,
                width: 1,
              ),
              color: SabanzuriColors.white_two,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.l10n.amount.toUpperCase(),
                  style: const TextStyle(
                      color: SabanzuriColors.warm_grey_two,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Arial",
                      fontStyle: FontStyle.normal,
                      fontSize: 15.5),
                  textAlign: TextAlign.left,
                ),
                const HeightBox(10),
                SabanzuriTextField(
                  controller: widget.amountController,
                  inputDecoration:
                      const InputDecoration.collapsed(hintText: null),
                  inputType: TextInputType.number,
                  textStyle: const TextStyle(
                    fontSize: 18,
                    color: SabanzuriColors.navy,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    ).pSymmetric(v: 10);
  }
}
