part of 'wallet_widget.dart';

class PaymentOption extends StatefulWidget {
  final PaymentOptionResponse? paymentOption;

  const PaymentOption({Key? key, this.paymentOption}) : super(key: key);

  @override
  State<PaymentOption> createState() => _PaymentOptionState();
}

class _PaymentOptionState extends State<PaymentOption> {
  @override
  Widget build(BuildContext context) {
    var paymentType = widget.paymentOption?.payTypeMap?.the14;
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              width: 90,
              height: 75,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(5),
                ),
                color: SabanzuriColors.sky_blue.withOpacity(0.15),
              ),
              child: Image.asset(
                "assets/icons/mpesa_1.png",
              ),
            ),
          ),
          const WidthBox(10.0),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  paymentType?.payTypeDispCode ?? "",
                  //   context.l10n.mobileMoney,
                  // "Mobile Money",
                  style: const TextStyle(
                    color: SabanzuriColors.yellow_orange,
                    fontWeight: FontWeight.w700,
                    fontFamily: "Roboto",
                    fontStyle: FontStyle.normal,
                    fontSize: 18.0,
                  ),
                  textAlign: TextAlign.left,
                ),
                const HeightBox(
                  20.0,
                ),
                Text(
                  "Min :    ${paymentType?.minValue}",
                  style: const TextStyle(
                      color: SabanzuriColors.pinkish_grey,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Roboto",
                      fontStyle: FontStyle.italic,
                      fontSize: 15.0),
                  textAlign: TextAlign.left,
                ),
                Text(
                  "Max:     ${paymentType?.maxValue}",
                  style: const TextStyle(
                      color: SabanzuriColors.pinkish_grey,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Roboto",
                      fontStyle: FontStyle.italic,
                      fontSize: 13.5),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: const TextSpan(
                    text: "Cost",
                    style: TextStyle(
                      color: SabanzuriColors.pinkish_grey,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Roboto",
                      fontStyle: FontStyle.normal,
                      fontSize: 13.0,
                    ),
                    children: [
                      TextSpan(
                        text: " 0 ",
                        style: TextStyle(
                          color: SabanzuriColors.white_two,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Roboto",
                          fontStyle: FontStyle.normal,
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).pSymmetric(v: 10);
  }
}
