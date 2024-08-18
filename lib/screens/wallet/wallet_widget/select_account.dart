part of 'wallet_widget.dart';

class SelectAccount extends StatefulWidget {
  const SelectAccount({Key? key}) : super(key: key);

  @override
  State<SelectAccount> createState() => _SelectAccountState();
}

class _SelectAccountState extends State<SelectAccount> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
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
            context.l10n.selectAC.toUpperCase(),
            style: const TextStyle(
                color: SabanzuriColors.warm_grey_two,
                fontWeight: FontWeight.w400,
                fontFamily: "Arial",
                fontStyle: FontStyle.normal,
                fontSize: 15.5),
            textAlign: TextAlign.left,
          ),
          const HeightBox(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "254" + UserInfo.mobNumber.substring(1),
                //"698 741 236",
                style: const TextStyle(
                  color: SabanzuriColors.brownish_grey,
                  fontWeight: FontWeight.w400,
                  fontFamily: "Arial",
                  fontStyle: FontStyle.normal,
                  fontSize: 18.5,
                ),
                textAlign: TextAlign.left,
              ),
              Image.asset(
                "assets/images/bottom_red_arrow.png",
                width: 20,
                height: 20,
              ),
            ],
          )
        ],
      ),
    );
  }
}
