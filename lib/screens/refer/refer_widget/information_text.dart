part of 'refer_widget.dart';

class InformationText extends StatelessWidget {
  final bool isDarkThemeOn;

  const InformationText({Key? key, required this.isDarkThemeOn})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "Share the referral code or link with your friends to refer and earn referral benefits.",
      style: TextStyle(
        color: isDarkThemeOn
            ? SabanzuriColors.white
            : SabanzuriColors.brownish_grey_three,
        fontWeight: FontWeight.w400,
        fontFamily: "SegoeUI",
        fontStyle: FontStyle.normal,
        fontSize: 18,
      ),
      textAlign: TextAlign.center,
    );
  }
}
